function MME(id,d,cover,stego,msgpath,var)
    jobj=jpeg_read(cover);
    accnt=sum(jobj.coef_arrays{1,1}(:)~=0)-jobj.image_width*jobj.image_height/64;
    ern=length(var.embedrate);
    for i=1:ern
        if (mod(id,ern)==i-1)
            msglength=floor(accnt*var.embednum(i)/8);
            break;
        end
    end
    [fpath,fname,fext]=fileparts(cover);  
    MsgFile=[msgpath '\' fname '.bin'];
    GenMsg(id, msglength, MsgFile);
    
    [~,msg]=system(['java.exe -Xmx1024M -jar ' [var.exe '\mme.jar -me 2 -e '] MsgFile ' -p ' var.password ' -q ' num2str(var.qf(d)) ' ' cover ' ' stego]);
    if (msg(1)=='F' && msg(2)=='5' && exist(stego,'file'))
        delete(stego);
end