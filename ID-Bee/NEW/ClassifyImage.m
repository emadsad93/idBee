function [genusClass, speciesClass, genderClass,subspeciesClass, lrwingClass] = ClassifyImage(limg, zoomImg)
genderClass = 'eh'; subspeciesClass = 'alo'; lrwingClass = 'ewdw'; 

load('SpeciesClassifier'); 
[feat_vector parts_inds num_parts]=getrefinefeats(zoomImg,limg);


feat_vector = feat_vector(1, fea); 

norm_feats=bsxfun(@rdivide,bsxfun(@minus,feat_vector,mu_1),s);    

imputemethod = 'zeros'; 
norm_feats=impute(norm_feats,imputemethod);% add option to impute by groups

feat_vector_species = norm_feats; 
dist1=bsxfun(@minus,feat_vector_species*w_class, gam_class);
[~,ind]=max(dist1,[],2);
speciesClass=groupids(ind);

clear('groupids', 'fea'); 

load('GenusClassifier'); 
[feat_vector parts_inds num_parts]=getrefinefeats(zoomImg,limg);


feat_vector = feat_vector(1, fea); 

norm_feats=bsxfun(@rdivide,bsxfun(@minus,feat_vector,mu_1),s);    

imputemethod = 'zeros'; 
norm_feats=impute(norm_feats,imputemethod);% add option to impute by groups

feat_vector_genus = norm_feats; 

dist1=bsxfun(@minus,feat_vector_genus*w_class, gam_class);
[~,ind]=max(dist1,[],2);
genusClass=groupids(ind);

% load(dataName); 
% mu = nanmean(data);
% s = nanstd(data);
% 
% classifyfnc=@knnclassify;
% 
%  % [~,~,~,~,~,~,zoom] = parsefilename(char(pix(k).name));
%     
% % get features
% [feat_vector parts_inds num_parts]=getrefinefeats(zoomImg,limg);
% % scale features
% norm_feats=bsxfun(@rdivide,bsxfun(@minus,feat_vector,mu),s);
% % impute features
% 
% feats = norm_feats;
% feats(isnan(feats))=0;
% 
% 
% %imputemethod = 'zeros';
% %feats = impute(norm_feats,imputemethod);
% 
% ind = [14957 45517 47646 13619 44776 47874 48052 6459 8416 48060 6711 46846 9512 48048 14929 47642 47887 15039 45070 416];
% %ind = 1:3:60; 
% training = data(:,ind);% or your choice of a few columns of data
% traininggroups = transpose(genus); % or genus, or your choice of group
% % classify
% class = classifyfnc(feats(:,ind), training, traininggroups);
% genusClass = class{1}; 
% 
% 
% traininggroups = transpose(species); % or genus, or your choice of group
% % classify
% class = classifyfnc(feats(:,ind), training, traininggroups);
% speciesClass = class{1}; 
% 
% traininggroups = transpose(gender); % or genus, or your choice of group
% % classify
% class = classifyfnc(feats(:,ind), training, traininggroups);
% genderClass = class{1}; 
% 
% traininggroups = transpose(subspecies); % or genus, or your choice of group
% % classify
% class = classifyfnc(feats(:,ind), training, traininggroups);
% subspeciesClass = class{1}; 
% %fprintf('Predicted class is %s', class{1});
% 
% traininggroups = transpose(lrwing); % or genus, or your choice of group
% % classify
% class = classifyfnc(feats(:,ind), training, traininggroups);
% lrwingClass = class{1}; 


%pause;

end 
