function movingimage
    %# Plotting a figure
    fig1=figure('Name','Plotting an image',...
        'Unit','normalized', 'Position',[.1 .1 .8 .8]);
    uicontrol(fig1,'Style','text','Unit','Normalized',...
        'Position',[.4 0.9 .1 .7],'String','Press the button below to move the image location.');
    uicontrol(fig1,'Style','pushbutton','Unit','Normalized',...
        'Position',[.9 .8 .05 .05],'String','Move','Callback',{@action_Callback});

    %# Say, you wish to plot an image of relative dimension (.3 x .3) to the figure.
    xdim=.3; ydim=.3;
    %# Image's movable range in x is (1 - xdim)
    dx=1-xdim;
    %# Image's Movable range in y is (1 - ydim)
    dy=1-ydim;
    %# considering the size of the image...
    pos = [.5*dx .5*dy xdim ydim];  %# Initial location of the image is at the center of the figure.
    ax1 = axes('position',pos);
    img = load('mandrill');
    image(img.X)
    colormap(img.map);axis off;axis equal;

    function action_Callback(hObj,eventdata)
        pos=[rand(1)*dx rand(1)*dy xdim ydim];
        set(ax1,'position',pos);
    end
end