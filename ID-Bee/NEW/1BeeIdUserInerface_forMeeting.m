function BeeIdUserInerface
%% BeeWing ID User Interface

%% Asking the user for the image
addpath('./funcs');
% UIControl_FontSize_bak = get(0, 'DefaultUIControlFontSize');
set(0, 'DefaultUIControlFontSize', 25);
impo = 'e';
count = 0;
stillInAddImg = 1;
while (strcmp(impo,'Cancel') ~= 1 && (stillInAddImg == 1))
    count = count + 1;
    importopt = questdlg('Welcome to UW-Madison Automated Bee Identification System! To proceed, you will need to upload/select a bee wing image. So, have your bee wing image ready! Which of these tasks would you like the program to do?','BeeID Menu','Upload Your Bee-Wing Image','Cancel','Add to Database');
    man_inst = imread('instrcforMan.001.jpg');
    dragging = imread('dragging.001.jpg');
    %     aut_conf = imread('aut_conf.jpg');
    %     man_num_inst = imread('beecells.png');
    %     man_conf = imread('man_conf.jpg');
    
    impo = importopt;
    fontSize = 24;
    try
        switch importopt
            case 'Cancel'
                userCanceled = true;
                clear; clc; close all; 
                return; 
                fprintf('emad');
            case 'Upload Your Bee-Wing Image'
                %% GET THE IMAGE FILE
                %                 stillInAddImg = 1;
                %
                %                 while (stillInAddImg == 1)
                [img, fname] = getImageFromFile;
                
                [id genus species subspecies gender lrwing zoom] = parsefilenameDEMO(fname);
                img=imresize(img(:,:,1:3),.25);
                limg=ExtractCells(img);
                
                limg2 = limg;
                doMoreWork = 1;
                while (doMoreWork == 1)
                    
                    h1 = subplot(1,2,1);
                    ax=get(h1,'Position');
                    set(h1,'Position',ax)
                    imshow(img);
%                     title(fname,'FontSize', 24);
                    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                    
                    
                    h2 = subplot(1,2,2);
                    ax=get(h2,'Position');
                    set(h2,'Position',ax);
                    
                    imshow(img);
                    hold on
                    h = imshow(label2rgb(limg2));
                    set(h,'alphadata',0.6);
%                     title('Automatically colored cells','FontSize', 24);
                    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                    %
                    hold on
                    ButtonName = MFquestdlg ( [ 0.13 , 1], 'How does the coloring of the cells look like? If it needs correction (e.g. some cells are missing or some are not completely colored) click on "Correct Cells". If there are many miscolored or missing cells, then manually color each cell yourself by clicking on "Manual Coloring Cells". If everything looks good and you want to proceed to the next task, then click on "Proceed".', 'Bee-ID', ...
                        'Correct Cells','Manually Color Cells','Proceed', 'Green');
                    switch ButtonName
                        case 'Correct Cells'
                            moreCells = 1;
                            indTemp = 0;
                            pixTemp = 0;
                            counter = 0;
                            m = 0;
                            while(moreCells == 1 && counter <8)
                                
                                close
                                figure;
                                ax = gca;
                                imshow(img);
%                                 title('Coloring Bee Wing Cells','FontSize', 24);
                                set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                                hold on
                                h1 = imshow(label2rgb(limg2));
                                set(h1,'alphadata',0.6)
                                
                                
                                if (m == 0 || (counter == 0))
                                    cellAnswer = MFquestdlg ( [ 0.13 , 1], 'Do the following: 1) click on your selected cell. 2) drag through the boundary of the cell 3) click on the point where you started to make a closed cell. Great! Now you know what to do... Do you want to start/continue coloring the cells? If Yes, click on "Yes!" If you want to redo what you did in the previous coloring stage, then click on "Redo". If you think everything is good and want to proceed to the next task, then click on "Proceed".', ...
                                        'Bee-ID', ...
                                        'Yes!','Redo' ,'Proceed', 'Green');
                                end
%                                 if (m ==1 && (counter ~= 0))
%                                     cellAnswer = 'Yes!';
%                                 end
                                
                                switch cellAnswer
                                    case 'Yes!'
                                        
                                        hFH = imfreehand();
                                        
                                        fcn = makeConstrainToRectFcn('imfreehand',get(ax,'XLim'),get(ax,'YLim'));
                                        % Enforce boundary constraint function using setPositionConstraintFcn
                                        setPositionConstraintFcn(hFH,fcn);
                                        xy = hFH.getPosition;
                                        pixel = limg2(uint32(xy(1,2)),uint32(xy(1,1)));
                                        
                                        if (pixel == 0)
                                            pixel = 4 * (counter+1);
                                        end
                                        hFH = impoly();
                                        fcn = makeConstrainToRectFcn('impoly',get(ax,'XLim'),get(ax,'YLim'));
                                        % Enforce boundary constraint function using setPositionConstraintFcn
                                        setPositionConstraintFcn(hFH,fcn);
                                        
                                        
                                        hold off;
                                        % Create a binary image ("mask") from the ROI object.
                                        binaryImage = createMask(hFH,h1);
                                        indTemp = find(binaryImage ~= 0);
                                        pixTemp = limg2(indTemp);
                                        limg2(indTemp) = pixel;
                                        counter = counter +1;
                                        m = 0;
                                        
                                    case 'Redo'
                                        if (counter ~= 0)
                                            limg2(indTemp) = pixTemp;
                                            counter = counter -1;
                                        end
                                        m = 1;
                                    case 'Proceed'
                                        
                                        moreCells = 0;
                                end
                            end
                            
                            %%
                            
                            
                            
                        case 'Manually Color Cells'
                            
                            limg2(:) = 0;
                            moreCells = 1;
                            j = 0;
                            indTemp = 0;
                            m = 0;
                            while(moreCells == 1 && j <8)
                                close all
                                figure
                                
                                imshow(img);
                                
%                                 title('Manually Coloring Missing/Incomplete Cells','FontSize', 24);
                                set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                                hold on
                                
                                h1 = imshow(label2rgb(limg2));
                                set(h1,'alphadata',0.6)
                                if (m == 0 || (j ==0))
                                    cellAnswer = MFquestdlg ( [ 0.13 , 1], 'Do the following: 1) drag through the boundary of the cell you want to color 2) click on the point where you started to make a closed boundary cell. 3) repeat this for all the cells. Great! Now you know what to do... Do you want to start/continue coloring the cells? If Yes, click on "Yes!" If you want to redo what you did in the previous coloring stage, then click on "Redo". If you think everything is good and want to proceed to the next task, then click on "Proceed".', ...
                                        'Bee-ID', ...
                                        'Yes!','Redo' ,'Proceed', 'Green');
                                end
%                                 if (m ==1 && (j ~= 0))
%                                     cellAnswer = 'Yes!';
%                                 end
                                
                                switch cellAnswer
                                    case 'Yes!'
                                        
                                        
                                        %%
                                        
                                        hFH = impoly();
                                        %                                         fcn = makeConstrainToRectFcn('impoly',get(h,'XLim'),get(h,'YLim'));
                                        %                                         % Enforce boundary constraint function using setPositionConstraintFcn
                                        %                                         setPositionConstraintFcn(hFH,fcn);
                                        
                                        
                                        hold off;
                                        % Create a binary image ("mask") from the ROI object.
                                        binaryImage = createMask(hFH,h1);
                                        indTemp = find(binaryImage ~= 0);
                                        limg2(indTemp) = 4* (j + 1); 
                                        j = j+1;
                                        m = 0;
                                    case 'Redo'
                                        if (j ~= 0)
                                            limg2(indTemp) = 0;
                                            j = j -1;
                                        end
                                        m = 1;
                                    case 'Proceed'
                                        
                                        moreCells = 0;
                                end
                            end
                            
                            %                         pause(2);
                            %                         close all;
                            %                         figure
                            %                         h = imshow(img);
                            %
                            %                         title('Manually labeling using dragging tool','FontSize', 24);
                            %                         set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                            %                         hold on
                            %
                            %                         h1 = imshow(label2rgb(limg2));
                            %                         set(h1,'alphadata',0.01)
                            %
                            %                         for n=1:7
                            %
                            %                             m = impoint(h1);
                            %
                            %                             fcn = makeConstrainToRectFcn('impoint',get(h1,'XLim'),get(h1,'YLim'));
                            %                             % Enforce boundary constraint function using setPositionConstraintFcn
                            %
                            %                             pos = getPosition(m);
                            %                             x = pos(1);
                            %                             y = pos(2);
                            %
                            %                             limg2(limg2==limg2(round(y),round(x)))=-n;
                            %                             text_string = sprintf('%d',n);
                            %                             text(x,y,text_string,'Color','k',...
                            %                                 'FontSize',16,'FontWeight','bold');
                            %                         end
                            %                         limg2(limg2==-8)=0;
                            %                         limg2(limg2>0)=0;
                            %                         limg2=abs(limg2);
                            %                         limg2=CleanCellBoundaries(limg2);
                            %                         hold off
                            % %
                            
                        case 'Proceed'
                            
                            done = 0;
                            limg3 = limg2;
                            man_inst = imread('instrcforMan.001.jpg');
                            firstTime = 1;
                            while(done ~= 1)
                                
                                close;
                                figure
                                
                                h3 = subplot(121);
                                
                                ax=get(h3,'Position');
                                set(h3,'Position',ax);
                                imshow(man_inst);
                                title('Numbering the Cells Instructions','FontSize', 24);
                                
                                
                                
                                h2 = subplot(122);
                                
                                ax=get(h2,'Position');
                                set(h2,'Position',ax);
                                imshow(img);
                                
                                set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                                title('Numbering the Cells','FontSize', 24);
                                hold on;
                                
                                h1 = imshow(label2rgb(limg2));
                                set(h1,'alphadata',0.6)
                                if firstTime == 1
                                    answer = MFquestdlg ( [ 0.17 , 0], 'First time numbering the cells? No worries. You will ace it! Here it goes... Look at the instruction on the left to see how to click on individual cells for correct numbering of the cells. Notice that if you have 6 or 7 cells, first, click on those cells; then, click on any point outside the colored cells. Perfect! You got it!', 'BeeID', 'I got it!', 'e');
                                end
                                if firstTime == 0
                                    answer = 'I got it!';
                                end
                                
                                switch answer
                                    case 'I got it!'
                                        
                                        % label the segments 1-7 (sequentially, by clicking them),
                                        % then label the something not belonging to the cells (if you are missing cell 2 label outside as cell 2, then relabel it as the eighth component)
                                        
                                        x = {0,0,0,0,0,0,0,0};
                                        y = {0,0,0,0,0,0,0,0};
                                        
                                        
                                        for n=1:8
                                            
                                            m = impoint(h2);
                                            
                                            fcn = makeConstrainToRectFcn('impoint',get(h2,'XLim'),get(h2,'YLim'));
                                            % Enforce boundary constraint function using setPositionConstraintFcn
                                            
                                            pos = getPosition(m);
                                            x{n} = pos(1);
                                            y{n} = pos(2);
                                            
                                            limg2(limg2==limg2(round(y{n}),round(x{n})))=-n;
                                            text_string = sprintf('%d',n);
                                            text(x{n},y{n},text_string,'Color','k',...
                                                'FontSize',16,'FontWeight','bold');
                                        end
                                        limg2(limg2==-8)=0;
                                        limg2(limg2>0)=0;
                                        limg2=abs(limg2);
                                        limg2=CleanCellBoundaries(limg2);
                                        hold off
                                        
                                        close;
                                        h1 = subplot(121);
                                        ax=get(h1,'Position');
                                        %ax(4)=ax(4)+0.5; %or wathever
                                        set(h1,'Position',ax);
                                        imshow(man_inst);
                                        %set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                                        
                                        
                                        h2 = subplot(122);
                                        ax=get(h2,'Position');
                                        %ax(4)=ax(4)+0.5; %or wathever
                                        set(h2,'Position',ax);
                                        
                                        imshow(img);
                                        hold on
                                        h = imshow(label2rgb(limg2));
                                        set(h,'alphadata',0.6);
                                        set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                                        
                                        hold on;
                                        for n=1:8
                                            text_string = sprintf('%d',n);
                                            text(x{n},y{n},text_string,'Color','k',...
                                                'FontSize',16,'FontWeight','bold');
                                        end
                                        
                                        
                                        ButtonName = MFquestdlg ( [ 0.15 , 0 ], 'Do your numbered cells match to the template shown in the left image?', ...
                                            'Bee-ID', ...
                                            'No, I want to correct them!', 'Yes, Proceed', 'Green');
                                        
                                        switch ButtonName
                                            case 'No, I want to correct them!'
                                                limg2 = limg3;
                                                done = 0;
                                                firstTime = 0;
                                                
                                            case 'Yes, Proceed'
                                                done = 1;
                                                
                                                showInfoImage(img, limg2);
                                                ButtonName = MFquestdlg ( [ 0.418 , 0.4 ], 'Add/Classify?', ...
                                                    'Bee-ID', ...
                                                    'Yes', 'No', 'Green');
                                                
                                                switch ButtonName                                                        
                                                    case 'Yes'
                                                        
                                                        
                                                        [Answer,Cancelled] = checkInputs(id, genus, species, subspecies, gender, zoom) ;
                                                        if (Cancelled == true)
                                                            throw(baseException);
                                                        end
                                                       
                                                        ButtonName = MFquestdlg ( [ 0.13 , 0.35 ], 'Your labeled bee wing image was added to the database. Would you like to see the classification result based on our magic Bee Identification algorithm?', ...
                                                            'Bee-ID', ...
                                                            'Yes', 'No', 'Green');
                                                        
                                                        switch ButtonName
                                                            case 'Yes'
                                                                speciesClass = ClassifyImage('trainingdata.mat', limg, 4);
                                                                fprintf('Predicted class is %s', speciesClass);
                                                                pause(40);
                                                            case 'No'
                                                                throw(baseException); 
                                                                
                                                            case 'Cancel'
                                                                throw(baseException);
                                                        end
                                                        
                                                        % Add? yes was added to the database
                                                        % This was the classification result
                                                        % with all the info about it.
                                                        
                                                    case 'No'
                                                        throw(baseException)
                                                        % show end message and
                                                        % close the program
                                                end
                                                %%%%%%%%%%%%%%%%%%%%%%%%
                                                %redo the previous STEP
                                                
                                                
                                                % ask for classfication or
                                                % addition
                                                % if addition
                                        end
                                end
                                
                            end
                            
                            
                    end
                    
                    
                    
                end
                
        end
        
        
    catch
        close all;
        clear; clc;
        stillInAddImg = 1;
        addpath('./funcs');
        % UIControl_FontSize_bak = get(0, 'DefaultUIControlFontSize');
        set(0, 'DefaultUIControlFontSize', 25);
        impo = 'e';
        count = 0;

        %         fprintf('hhh');
    end
end

end



