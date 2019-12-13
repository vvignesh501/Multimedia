function [MSE,PSNR] = loss(OriginalImage,ReconstructedImage,h,w,d)
    
    Bits=8;
    Size=h*w*d;
    MSE = sum((OriginalImage(:) - ReconstructedImage(:)).^2)/Size;
    PSNR = 10*log10((((2.^Bits)-1)^2)/MSE);
end