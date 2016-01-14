function [img fname fpath cmap] = getImageFromFile
    filterspec = imgformats(1);
    [fname,fpath] = uigetfile(filterspec, 'Select image file');
    if ~ischar(fpath)
        userCanceled = true;
        return
    end
    [img,cmap] = imread(fullfile(fpath,fname));
    
end 