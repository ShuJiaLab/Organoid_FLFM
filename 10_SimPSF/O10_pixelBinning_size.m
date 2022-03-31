
function Image_pin_size = O10_pixelBinning_size(Size_org, Numb_org)
%     tic
%     Image_org = P20_NIP_CSFOdd;
%     Numbe_org = Data_05_Rifine;
% Size_org = 21
% Numb_org = 4
% 
% Size_org = ObjRez_13_numRd
% Numb_org = FLF_SubPSF_rez_Num
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Illustration how codes works
% disp(O10_pixelBinning_size(16,4)-4)
% disp(O10_pixelBinning_size(18,4)-4)
% disp(O10_pixelBinning_size(20,4)-5)
% disp(O10_pixelBinning_size(17,4)-4)
% disp(O10_pixelBinning_size(19,4)-4)
% disp(O10_pixelBinning_size(21,4)-5)
% disp(O10_pixelBinning_size(15,3)-5)
% disp(O10_pixelBinning_size(17,3)-5)
% disp(O10_pixelBinning_size(19,3)-5)
% disp(O10_pixelBinning_size(20,3)-6)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        flag__odd_even = xor( mod(Size_org,2),mod(Numb_org,2));            %   精细像尺寸同放大倍数奇偶性是否一致
    if  flag__odd_even                                                     %   精细像尺寸同放大倍数奇偶性一致
        size_modify = Size_org*2;
        Numb_modify = Numb_org*2;
    else
        size_modify = Size_org  ;
        Numb_modify = Numb_org  ;
    end
    
        size_modify_half = floor(size_modify/2);
        Numb_modify_half = floor(Numb_modify/2);
    
    if(mod(Numb_modify,2))                                                 % 降采样像起始点坐标偏移
        size_org_cut  = mod(size_modify_half - Numb_modify_half ,Numb_modify)  ;   
    else
        size_org_cut  = mod(size_modify                         ,Numb_modify)/2;   
    end
        Image_pin_ini  =     1       + size_org_cut;                              % 降采样像起始坐标
        Image_pin_end  = size_modify - size_org_cut;                              % 降采样像终止坐标
        Image_pin_size =   ( 1       + Image_pin_end -Image_pin_ini)/Numb_modify; % 降采样像尺寸
end

