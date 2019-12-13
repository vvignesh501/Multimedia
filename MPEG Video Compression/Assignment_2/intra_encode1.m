function encoded_img = intra_encode1(img,optionFlag,EOB)
encoded_frame_Y=[]; 
encoded_frame_Cb=0; 
encoded_frame_Cr=0;
h=size(img,1);
w=size(img,2);
frame_Y = img(:,:,1);
frame_Cb = img(:,:,2);
frame_Cr = img(:,:,3);
flag = 0;

    for i = 0:4:h-4
        for j = 0:4:w-4
            flag = flag+1;
            if (i==0)&(j==0)    % Mode=1 Vertical
                vector_Y = frame_Y(i+1:i+4,j+1:j+4);
                vector_Cb = frame_Cb(i+1:i+4,j+1:j+4);
                vector_Cr = frame_Cr(i+1:i+4,j+1:j+4);

                if ( optionFlag==2)
                W = int_transform(vector_Y,vector_Cb,vector_Cr);
                end
                [quant_Y, quant_Cb, quant_Cr] = quantization(W);
                [construct_Y, construct_Cb, construct_Cr] = encode_construct(quant_Y,quant_Cb,quant_Cr);
                [encoded_Y, encoded_Cb, encoded_Cr] = encode_run(construct_Y,construct_Cb,construct_Cr,EOB);

                % Merging the data for whole image
                if ( i == 0 && j == 0)
                    encoded_frame_Y = encoded_Y;
                    encoded_frame_Cb = encoded_Cb;
                    encoded_frame_Cr = encoded_Cr;
                else
                    encoded_frame_Y = [encoded_frame_Y,encoded_Y];
                    encoded_frame_Cb = [encoded_frame_Cb,encoded_Cb];
                    encoded_frame_Cr = [encoded_frame_Cr,encoded_Cr];
                end   
            elseif(i==0)       %%%Mode =1   % Horizontal
                vector_Y = frame_Y(i+1:i+4,j+1:j+4);
                vector_Cb = frame_Cb(i+1:i+4,j+1:j+4);
                vector_Cr = frame_Cr(i+1:i+4,j+1:j+4);

                % DCT --> Quantization --> ZigZagScan --> RunLengthCoding
                if ( optionFlag==2)
                W = int_transform(vector_Y,vector_Cb,vector_Cr);
                end
                [quant_Y, quant_Cb, quant_Cr] = quantization(W);
                [construct_Y, construct_Cb, construct_Cr] = encode_construct(quant_Y,quant_Cb,quant_Cr);
                [encoded_Y, encoded_Cb, encoded_Cr] = encode_run(construct_Y,construct_Cb,construct_Cr,EOB);

                % Merging the data for whole image
                if ( i == 0 && j == 0)
                    encoded_frame_Y = encoded_Y;
                    encoded_frame_Cb = encoded_Cb;
                    encoded_frame_Cr = encoded_Cr;
                else
                    encoded_frame_Y = [encoded_frame_Y,encoded_Y];
                    encoded_frame_Cb = [encoded_frame_Cb,encoded_Cb];
                    encoded_frame_Cr = [encoded_frame_Cr,encoded_Cr];
                end   
            else %%%Mode =2   
                vector_Y = frame_Y(i+1:i+4,j+1:j+4);
                vector_Cb = frame_Cb(i+1:i+4,j+1:j+4);
                vector_Cr = frame_Cr(i+1:i+4,j+1:j+4);

                if ( optionFlag==2)
                W = int_transform(vector_Y,vector_Cb,vector_Cr);
                end
                [quant_Y, quant_Cb, quant_Cr] = quantization(W);
                [construct_Y, construct_Cb, construct_Cr] = encode_construct(quant_Y,quant_Cb,quant_Cr);
                [encoded_Y, encoded_Cb, encoded_Cr] = encode_run(construct_Y,construct_Cb,construct_Cr,EOB);

                % Merging the data for whole image
                if ( i == 0 && j == 0)
                    encoded_frame_Y = encoded_Y;
                    encoded_frame_Cb = encoded_Cb;
                    encoded_frame_Cr = encoded_Cr;
                else
                    encoded_frame_Y = [encoded_frame_Y,encoded_Y];
                    encoded_frame_Cb = [encoded_frame_Cb,encoded_Cb];
                    encoded_frame_Cr = [encoded_frame_Cr,encoded_Cr];
                end   
            end
        end
    end
    encoded_img = [encoded_frame_Y,encoded_frame_Cb,encoded_frame_Cr];
end