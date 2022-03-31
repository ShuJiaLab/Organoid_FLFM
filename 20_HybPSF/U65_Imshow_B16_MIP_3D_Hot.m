function [] = U65_Imshow_B16_MIP_3D_Hot(Image_Data) 
%Show max projection of image in 3D direction
% Image_Data = FLF_HyRPSF_Rez;
    Image_norm   = rescale(double(Image_Data));
    
    Image_MaxP_x = squeeze(max(Image_norm,[],1))';
    Image_MaxP_y = squeeze(max(Image_norm,[],2));
    Image_MaxP_z = squeeze(max(Image_norm,[],3));
    
    Image_size = [size(Image_norm,1),size(Image_norm,2),size(Image_norm,3)];
    Seam__size = ceil(Image_size(1)/30);
%     Seam__size = 1;
    Maxpr_size = Image_size(3) + Seam__size + Image_size(1);
    Image_MaxP = ones(Maxpr_size,Maxpr_size);
    Image_MaxP( 1:Image_size(1)                              ,                              1:Image_size(2))   = Image_MaxP_z;
    Image_MaxP( 1:Image_size(1)                              ,Image_size(2) + Seam__size + (1:Image_size(3)) ) = Image_MaxP_y;
    Image_MaxP((1:Image_size(3)) + Image_size(1) + Seam__size,                              1:Image_size(2)  ) = Image_MaxP_x;
%                                                                            figure;imshow(Image_MaxP)
    Image_MaxP_hot = ind2rgb(uint16(Image_MaxP*65536),hot(65536));         figure;imshow(Image_MaxP_hot)
end
