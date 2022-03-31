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
        Image_modify = imresize( Image_origin,      2, 'nearest')/4;
        Numbe_modify =           Numbe_origin*      2 ;
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
    
    

