
imgdir={'D:\JPEG\jpg_80_big','D:\JPEG\jpg_80_mid','D:\JPEG\jpg_80_sml',...
    'D:\JPEG\jpg_90_big','D:\JPEG\jpg_90_mid','D:\JPEG\jpg_90_sml'};
var.embedrate=[0.20 0.25 0.30 0.35 0.40];
var.qf=[80 80 80 90 90 90];
var.password='sklois27';
var.embednum=7;
%制备阳性集
JPEGBatchEmbed(imgdir,var);
