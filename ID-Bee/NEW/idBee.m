function idBee

addpath('./funcs');
set(0, 'DefaultUIControlFontSize', 20);
impo = 'e';
count = 0;
stillInAddImg = 1;
while (strcmp(impo,'Cancel') ~= 1 && (stillInAddImg == 1))
    count = count + 1;
    importopt = questdlg('Welcome to UW-Madison Automated Bee Identification System!','BeeID Menu','Upload Your Bee-Wing Image','Cancel','Add to Database');
    impo = importopt;
    try
        switch importopt
            case 'Cancel'
                userCanceled = true;
                clear; clc; close all;
                return;
            case 'Upload Your Bee-Wing Image'
                [img, fname] = getImageFromFile;
                
                img=imresize(img(:,:,1:3),.25);
                limg=ExtractCells(img);
                
                limg2 = limg;
                doMoreWork = 1;
                while (doMoreWork == 1)
                    
                    h1 = subplot(1,2,1);
                    ax=get(h1,'Position');
                    set(h1,'Position',ax)
                    imshow(img);
                    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                    
                    h2 = subplot(1,2,2);
                    ax=get(h2,'Position');
                    set(h2,'Position',ax);
                    
                    imshow(img);
                    hold on
                    h = imshow(label2rgb(limg2));
                    set(h,'alphadata',0.6);
                    set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                    hold on
                    ButtonName = MFquestdlg ( [ 0.18 , 1], 'Please evaluate the quality of the coloring of your bee wing cells. If there are some cells missing or not completely colored, click on "Correct Cell Coloring". If there are many miscolored or missing cells, you can manually color each cell by clicking on "Manual Cell Coloring". If you are happy with the current coloring of the cells, you may "proceed". ', 'Bee-ID', ...
                        'Correct Cell Coloring','Manual Cell Coloring','Proceed to Labeling', 'Green');
                    switch ButtonName
                        case 'Correct Cell Coloring'
                            moreCells = 1;
                            indTemp = 0;
                            pixTemp = 0;
                            counter = 0;
                            m = 0;
                            while(moreCells == 1 && counter <8)
                                
                                close all;
                                ax = gca;
                                imshow(img);
                                title('Coloring Bee Wing Cells...','FontSize', 24);
                                set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                                hold on
                                h1 = imshow(label2rgb(limg2));
                                set(h1,'alphadata',0.6)
                                
                                if (m == 0 || (counter == 0))
                                    cellAnswer = MFquestdlg ( [ 0.17 , 0], 'To color a selected cell, first click on a point inside the cell; then, click on a point on its boundary and drag through it until you have a closed loop. You can always repeat the last cell coloring step by clicking on "Redo". If you are happy with the current coloring of the cell, you may "Proceed to Labeling".', 'Bee-ID', ...
                                        'Start/Continue Coloring','Redo' ,'Proceed to Labeling', 'Green');
                                end
                                
                                switch cellAnswer
                                    case 'Start/Continue Coloring'
                                        
                                        hFH = imfreehand();
                                        fcn = makeConstrainToRectFcn('imfreehand',get(ax,'XLim'),get(ax,'YLim'));
                                        % Enforce boundary constraint function using setPositionConstraintFcn
                                        setPositionConstraintFcn(hFH,fcn);
                                        xy = hFH.getPosition;
                                        pixel = limg2(uint32(xy(1,2)),uint32(xy(1,1)));
                                        
                                        if (pixel == 0)
                                            pixel = (counter+50);
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
                                    case 'Proceed to Labeling'
                                        moreCells = 0;
                                end
                            end
                        case 'Manual Cell Coloring'
                            
                            limg2(:) = 0;
                            moreCells = 1;
                            j = 0;
                            indTemp = 0;
                            m = 0;
                            while(moreCells == 1 && j <8)
                                close all
                                imshow(img);
                                title('Coloring Bee Wing Cells...','FontSize', 24);
                                set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                                hold on
                                
                                h1 = imshow(label2rgb(limg2));
                                set(h1,'alphadata',0.6)
                                if (m == 0 || (j ==0))
                                    cellAnswer = MFquestdlg ( [ 0.173 , 0], 'To start coloring a selected cell, click on a point on its boundary and drag through it until you have a closed loop. You can always repeat the last cell coloring step by clicking on "Redo". If you are happy with the current coloring of the cell, you may "Proceed to Labeling".                                                           Repeat this procedue until you color all required cells.',...
                                        'Bee-ID', ...
                                        'Start/Continue Coloring','Redo' ,'Proceed to Labeling', 'Green');
                                end
                                
                                switch cellAnswer
                                    case 'Start/Continue Coloring'
                                        hFH = impoly();
                                        hold off;
                                        % Create a binary image ("mask") from the ROI object.
                                        binaryImage = createMask(hFH,h1);
                                        indTemp = find(binaryImage ~= 0);
                                        limg2(indTemp) = j + 50;
                                        j = j+1;
                                        m = 0;
                                    case 'Redo'
                                        if (j ~= 0)
                                            limg2(indTemp) = 0;
                                            j = j -1;
                                        end
                                        m = 1;
                                    case 'Proceed to Labeling'
                                        
                                        moreCells = 0;
                                end
                            end
                        case 'Proceed to Labeling'
                            
                            done = 0;
                            limg3 = limg2;
                            man_inst = imread('number.jpg');
                            
                            firstTime = 1;
                            while(done ~= 1)
                                
                                close;
                                figure
                                h3 = subplot(121);
                                ax=get(h3,'Position');
                                set(h3,'Position',ax);
                                imshow(man_inst);
                                title('Labeled Bee Wing Example','FontSize', 24);
                                h2 = subplot(122);
                                
                                ax=get(h2,'Position');
                                set(h2,'Position',ax);
                                imshow(img);
                                
                                set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                                title('Labeling the Cells...','FontSize', 24);
                                hold on;
                                
                                h1 = imshow(label2rgb(limg2));
                                
                                set(h1,'alphadata',0.6)
                                if firstTime == 1
                                    answer = MFquestdlg ( [ 0.205 , 0.1], 'Instructions for Manually Labeling of Bee Wing Cells:                                     ----------------------------------------------------------------------                                                                         Label the cells 1-7 by clicking them sequentially, as shown in the top left figure, and label the region not belonging to the cells (1-7) as cell 8. In case there is a cell missing, you need to label the cells 1-6 first, and then, label the region not belonging to the cells (1-6) as cells 7 and 8 by clicking two times on the respective region.',...
                                        'BeeID', 'Got it!', 'e');
                                end
                                if firstTime == 0
                                    answer = 'Got it!';
                                end
                                
                                switch answer
                                    case 'Got it!'
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
                                        set(h1,'Position',ax);
                                        imshow(man_inst);
                                        title('Labeled Bee Wing Example','FontSize', 24);
                                        
                                        h2 = subplot(122);
                                        ax=get(h2,'Position');
                                        set(h2,'Position',ax);
                                        
                                        imshow(img);
                                        hold on
                                        title('Labeled Cells','FontSize', 24);
                                        
                                        h = imshow(label2rgb(limg2));
                                        set(h,'alphadata',0.6);
                                        set(gcf, 'Position', get(0,'Screensize')); % Maximize figure.
                                        hold on;
                                        for n=1:8
                                            text_string = sprintf('%d',n);
                                            text(x{n},y{n},text_string,'Color','k',...
                                                'FontSize',16,'FontWeight','bold');
                                        end
                                        
                                        
                                        ButtonName = MFquestdlg ( [ 0.192 , 0.1 ], 'Do your labeled cells match the template shown on the left image?', ...
                                            'Bee-ID', ...
                                            'No, I want to correct them!', 'Yes, proceed.', 'Green');
                                        
                                        switch ButtonName
                                            case 'No, I want to correct them!'
                                                limg2 = limg3;
                                                done = 0;
                                                firstTime = 0;
                                                
                                            case 'Yes, proceed.'
                                                done = 1;
                                                
                                                showInfoImage(img, limg2);
                                                ButtonName = MFquestdlg ( [ 0.428 , 0.4 ], 'Add/Classify?', ...
                                                    'Bee-ID', ...
                                                    'Yes', 'No', 'Green');
                                                
                                                switch ButtonName
                                                    case 'Yes'
                                                        try
                                                            [id genus species subspecies gender lrwing zoom] = parsefilenameDEMO(fname);
                                                        catch
                                                            id = 0;
                                                            genus = 'unkown';
                                                            species = 'unkown';
                                                            subspecies = 'unkown';
                                                            gender = 'unkown';
                                                            lrwing = 'unkown';
                                                            zoom = 0;
                                                        end
                                                        [Answer,Cancelled] = checkInputs(id, genus, species, subspecies, gender, lrwing, zoom) ;
                                                        if (Cancelled == true)
                                                            throw(baseException);
                                                        end
                                                        fileName = strcat(int2str(Answer.ID),'_',Answer.Genus, '_', Answer.Species, '_',Answer.Subspecies, '_', Answer.Gender,'_', Answer.Lrwing, '_',int2str(Answer.Zoom), '.mat');
                                                        newFolderName = 'LabeledBees';
                                                        currentPath = pwd;
                                                        pathname = strcat(currentPath, '/', newFolderName);
                                                        
                                                        fullFileName = fullfile(pathname, fileName);
                                                        save(fullFileName, 'limg2');
                                                        ButtonName = MFquestdlg ( [ 0.179 , 0.405 ], 'Your labeled bee wing image was added to the database. Would you like to see the classification results?', ...
                                                            'Bee-ID', ...
                                                            'Yes', 'No', 'Green');
                                                        
                                                        switch ButtonName
                                                            case 'Yes'
                                                                close all;
                                                                [genusClass, speciesClass, genderClass,subspeciesClass, lrwingClass] = ClassifyImage('readyDataNew.mat', limg2, zoom);
                                                                ButtonName = MFquestdlg ( [ 0.179 , 0.405 ], 'Your labeled bee wing image was added to the database. Would you like to see the classification results?', ...
                                                                    'Bee-ID', ...
                                                                    'Yes', 'No', 'Green');
                                                                
                                                                genus_1 = strcat('classified as "',genusClass, '" should be "', genus, '"');
                                                                species_1 = strcat('classified as "',speciesClass, '" should be "',speciesClass, '"');
                                                                subspecies_1 = strcat('classified as "',subspeciesClass, '" should be "',subspecies, '"');
                                                                gender_1 = strcat('classified as "',gender, '" should be "',gender, '"');
                                                                lrwing_1 = strcat('classified as "',lrwingClass, '" should be "',lrwing, '"');
                                                                
                                                                [Answer,Cancelled] = checkInputs1(genus_1, species_1, subspecies_1, gender_1, lrwing_1) ;
                                                                if (Cancelled == true)
                                                                    throw(baseException);
                                                                end
                                                                
                                                                
                                                                
                                                                fprintf('Predicted class is %s', genusClass);
                                                                fprintf('\nPredicted class is %s', speciesClass);
                                                                fprintf('\nPredicted class is %s', genderClass);
                                                                fprintf('\nPredicted class is %s', subspeciesClass);
                                                                fprintf('\nPredicted class is %s', lrwingClass);
                                                                
                                                                
                                                                pause(0.8);
                                                                throw(baseException);
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
        set(0, 'DefaultUIControlFontSize', 20);
        impo = 'e';
        count = 0;
        
    end
end

end



