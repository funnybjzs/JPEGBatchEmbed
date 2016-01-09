function JSteg(id,d,cover,stego,msgpath,var,f_log)
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
    
    command=[[var.exe '\cjpeg.exe -quality '] num2str(var.qf(d)) ' -steg ' MsgFile ' ' cover ' ' stego];
    [~,~]=system(command);
    fprintf(f_log,'���� ��%d ��ͼ�� %s [OK]��[JSteg��Ƕ����%f����������%d]��\n',id,[fname,fext],er,var.qf(d));
    fprintf('���� ��%d ��ͼ�� %s [OK]��[JSteg��Ƕ����%f����������%d]��\n',id,[fname,fext],er,var.qf(d));
end