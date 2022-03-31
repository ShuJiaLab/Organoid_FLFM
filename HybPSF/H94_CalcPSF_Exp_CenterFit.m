function [FLF_ExpPSF_sub_Xmax,FLF_ExpPSF_sub_Ymax,FLF_ExpPSF_sub_Zmax,...
          FLF_ExpPSF_sub_Xpos,FLF_ExpPSF_sub_Ypos,FLF_ExpPSF_sub_Zcen] = H94_CalcPSF_Exp_CenterFit(...
          FLF_DnsPSF_Fit     ,FLF_SimPSF_Bin_Num , Recons_43_NumEd                         ,...
          FLF_ExpPSF_Fit_len ,FLF_SimPSF_Sim_len , FLF_ExpPSF_Fit_Int , FLF_SimPSF_Sim_Int ,...
          FLF_ExpPSF_Sub_Dia ,FLF_SubPSF_fit_rad , FLF_HybPSF_SavePath, Data_01_formIm)
          
%     FLF_SimPSF_Bin_Num = 1;
    
    FLF_ExpPSF_Sub_rad = floor((FLF_ExpPSF_Sub_Dia-1)/2);
    Recons_43_NumEc    = ceil(  Recons_43_NumEd      /2);

    FLF_ExpPSF_sub_Imax = zeros(Recons_43_NumEd,Recons_43_NumEd,FLF_ExpPSF_Fit_len);
    FLF_ExpPSF_sub_Xmax = zeros(Recons_43_NumEd,Recons_43_NumEd,FLF_ExpPSF_Fit_len);
    FLF_ExpPSF_sub_Ymax = zeros(Recons_43_NumEd,Recons_43_NumEd,FLF_ExpPSF_Fit_len);
    FLF_ExpPSF_sub_Zmax = zeros(Recons_43_NumEd,Recons_43_NumEd);
    FLF_ExpPSF_sub_Xfit = zeros(Recons_43_NumEd,Recons_43_NumEd,FLF_ExpPSF_Fit_len);
    FLF_ExpPSF_sub_Yfit = zeros(Recons_43_NumEd,Recons_43_NumEd,FLF_ExpPSF_Fit_len);
    FLF_ExpPSF_sub_Xpos = zeros(Recons_43_NumEd,Recons_43_NumEd,FLF_SimPSF_Sim_len);
    FLF_ExpPSF_sub_Ypos = zeros(Recons_43_NumEd,Recons_43_NumEd,FLF_SimPSF_Sim_len);
        
    for idxxi = 1:Recons_43_NumEd                                          % EXPPSF SubPSF max position located                     
    for idxet = 1:Recons_43_NumEd                                          
            ExpPSF_sub_org           = FLF_DnsPSF_Fit((idxet-1)*FLF_ExpPSF_Sub_Dia + FLF_ExpPSF_Sub_rad + (-FLF_SubPSF_fit_rad : FLF_SubPSF_fit_rad),...
                                                      (idxxi-1)*FLF_ExpPSF_Sub_Dia + FLF_ExpPSF_Sub_rad + (-FLF_SubPSF_fit_rad : FLF_SubPSF_fit_rad),:);
%             [~,  Index_max_org                   ] = max(ExpPSF_sub_org(:));    
%             [~,~,FLF_ExpPSF_sub_Zmax(idxet,idxxi)] = ind2sub(size(ExpPSF_sub_org),Index_max_org);
            
        for idxfr = 1:FLF_ExpPSF_Fit_len                                   
            ExpPSF_sub_rez = imresize(ExpPSF_sub_org(:,:,idxfr),FLF_SimPSF_Bin_Num);
%             imshow(ExpPSF_sub_rez)
            
            [FLF_ExpPSF_sub_Imax(idxet,idxxi,idxfr),  Index_max_rez                   ] = max(ExpPSF_sub_rez(:));    
            [    center_y,center_x               ] = ind2sub(size(ExpPSF_sub_rez),Index_max_rez);
            
            FLF_ExpPSF_sub_Xmax(idxet,idxxi,idxfr) = ((idxxi-1)*FLF_ExpPSF_Sub_Dia + FLF_ExpPSF_Sub_rad -1 -FLF_SubPSF_fit_rad)* FLF_SimPSF_Bin_Num + center_x;
            FLF_ExpPSF_sub_Ymax(idxet,idxxi,idxfr) = ((idxet-1)*FLF_ExpPSF_Sub_Dia + FLF_ExpPSF_Sub_rad -1 -FLF_SubPSF_fit_rad)* FLF_SimPSF_Bin_Num + center_y;
            disp(idxfr)
        end
        disp(idxxi);        disp(idxet);
        
        FLF_ExpPSF_sub_Zmax(idxet,idxxi) = round(W40_GuassianBeam_Rfit_Center(squeeze(FLF_ExpPSF_sub_Imax(idxet,idxxi,:)),1:FLF_ExpPSF_Fit_len,'','','',0)) ;
    end
    end
    FLF_ExpPSF_sub_Zfit = FLF_ExpPSF_sub_Zmax - ceil(FLF_ExpPSF_Fit_len/2);
    FLF_ExpPSF_sub_Zcen = FLF_ExpPSF_sub_Zfit - FLF_ExpPSF_sub_Zfit(Recons_43_NumEc,Recons_43_NumEc); disp(FLF_ExpPSF_sub_Zcen)
    
    for idxxi = 1:Recons_43_NumEd                                          % Fit and locate the lateral shift due to axial variance 
    for idxet = 1:Recons_43_NumEd                                          
            FLF_ExpPSF_sub_Xfit(idxet,idxxi,:) = ceil(polyval(polyfit(FLF_ExpPSF_Fit_Int,squeeze(FLF_ExpPSF_sub_Xmax(idxet,idxxi,:))',1),...
                                                                      FLF_ExpPSF_Fit_Int ) -0.5 );
            FLF_ExpPSF_sub_Yfit(idxet,idxxi,:) = ceil(polyval(polyfit(FLF_ExpPSF_Fit_Int,squeeze(FLF_ExpPSF_sub_Ymax(idxet,idxxi,:))',1),...
                                                                      FLF_ExpPSF_Fit_Int ) -0.5 );
            FLF_ExpPSF_sub_Xpos(idxet,idxxi,:) = ceil(polyval(polyfit(FLF_ExpPSF_Fit_Int,squeeze(FLF_ExpPSF_sub_Xmax(idxet,idxxi,:))',1),...
                                                                      FLF_SimPSF_Sim_Int - FLF_ExpPSF_sub_Zfit(Recons_43_NumEc,Recons_43_NumEc)) -0.5);
            FLF_ExpPSF_sub_Ypos(idxet,idxxi,:) = ceil(polyval(polyfit(FLF_ExpPSF_Fit_Int,squeeze(FLF_ExpPSF_sub_Ymax(idxet,idxxi,:))',1),...
                                                                      FLF_SimPSF_Sim_Int - FLF_ExpPSF_sub_Zfit(Recons_43_NumEc,Recons_43_NumEc)) -0.5);
    end
    end
        figure('Position',[100,100,2400,1200])
    for idxxi = 1:Recons_43_NumEd                                          
    for idxet = 1:Recons_43_NumEd                                          
        subplot(Recons_43_NumEd,Recons_43_NumEd*2,(idxet-1)*Recons_43_NumEd*2+idxxi);
        plot(FLF_ExpPSF_Fit_Int,squeeze(FLF_ExpPSF_sub_Xmax(idxet,idxxi,:)),...
             FLF_ExpPSF_Fit_Int,squeeze(FLF_ExpPSF_sub_Xfit(idxet,idxxi,:)))
        
        subplot(Recons_43_NumEd,Recons_43_NumEd*2,(idxet-1)*Recons_43_NumEd*2+idxxi+Recons_43_NumEd);
        plot(FLF_ExpPSF_Fit_Int,squeeze(FLF_ExpPSF_sub_Ymax(idxet,idxxi,:)),...
             FLF_ExpPSF_Fit_Int,squeeze(FLF_ExpPSF_sub_Yfit(idxet,idxxi,:)))
    end
    end
    saveas(gcf,[FLF_HybPSF_SavePath,'\','ExpPSF_Fitted_Used'    ,Data_01_formIm])
    
    figure('Position',[100,100,2400,1200])
    for idxxi = 1:Recons_43_NumEd                                          
    for idxet = 1:Recons_43_NumEd                                          
        subplot(  Recons_43_NumEd,Recons_43_NumEd*2,(idxet-1)*Recons_43_NumEd*2+idxxi);
        plot(FLF_SimPSF_Sim_Int,squeeze(FLF_ExpPSF_sub_Xpos(idxet,idxxi,:)))
        
        subplot(  Recons_43_NumEd,Recons_43_NumEd*2,(idxet-1)*Recons_43_NumEd*2+idxxi+Recons_43_NumEd);
        plot(FLF_SimPSF_Sim_Int,squeeze(FLF_ExpPSF_sub_Ypos(idxet,idxxi,:)))
    end
    end
    saveas(gcf,[FLF_HybPSF_SavePath,'\','ExpPSF_Fitted_Extented',Data_01_formIm])
    
    figure('Position',[100,100,2400,1200])
    for idxxi = 1:Recons_43_NumEd                                          
    for idxet = 1:Recons_43_NumEd                                          
        subplot(Recons_43_NumEd,Recons_43_NumEd*2,(idxet-1)*Recons_43_NumEd*2+idxxi);
        plot(FLF_ExpPSF_Fit_Int,squeeze(FLF_ExpPSF_sub_Xmax(idxet,idxxi,:)));hold
        plot(FLF_SimPSF_Sim_Int,squeeze(FLF_ExpPSF_sub_Xpos(idxet,idxxi,:)))
        
        subplot(Recons_43_NumEd,Recons_43_NumEd*2,(idxet-1)*Recons_43_NumEd*2+idxxi+Recons_43_NumEd);
        plot(FLF_ExpPSF_Fit_Int,squeeze(FLF_ExpPSF_sub_Ymax(idxet,idxxi,:)));hold
        plot(FLF_SimPSF_Sim_Int,squeeze(FLF_ExpPSF_sub_Ypos(idxet,idxxi,:)))
    end
    end
    saveas(gcf,[FLF_HybPSF_SavePath,'\','ExpPSF_Fitted_All',Data_01_formIm])
    
%     close all;clc;
end




function [CentF] = W40_GuassianBeam_Rfit_Center(y_org,x_org,Titlesave,XLable,Path_save,flag_save) 
%% 高斯拟合
% 
% 版权声明：本文为CSDN博主「四片叶子的三叶草」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
% 原文链接：https://blog.csdn.net/sunzhao1000/java/article/details/86663561
% 
%     x_org = RecFLF_89_coordR' ;
%     y_org = RecWFM_79_Rezpf1;
%     x_stp = 1;
%     Fontsize = 20;
%     data_num = numel(  x_org);
%     y_org    = V40_NorGPU_one(y_org);
%% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
    Fontsize = 20;
    data_num = numel(  x_org);
    x_use    = x_org - (max(x_org)/2);
    y_use    = rescale(double( abs(y_org) ));
%% 
    func_type = fittype('a*exp(-((x-b)/c)^2)+d');                          % 确定高斯函数的表达形式
    % 其中a是振幅，b是期望，c是标准差，d是直流分量
        opts      = fitoptions( 'Method', 'NonlinearLeastSquares' );
        opts.Display = 'Off';
        opts.Lower      = [           -2 -Inf 0];
%         opts.StartPoint = [max(y_org),data_num/2,data_num/2,min(y_org)];
        opts.StartPoint = [max(y_use),-2,data_num/2,min(y_use)];
   [y_fit,~] = fit(x_use',y_use,func_type,opts);                          % 高斯拟合
    FWHMx = 2*sqrt(log(2))*y_fit.c;
    sigma =                y_fit.c;
    CentF =                y_fit.b;
%%  绘图
    figure('Name','profile','InnerPosition',[100 50 600 600]);
    
    ax = subplot(1,1,1);plot(y_fit, x_use, y_use, 'b.');  % 绘制数据点
        legend('Org-data1', 'Fit-data1'                   ,'Fontsize',Fontsize);
        text(x_use(1),0.9,['FWHM:' ,num2str(FWHMx,'%.2f')],'Fontsize',Fontsize);
    if(flag_save ==0)
        text(x_use(1),0.8,['sigma:',num2str(sigma,'%.2f')],'Fontsize',Fontsize);
    end
    title(Titlesave);
%     xticks([x_org(1),0,x_org(end)]);	xticklabels(num2str([x_org(1),0,x_org(end)]'*x_stp,'%.0f'));
    xticks([x_use(1),0,x_use(end)]);	xticklabels([x_use(1),0,x_use(end)]);
    yticks([0,       0.5 ,      1]);	yticklabels([0,       0.5,       1]);
    ylabel(     'Intensity (A.U.)');
    xlabel(     [XLable,'(\mum)'] );    
    ax.FontName = 'New Times Roman'; ax.FontSize = Fontsize;
    Figure_fit = frame2im(getframe(ax)); %imshow(Figure_fit)
%% Save data
    if(flag_save ==1)
        imwrite(Figure_fit,                         [Path_save,'_Fitted_curve','.tif']);
        set(gcf,'renderer','Painters');  saveas(gcf,[Path_save,'_Fitted_curve','.emf']);
    end
end













