function Image_Figure = V40_NorCPU_one(Image_Data) 
%Show normalized image   
    Image_Data_G = double(Image_Data);
    Image_Figure =        Image_Data_G/max(Image_Data_G(:));
end
                 
