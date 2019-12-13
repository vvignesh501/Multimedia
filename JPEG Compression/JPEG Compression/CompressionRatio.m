function [ CompressionRatio ] = CompressionRatio(image1,image2)

original = dir(image1); 
filesize1 = original.bytes;
compressed = dir(image2); 
filesize2 = compressed.bytes;
CompressionRatio = filesize1/filesize2;
end