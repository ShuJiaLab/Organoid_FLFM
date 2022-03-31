function [] = H47_calcPSF_WFM_FLFM_Desampling(Path_s11c_unifor , Path_s31c_unifor , Data_05_Refine  ,...
                                              P27_WFM_RefAd_Odd, P27_WFM_RefAd_Eve, P47_MLA_NumAd_RF,...
                                              Object_33_ZdNum  , Object_35_ZCoor  ,                  ...
                                              Data_02_formDt   , Data_01_formIm   ,                  ...
                                              Flag_Simulation  , Flag_WFMPSFOnly  , Flag_breakpoint)
    
% 
% flag_profilesim = 1
    
    for idxta = 1                                                          % Save file name set                  
        Path_s111_NIPodd = [Path_s11c_unifor,'_','2_NIPodd_Fine'];
        Path_s111_NIPeve = [Path_s11c_unifor,'_','2_NIPeve_Fine'];
        Path_s311_NIPodd = [Path_s31c_unifor,'_','2_NIPodd_Fine'];
        Path_s311_NIPeve = [Path_s31c_unifor,'_','2_NIPeve_Fine'];
        Path_s312_MLACSF = [Path_s31c_unifor,'_','3_MLACSF_Fine'];
        Path_s315_CCDCSF = [Path_s31c_unifor,'_','5_CCDCSF_Fine'];
        Path_s316_WFModd = [Path_s31c_unifor,'_','6_WFModd_Down'];
        Path_s316_WFMeve = [Path_s31c_unifor,'_','6_WFMeve_Down'];
        Path_s316_PSF3DN = [Path_s31c_unifor,'_','6_3DNDat_Down'];
        Path_s316_PSF3Dt = [Path_s31c_unifor,'_','6_3DtDat_Down'];
        Path_s316_PSF5Dn = [Path_s31c_unifor,'_','6_5DnDat_Down'];
        Path_s316_PSF5Dt = [Path_s31c_unifor,'_','6_5DtDat_Down'];
        Path_s31A_CSFPrf = [Path_s31c_unifor,'_','A_PROFIL_Fine'];
        Path_s31A_CSFrgb = [Path_s31c_unifor,'_','A_PROFIL_rgbc'];
    end
    
        Data_05_RefInt   =     round(Data_05_Refine);
    for idxta = 1                                                          % PSF matrix set                      
%             P66_WFM_OddAd = O10_pixelBinning_size(P27_WFM_RefAd_Odd,Data_05_RefInt);
%             P66_WFM_EveAd = O10_pixelBinning_size(P27_WFM_RefAd_Eve,Data_05_RefInt);
        if (Flag_Simulation==1)
            P66_FLF_NumAd = O10_pixelBinning_size(P47_MLA_NumAd_RF ,Data_05_RefInt);
        else
            P66_FLF_NumAd =                       P47_MLA_NumAd_RF /Data_05_RefInt ;
        end
%             P61_WFM_PSFeve = zeros(P66_WFM_EveAd,P66_WFM_EveAd,Object_33_ZdNum);
%             P61_WFM_PSFodd = zeros(P66_WFM_OddAd,P66_WFM_OddAd,Object_33_ZdNum);
            P61_FLF_PSFtep = zeros(P66_FLF_NumAd,P66_FLF_NumAd,Object_33_ZdNum);
    end
    
    for idxk  = Flag_breakpoint:Object_33_ZdNum                            % CSF load                            
%                 idxk  = 1;
            Path_s31c_zdepth = [num2str(idxk,'%03d'),'_',num2str(Object_35_ZCoor(idxk)*1e6,'%+08.3f'),'um'];
        if (Flag_WFMPSFOnly==1)                                            % Simulate only WFM PSF. 
%             load([Path_s111_NIPodd,'_',Path_s31c_zdepth,Data_02_formDt],'P20_NIP_CSFOdd');  P21_NIP_PSFOdd = abs(P20_NIP_CSFOdd).^2;
%             load([Path_s111_NIPeve,'_',Path_s31c_zdepth,Data_02_formDt],'P20_NIP_CSFEve');  P21_NIP_PSFEve = abs(P20_NIP_CSFEve).^2;
        else                                                               % Simulate both WFM PSF and FLFM PSF 
%             load([Path_s311_NIPodd,'_',Path_s31c_zdepth,Data_02_formDt],'P20_NIP_CSFOdd');  P21_NIP_PSFOdd = abs(P20_NIP_CSFOdd).^2;
%             load([Path_s311_NIPeve,'_',Path_s31c_zdepth,Data_02_formDt],'P20_NIP_CSFEve');  P21_NIP_PSFEve = abs(P20_NIP_CSFEve).^2;
            load([Path_s315_CCDCSF,'_',Path_s31c_zdepth,Data_02_formDt],'P50_Cam_CSFunc');	P51_Cam_PSFunc = abs(P50_Cam_CSFunc).^2;
        end
%         if( P27_WFM_RefAd_Odd>size(P21_NIP_PSFOdd,1))
%             P61_WFM_PSFodd(:,:,idxk) = O10_pixelBinning(   P20_Zeropad_centerS( P21_NIP_PSFOdd, P27_WFM_RefAd_Odd ),Data_05_RefInt);
%             P61_WFM_PSFeve(:,:,idxk) = O10_pixelBinning(   P20_Zeropad_centerS( P21_NIP_PSFEve, P27_WFM_RefAd_Eve ),Data_05_RefInt);
%         else
%             P61_WFM_PSFodd(:,:,idxk) = O10_pixelBinning(   P35_Imgcrop_centerS( P21_NIP_PSFOdd, P27_WFM_RefAd_Odd ),Data_05_RefInt);
%             P61_WFM_PSFeve(:,:,idxk) = O10_pixelBinning(   P35_Imgcrop_centerS( P21_NIP_PSFEve, P27_WFM_RefAd_Eve ),Data_05_RefInt);
%         end
%         
        if (Flag_Simulation == 1)
            P61_FLF_PSFtep(:,:,idxk) = O10_pixelBinning(   P35_Imgcrop_centerS( P51_Cam_PSFunc, P47_MLA_NumAd_RF  ),Data_05_RefInt);
        else
            P61_FLF_PSFtep(:,:,idxk) = O12_pixelBinning_3D(P35_Imgcrop_centerS( P51_Cam_PSFunc, P47_MLA_NumAd_RF  ),Data_05_RefInt);
        end
%         figure,imshow(rescale(P51_Cam_PSFunc))
        disp([' Layer ' num2str(idxk) ' | ' num2str(Object_33_ZdNum)]);
    end
    
    for idxta = 1                                                          % PSF matrix generation and save      
        if (Flag_WFMPSFOnly==1)                                            % WFMPSF matrix generation and save     
                P62_WFM_PSFodd_nor = V40_NorCPU_one(P61_WFM_PSFodd );      save(                         [Path_s111_NIPodd, Data_02_formDt],'P62_WFM_PSFodd_nor','-v7.3');
                P62_WFM_PSFeve_nor = V40_NorCPU_one(P61_WFM_PSFeve );      save(                         [Path_s111_NIPeve, Data_02_formDt],'P62_WFM_PSFeve_nor','-v7.3');
                                                                           S30_Imsave(P62_WFM_PSFodd_nor, Path_s111_NIPodd, Data_01_formIm);
                                                                           S30_Imsave(P62_WFM_PSFeve_nor, Path_s111_NIPeve, Data_01_formIm);
                clear P62_WFM_PSFodd_nor P61_WFM_PSFodd;
                clear P62_WFM_PSFeve_nor P61_WFM_PSFeve;
        else                                                               % WFMPSF matrix generation and save     
                P62_WFM_PSFodd_nor = V40_NorCPU_one(P61_WFM_PSFodd );      save(                         [Path_s316_WFModd, Data_02_formDt],'P62_WFM_PSFodd_nor','-v7.3');
                P62_WFM_PSFeve_nor = V40_NorCPU_one(P61_WFM_PSFeve );      save(                         [Path_s316_WFMeve, Data_02_formDt],'P62_WFM_PSFeve_nor','-v7.3');
                                                                           S30_Imsave(P62_WFM_PSFodd_nor, Path_s316_WFModd, Data_01_formIm);
                                                                           S30_Imsave(P62_WFM_PSFeve_nor, Path_s316_WFMeve, Data_01_formIm);
                clear P62_WFM_PSFodd_nor P61_WFM_PSFodd;
                clear P62_WFM_PSFeve_nor P61_WFM_PSFeve;
                                                                           % FLFPSF matrix generation and save     
                P61_FLF_PSF3Dn     = ( P61_FLF_PSFtep + rot90(P61_FLF_PSFtep,1) + rot90(P61_FLF_PSFtep,2) + rot90(P61_FLF_PSFtep,3) )/4;
                clear P61_FLF_PSFtep
%                 figure,imshow(rescale(P61_FLF_PSF3Dn(:,:,idxk)))
                P62_FLF_PSF3Dn_nor = V40_NorCPU_one(P61_FLF_PSF3Dn );      save(                         [Path_s316_PSF3DN, Data_02_formDt],'P62_FLF_PSF3Dn_nor','-v7.3');
                P62_FLF_PSF3Dt_nor = flip(flip(P62_FLF_PSF3Dn_nor,1),2);   save(                         [Path_s316_PSF3Dt, Data_02_formDt],'P62_FLF_PSF3Dt_nor','-v7.3');
                                                                           S30_Imsave(P62_FLF_PSF3Dn_nor, Path_s316_PSF3DN, Data_01_formIm);
                                                                           S30_Imsave(P62_FLF_PSF3Dt_nor, Path_s316_PSF3Dt, Data_01_formIm);
                                                                           S65_Imsave(P62_FLF_PSF3Dn_nor, Path_s316_PSF3DN, Data_01_formIm)         
                clear P62_FLF_PSF3Dn_nor P61_FLF_PSF3Dn;
                clear P62_FLF_PSF3Dt_nor;
                
            if (Flag_Simulation==0)                                        % FLFPSF matrix generation and save (5D deconvolution use)
                P62_FLF_PSF5Dn_nor = V40_NorCPU_one( reshape(        P61_FLF_PSF3Dn,size(P61_FLF_PSF3Dn,1), size(P61_FLF_PSF3Dn,2), 1, 1,Object_33_ZdNum) );
                P62_FLF_PSF3Dt_nor = V40_NorCPU_one( H51_calcHt_3D_O(P61_FLF_PSF3Dn    ) );
                P62_FLF_PSF5Dt_nor = V40_NorCPU_one( H55_calcHt_5D_O(P62_FLF_PSF5Dn_nor) );
                
                                                                           save(                         [Path_s316_PSF3Dt, Data_02_formDt],'P62_FLF_PSF3Dt_nor','-v7.3');
                                                                           save(                         [Path_s316_PSF5Dn, Data_02_formDt],'P62_FLF_PSF5Dn_nor','-v7.3');
                                                                           save(                         [Path_s316_PSF5Dt, Data_02_formDt],'P62_FLF_PSF5Dt_nor','-v7.3');
                                                                           S30_Imsave(P62_FLF_PSF3Dt_nor, Path_s316_PSF3Dt, Data_01_formIm);
                                                                           S30_Imsave(P62_FLF_PSF5Dn_nor, Path_s316_PSF5Dn, Data_01_formIm);
                                                                           S30_Imsave(P62_FLF_PSF5Dt_nor, Path_s316_PSF5Dt, Data_01_formIm);
                clear P62_FLF_PSF3Dt_nor;
                clear P62_FLF_PSF5Dn_nor;
                clear P62_FLF_PSF5Dt_nor;
            end
        end
    end
    
    function Image_pad = P20_Zeropad_centerS(Input,Side_Long)              
    %  Embedded the input into a black background.
    %  The size of the imput is larger than. 
    %  the size of the background.
    %
    % This is the test
    % 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % 
    % for a = 6:7
    %     for b = 2:3
    %         tst0 = 1:b;
    %         Imput = tst0'*tst0;              disp(Imput)
    %         Image = P20_Zeropadding_centerS(Imput,a);  disp(Image)
    %     end
    % end
    % 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        Size_old = [size( Input,1  ), size( Input,2  )];
        Size_new = [round(Side_Long), round(Side_Long)];
        if( Size_old(1)>Size_new(1)||Size_old(2)>Size_new(2))
            error('Wrong use of the function!!!!!!!');
        end

        Image_pad = zeros([ Size_new   ,size(Input,3)]);

        IndexIni = ceil(Size_new/2) - floor((Size_old-1)/2) - 1;
        Image_pad(  IndexIni(1) + ( 1 :  Size_old(1) ) , ...
                    IndexIni(2) + ( 1 :  Size_old(2) ) , :) = Input;
    end
    
    function Image_crp = P35_Imgcrop_centerS(Input,Side_Long)              
    %  Embedded the input into a black background.
    %  The size of the imput is larger than. 
    %  the size of the background.
    % This is the test
    % 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % for a = 6:7
    %     for b = 2:3
    %         tst0 = 1:a;
    %         Imput = tst0'*tst0;              disp(Imput)
    %         Image = P35_Imgcrop_center(Imput,b,b);  disp(Image)
    %         Image = P35_Imgcrop_centerN(Imput,b,b);  disp(Image)
    %         Image = P35_Imgcrop_centerP(Imput,b,b);  disp(Image)
    %         Image = P35_Imgcrop_centerS(Imput,b  );  disp(Image)
    %     end
    % end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        Size_old = [size( Input,1  ), size( Input,2  )];
        Size_new = [round(Side_Long), round(Side_Long)];
        if( Size_old(1)<Size_new(1)||Size_old(2)<Size_new(2))
            error('Wrong use of the function!!!!!!!');
        end

        disp(['An image of size: ', num2str(Size_new(1),'%.0f'), ' X ', num2str(Size_new(2),'%.0f'),...
              ' is cropped from '  ,...
              'an image of size: ', num2str(Size_old(1),'%.0f'), ' X ', num2str(Size_old(2),'%.0f')])

        IndexIni = ceil(Size_old/2) - floor((Size_new-1)/2) - 1;

        Image_crp = Input(  IndexIni(1) + ( 1 :  Size_new(1) ) , ...
                            IndexIni(2) + ( 1 :  Size_new(2) ) , :);
    end
    
    function Image_pin = O10_pixelBinning(Image_origin, Numbe_origin)      
    %     tic
    %     Image_org = P20_NIP_CSFOdd;
    %     Numbe_org = Data_05_Rifine;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     U_Image_show_16(1501,Image_org)
    %     U_Image_show_16(1502,Image_pin)

    %     tsta = toc();
    %     disp(tsta);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %     Illustration how codes works
    %         tst_1 = reshape(1:54,6,9)
    %         m=size(     tst_1) 
    %         s=m/3
    %         a    = kron(eye(s(1)),ones(1,3))
    %         b    = a'
    %         c    = kron(eye(s(2)),ones(3,1))
    %         tst_2 = a*tst_1*c
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


            Image_org_size = size(    Image_origin     ,1);                           %   精细像尺寸
            flag__odd_even = xor( mod(Image_org_size,2),mod(Numbe_origin,2));
        if  flag__odd_even
            Image_modify = kron(     Image_origin,ones(2));
            Numbe_modify =           Numbe_origin*     2  ;
        else
            Image_modify =           Image_origin         ;
            Numbe_modify =           Numbe_origin         ;
        end

            Image_modify_size = size(    Image_modify     ,1);
            Image_modify_half = floor(   Image_modify_size/2);
            Numbe_modify_half = floor(   Numbe_modify     /2);

        if(mod(Numbe_modify,2))                                                   % 降采样像起始点坐标偏移
            Image_origin_cut  = mod(Image_modify_half-Numbe_modify_half,Numbe_modify)  ;   
        else
            Image_origin_cut  = mod(Image_modify_size                  ,Numbe_modify)/2;   
        end
            Image_pinned_ini  =         1             +Image_origin_cut;                 % 降采样像起始坐标
            Image_pinned_end  =      Image_modify_size-Image_origin_cut;                 % 降采样像终止坐标
            Image_pinned_size = ( 1+ Image_pinned_end -Image_pinned_ini)/Numbe_modify;      % 降采样像尺寸

            %%%%%%%%%%%%%%%%%% PIXEL BINNING  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            Image_pin_Temp =gpuArray(Image_modify(Image_pinned_ini : Image_pinned_end ,...
                                                  Image_pinned_ini : Image_pinned_end ) );
            DownS_Matrix_L  = kron( gpuArray.eye( Image_pinned_size),gpuArray.ones(1,Numbe_modify));
            DownS_Matrix_R  = kron( gpuArray.eye( Image_pinned_size),gpuArray.ones(Numbe_modify,1));
            Image_pin       = gather(DownS_Matrix_L*Image_pin_Temp*DownS_Matrix_R);
    end
    
    function Image_pin = O12_pixelBinning_3D(Image_origin, Numbe_origin)   
        %%%%%%%%%%%%%%%%%% PIXEL BINNING  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        IMG_TP_size = size(Image_origin);
        IMG_EX_size = IMG_TP_size/Numbe_origin;
        DownS_MAT_L = kron(eye(IMG_EX_size(1)),ones(1,Numbe_origin));
        DownS_MAT_R = kron(eye(IMG_EX_size(2)),ones(Numbe_origin,1));
        Image_pin   = DownS_MAT_L*Image_origin*DownS_MAT_R;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
    
    function Image_Figure = V40_NorGPU_one(Image_Data)                     
    %Show normalized image   
        Image_Data_G = double(Image_Data);
        Image_Figure =        Image_Data_G/max(Image_Data_G(:));
    end
    
    function [] = S30_Imsave(Data_norm,Image_Path,Image_form)
%         Data_norm = P62_FLF_PSF3Dn_nor;
%         Image_Path= Path_s316_PSF3DN;
%         Image_form= Data_01_formIm;
%         clear Data_norm;
        
        Img_16bit = uint16(Data_norm*65535);                               
        for idxzz = 1:size(Data_norm,3)                                    
            imwrite(Img_16bit(:,:,idxzz),[Image_Path,Image_form],'WriteMode','append');
            disp(idxzz)
        end
    end

    function [] = S65_Imsave(Data_norm,Image_Path,Image_form)
%         Data_norm  = P62_FLF_PSF3Dn_nor;
%         Image_Path = Path_s316_PSF3DN;
%         Image_form = Data_01_formIm;

            Index_Sat    = 1;
            MaxIntensity  = 65535;
            Colormap_bt16 = jet(MaxIntensity+1);
            Image_Colobar = repmat(reshape(jet(256),[256,1,3]),[1,256/8,1]);
            figure,imshow(Image_Colobar);
            
            Scale_size = size(Colormap_bt16);
            Image_size = size(Data_norm   );

            Image_norm = rescale(single(Data_norm));

           [Image_MaxZval,Image_MaxZpos]= max( reshape(Image_norm   ,[Image_size(1)*Image_size(2)  ,Image_size(3)]),[],2);
            Image_colcpos               = ceil(reshape(Image_MaxZpos,[Image_size(1),Image_size(2)])/Image_size(3)*Scale_size(1) );
            Image_colZval               =      reshape(Image_MaxZval,[Image_size(1),Image_size(2)]);

            Stack_Coltemp = zeros([Image_size(1:2),3]);

        for idyy = 1:Image_size(1)
        for idxx = 1:Image_size(2)
            Stack_Coltemp(idyy,idxx,:) = Colormap_bt16(Image_colcpos(idyy,idxx),:).*Image_colZval(idyy,idxx);
        end
        end
            Stack_Colcode = uint16(Stack_Coltemp*MaxIntensity*Index_Sat);
            figure;imshow(Stack_Colcode)
            figure;imshow(Image_Colobar)
            Save_Path = [Image_Path,'jet'];                                 mkdir(Save_Path);
            imwrite(Stack_Colcode,[Save_Path,'_Img',Image_form]);
            imwrite(Image_Colobar,[Save_Path,'_Map',Image_form]);
    end
    
end























