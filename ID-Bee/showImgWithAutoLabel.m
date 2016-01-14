function showImgWithAutoLabel

filterspec = imgformats(1);
[fname,fpath] = uigetfile(filterspec, 'Select image file');
if ~ischar(fpath)
    userCanceled = true;
    return
end
[img,cmap] = imread(fullfile(fpath,fname));
img=imresize(img(:,:,1:3),.25);
limg=ExtractCells(img);

stillInAddImg = 1;
while (stillInAddImg == 1)
    subplot(221)
    imshow(img);
    title(fname,'FontSize', 24);
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    
    subplot(222)
    
    imshow(man_inst);
    
    title('Instuctions...','FontSize', 24);
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    
    subplot(223)
    imshow(img);
    hold on
    h = imshow(label2rgb(limg));
    set(h,'alphadata',0.6);
    
    title('Automatically Labeled','FontSize', 24);
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    
    hold off
    subplot(224)
    imshow(img);
    
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    title('Manually Labelling ','FontSize', 24);
    hold on;
    
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
    
    %                 h=imshow(label2rgb(limg));
    %                 set(h,'alphadata',0.6)
    %                 hold on
    %
    %                 limg2=limg;
    %                 for n=1:8% label the segments 1-7 (sequentially), then label the exterior
    %                     [x,y] = ginput(1);
    %                     % display the results
    %                     text_string = sprintf('%d',n);
    %                     text(x,y,text_string,'Color','k',...
    %                         'FontSize',16,'FontWeight','bold');
    %                     limg2(limg2==limg2(round(y),round(x)))=-n;
    %
    %                 end
    %                 limg2(limg2==-8)=0;
    %                 limg2(limg2>0)=0;
    %                 limg2=abs(limg2);
    %                 limg2 = CleanCellBoundaries(limg2);
    %
    %
    %                 %             limg2 = CleanCellBoundaries(limg2);
    %                 hold off;
    
    
    pause(4)
    close all
    
    subplot(121)
    
    imshow(img);
    hold on;
    
    title('Automatically Labeled ','FontSize', fontSize)
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    h = imshow(label2rgb(limg));
    set(h,'alphadata',0.6)
    
    %                 subplot(223)
    %                 imshow(img);
    %                 hold on;
    %
    %                 title('Automatically Labeled Outlings','FontSize', fontSize);
    %                 set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    %
    %                 h=imshow(label2rgb(limg));
    %                 set(h,'alphadata',0.6)
    %                 hold on
    %                 limg_y = limg;
    %
    %                 [locs veins]=findJunctionsBranchpoints(limg_y);
    %                 limg2_y=bwlabel(~veins.*imfill(veins,'holes'),4);
    %                 limg3_y=relabel(limg_y,limg2_y);
    %
    %                 [junction_pos junction_labs jneighbs] = labelJunctions(locs,limg3_y);
    %                 [lveinsthin lveinsthick]=labelVeins(limg3_y,limg_y);
    %                 junction_pos2=findExtJunctions(lveinsthin,junction_pos);
    %
    %                 %plot(junction_pos2(junction_pos2(:,2)>0,2),junction_pos2(junction_pos2(:,1)>0,1),'*m')
    %                 plot(junction_pos(junction_pos(:,2)>0,2),junction_pos(junction_pos(:,1)>0,1),'-mo',...
    %                     'LineWidth',2,...
    %                     'MarkerEdgeColor','k',...
    %                     'MarkerFaceColor',[.49 1 .63],...
    %                     'MarkerSize',10);
    %
    %                 hold on;
    %
    %                  h=imshow(label2rgb(lveinsthick));
    %                  set(h,'alphadata',0.6)
    %
    %                 hold off;
    
    subplot(122)
    
    %     title([num2str(k) ': ' name])
    %                 hold on
    %                 limg2=limg;
    %
    %                 % label the segments 1-7 (sequentially, by clicking them),
    %                 % then label the something not belonging to the cells (if you are missing cell 2 label outside as cell 2, then relabel it as the eighth component)
    %                 for n=1:8
    %                     [x,y] = ginput(1);
    %                     limg2(limg2==limg2(round(y),round(x)))=-n;
    %                 end
    %                 limg2(limg2==-8)=0;
    %                 limg2(limg2>0)=0;
    %                 limg2=abs(limg2);
    %                 limg2=CleanCellBoundaries(limg2);
    %                 hold off
    %
    
    
    imshow(img);
    title('Manually Labeled','FontSize', fontSize);
    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    
    hold on;
    h =imshow(label2rgb(limg2));
    set(h,'alphadata',0.6)
    % hold off
    %                 imshow(img);
    %                 title('Your Manually Labelled Bee-wing Cells','FontSize', fontSize);
    %                 set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    %                 hold on
    %                 h = imshow(label2rgb(limg2));
    %                 set(h,'alphadata',0.6)
    %                 hold off;
    %
    %                 subplot(224)
    %                  imshow(img);
    %
    %                  hold on;
    %                  title('Manually Labeled Outlings','FontSize', fontSize);
    %                  set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
    %
    %                  limg_x = limg2;
    %
    %                  h=imshow(label2rgb(limg_x));
    %                  set(h,'alphadata',0.6)
    %                  hold on
    %
    %                  [locs veins]=findJunctionsBranchpoints(limg_x);
    %                  limg2_x=bwlabel(~veins.*imfill(veins,'holes'),4);
    %                  limg3_x=relabel(limg_x,limg2_x);
    %
    %                  [junction_pos junction_labs jneighbs] = labelJunctions(locs,limg3_x);
    %                  [lveinsthin lveinsthick]=labelVeins(limg3_x,limg_x);
    %                  junction_pos2=findExtJunctions(lveinsthin,junction_pos);
    %
    %                  %plot(junction_pos2(junction_pos2(:,2)>0,2),junction_pos2(junction_pos2(:,1)>0,1),'*m')
    %                  plot(junction_pos(junction_pos(:,2)>0,2),junction_pos(junction_pos(:,1)>0,1),'-mo',...
    %                      'LineWidth',2,...
    %                      'MarkerEdgeColor','k',...
    %                      'MarkerFaceColor',[.49 1 .63],...
    %                      'MarkerSize',10);
    %
    %                  hold on;
    %
    %                     %h=imshow(label2rgb(lveinsthin));
    %                     h=imshow(label2rgb(lveinsthick));
    %                     set(h,'alphadata',0.6)
    %
    %                     hold off;
    
    
end 