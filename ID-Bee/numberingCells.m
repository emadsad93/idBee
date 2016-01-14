function limg2 = numberingCells(limg)
    h = imshow(label2rgb(limg));
    set(h,'alphadata',0.6)
    limg2=limg;

    % label the segments 1-7 (sequentially, by clicking them),
    % then label the something not belonging to the cells (if you are missing cell 2 label outside as cell 2, then relabel it as the eighth component)
    for n=1:8
        [x,y] = ginput(1);
        limg2(limg2==limg2(round(y),round(x)))=-n;
        text_string = sprintf('%d',n);
        text(x,y,text_string,'Color','k',...
            'FontSize',16,'FontWeight','bold');
    end
    limg2(limg2==-8)=0;
    limg2(limg2>0)=0;
    limg2=abs(limg2);
    limg2=CleanCellBoundaries(limg2);
    hold off
end
