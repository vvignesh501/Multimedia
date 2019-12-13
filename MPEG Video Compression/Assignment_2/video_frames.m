 vid=VideoReader('data/formancif.mov');
 numFrames = vid.NumberOfFrames;
 n=numFrames;
 for i = 1:n
 frames = readframe(vid,i);
 imwrite(frames,['data/sequences/Image00' int2str(i), '.jpg']);
 end
 
 
 