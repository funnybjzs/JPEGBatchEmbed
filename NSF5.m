function NSF5(id,d,cover,stego,msgpath,var)
    for i=1:ern
        if (mod(id,ern)==i-1)
            embedrate=var.embednum(i);
            break;
        end
    end
    nsf5_simulation(cover,stego,embedrate,id);
end