function showInfoImage(img,limg)

close all; 
h1 = subplot(2,2,1);
ax=get(h1,'Position');
set(h1,'Position',ax)
imshow(img);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
title('Bee Wing Image','FontSize', 20);


h2 = subplot(2,2,2);
ax=get(h2,'Position');
set(h2,'Position',ax);


imshow(img);
hold on
h = imshow(label2rgb(limg));
set(h,'alphadata',0.6);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.


% subplot(2,2,3);

[locs veins]=findJunctionsBranchpoints(limg);
limg2=bwlabel(~veins.*imfill(veins,'holes'),4);
limg3=relabel(limg,limg2);

[junction_pos junction_labs jneighbs] = labelJunctions(locs,limg3);
[lveinsthin lveinsthick]=labelVeins(limg3,limg);
junction_pos2=findExtJunctions(lveinsthin,junction_pos);

imshow(img);
hold on;
plot(junction_pos(junction_pos(:,2)>0,2),junction_pos(junction_pos(:,1)>0,1),'*r')

hold on;
h=imshow(label2rgb(limg));
set(h,'alphadata',0.6)
plot(junction_pos2(junction_pos2(:,2)>0,2),junction_pos2(junction_pos2(:,1)>0,1),'*m')
title('Branch Points','FontSize', 20);


subplot(2,2,3); 
imshow(img);
hold on;
h=imshow(label2rgb(lveinsthin));
set(h,'alphadata',0.6)
title('Thinly Veined Junctions','FontSize', 20);


subplot(2,2,4); 
imshow(img);
hold on;
h=imshow(label2rgb(lveinsthick));
set(h,'alphadata',0.6)
title('Thickly Veined Junctions','FontSize', 20);




end 




