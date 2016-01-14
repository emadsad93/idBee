%INPUTSDLG DEMO (Enhanced input dialog box with multiple data types)
%   Demonstrates new "required" field of Formats argument

% Written by: Takeshi Ikuma
% Last Updated: July 17 2013


function [Answer,Cancelled] = checkInputs(id, genus, species, subspecies, gender,lrwing, zoom)

Title = 'Bee Information:';

DefAns = struct([]);

Prompt = {
   'ID','ID',
   'Genus','Genus',
   'Species','Species',
   'Subspecies','Subspecies',
   'Gender','Gender',
   'Lrwing','Lrwing',
   'Zoom','Zoom',
   };
Formats(1,1).type = 'edit';
Formats(1,1).format = 'integer';
Formats(1,1).span = [1 1];
DefAns(1).ID = id;


Formats(2,1).type = 'edit';
Formats(2,1).format = 'text';
DefAns.Genus = genus;
%Formats(2,1).span = [1 2];
Formats(2,1).span = [1 1];


Formats(3,1).type = 'edit';
Formats(3,1).format = 'text';
DefAns.Species = species;
% Formats(3,1).span = [1 2];
Formats(3,1).span = [1 1];


Formats(4,1).required = 'on'; % Name
Formats(4,1).type = 'edit';
Formats(4,1).format = 'text';
 DefAns.Subspecies = subspecies;
% Formats(4,1).span = [1 2];
Formats(4,1).span = [1 1];



Formats(5,1).type = 'edit';
Formats(5,1).format = 'text';
DefAns.Gender = gender;
% Formats(5,1).span = [1 2];
Formats(5,1).span = [1 1];


Formats(6,1).type = 'edit';
Formats(6,1).format = 'text';
DefAns.Lrwing = lrwing;
% Formats(5,1).span = [1 2];
Formats(6,1).span = [1 1];



Formats(7,1).type = 'edit';
Formats(7,1).format = 'float';
DefAns.Zoom = zoom;
Formats(7,1).span = [1 1];



%Formats(8,1).type = 'text'; % footnote
Options.AlignControls = 'on';

[Answer,Cancelled] = inputsdlg(Prompt,Title,Formats,DefAns,Options);
end 

