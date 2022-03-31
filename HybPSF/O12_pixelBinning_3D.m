function IMG_EX = O12_pixelBinning_3D(IMG_IN, Pixel_Refine)
    %%%%%%%%%%%%%%%%%% PIXEL BINNING  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     This is a test
%     idxa = 6;     Pixel_Refine = 2
%     idxa = 9;     Pixel_Refine = 3
%         tst1 = reshape(1:idxa^2*2,[idxa,idxa,2])   ; disp(tst1)
%         tst1 =                ones(idxa,idxa,2 )   ; disp(tst1)
%         tst2 = O10_pixelBinning_3D(tst1,Pixel_Refine); disp(tst2)
%         
%         IMG_IN = reshape(1:idxa^2*2,[idxa,idxa,2])   ; disp(IMG_IN)
%         IMG_IN =                ones(idxa,idxa,2 )   ; disp(IMG_IN)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IMG_IN = FLF_HybPSF_Tep;
% Pixel_Refine = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    IMG_TP_size = [size(IMG_IN,1),size(IMG_IN,2),size(IMG_IN,3)];
    IMG_EX_size = [IMG_TP_size(1),IMG_TP_size(2)] /Pixel_Refine ;
    DownS_MAT_L = gpuArray(kron(eye(IMG_EX_size(1)),ones(1,Pixel_Refine)));
    DownS_MAT_R = gpuArray(kron(eye(IMG_EX_size(2)),ones(Pixel_Refine,1)));
    
        IMG_EX= zeros([IMG_EX_size(1),IMG_EX_size(2),IMG_TP_size(3)]);
    for z = 1:IMG_TP_size(3)
        IMG_EX(:,:,z) = gather(DownS_MAT_L*gpuArray(IMG_IN(:,:,z))*DownS_MAT_R);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end