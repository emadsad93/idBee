function [ ] = ShowMsg(imgFileName, msg)
%% msg should be string
%% imgFileName should include the file extention + it should be in ''
fontSize = 24;
img = imread(imgFileName);
imshow(img); 
title(msg,'FontSize', fontSize);
set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.


end

