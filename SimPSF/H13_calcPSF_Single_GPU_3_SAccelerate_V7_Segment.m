function [pattern_psf] = H13_calcPSF_Single_GPU_3_SAccelerate_V7_Segment(...
                                     zho    , z_o    , x_t   , y_t  ,...
                                     Fl_obj , Ma_obj , NA_obj, n_obj,...
                                     wavelen, maxval , maxgpu)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test codes
% zho = Step_NIP_Finetune;
% z_o = Object_35_CoorZ(1);
% x_t = P20_NIP_CoorR_Odd;
% y_t = P20_NIP_CoorR_Odd;
% Fl_obj = Fl_01_obj ;
% Ma_obj = Ma_01_obj ;
% NA_obj = NA_01_obj ;
% n_obj  = Ind01_obj ;
% wavelen= lambda    ;
% maxval = Data_00_maxval;
% maxgpu = 500;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
    for idxta = 1                                                          
        Length_r = length(x_t)     ;
        center_r = ceil(Length_r/2);
        qt_sizer = 1:center_r      ;
             x_o = 0               ;
             y_o = 0               ;
        if(  z_o== 0)
             z_z = -zho;
        else 
             z_z = z_o             ;
        end
    end
%%
    for idxta = 1                                                          
        k       = 2*pi/ wavelen*n_obj ;
        alpha   = asin(NA_obj  /n_obj);
        sin_al  = sin(alpha)          ;
        sin2alh = sin(alpha/2)^2      ;
        
        num_segm = ceil(center_r/maxgpu);
    end
    for idxpsgx = 0: num_segm-1                                            
        for idxpsgy = 0: num_segm-1
            Int_rang_l = 1      + idxpsgx*maxgpu;
            Int_rang_r = maxgpu + idxpsgx*maxgpu;
            Int_rang_u = 1      + idxpsgy*maxgpu;
            Int_rang_d = maxgpu + idxpsgy*maxgpu;
            if (Int_rang_r > center_r)
                Int_rang_r = center_r(end);
            end
            if (Int_rang_d > center_r)
                Int_rang_d = center_r(end);
            end
    %         coe_xx_t = x_t(qt_sizer)+Ma_obj*x_o;
    %         coe_yy_t = y_t(qt_sizer)+Ma_obj*y_o;
            coe_xx_t = x_t(Int_rang_l:Int_rang_r)+Ma_obj*x_o;
            coe_yy_t = y_t(Int_rang_u:Int_rang_d)+Ma_obj*y_o;
           [coe_XX_t, coe_YY_t] = meshgrid(coe_xx_t,coe_yy_t);

            coe_rh_t = sqrt(coe_XX_t.^2 + coe_YY_t.^2)./Ma_obj;
            v   =   k* sin_al * coe_rh_t  ;
            u   = 4*k* sin2alh* z_z;

            V   = gpuArray(v);
            tic
            PSF_Minggu_GPU = @(theta) (sqrt(cos(theta))) ...
                             .* (1 +    cos(theta) )     ...
                             .* (exp((1i.*u/2) * (sin(theta/2).^2) / sin2alh   )) ...
                             .* (besselj(0,       sin(theta)       / sin_al .*V)) ...
                             .* (sin(theta));                 
            I0(Int_rang_u:Int_rang_d,Int_rang_l:Int_rang_r)...
                = Z_integral_3_SAccelerate_V6(@(theta) PSF_Minggu_GPU(theta),0,alpha,'ArrayValued',true);
           toc
        end
    end
%%
    for idxta = 1
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Expval = 10^ceil(log10(maxval))     ;
        Koi_c1 = Ma_obj/((Fl_obj*wavelen)^2);
        Koi_c2 = 4*   sin2alh;
        Koi    = Koi_c1*exp(-1i*u/Koi_c2)   ;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        pattern_qua                      = zeros( Length_r, Length_r , 4 );
        pattern_qua(qt_sizer,qt_sizer,1) = Expval.*Koi.*I0;
        pattern_qua(  :     ,  :     ,2) = rot90( pattern_qua(:,:,1) , -1);
        pattern_qua(  :     ,  :     ,3) = rot90( pattern_qua(:,:,1) , -2);
        pattern_qua(  :     ,  :     ,4) = rot90( pattern_qua(:,:,1) , -3);
        pattern_psf = squeeze(max(pattern_qua,[],3));
    end
%     imshow(pattern_psf)
if(  z_o== 0)
%% Chirp coordinates set 
    for idxta = 1
        hzt   = zho * Ma_obj^2  ;
        hrt   = x_t(2)- x_t(1)  ;
        Num_x = Length_r; Rad_x = (Num_x-1)/2; Cen_x = floor(Num_x/2);
        Num_y = Length_r; Rad_y = (Num_y-1)/2; Cen_y = floor(Num_y/2);
        du    = 1./(Num_x*hrt);
        dv    = 1./(Num_y*hrt);
        idxu  = [Cen_x-Rad_x:Rad_x -Rad_x:-Rad_x+Cen_x-1];                 % 如此定义可以不用在做Fourier Transfermation的时候加fftshift函数
        idxv  = [Cen_y-Rad_y:Rad_y -Rad_y:-Rad_y+Cen_y-1];
       [Indu, Indv] = meshgrid(idxu,idxv);
    end
%% Propogation
    for idxta = 1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Propogate only one step
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        Prop1_GPU = gpuArray(exp( 1i*2*pi/wavelen*hzt)                            );
        Chirp_GPU = gpuArray(exp(-1i  *pi*wavelen*hzt*(Indu.^2*du^2+Indv.^2*dv^2)));
        Image_GPU = gpuArray(pattern_psf(:,:,z_o==0) );
        Image_GPU = Prop1_GPU*ifft2( fft2(Image_GPU).*Chirp_GPU);
        Image_CPU = gather(Image_GPU);
        pattern_psf = ( Image_CPU + flip(flip(Image_CPU,1),2) )/2;        
    end
end