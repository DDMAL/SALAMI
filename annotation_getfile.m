function [time_points, text_labels, bound_labels] = annotation_getfile(song_number, timescale, textfile_no, annotation_dir)

% function [time_points, text_labels, bound_labels] =
%   annotation_getfile(song_number, timescale, textfile_no, annotation_dir)
%
%   Takes a song identified by its SONG_NUMBER (i.e., its SALAMI ID), and
%   locates and accesses an available annotation file, returning the data
%   within that file.
%   
%   The default is to use the first available annotation (textfile1) and
%   to use the large-scale letter labels as boundaries. You can specify the
%   directory in which the annotations appear by a variable (ANNOTATION_DIR),
%   or hard-code it into the function.
%
%   Optionally, you can set SONG_NUMBER to be the filename of a target
%   annotation and load that instead.
%   
%   The BOUND_LABELS are all just 1 by default, but if you want to have the
%   large and small scale boundaries returned, this output vector contains a
%   2 if the boundary is large and 1 if the boundary is small-scale.
%
%   Example use:
%   [tims txts] = annotation_getfile(6,'small',2)
%       Returns the times and text labels of the small-scale annotations of
%       'textfile2' for the 6th song.
%
%   [tims txts labs] = annotation_getfile(1006,'small_and_large',1)
%       Returns the times and text labels of all segments of 'textfile1',
%       and indicates for each in LABS whether it is a large or small
%       boundary.
%
%   Written by Jordan Bennett Louis Smith.

if nargin<3,
    textfile_no = 1;
end
if nargin<2,
    timescale = 'large';
end
if nargin<1,
    song_number = 2;
    disp('Accessing annotation for song number 2 by default.')
end

% Upon receiving this file, you should manually edit this portion to your liking.
% Whatever you put here, you need to have two strings for later:
% ANNOTATION_DIR, the directory where all the annotations are located, and
% DIR_SEPARATOR, either " / " or " \ " (without spaces) depending on your system.
if nargin<4,
    annotation_dir = '/Users/jordan/Desktop/SALAMI_data_v1.2/data/';
    dir_separator = '/';
else
    dir_separator = annotation_dir(1);
end

switch timescale
    case 'small'
        % Load the lowercase annotations:
        if ischar(song_number),
            annotation_file = song_number;
        else
            annotation_file = strcat(annotation_dir,int2str(song_number),dir_separator,'parsed',dir_separator,'textfile',int2str(textfile_no),'_lowercase.txt');
        end
        fid = fopen(annotation_file,'r');
        btimes = textscan(fid,'%f%[^\n]');
        fclose(fid);
        % Take all the onset times and label with 1s.
        text_labels = btimes{2};
        btimes = btimes{1};
        if ~any(btimes==0),
            btimes = [0; btimes];
        end
        labels = ones(length(btimes),1);
    case 'large'
        % Load the uppercase annotations:
        if ischar(song_number),
            annotation_file = song_number;
        else
            annotation_file = strcat(annotation_dir,int2str(song_number),dir_separator,'parsed',dir_separator,'textfile',int2str(textfile_no),'_uppercase.txt');
        end
        fid = fopen(annotation_file,'r');
        btimes = textscan(fid,'%f%[^\n]');
        fclose(fid);
        % Take all the onset times and label with 1s.
        text_labels = btimes{2};
        btimes = btimes{1};
        labels = ones(length(btimes),1);
    case {'small_and_large','large_and_small'}
        % Now we want to take all boundaries, but give greater weight
        % to those that are also large boundaries.
        % Load small bound times:
        if ischar(song_number),
            annotation_file = song_number;
        else
            annotation_file = strcat(annotation_dir,int2str(song_number),dir_separator,'parsed',dir_separator,'textfile',int2str(textfile_no),'_lowercase.txt');
        end
        fid = fopen(annotation_file,'r');
        btimes = textscan(fid,'%f%[^\n]');
        fclose(fid);
        % Take all the onset times and label with 1s.
        text_labels = btimes{2};
        btimes = btimes{1};
        if ~any(btimes==0),
            btimes = [0; btimes];
        end
        labels = ones(length(btimes),1);
        % Load large bound times:
        if ischar(song_number),
            annotation_file = song_number;
        else
            annotation_file = strcat(annotation_dir,int2str(song_number),dir_separator,'parsed',dir_separator,'textfile',int2str(textfile_no),'_uppercase.txt');
        end
        fid = fopen(annotation_file,'r');
        btimes_lg = textscan(fid,'%f%[^\n]');
        btimes_lg = btimes_lg{1};
        fclose(fid);
        % Now, for every large boundary, find it in the list and adjust weight accordingly.
        for i=1:length(btimes_lg),
            labels(find(btimes_lg(i)==btimes))=2;
        end
end

time_points = btimes;
bound_labels = labels;