function JPEGBatchEmbed(imgdir,var)
%дlog
f = fopen('stego_make.txt', 'a', 'n', 'UTF-8');
for d=1:length(imgdir)
        stego_dir{d}=[imdir{d} '_stego'];
        msg_dir{d}=[imgdir{d} '_msg'];
        mkdir(stego_dir{d});
        mkdir(msg_dir{d});
        %��ʼ��COVER�ļ����µ�ͼƬ����Ƕ��
        files=dir([imgdir{d} '\*.jpg']);
        share=fix(numel(files)/var.embednum);
        share_last=mod(numel(files),var.embednum);
        for (id=1:numel(files))
            try

            catch ex
                WriteLog(f,[cover_dirs{j,k} '\' files(id).name],ex.getReport);
            end
        end
        
    end
end



end