%INPUTSDLG DEMO (Enhanced input dialog box with multiple data types)
%   Demonstrates new "required" field of Formats argument

% Written by: Takeshi Ikuma
% Last Updated: July 17 2013


function [Answer,Cancelled] = checkInputs1(genus, species)%, subspecies, gender,lrwing)

Title = 'Classificaton Results';

DefAns = struct([]);

Prompt = {  
   'Genus','ClassifiedGenus',
   'Species','ClassifiedSpecies',
%    'Subspecies','ClassifiedSubspecies',
%    'Gender','ClassifiedGender',
%    'Lrwing','ClassifiedLrwing',
   };

Formats(1,1).type = 'edit';
Formats(1,1).span = [1 1];
Formats(1,1).size = 650; % automatically assign the height

Formats(1,1).format = 'text';
DefAns(1).ClassifiedGenus = genus;

Formats(2,1).type = 'edit';
Formats(2,1).format = 'text';
Formats(2,1).size = 650; % automatically assign the height
DefAns.ClassifiedSpecies = species;
% Formats(2,1).span = [1 2];

% Formats(3,1).required = 'on'; % Name
% Formats(3,1).type = 'edit';
% Formats(3,1).format = 'text';
% Formats(3,1).size = 650; % automatically assign the height
% 
%  DefAns.ClassifiedSubspecies = subspecies;
% % Formats(3,1).span = [1 2];
% 
% 
% Formats(4,1).type = 'edit';
% Formats(4,1).format = 'text';
% DefAns.ClassifiedGender = gender;
% Formats(4,1).size = 650; % automatically assign the height
% 
% % Formats(4,1).span = [1 2];
% 
% Formats(5,1).type = 'edit';
% Formats(5,1).format = 'text';
% Formats(5,1).size = 650; % automatically assign the height
% 
% DefAns.ClassifiedLrwing = lrwing;
% % Formats(5,1).span = [1 2];
% 
% 
% %Formats(8,1).type = 'text'; % footnote
Options.AlignControls = 'on';

[Answer,Cancelled] = inputsdlg(Prompt,Title,Formats,DefAns,Options);
end 

