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
    fprintf(f_log,'处理 第%d 张图像 %s [OK]。[NSF5，嵌入率%f，质量因子%d]。\n',id,[fname,fext],embedrate,var.qf(d));
    fprintf('处理 第%d 张图像 %s [OK]。[NSF5，嵌入率%f，质量因子%d]。\n',id,[fname,fext],embedrate,var.qf(d));
end