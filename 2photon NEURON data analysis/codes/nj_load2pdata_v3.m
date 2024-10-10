function [ctrlON,ctrlOFF,mutON,mutOFF,time]=nj_load2pdata_v2(cfg)

% STEP 1 LOAD THE RESPONDING CELL DATA
path=cfg.pathData;
cd(path)

% STEP1.1 LOAD THE CTRL DATA INTO ONE CELL ARRAY------------------------------------------

stk_files = dir(fullfile(path, '*ctrl*' ));

% makes a cell array called ctrlON for ctrlON datasets and ctrlOFF for ctrlOFF datasets
% raw one is just the title of the columns in the array
ctrlON=cell(1,7);
ctrlON{1,1}='name sample'; 
ctrlON{1,2}='DFF of cells activated during ON stimulus'; 
ctrlON{1,3}='DFF of cells inhibited during ON stimulus';
ctrlON{1,4}='x,y,z,brain area of cells activated during ON stimulus'; 
ctrlON{1,5}='x,y,z,brain area of cells inhibited during ON stimulus';
ctrlON{1,6}='DFF of ALL cells during ON stimulus'; 
ctrlON{1,7}='x,y,z,brain area of ALL cells'; 

ctrlOFF=cell(1,7);
ctrlOFF{1,1}='name sample'; 
ctrlOFF{1,2}='DFF of cells activated during OFF stimulus'; 
ctrlOFF{1,3}='DFF of cells inhibited during OFF stimulus';
ctrlOFF{1,4}='x,y,z,brain area of cells activated during OFF stimulus'; 
ctrlOFF{1,5}='x,y,z,brain area of cells inhibited during ON stimulus';
ctrlOFF{1,6}='DFF of ALL cells during OFF stimulus'; 
ctrlOFF{1,7}='x,y,z,brain area of ALL cells'; 


% I need a counter so that there is no empty rows
countON=2; countOFF=2;

for i=1:length(stk_files)
load(stk_files(i).name);
fps=amplitude.cfg.fps;
if isfield (amplitude,'ON')
    ctrlON{countON,1}=stk_files(i).name;
    ctrlON{countON,2}=amplitude.ON.UP.DFF;
    ctrlON{countON,3}=amplitude.ON.DOWN.DFF;
    ctrlON{countON,4}=amplitude.ON.UP.cellIDxyzb;
    ctrlON{countON,5}=amplitude.ON.DOWN.cellIDxyzb;
    ctrlON{countON,6}=amplitude.all.traces;
    ctrlON{countON,7}=amplitude.all.xyzb;
    countON=countON+1;
elseif isfield (amplitude,'OFF')
    ctrlOFF{countOFF,1}=stk_files(i).name;
    ctrlOFF{countOFF,2}=amplitude.OFF.UP.DFF;
    ctrlOFF{countOFF,3}=amplitude.OFF.DOWN.DFF;
    ctrlOFF{countOFF,4}=amplitude.OFF.UP.cellIDxyzb;
    ctrlOFF{countOFF,5}=amplitude.OFF.DOWN.cellIDxyzb;
    ctrlOFF{countOFF,6}=amplitude.all.traces;
    ctrlOFF{countOFF,7}=amplitude.all.xyzb;
    countOFF=countOFF+1;
end
amplitude=[];
end
stk_files=[];

% STEP1.2 LOAD THE MUTANT DATA INTO ONE CELL ARRAY------------------------------------------

stk_files = dir(fullfile(path, '*mut*' ));

% makes a cell array called mutON for mutON datasets and mutOFF for mutOFF datasets
% raw one is just the title of the columns in the array
mutON=cell(1,7);
mutON{1,1}='name sample'; 
mutON{1,2}='DFF of cells activated during ON stimulus'; 
mutON{1,3}='DFF of cells inhibited during ON stimulus';
mutON{1,4}='x,y,z,brain area of cells activated during ON stimulus'; 
mutON{1,5}='x,y,z,brain area of cells inhibited during ON stimulus';
mutON{1,6}='DFF of ALL cells during ON stimulus'; 
mutON{1,7}='x,y,z,brain area of ALL cells'; 


mutOFF=cell(1,7);
mutOFF{1,1}='name sample'; 
mutOFF{1,2}='DFF of cells activated during OFF stimulus'; 
mutOFF{1,3}='DFF of cells inhibited during OFF stimulus';
mutOFF{1,4}='x,y,z,brain area of cells activated during OFF stimulus'; 
mutOFF{1,5}='x,y,z,brain area of cells inhibited during ON stimulus';
mutOFF{1,6}='DFF of ALL cells during OFF stimulus'; 
mutOFF{1,7}='x,y,z,brain area of ALL cells'; 


% I need a counter so that tehre is no empty rows
countON=2; countOFF=2;

for i=1:length(stk_files)
load(stk_files(i).name);
fps=amplitude.cfg.fps;
if isfield (amplitude,'ON')
    mutON{countON,1}=stk_files(i).name;
    mutON{countON,2}=amplitude.ON.UP.DFF;
    mutON{countON,3}=amplitude.ON.DOWN.DFF;
    mutON{countON,4}=amplitude.ON.UP.cellIDxyzb;
    mutON{countON,5}=amplitude.ON.DOWN.cellIDxyzb;
    mutON{countON,6}=amplitude.all.traces;
    mutON{countON,7}=amplitude.all.xyzb;
    countON=countON+1;
elseif isfield (amplitude,'OFF')
    mutOFF{countOFF,1}=stk_files(i).name;
    mutOFF{countOFF,2}=amplitude.OFF.UP.DFF;
    mutOFF{countOFF,3}=amplitude.OFF.DOWN.DFF;
    mutOFF{countOFF,4}=amplitude.OFF.UP.cellIDxyzb;
    mutOFF{countOFF,5}=amplitude.OFF.DOWN.cellIDxyzb;
    mutOFF{countOFF,6}=amplitude.all.traces;
    mutOFF{countOFF,7}=amplitude.all.xyzb;
    countOFF=countOFF+1;
end
amplitude=[];
end

stk_files=[];

% make a time vector in min where 0 is time of stimulus
time=[0:size(ctrlON{2,2},2)-1]*1/fps;
time=time-max(time)/2;
%time=time/60;


