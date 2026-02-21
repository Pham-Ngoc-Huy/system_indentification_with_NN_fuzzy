clc;
clear;

%% reading exoskeleton data
folder_path = "D:\system_indentification_with_NN_fuzzy\data\data\MAT files";

% list all items in folder
listing = dir(folder_path);

% keep only directories
isDir = [listing.isdir];
folderlist = listing(isDir);

% remove "." and ".."
folderlist = folderlist(~ismember({folderlist.name}, {'.','..'}));

%% find Participant folders
participantFolders = folderlist(startsWith({folderlist.name}, 'Participant'));

%% loop through each participant
data = [];
for i = 1:length(participantFolders)

    participantName = participantFolders(i).name;

    matPath = fullfile(folder_path, participantName, "Processed_Data.mat");

    if isfile(matPath)

        fprintf("Loading %s\n", participantName);

        data = load(matPath);

        % display variable names inside MAT file
        disp(fieldnames(data))
    end
end