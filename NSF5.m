function NSF5(id,d,cover,stego,msgpath,var,f_log)
    ern=length(var.embedrate);
    for i=1:ern
        if (mod(id,ern)==i-1)
            embedrate=var.embedrate(i);
            break;
        end
    end
    nsf5_simulation(cover,stego,embedrate,id);
    [fpath,fname,fext]=fileparts(cover); 
    fprintf(f_log,'���� ��%d ��ͼ�� %s [OK]��[NSF5��Ƕ����%f����������%d]��\n',id,[fname,fext],embedrate,var.qf(d));
    fprintf('���� ��%d ��ͼ�� %s [OK]��[NSF5��Ƕ����%f����������%d]��\n',id,[fname,fext],embedrate,var.qf(d));
end