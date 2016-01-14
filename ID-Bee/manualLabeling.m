function limg2 = manualLabeling(img,limg)
    %close all; 
    man_inst = imread('instrcforMan.001.jpg');
%     guiEMAD(img,limg)
%     set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    
    h1 = subplot(121); 
    
    ax=get(h1,'Position');
    set(h1,'Position',ax);
    imshow(man_inst);
    title('Instuctions...','FontSize', 24);
    
    h2 = subplot(122); 
    
    ax=get(h2,'Position');
    set(h2,'Position',ax);    
    imshow(img);

    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    title('Manually Labeling ','FontSize', 24);
    hold on;
    
    h1 = imshow(label2rgb(limg));
    set(h1,'alphadata',0.6)
    limg2=limg;
    
    % label the segments 1-7 (sequentially, by clicking them),
    % then label the something not belonging to the cells (if you are missing cell 2 label outside as cell 2, then relabel it as the eighth component)
    
    
    
    for n=1:8
        
        m = impoint(h2);
        
        fcn = makeConstrainToRectFcn('impoint',get(h2,'XLim'),get(h2,'YLim'));
        % Enforce boundary constraint function using setPositionConstraintFcn
        
        pos = getPosition(m);
        x = pos(1);
        y = pos(2);
        
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