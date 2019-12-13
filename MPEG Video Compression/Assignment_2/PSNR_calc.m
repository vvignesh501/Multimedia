function PSNR_Frames=PSNR_calc(h,w,d,CurrentFrame,Decoded_Frame,frames)

            
[MSE,PSNR] = loss(CurrentFrame,Decoded_Frame,h,w,d);
PSNR_Frames(:,frames) = PSNR;

fprintf(' MSE ------%d\n',MSE);
fprintf('PSNR ------%d\n',PSNR);
fprintf('------ Frame - %d - Decoded ------\n',frames);

end