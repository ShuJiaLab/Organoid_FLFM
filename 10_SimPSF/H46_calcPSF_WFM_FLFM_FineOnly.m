function [] = H46_calcPSF_WFM_FLFM_FineOnly(Path_s11c_unifor , Path_s31c_unifor , Data_06_CCD_RF  , Flag_WFMPSFOnly ,...
                                            P27_NIP_RefAr_Odd, P27_NIP_RefAr_Eve, P47_MLA_NumAdSim, P47_MLA_NumAd_RF,...
                                            Flag_Startpoint  , Flag_Finalpoint  , Object_33_NumZd , Object_35_ZCoor ,...
                                            Step_NIP_Finetune, Fl_01_obj, Ma_06_Mic, NA_01_obj, Ind01_obj, lambdaAir,...
                                            Step_Propergation, NIP_SegSZ, dis_04_em, det_08MLA, dis_05_mc, lambdaLen,...
                                            Flag_Profilesim  , P41_Fou_MLATra , P42_Fou_MLAApt,...
                                            Data_02_formDt   , Data_01_formIm , Data_00_maxval)
% 
% flag_profilesim = 1

    for idxta = 1                                                          % PSF name set                      
        Path_s111_NIPodd = [Path_s11c_unifor,'_','2_NIPodd_Fine'];
        Path_s111_NIPeve = [Path_s11c_unifor,'_','2_NIPeve_Fine'];
        Path_s311_NIPodd = [Path_s31c_unifor,'_','2_NIPodd_Fine'];
        Path_s311_NIPeve = [Path_s31c_unifor,'_','2_NIPeve_Fine'];
        Path_s312_MLACSF = [Path_s31c_unifor,'_','3_MLACSF_Fine'];
        Path_s315_CCDCSF = [Path_s31c_unifor,'_','5_CCDCSF_Fine'];
        Path_s31A_CSFPrf = [Path_s31c_unifor,'_','A_PROFIL_Fine'];
        Path_s31A_CSFrgb = [Path_s31c_unifor,'_','A_PROFIL_rgbc'];
    end
    for idxta = 1                                                          % NIP stoper and size set           
        P20_NIP_CoorR_Odd = (-P27_NIP_RefAr_Odd:1:P27_NIP_RefAr_Odd)*Data_06_CCD_RF;           % native image plane 上x轴坐标，用作模拟
        P20_NIP_CoorR_Eve = (-P27_NIP_RefAr_Eve:1:P27_NIP_RefAr_Eve)*Data_06_CCD_RF;           % native image plane 上x轴坐标，用作模拟
    end

    for idxk  = Flag_Startpoint:Flag_Finalpoint                            % Wave propogation and CSF save     
%                 idxk  = 151;
                Path_s31c_zdepth = [num2str(idxk,'%03d'),'_',num2str(Object_35_ZCoor(idxk)*1e6,'%+08.3f'),'um'];
                P20_NIP_CSFOdd = H13_calcPSF_Single_GPU_3_SAccelerate_V7_Segment(  ...
                                         Step_NIP_Finetune, Object_35_ZCoor(idxk), P20_NIP_CoorR_Odd , P20_NIP_CoorR_Odd ,...
                                         Fl_01_obj, Ma_06_Mic, NA_01_obj, Ind01_obj , lambdaAir  , Data_00_maxval, NIP_SegSZ);       % CSF In Image plane.
%                 P20_NIP_CSFEve = H13_calcPSF_Single_GPU_3_SAccelerate_V7_Segment(  ...
%                                          Step_NIP_Finetune, Object_35_CoorZ(idxk), P20_NIP_CoorR_Eve , P20_NIP_CoorR_Eve ,...
%                                          Fl_01_obj, Ma_06_Mic, NA_01_obj, Ind01_obj , lambda  , Data_00_maxval, segsize);       % CSF In Image plane.
                
                P21_NIP_PSFOdd = abs(P20_NIP_CSFOdd).^2;
%                 P21_NIP_PSFEve = abs(P20_NIP_CSFEve).^2;
        if (Flag_WFMPSFOnly==1)                                            % MLA & CSF on CCD plane simulation
                save([                                         Path_s111_NIPodd,'_',Path_s31c_zdepth,Data_02_formDt],'P20_NIP_CSFOdd','-v7.3');
                save([                                         Path_s111_NIPeve,'_',Path_s31c_zdepth,Data_02_formDt],'P20_NIP_CSFEve','-v7.3');
                imwrite(uint16(rescale(P21_NIP_PSFOdd)*65535),[Path_s111_NIPodd,'_',Path_s31c_zdepth,Data_01_formIm]);
                imwrite(uint16(rescale(P21_NIP_PSFEve)*65535),[Path_s111_NIPeve,'_',Path_s31c_zdepth,Data_01_formIm]);
        else
            if mod(P47_MLA_NumAdSim , 2)
                P20_NIP_CSFunc  =  P20_NIP_CSFOdd ;
            else
                P20_NIP_CSFunc  =  P20_NIP_CSFEve ;
            end
                P27_NIP_NumAdCSF= size(P20_NIP_CSFunc,1);
            if(    P47_MLA_NumAdSim > P27_NIP_NumAdCSF )
                P20_NIP_Stoper = P20_Zeropad_centerS( I30_Stop_Modulation( P27_NIP_NumAdCSF ), P47_MLA_NumAdSim);
                P20_NIP_CSFStp = P20_Zeropad_centerS( P20_NIP_CSFunc,      P47_MLA_NumAdSim ).*P20_NIP_Stoper   ;
            else
                P20_NIP_Stoper = P35_Imgcrop_centerS( I30_Stop_Modulation( P27_NIP_NumAdCSF ), P47_MLA_NumAdSim);
                P20_NIP_CSFStp = P35_Imgcrop_centerS( P20_NIP_CSFunc,      P47_MLA_NumAdSim ).*P20_NIP_Stoper   ;
            end
                                                                           % Stp & CSF on MIC plane simulation
            if (Flag_Profilesim==0)                                        % MLA & CSF on CCD plane simulation
                P30_Fou_CSFunc                 = J31_OFT_Lens_Vol_GPU(        lambdaAir, P20_NIP_CSFStp, Data_06_CCD_RF, dis_04_em, Step_Propergation);
                P401Fou_CSFunc = P30_Fou_CSFunc.*P41_Fou_MLATra;
                P402Fou_CSFunc                 = J21_OFT_Vol_GPU(             lambdaLen, P401Fou_CSFunc, Data_06_CCD_RF, det_08MLA, Step_Propergation);
                P403Fou_CSFunc = P402Fou_CSFunc.*P42_Fou_MLAApt;
                P50_Cam_CSFtem                 = J21_OFT_Vol_GPU(             lambdaAir, P403Fou_CSFunc, Data_06_CCD_RF, dis_05_mc, Step_Propergation);
            else
               [P30_Fou_CSFunc , PA0_Pr1_CSFunc]=J32_OFT_Lens_Vol_Profile_GPU(lambdaAir, P20_NIP_CSFStp, Data_06_CCD_RF, dis_04_em, Step_Propergation);
                P401Fou_CSFunc = P30_Fou_CSFunc.*P41_Fou_MLATra;
               [P402Fou_CSFunc , PA0_Pr3_CSFunc]=J22_OFT_Vol_Proflie_GPU(     lambdaLen, P401Fou_CSFunc, Data_06_CCD_RF, det_08MLA, Step_Propergation);
                P403Fou_CSFunc = P402Fou_CSFunc.*P42_Fou_MLAApt;
                
                for idxsg = 1                                              % Test codes    
%                     Fl_04bMLA = 27.1*1e-3;          %get
%                     del_01_oo = 0;                                                      %get
%                     del_02_ot = 0;                                                      %get
%                     del_03_te = 0;                                                      %get
%                     del_04_em = 0;                                                      %get
%                     del_05_mc = 0;                                                      %get
%                     dell05_mc  = del_05_mc/Fl_04_MLA;                                    
%                     del_06_ti = 0;                                                      %get
%                     del_07_ec = 0;                                                      %get
%                     %Distance
%                     dis_01_oo  = del_01_oo + Fl_01_obj;                                  %get
%                     dis_02_ot  = del_02_ot + Fl_01_obj + Fl_02_tub;                      %get
%                     dis_03_te  = del_03_te + Fl_02_tub + Fl_03_ent;                      %get
%                     dis_04_em  = del_04_em + Fl_03_ent;                                  %get
%                     dis_05_mc  = del_05_mc + Fl_04bMLA;                                  %get
%                     dis_06_ti  = del_06_ti + Fl_02_tub + Fl_07_img;                      %get
%                     dis_07_ec  = del_07_ec + Fl_03_ent;                                  %get
                end
               [P50_Cam_CSFtem , PA0_Pr2_CSFunc]=J22_OFT_Vol_Proflie_GPU(     lambdaAir, P403Fou_CSFunc, Data_06_CCD_RF, dis_05_mc, Step_Propergation);
            end
                P50_Cam_CSFunc = P35_Imgcrop_centerS( P50_Cam_CSFtem, P47_MLA_NumAd_RF  );
                P31_Fou_PSFunc = abs(P30_Fou_CSFunc).^2;
                P51_Cam_PSFunc = abs(P50_Cam_CSFunc).^2;
                
                save([                                         Path_s311_NIPodd,'_',Path_s31c_zdepth,Data_02_formDt],'P20_NIP_CSFOdd','-v7.3');
%                 save([                                         Path_s311_NIPeve,'_',Path_s31c_zdepth,Data_02_formDt],'P20_NIP_CSFEve','-v7.3');
%                 save([                                         Path_s312_MLACSF,'_',Path_s31c_zdepth,Data_02_formDt],'P30_Fou_CSFunc','-v7.3');
                save([                                         Path_s315_CCDCSF,'_',Path_s31c_zdepth,Data_02_formDt],'P50_Cam_CSFunc','-v7.3');
                imwrite(uint16(rescale(P21_NIP_PSFOdd)*65535),[Path_s311_NIPodd,'_',Path_s31c_zdepth,Data_01_formIm]);
%                 imwrite(uint16(rescale(P21_NIP_PSFEve)*65535),[Path_s311_NIPeve,'_',Path_s31c_zdepth,Data_01_formIm]);
%                 imwrite(uint16(rescale(P31_Fou_PSFunc)*65535),[Path_s312_MLACSF,'_',Path_s31c_zdepth,Data_01_formIm]);
                imwrite(uint16(rescale(P51_Cam_PSFunc)*65535),[Path_s315_CCDCSF,'_',Path_s31c_zdepth,Data_01_formIm]);
            if (Flag_Profilesim==1)
                PA0_PrL_CSFunc =     cat(2,   PA0_Pr1_CSFunc,PA0_Pr3_CSFunc,PA0_Pr2_CSFunc);
                PA1_PrL_PSFunc =     abs(     PA0_PrL_CSFunc).^2                           ;
                PA2_PrL_PSFave =              PA1_PrL_PSFunc .^0.2                         ;
                save([                                         Path_s31A_CSFPrf,'_',Path_s31c_zdepth,Data_02_formDt],'PA0_PrL_CSFunc','-v7.3');
                imwrite(uint16(rescale(PA2_PrL_PSFave)*65535),[Path_s31A_CSFPrf,'_',Path_s31c_zdepth,Data_01_formIm]);
                figure;imshow( uint16(rescale(PA2_PrL_PSFave)*65535)*2)
                for idxtst = 1                                             % Test codes    
%                     tst = rescale(abs( cat(2,PA0_Pr3_CSFunc,PA0_Pr2_CSFunc) ).^2).^0.2*1;
%                     figure;imshow(tst(2780:3350,:))
%                     figure;imshow(tst*10)
%                     figure;imshow(PA2_PrL_PSFave*10)
% 
%                     figure;imshow( uint16(rescale(PA2_PrL_PSFave)*65535))
%                     figure;plot(1:size(PA2_PrL_PSFave,2),PA2_PrL_PSFave(3045,:))
%                     figure;plot(1:size(PA2_PrL_PSFave,2),PA2_PrL_PSFave(2030,:))
%                     figure;imshow( uint16(rescale(P51_Cam_PSFunc)*65535)*2)
                end
            end
        end
    end
       
    function size_new  = P17_ParityMatch_Min(size_old,size_cmp)            
    %  To match the parity of number 1 and number 2
    % This is the test

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % tst1 = [3,4,4,3];                   disp(tst1)
    % tst2 = [3,3,4,4];                   disp(tst2)
    % tst3 = P20_ParityMatch(tst1,tst2);  disp(tst3)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        size_new = size_old - xor(mod(size_old,2),mod(size_cmp,2));
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
    %  Input = I30_Stop_Modulation( P27_NIP_NumAdCSF );
    %  Side_Long = P47_MLA_NumAdSim;
    %  P20_NIP_Stoper = Image_pad;
    %     Input     = P20_NIP_CSFunc;
    %     Side_Long = P47_MLA_NumAdSim;
    %     P20_NIP_CSFStp = Image_pad.*P20_NIP_Stoper;
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
    
end



















