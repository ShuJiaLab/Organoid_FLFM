function I30_Stop_TFunc = I30_Stop_Modulation( I30_Native_23_NumRd )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        I30_Native_23_NumRr = (I30_Native_23_NumRd-1)/2;
        idxxi               = -I30_Native_23_NumRr:+I30_Native_23_NumRr;
        idxet               = -I30_Native_23_NumRr:+I30_Native_23_NumRr;
        [idxxi, idxet]      = meshgrid(idxxi,idxet);                  
        I30_Stop_TFunc      = ones(I30_Native_23_NumRd);
        I30_Stop_TFunc(sqrt(idxxi.^2+idxet.^2)>I30_Native_23_NumRr) = 0;
% figure(9030); imshow(uint16(I30_Stop_TFunc/max(I30_Stop_TFunc(:))*65535));
end
