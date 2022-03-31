function [] = S30_Imsave(Image_Path,Image_form,Image_data)
% Data_10_File  = File_42_FLF_Fixexp_Proc
% Data_11_strhd = FLFPSF_48_fix_strhd
% Data_11_strtl = FLFPSF_48_fix_strtl
% Data_13_FOVZu = +0*10^-6
% Data_13_FOVZl = -0*10^-6
% Data_14_STP_Z = 1.0*10^-6
% Data_12_dzstr = Recons_07_dzstr
% Data_12_zcstr = Recons_07_zcstr
% Data_19_form  = Data_01_formIm

    Image_Length = size(Image_data,3);
    for idxk = 1:Image_Length                                  
        imwrite(Image_data(:,:,idxk),[Image_Path,Image_form],'WriteMode','append');
    end
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        