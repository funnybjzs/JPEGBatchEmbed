function Outguess(id,d,cover,stego,msgpath,var,f_log)
    jobj=jpeg_read(cover);
    accnt=sum(jobj.coef_arrays{1,1}(:)~=0)-jobj.image_width*jobj.image_height/64;
    er=0.20; %�̶�Ƕ����;
    msglength=floor(accnt*er/8);
    [fpath,fname,fext]=fileparts(cover);  
    MsgFile=[msgpath '\' fname '.bin'];
    GenMsg(id, msglength, MsgFile);
    %0.1Ƕ����
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
                fprintf(f_log,'���� ��%d ��ͼ�� %s [OK]��[Outguess��Ƕ����%f����������%d]��\n',id,[fname,fext],er,var.qf(d));
                fprintf('���� ��%d ��ͼ�� %s [OK]��[Outguess��Ƕ����%f����������%d]��\n',id,[fname,fext],er,var.qf(d));
                break;
            else%Ƕ��ʧ��
                fprintf(f_log,'���� ��%d ��ͼ�� %s [fail]��[Outguess��Ƕ����%f����������%d]��\n',id,[fname,fext],er,var.qf(d));
                fprintf('���� ��%d ��ͼ�� %s [fail]��[Outguess��Ƕ����%f����������%d]��Fail: %s \n',id,[fname,fext],er,var.qf(d),cmdout);
                if(exist(stego,'file'))
                    delete(stego);   %ɾ��Ƕ��ʧ�ܵ�ͼ��
                end
                if(i==2)
                    delete(cover);
                end
                er=er-0.1;
            end        
end