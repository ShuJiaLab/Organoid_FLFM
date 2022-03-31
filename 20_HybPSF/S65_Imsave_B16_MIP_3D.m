function [] = S65_Imsave_B16_MIP_3D(Image_Path,Image_form,Image_Data,Flag_File)

%     Image_Data = FLF_ExpPSF_Nor;
%     Index_Col  = 'green'
%     Image_Path = [WFM_ExpFLF_saveUniN,'_','74_Flpnor',WFM_ExpImg_saveDept];
%     Image_form = Data_01_formIm;
%     Flag_File  = 1;
    
        MaxIntensity  = 65535;
        Colormap_bt16 = hot(MaxIntensity+1);
        
        Image_Norm   = uint16(rescale(double(Image_Data),0,MaxIntensity));
        
        Image_MIPX   = squeeze(max(Image_Norm,[],1))';
        Image_MIPY   = squeeze(max(Image_Norm,[],2)) ;
        Image_MIPZ   = squeeze(max(Image_Norm,[],3)) ;
        
        Image_size   =[size(Image_Data,1),size(Image_Data,2),size(Image_Data,3)];
        
        Blank_size   = ceil(Image_size(1)/30);
        Maxpx_size   = Image_size(3) + Blank_size + Image_size(2);
        Maxpy_size   = Image_size(3) + Blank_size + Image_size(1);
        
        Image_MaxP   = uint16( ones( Maxpy_size, Maxpx_size )* MaxIntensity);
        Image_MaxP(   1:Image_size(1)                              , 1:Image_size(2)                                ) = Image_MIPZ;
        Image_MaxP(   1:Image_size(1)                              ,(1:Image_size(3)) + Image_size(2) + Blank_size  ) = Image_MIPY;
        Image_MaxP(  (1:Image_size(3)) + Image_size(1) + Blank_size, 1:Image_size(2)                                ) = Image_MIPX;
        
        Image_MIPX16 = uint16( ind2rgb( Image_MIPX , Colormap_bt16 )* MaxIntensity );
        Image_MIPY16 = uint16( ind2rgb( Image_MIPY , Colormap_bt16 )* MaxIntensity );
        Image_MIPZ16 = uint16( ind2rgb( Image_MIPZ , Colormap_bt16 )* MaxIntensity );
        Image_MaxP16 = uint16( ind2rgb( Image_MaxP , Colormap_bt16 )* MaxIntensity );

        Image_MaxP16((1:Blank_size   ) + Image_size(1)             ,  :                                           ,:) = MaxIntensity;
        Image_MaxP16(                  :                           ,(1:Blank_size   ) + Image_size(2)             ,:) = MaxIntensity;
        Image_MaxP16((1:Image_size(3)) + Image_size(1) + Blank_size,(1:Image_size(3)) + Image_size(2) + Blank_size,:) = MaxIntensity;
        
        imshow(Image_MaxP  );
        imshow(Image_MaxP16);
        
        Save_Path =         [Image_Path,'_','MIP3D'];              
    if (Flag_File)
        mkdir(Save_Path);
        imwrite(Image_MIPX  ,[Save_Path,'\','Ind_X',Image_form]);
        imwrite(Image_MIPY  ,[Save_Path,'\','Ind_Y',Image_form]);
        imwrite(Image_MIPZ  ,[Save_Path,'\','Ind_Z',Image_form]);
        imwrite(Image_MaxP  ,[Save_Path,'\','Ind3D',Image_form]);
        
        imwrite(Image_MIPX16,[Save_Path,'\','Col_X',Image_form]);
        imwrite(Image_MIPY16,[Save_Path,'\','Col_Y',Image_form]);
        imwrite(Image_MIPZ16,[Save_Path,'\','Col_Z',Image_form]);
        imwrite(Image_MaxP16,[Save_Path,'\','Col3D',Image_form]);
    else
        imwrite(Image_MaxP   ,[Save_Path,'_','Col3D',Image_form]);
        imwrite(Image_MaxP16 ,[Save_Path,'_','Ind3D',Image_form]);
    end
end
    
    
    
    
    
    
    
    
    
    
