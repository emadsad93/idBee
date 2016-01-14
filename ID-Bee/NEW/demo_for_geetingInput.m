%INPUTSDLG DEMO (Enhanced input dialog box with multiple data types)
%   Demonstrates new "required" field of Formats argument

% Written by: Takeshi Ikuma
% Last Updated: July 17 2013

clear; close all;

Title = 'Bee Information:';

DefAns = struct([]);

Prompt = {
   'ID','ID','*'
   'Genus','Genus','*'
   'Species','Species','*'
   'Subspecies','Subspecies','*'
   'Gender','Gender','*'
   'Zoom','Zoom','*'
   '* Required fields','',''
   };
Formats(1,1).required = 'on'; % Name
Formats(1,1).type = 'edit';
Formats(1,1).format = 'integer';
%Formats(1,1).span = [1 2];
DefAns(1).ID = 32;


Formats(2,1).required = 'on'; % Name
Formats(2,1).type = 'edit';
Formats(2,1).format = 'text';
DefAns.Genus = 'Emad';
%Formats(2,1).span = [1 2];

Formats(3,1).required = 'on'; % Name
Formats(3,1).type = 'edit';
Formats(3,1).format = 'text';
DefAns.Species = 'Emad';
% Formats(3,1).span = [1 2];

Formats(4,1).required = 'on'; % Name
Formats(4,1).type = 'edit';
Formats(4,1).format = 'text';
DefAns.Subspecies = 'Emad';
% Formats(4,1).span = [1 2];


Formats(5,1).required = 'on'; % Name
Formats(5,1).type = 'edit';
Formats(5,1).format = 'text';
DefAns.Gender = 'Emad';
% Formats(5,1).span = [1 2];

Formats(6,1).required = 'on'; % Name
Formats(6,1).type = 'edit';
Formats(6,1).format = 'integer';
DefAns.Zoom = 2;


Formats(7,1).type = 'text'; % footnote


Options.AlignControls = 'on';

[Answer,Cancelled] = inputsdlg(Prompt,Title,Formats,DefAns,Options);

