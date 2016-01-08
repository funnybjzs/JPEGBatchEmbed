function JPEGBatchEmbed(imgdir,var)
%写log
f = fopen('stego_make.txt', 'a', 'n', 'UTF-8');
for d=1:length(imgdir)
        stego_dir{d}=[imgdir{d} '_stego'];
        msg_dir{d}=[imgdir{d} '_msg'];
        mkdir(stego_dir{d});
        mkdir(msg_dir{d});
        %开始对COVER文件夹下的图片进行嵌入
        files=dir([imgdir{d} '\*.jpg']);
        shareEach=fix(numel(files)/7);  %7是算法数量
        for (id=1:numel(files))
            try
                if(id<=shareEach)
                   F5(id,d,[imgdir{d} '/' file(id).name],[stego_dir{d} '/' file(id).name],msg_dir{d},var);
                elseif(id<=2*shareEach)
                   JPHS(id,d,[imgdir{d} '/' file(id).name],[stego_dir{d} '/' file(id).name],msg_dir{d},var);
                elseif(id<=3*shareEach)
                    JSteg(id,d,[imgdir{d} '/' file(id).name],[stego_dir{d} '/' file(id).name],msg_dir{d},var);
                elseif(id<=4*shareEach)
                    NSF5(id,d,[imgdir{d} '/' file(id).name],[stego_dir{d} '/' file(id).name],msg_dir{d},var);
                elseif(id<=5*shareEach)
                    MME(id,d,[imgdir{d} '/' file(id).name],[stego_dir{d} '/' file(id).name],msg_dir{d},var);
                elseif(id<=6*shareEach)
                    JLSBM(id,d,[imgdir{d} '/' file(id).name],[stego_dir{d} '/' file(id).name],msg_dir{d},var);
                else
                    Outguess(id,d,[imgdir{d} '/' file(id).name],[stego_dir{d} '/' file(id).name],msg_dir{d},var);
                end   
            catch ex
                WriteLog(f,[cover_dirs{j,k} '\' files(id).name],ex.getReport);
            end
        end   
    end
end