function Final_PSNR = main(optionFlag,no_frames,start_frames)


start = 700; 
endd=700;


    for frames = 1:no_frames
        Fr_Num = start_frames+frames;
        
        if (frames == 1)
            frame1 = strcat('C:\Vignesh\2nd Sem\Multimedia Systems\Assignment 2\Assignment\Submit\Assignment_2\data\sequences\Image00',num2str(Fr_Num),'.jpg');
            frame1=double(imread(frame1));
            
            h=size(frame1,1); w=size(frame1,2); d=size(frame1,3);
            
            %RGB to YCbCr conversion
            [subsampledYUV(:,:,1), subsampledYUV(:,:,2), subsampledYUV(:,:,3)] = subsampleRGbToYUV(frame1);
            
            %Encoding the i Frame
            encoded_img = intra_encode1(subsampledYUV,optionFlag,endd);
            
            %% Decoding the i Frame
            [Decoded_Ref_Frame_Y, Decoded_Ref_Frame_Cb, Decoded_Ref_Frame_Cr] = decode(encoded_img,frame1,optionFlag,endd);
            Decoded_Frames_Y(:,1:w) = Decoded_Ref_Frame_Y;
            Decoded_Frames_Cb(:,1:w) = Decoded_Ref_Frame_Cb;
            Decoded_Frames_Cr(:,1:w) = Decoded_Ref_Frame_Cr;
            
            %% YCbCr to RGB
            [FirstDecodedFrame(:,:,1), FirstDecodedFrame(:,:,2), FirstDecodedFrame(:,:,3)] = subsampleYUVToRGB(Decoded_Ref_Frame_Y,Decoded_Ref_Frame_Cb,Decoded_Ref_Frame_Cr);
             A=FirstDecodedFrame/256;
             imwrite(A,['C:\Vignesh\2nd Sem\Multimedia Systems\Assignment 2\Assignment\Submit\Assignment_2\data\Image_Convert\Image00' num2str(Fr_Num), '.jpg']);
             
             %Error Calculation for First I Frame
             error=error_calculate(frame1,FirstDecodedFrame,h,w,d);
             fprintf('------ Frame - %d - Decoded ------\n',frames);

        else
            prev_frame=frames-1;
            old_frame=frames-2;
            Frame_FileName = strcat('C:\Vignesh\2nd Sem\Multimedia Systems\Assignment 2\Assignment\Submit\Assignment_2\data\sequences\Image00',num2str(Fr_Num),'.jpg');
            CurrentFrame = double(imread(Frame_FileName));
            [Y_Frame, Cb_Frame, Cr_Frame] = subsampleRGbToYUV(CurrentFrame);

            %% Current Frame to be Decoded
            Current_Frame_YCbCr(:,:,1) = Y_Frame;
            Current_Frame_YCbCr(:,:,2) = Cb_Frame;
            Current_Frame_YCbCr(:,:,3) = Cr_Frame;        

            %% Reference frame (Previous Decoded Frame)
            Ref_Frame(:,:,1) = Decoded_Frames_Y(:,(old_frame)*w+1:(prev_frame)*w);
            Ref_Frame(:,:,2) = Decoded_Frames_Cb(:,(old_frame)*w+1:(prev_frame)*w);
            Ref_Frame(:,:,3) = Decoded_Frames_Cr(:,(old_frame)*w+1:(prev_frame)*w);
            
            %Calculating the Motion Estimation
            [encod_frame(:,:,1),encod_frame(:,:,2),encod_frame(:,:,3), Motion_Vector] = motion_estimation(Current_Frame_YCbCr,Ref_Frame);
            
            encoded_pframes = intra_encode1(encod_frame,optionFlag,endd);
            
            %% Motion Compensation (Decoding the current Frame)
            Decoded_Ref_Frame = decode_pframes(encoded_pframes,Motion_Vector,Ref_Frame,optionFlag,endd);
            Decoded_Frames_Y(:,(prev_frame)*w+1:frames*w) = Decoded_Ref_Frame(:,:,1);
            Decoded_Frames_Cb(:,(prev_frame)*w+1:frames*w) = Decoded_Ref_Frame(:,:,2);
            Decoded_Frames_Cr(:,(prev_frame)*w+1:frames*w) = Decoded_Ref_Frame(:,:,3);
            
            [Decoded_Frame(:,:,1), Decoded_Frame(:,:,2), Decoded_Frame(:,:,3)] = subsampleYUVToRGB(Decoded_Ref_Frame(:,:,1),Decoded_Ref_Frame(:,:,2),Decoded_Ref_Frame(:,:,3));
            imwrite(Decoded_Frame/256,['C:\Vignesh\2nd Sem\Multimedia Systems\Assignment 2\Assignment\Submit\Assignment_2\data\Image_Convert\Image00' num2str(Fr_Num), '.jpg']);      
            PSNR_Frames= PSNR_calc(h,w,d,CurrentFrame,Decoded_Frame,frames);
        end
    end
    
    %Calculating the final PSNR Value
    Final_PSNR = mean(PSNR_Frames);
   
    fprintf('------ Total PSNR - %d ------\n',Final_PSNR);
   
end
