function MME(id,d,cover,stego,msgpath,var,f_log)
    jobj=jpeg_read(cover);
    accnt=sum(jobj.coef_arrays{1,1}(:)~=0)-jobj.image_width*jobj.image_height/64;
    ern=length(var.embedrate);
    for i=1:ern
        if (mod(id,ern)==i-1)
            er=var.embedrate(i);
            msglength=floor(accnt*var.embedrate(i)/8);
            break;
        end
    end
    [fpath,fname,fext]=fileparts(cover);  
    MsgFile=[msgpath '\' fname '.bin'];
    GenMsg(id, msglength, MsgFile);
    
    [~,msg]=system(['java.exe -Xmx1024M -jar ' [var.exe '\mme.jar embed -me 2 -e '] MsgFile ' -p ' var.password ' -q ' num2str(var.qf(d)) ' ' cover ' ' stego]);
    if (msg(1)=='F' && msg(2)=='5' && exist(stego,'file'))
        delete(stego);
        fprintf(f_log,'处理 第%d 张图像 %s [fail]。[MME，嵌入率%f，质量因子%d]。\n',id,[fname,fext],er,var.qf(d));
        fprintf('处理 第%d 张图像 %s [fail]。[MME，嵌入率%f，质量因子%d]。\n',id,[fname,fext],er,var.qf(d));
    else
        fprintf(f_log,'处理 第%d 张图像 %s [OK]。[MME，嵌入率%f，质量因子%d]。\n',id,[fname,fext],er,var.qf(d));
        fprintf('处理 第%d 张图像 %s [OK]。[MME，嵌入率%f，质量因子%d]。\n',id,[fname,fext],er,var.qf(d));
    end
end