function [] = S65_Imsave_B16_MIP_3D_Col(Image_Path,Image_form,Image_Data,Index_Col,Flag_File)

%     Image_Data = FLF_SimPSF_sub_rez;
%     Index_Col  = 'green'
%     Image_Path = [WFM_ExpFLF_saveUniN,'_','74_Flpnor',WFM_ExpImg_saveDept];
%     Image_form = Data_01_formIm;
%     Flag_File  = 1;
    
        MaxIntensity  = 65535;
       [Colormap_bt16,Image_Colobar,Test_Col] = U06_Color_B16(Index_Col);
        
        Image_norm   = rescale(double(Image_Data),0,MaxIntensity);
        Image_size   =[size(Image_norm,1),size(Image_norm,2),size(Image_norm,3)];
        Blank_size   = ceil(Image_size(1)/30);
        Maxpx_size   = Image_size(3) + Blank_size + Image_size(2);
        Maxpy_size   = Image_size(3) + Blank_size + Image_size(1);
        
        Image_MaxP_x = uint16( ind2rgb( uint16(squeeze(max(Image_norm,[],1))'), Colormap_bt16 )*MaxIntensity );
        Image_MaxP_y = uint16( ind2rgb( uint16(squeeze(max(Image_norm,[],2)) ), Colormap_bt16 )*MaxIntensity );
        Image_MaxP_z = uint16( ind2rgb( uint16(squeeze(max(Image_norm,[],3)) ), Colormap_bt16 )*MaxIntensity );
        
        Image_MaxP16 = uint16( zeros(Maxpy_size,Maxpx_size,3) );
        Image_MaxP16( 1:Image_size(1)                              , 1:Image_size(2)                              ,:) = Image_MaxP_z;
        Image_MaxP16( 1:Image_size(1)                              ,(1:Image_size(3)) + Image_size(2) + Blank_size,:) = Image_MaxP_y;
        Image_MaxP16((1:Image_size(3)) + Image_size(1) + Blank_size, 1:Image_size(2)                              ,:) = Image_MaxP_x;
        
        Image_MaxP16((1:Blank_size   ) + Image_size(1)             ,  :                                           ,:) = MaxIntensity;
        Image_MaxP16(                  :                           ,(1:Blank_size   ) + Image_size(2)             ,:) = MaxIntensity;
        Image_MaxP16((1:Image_size(3)) + Image_size(1) + Blank_size,(1:Image_size(3)) + Image_size(2) + Blank_size,:) = MaxIntensity;
        
        imshow(Image_MaxP16);
        
        Save_Path =           [Image_Path,'_MIP3D',Test_Col];              
    if (Flag_File)
        mkdir(Save_Path);
        imwrite(Image_MaxP_x ,[Save_Path,'\','X'  ,Image_form]);
        imwrite(Image_MaxP_y ,[Save_Path,'\','Y'  ,Image_form]);
        imwrite(Image_MaxP_z ,[Save_Path,'\','Z'  ,Image_form]);
        imwrite(Image_MaxP16 ,[Save_Path,'\','All',Image_form]);
        
        imwrite(Image_Colobar,[Save_Path,'\','Map',Image_form]);
    else
        imwrite(Image_MaxP16 ,[Save_Path,'_','All',Image_form]);
    end
end
    
    
    
    
    
    
    
    
    
    
