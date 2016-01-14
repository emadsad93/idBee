close all;
clear all;
clc;


iptsetpref('ImshowBorder','loose')
folderin='..\img\';
pix=rdir([folderin '*.jpg']);
addpath('.\funcs');
for k=1:length(pix)    
    name=char(pix(k).name);
    ind=strfind(name,filesep);
    name=name(ind(end)+1:end);
    
    img=imread(char(pix(k).name));
    img=imresize(img(:,:,1:3),.25);
    tic;
    limg=ExtractCells(img);
    toc;
    
    figure(1),imshow(label2rgb(limg))
    title([num2str(k) ': ' name])

    limg2=limg;
    for n=1:8% label the segments 1-7 (sequentially), then label the exterior
        [x,y] = ginput(1);
        limg2(limg2==limg2(round(y),round(x)))=-n;
    end
    limg2(limg2==-8)=0;
    limg2(limg2>0)=0;
    limg2=abs(limg2); 
    
    figure,imshow([label2rgb(limg) label2rgb(limg2)])
    title([num2str(k) ': ' name])
    
    if ~mod(k,3)
        pause;
        close all;
    end          
end
rmpath('.\funcs');