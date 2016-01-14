
                set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.

subplot(1,2,1,'Position',[0 0.2 0.6 0.70]);
imshow(phantom);
title('emdemf','FontSize', 24);


subplot(1,2,2,'Position',[0.8 0.2 0.1 0.70]);
imshow(phantom);
title('efef','FontSize', 24);
