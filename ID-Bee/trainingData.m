function trainingData = 

addpath('.\funcs','.\funcs\classifyfuncs')
iptsetpref('ImshowBorder','loose')
folderinl='..\cells\';
pixl=rdir([folderinl '*L2.mat']);   

feat_names=getrefinefeatsnames();
data=zeros(length(pix),size(feat_names,1));
id=zeros(1,length(pix));
genus=cell(1,length(pix));
species=cell(1,length(pix));
subspecies=cell(1,length(pix));
gender=cell(1,length(pix));
lrwing=cell(1,length(pix));
zoom=zeros(1,length(pix));
clear feat_names
for k=1:length(pixl)
    % need zoom\scale to classify
    [id(k) genus{k} species{k} subspecies{k} gender{k} lrwing{k} ....
        zoom(k)] =  parsefilename(char(pixl(k).name));
    data(k,:)=getrefinefeats(zoom(k),limg2);
end
save('trainingdata2.mat','data','id','genus','species','subspecies',...
    'gender','lrwing','zoom');
scaleoptions='nanzscore';% DataScaling, NormalMaxMagnitude, none
[data mu s]=scalefeatures(data,scaleoptions);
imputemethod='zeros';
data=impute(data,imputemethod);
featind=1:20;
save('readytrainingdata2.mat','data','id','genus','species','subspecies',...
    'gender','lrwing','zoom','scaleoptions','mu','s','imputemethod',...
    'featind');


rmpath('.\funcs','.\funcs\classifyfuncs')