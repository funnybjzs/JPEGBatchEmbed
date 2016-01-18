function cover_ppmm=JStegPPM(cover,var,ppm_dir)
[fpath,fname,fext]=fileparts(cover);
if(strfind(fpath,'big')>0)
      img=imread(fullfile([var.pngdir '\png_0_big'],[fname '.png']));
elseif(strfind(fpath,'mid')>0)
      img=imread(fullfile([var.pngdir '\png_0_mid'],[fname '.png']));
elseif(strfind(fpath,'sml')>0)
      img=imread(fullfile([var.pngdir '\png_0_sml'],[fname '.png']));
else
end
    cover_ppmm=fullfile(ppm_dir,[fname '.ppm']);
    imwrite(img,cover_ppmm);
end