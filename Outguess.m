function Outguess(id,d,cover,stego,msgpath,var,f_log)
    jobj=jpeg_read(cover);
    accnt=sum(jobj.coef_arrays{1,1}(:)~=0)-jobj.image_width*jobj.image_height/64;
    er=0.20; %固定嵌入率;
    msglength=floor(accnt*er/8);
    [fpath,fname,fext]=fileparts(cover);  
    MsgFile=[msgpath '\' fname '.bin'];
    GenMsg(id, msglength, MsgFile);
    %0.1嵌入率
    msglength1=floor(accnt*(er-0.10)/8);
    MsgFile1=[msgpath '\' fname '_.bin'];
    GenMsg(id, msglength1, MsgFile1);
    
    for i=1:2 
        if(i==1)
            command=[[var.exe '\outguess.exe -k '] var.password ' -d ' MsgFile ' ' cover ' ' stego];
        else
            command=[[var.exe '\outguess.exe -k '] var.password ' -d ' MsgFile1 ' ' cover ' ' stego];
        end
            [ret,cmdout]=system(command);
            if(ret==0)
                fprintf(f_log,'处理 第%d 张图像 %s [OK]。[Outguess，嵌入率%f，质量因子%d]。\n',id,[fname,fext],er,var.qf(d));
                fprintf('处理 第%d 张图像 %s [OK]。[Outguess，嵌入率%f，质量因子%d]。\n',id,[fname,fext],er,var.qf(d));
                break;
            else%嵌入失败
                fprintf(f_log,'处理 第%d 张图像 %s [fail]。[Outguess，嵌入率%f，质量因子%d]。\n',id,[fname,fext],er,var.qf(d));
                fprintf('处理 第%d 张图像 %s [fail]。[Outguess，嵌入率%f，质量因子%d]。Fail: %s \n',id,[fname,fext],er,var.qf(d),cmdout);
                if(exist(stego,'file'))
                    delete(stego);   %删除嵌入失败的图像
                end
                if(i==2)
                    delete(cover);
                end
                er=er-0.1;
            end        
end