function JPEGBatchEmbed(imgdir,var)
%дlog
f = fopen('stego_make.txt', 'a', 'n', 'UTF-8');
f_log=fopen('stego_log.txt', 'a', 'n', 'UTF-8');
for d=1:length(imgdir)
    stego_dir{d}=[imgdir{d} '_stego'];
    msg_dir{d}=[imgdir{d} '_msg'];
    jstegppm_dir{d}=[imgdir{d} '_jstegppm'];
    mkdir(stego_dir{d});
    mkdir(msg_dir{d});
    mkdir(jstegppm_dir{d}); %�����png���ɵ�ppm;
    %��ʼ��COVER�ļ����µ�ͼƬ����Ƕ��
    files=dir([imgdir{d} '\*.jpg']);
    shareEach=fix(numel(files)/6);  %6���㷨������������7������ȥ����outguess(�����������ͳһΪ75)
    %log
    fprintf(f_log,'---------------------------\n');
    fprintf(f_log,'[��ʼʱ��: %s]\n',datestr(now,'yy-mm-dd HH:MM:SS'));
    fprintf(f_log,'����Ŀ¼:  %s\n',imgdir{d});
    fprintf(f_log,'��Ŀ¼�¹��� %d ��jpgͼ��\n',numel(files));
    fprintf(f_log,'ƽ��ÿ���㷨��ռ���� %d \r\n',shareEach);
    %print
    fprintf('---------------------------\n');
    fprintf('[��ʼʱ��: %s]\n',datestr(now,'yy-mm-dd HH:MM:SS'));
    fprintf('����Ŀ¼:  %s\n',imgdir{d});
    fprintf('��Ŀ¼�¹��� %d ��jpgͼ��\n',numel(files));
    fprintf('ƽ��ÿ���㷨��ռ���� %d \r\n',shareEach);
    
    for (id=1:numel(files))
        try
            if(id<=shareEach)
                F5(id,d,[imgdir{d} '\' files(id).name],[stego_dir{d} '\' files(id).name],msg_dir{d},var,f_log);
            elseif(id<=2*shareEach)
                JPHS(id,d,[imgdir{d} '\' files(id).name],[stego_dir{d} '\' files(id).name],msg_dir{d},var,f_log);
            elseif(id<=3*shareEach)
                cover_ppm=JStegPPM([imgdir{d} '\' files(id).name],var,jstegppm_dir{d});
                JSteg(id,d,[imgdir{d} '\' files(id).name],[stego_dir{d} '\' files(id).name],msg_dir{d},var,f_log,cover_ppm);
            elseif(id<=4*shareEach)
                NSF5(id,d,[imgdir{d} '\' files(id).name],[stego_dir{d} '\' files(id).name],msg_dir{d},var,f_log);
            elseif(id<=5*shareEach)
                MME(id,d,[imgdir{d} '\' files(id).name],[stego_dir{d} '\' files(id).name],msg_dir{d},var,f_log);
            else
                JLSBM(id,d,[imgdir{d} '\' files(id).name],[stego_dir{d} '\' files(id).name],msg_dir{d},var,f_log);
%             else
%                 Outguess(id,d,[imgdir{d} '\' files(id).name],[stego_dir{d} '\' files(id).name],msg_dir{d},var,f_log);
            end
        catch ex
            WriteLog(f,[imgdir{d} '\' files(id).name],ex.getReport);
        end
    end
    fprintf(f_log,'[����ʱ��: %s]\n',datestr(now,'yy-mm-dd HH:MM:SS'));
    fprintf(f_log,'---------------------------\r\n');
    fprintf('[����ʱ��: %s]\n',datestr(now,'yy-mm-dd HH:MM:SS'));
    fprintf('---------------------------\n');
end
fclose(f_log);
fclose(f);
end