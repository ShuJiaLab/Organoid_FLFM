function [] = S69_Imsave_B16_DepthC_Col(Image_Path,Image_form,Image_Data,Index_Col,Flag_File,Index_Sat,Index_Rev)

% Image_Data = RecWFM_74_Crpimg;
% Image_Path = [WFM_ExpFLF_saveUniN,'_','74_Crpnor'];
% Image_form = Data_01_formIm;

% Image_Data = RecFLF_85_Flpnor;
% Image_Path = [Path_s408_FLFLsp,Path_s043_DepFRM];
% Image_form = Data_01_formIm;

    MaxIntensity = 65535;
   [Colormap_bt16,Image_Colobar,Test_Col] = U06_Color_B16(Index_Col);
    if (Index_Rev)
        Colormap_bt16 = flip( Colormap_bt16);
        Image_Colobar = rot90(Image_Colobar,3);
    end
        Scale_size = size(Colormap_bt16);
        Image_size = size(Image_Data   );
        
        Image_norm = rescale(single(Image_Data));

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
        Save_Path = [Image_Path,Test_Col];                                 mkdir(Save_Path);
    if(Flag_File)
        imwrite(Stack_Colcode,[Save_Path,'\Img',Image_form]);
        imwrite(Image_Colobar,[Save_Path,'\Map',Image_form]);
    else
        imwrite(Stack_Colcode,[Save_Path,'_Img',Image_form]);
        imwrite(Image_Colobar,[Save_Path,'_Map',Image_form]);
    end
end
    
    
    
    
