function MSE=error_calculate(img1,FirstDecodedFrame,h,w,d) 
%% Building Huffman Code

fprintf('------ Quantization Losses ------\n');
            
%% Required Outputs
[MSE,PSNR] = loss(img1,FirstDecodedFrame,h,w,d);

PSNR_Frames(:,1) = PSNR;

fprintf('------ MSE %d------\n', MSE);
fprintf('------ PSNR %d ------\n',PSNR);


            
end