close all;
clear all;
clc;

saveDir = fullfile('~','Dropbox','MsVideo','Notes','FluorescencePaperV2','Figures');


fName = fullfile(fiToolboxRootPath,'results','evaluation','McNamara-Boswell_simQe_Fl.mat');
load(fName);

lw = 1;
ms = 5;
sz = [1 1 9 4];
fs = 6;

figure;
hold all; grid on; box on; 
errorbar(flQe,totalPixelErr,totalPixelStd/sqrt(24),'-rs','lineWidth',lw,'markersize',ms);
errorbar(flQe,reflErr,reflStd/sqrt(24),'-gd','lineWidth',lw,'markersize',ms);
errorbar(flQe,exNormErr,exNormStd/sqrt(24),'-ob','lineWidth',lw,'markersize',ms);
errorbar(flQe,emNormErr,emNormStd/sqrt(24),'-^c','lineWidth',lw,'markersize',ms);
set(gca,'xscale','log');
set(gca,'yscale','log');
set(gca,'fontsize',fs-2);
set(gcf,'PaperUnits','centimeters');
set(gcf,'PaperPosition',sz);
xlabel('Practical efficiency','fontsize',fs);
ylabel('RMSE','fontsize',fs);
lg = legend('Pixel','Reflectance','Excitation','Emission','location','northeast','fontsize',fs-2);
set(lg,'location','northeast');
grid minor;


fName = fullfile(saveDir,'fluorophoreQe.eps');
print('-depsc',fName);
