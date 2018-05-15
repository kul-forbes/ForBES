% install external libs
lib_path = pwd;

%% install panoc


if ismac
    disp('Using mex interface Mac os');
    mex_file_location=fullfile(lib_path,'forbes_panoc','bin','PANOC_Mac64_clang.mexmaci64');
    mex_file_destination = fullfile(lib_path,'forbes_panoc','bin','panoc.mexmaci64');
elseif isunix
    disp('Using mex interface Linux');
    mex_file_location=fullfile(lib_path,'forbes_panoc','bin','PANOC_linux64_gcc.mexa64');
    mex_file_destination = fullfile(lib_path,'forbes_panoc','bin','panoc.mexa64');
elseif ispc
    disp('Using mex interface Windows');
    mex_file_location=fullfile(lib_path,'forbes_panoc','bin','panoc_Windows64VStudio.mexw64');
else
    disp('Platform not supported')
end
copyfile(mex_file_location,mex_file_destination);


%% add paths to path and save
addpath(fullfile(lib_path,'forbes_panoc','bin'));
addpath(fullfile(lib_path,'src_Matlab'));
savepath;% write away path variable

