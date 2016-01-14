close all;
clear all;
clc;

iptsetpref('ImshowBorder','loose')
folderin='..\img\';
pix=rdir([folderin '*.jpg']);
addpath('.\funcs');

for k = 1
    name=char(pix(k).name);
    ind=strfind(name,filesep);
    name=name(ind(end)+1:end);
    
    img = imread(char(pix(k).name));
    img = imresize(img(:,:,1:3),.25);
    
    limg = ExtractCells(img);close
    
    figure;
    imshow(img);
    hold on;
    h=imshow(label2rgb(limg));
    set(h,'alphadata',0.6)
    title([num2str(k) ': ' name])
    %% get the pixel
    message = sprintf('Left click on the color or segment you want to alter \n');
    uiwait(msgbox(message));
    %%
    hFH = imfreehand();
    xy = hFH.getPosition;
    pixel = limg(uint32(xy(1,2)),uint32(xy(1,1)));
    hold off;
    close;
    %% get the region
    figure
    imshow(img);
    hold on;
    h1 = imshow(label2rgb(limg));
    set(h1,'alphadata',0.6)
    hold on
    message = sprintf('Left click and hold to begin drawing.\nSimply lift the mouse button to finish');
    uiwait(msgbox(message));
    hFH = impoly();
    message = sprintf('Are you happy with this?');
    uiwait(msgbox(message));


    hold off;
    % Create a binary image ("mask") from the ROI object.
    binaryImage = createMask(hFH,h1);
    ind = find(binaryImage ~= 0);
    limg(ind) = pixel;
    figure
    h=imshow(label2rgb(limg));
    set(h,'alphadata',0.6)
    
    
    % fill any holes, so that regionprops can be used to estimate
    % the area enclosed by each of the boundaries
    bw = imfill(limg,'holes');
    
    imshow(bw)
    
    [B,L] = bwboundaries(bw,'noholes');
    stats = regionprops(L,'Area','Centroid');

    % Display the label matrix and draw each boundary
    imshow(label2rgb(L, @jet, [.5 .5 .5]))
    hold on
    for k = 1:length(B)
        % obtain (X,Y) boundary coordinates corresponding to label 'k'
        boundary = B{k};
        plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2);
        
        centroid = stats(k).Centroid;
        
        % display the results
        text_string = sprintf('%d',k);
        
        text(centroid(1),centroid(2),text_string,'Color','k',...
            'FontSize',16,'FontWeight','bold');
    end   
    
    hold off; 
end
