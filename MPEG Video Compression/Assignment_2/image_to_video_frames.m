function output = image_to_video_frames()

workingDir = 'C:\Vignesh\2nd Sem\Multimedia Systems\Assignment 2\Assignment\Submit\Assignment_2\data\';
mkdir(workingDir,'Image_Convert')


imageNames = dir(fullfile(workingDir,'Image_Convert','*.jpg'));
imageNames = {imageNames.name}';
str  = sprintf('%s#', imageNames{:});
num  = sscanf(str, 'Image%d.jpg#');
[~, index] = sort(num);
imageNames = imageNames(index);

outputVideo = VideoWriter(fullfile(workingDir,'sample_output'));
open(outputVideo)


for ii = 1:length(imageNames)
   img = imread(fullfile(workingDir,'Image_Convert',imageNames{ii}));
   writeVideo(outputVideo,img)
end

output=workingDir;
close(outputVideo)