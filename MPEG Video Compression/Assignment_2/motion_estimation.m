function [Y,Cb,Cr,Motion_Vector]=motion_estimation(current_frame,previous_frame)

%% Motion Estimation
h=size(previous_frame,1);
w=size(previous_frame,2);
prev_Y  = previous_frame(:,:,1);
prev_Cb = previous_frame(:,:,2);
prev_Cr = previous_frame(:,:,3);

flag = 0;
frame_size = 4;

curr_Y = current_frame(:,:,1);
curr_Cb = current_frame(:,:,2);
curr_Cr = current_frame(:,:,3);
Motion_Vector = zeros(h*w/frame_size^2,2);
for i = 1:4:h-frame_size+1
for j = 1:4:w-frame_size+1
    flag = flag+1;
    %% Current Frame 8x8 Block
    curr_block = curr_Y(i:i+3,j:j+3);
    Current_Frame_Block_Index = [i j];

    %% Comparing the pixels to the previous frame
    search_row_back = i-4;
    search_row_front = i+4;
    search_col_back = j-4;
    search_col_front = j+4;
    if (search_row_back <= 1)
        search_row_back = i;
    end
    if (search_row_front >= h)
        search_row_front = h;
    end
    if (search_col_back <= 1)
        search_col_back = j;
    end
    if (search_col_front >= w)
        search_col_front = w;
    end
   
    %% Traverse through the block and find the error
    ii=search_row_back;
    flag1 = 0;motion_diff_init = inf; flag2 = 0;
    while(ii<=search_row_front)
        jj=search_col_back;
        while(jj<=search_col_front)
            if((jj <= w-3) && (ii <= h-3))
                flag1 = flag1+1;                               
                motion_block = prev_Y(ii:ii+3,jj:jj+3);                             
                Difference = (curr_block - motion_block).^2;
                motion_diff = sum(sum(Difference(:)));
                flag2 = flag2+1;
                if(motion_diff < motion_diff_init)
                    motion_diff_init = motion_diff;
                    next_motion = [ii jj];
                end
            end
        jj = jj+1;
        end
        ii = ii+1;
    end
    %% Motion Vector and Sub-Pel Check
    Motion_Vector(flag,:) = next_motion-Current_Frame_Block_Index;

    %% Error Frame
    residuals_i = i+Motion_Vector(flag,1);
    residuals_j = j+Motion_Vector(flag,2);
    
    Y(i:i+3,j:j+3) = curr_Y(i:i+3,j:j+3) - prev_Y(residuals_i:residuals_i+3,residuals_j:residuals_j+3);
    Cb(i:i+3,j:j+3) = curr_Cb(i:i+3,j:j+3) - prev_Cb(residuals_i:residuals_i+3,residuals_j:residuals_j+3);
    Cr(i:i+3,j:j+3) = curr_Cr(i:i+3,j:j+3) - prev_Cr(residuals_i:residuals_i+3,residuals_j:residuals_j+3);

end
end