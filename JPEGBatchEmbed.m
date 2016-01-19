function JPEGBatchEmbed(imgdir,var)
%写log
f = fopen('stego_make.txt', 'a', 'n', 'UTF-8');
f_log=fopen('stego_log.txt', 'a', 'n', 'UTF-8');
for d=1:length(imgdir)
    stego_dir{d}=[imgdir{d} '_stego'];
    msg_dir{d}=[imgdir{d} '_msg'];
    jstegppm_dir{d}=[imgdir{d} '_jstegppm'];
    mkdir(stego_dir{d});
    mkdir(msg_dir{d});
    mkdir(jstegppm_dir{d}); %存放用png生成的ppm;
    %开始对COVER文件夹下的图片进行嵌入
    files=dir([imgdir{d} '\*.jpg']);
    shareEach=fix(numel(files)/6);  %6是算法数量，本来是7，但是去掉了outguess(输出质量因子统一为75)
    %log
    fprintf(f_log,'---------------------------\n');
    fprintf(f_log,'[开始时间: %s]\n',datestr(now,'yy-mm-dd HH:MM:SS'));
    fprintf(f_log,'进入目录:  %s\n',imgdir{d});
    fprintf(f_log,'该目录下共有 %d 张jpg图像\n',numel(files));
    fprintf(f_log,'平均每份算法所占份数 %d \r\n',shareEach);
    %print
    fprintf('---------------------------\n');
    fprintf('[开始时间: %s]\n',datestr(now,'yy-mm-dd HH:MM:SS'));
    fprintf('进入目录:  %s\n',imgdir{d});
    fprintf('该目录下共有 %d 张jpg图像\n',numel(files));
    fprintf('平均每份算法所占份数 %d \r\n',shareEach);
    
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
    fprintf(f_log,'[结束时间: %s]\n',datestr(now,'yy-mm-dd HH:MM:SS'));
    fprintf(f_log,'---------------------------\r\n');
    fprintf('[结束时间: %s]\n',datestr(now,'yy-mm-dd HH:MM:SS'));
    fprintf('---------------------------\n');
end
fclose(f_log);
fclose(f);
end