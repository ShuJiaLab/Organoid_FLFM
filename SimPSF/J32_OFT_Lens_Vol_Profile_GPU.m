function [Image_final,Image_ProfL] = J32_OFT_Lens_Vol_Profile_GPU( lambda, Image_incid, dr, Focal_length, dz)
%% test 
%     Image_incid  = P20_NIP_CSFStp;
%     dr           = Data_06_CCD_RF;
%     Focal_length = ds_04_em;
%     dz           = Para_Stepsize_Propergation;
%%     
        Step_Num = round(Focal_length/dz);
        Num_x = size(Image_incid,1); Rad_x = (Num_x-1)/2; Cen_x = ceil(Num_x/2);
        Num_y = size(Image_incid,2); Rad_y = (Num_y-1)/2; Cen_y = ceil(Num_y/2);
        Num_z = size(Image_incid,3); 
%% 
    % Chirp coordinates set 
        du    = 1./(Num_x*dr);
        dv    = 1./(Num_y*dr);
        idxu  = [flip(Rad_x:-1:0) (Rad_x-floor(Cen_x-Rad_x)):-1:0];                 % 如此定义可以不用在做Fourier Transfermation的时候加fftshift函数
        idxv  = [flip(Rad_y:-1:0) (Rad_y-floor(Cen_y-Rad_y)):-1:0];
        [Indu, Indv] = meshgrid(idxu,idxv);
    
    % LensT coordinates set 
        idxs  = (-Rad_x:Rad_x);
        idxt  = (-Rad_y:Rad_y);
        [inds, indt] = meshgrid(idxs,idxt);
    
    % Propergation coefficient, chirp and lens transfermation function set
        Prop1_func  = exp( 1i*2*pi/lambda*dz);
        Chirp_func  = exp(-1i  *pi*lambda*(Indu.^2*du^2+Indv.^2*dv^2)*dz);
        Trans_func  = exp(-1i*2*pi/lambda*(inds.^2*dr^2+indt.^2*dr^2)/(2*Focal_length));
        Image_final = zeros(Num_x,Num_y     ,Num_z);
        Image_ProfL = zeros(Num_x,Step_Num*2,Num_z);
        
        Bound_Cond  = zeros(Num_x,Num_y);                                  Bound_Cond(2:Num_x-1,2:Num_x-1) = 1; %figure,imshow(Bound_Cond)
%% GPU Initial
        Prop1_GPU = gpuArray(Prop1_func);
        Chirp_GPU = gpuArray(Chirp_func);
        Trans_GPU = gpuArray(Trans_func);
        
	for idxk = 1:Num_z
        tic
        Image_GPU = gpuArray(Image_incid(:,:,idxk));
        Prof1_GPU = gpuArray(zeros(Num_x,Step_Num));
        Prof2_GPU = gpuArray(zeros(Num_x,Step_Num));
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 传播过一个焦距
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for Step_1 = 1:Step_Num
            Image_GPU = Prop1_GPU*ifft2( fft2(Image_GPU).*Chirp_GPU).*Bound_Cond;
            Prof1_GPU(:,Step_1)= Image_GPU(:,Cen_y);
            disp(['Step_1 ',num2str(Step_1),'|',num2str(Step_Num)]);
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 乘以透镜透射函数
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Image_GPU = Image_GPU.*Trans_GPU;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 传播过一个焦距
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        for Step_2 = 1:Step_Num
            Image_GPU = Prop1_GPU*ifft2( fft2(Image_GPU).*Chirp_GPU).*Bound_Cond;
            Prof2_GPU(:,Step_2)= Image_GPU(:,Cen_y);
            disp(['Step_2 ',num2str(Step_2),'|',num2str(Step_Num)]);
        end
        Image_final(:,:,idxk) = gather(      Image_GPU           );
        Image_ProfL(:,:,idxk) = gather(cat(2,Prof1_GPU,Prof2_GPU));
        toc
    end
    
    
    
    
    
    
    
    