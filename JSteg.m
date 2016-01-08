function JSteg(id,d,cover,stego,msgpath,var)
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
    
    command=[[var.exe '\cjpeg.exe -quality '] num2str(var.qf(d)) ' -steg ' MsgFile ' ' cover ' ' stego];
    [~,~]=system(command);
end