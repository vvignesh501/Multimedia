function Decoded_Ref_Frame = decode_pframes(encoded_pframes,Motion_Vector,Ref_Frame,optionFlag,endd)

    h=size(Ref_Frame,1);
    w=size(Ref_Frame,2);
    Ref_Frame_Y = Ref_Frame(:,:,1);
    Ref_Frame_Cb = Ref_Frame(:,:,2);
    Ref_Frame_Cr = Ref_Frame(:,:,3);
    decode_pframes = pframes(encoded_pframes,endd);
    decoded_Y = decode_pframes(1,1:size(decode_pframes,2)/3);
    decoded_Cb = decode_pframes(1,size(decode_pframes,2)/3+1:2*size(decode_pframes,2)/3);
    decoded_Cr = decode_pframes(1,2*size(decode_pframes,2)/3+1:end);
    flag = 0;
    for i = 0:4:h-4+1
        for j = 0:4:w-4+1
        flag = flag+1;
        
        [decode_Y, decode_Cb, decode_Cr] = decode_reconstruct(decoded_Y((flag-1)*16+1:flag*16),decoded_Cb((flag-1)*16+1:flag*16),decoded_Cr((flag-1)*16+1:flag*16));
        W = de_quant(decode_Y,decode_Cb,decode_Cr);
      
            if ( optionFlag==2)
            [inv_Y, inv_Cb, inv_Cr] = inv_int_transform(W);
            end
       
        %% Image Reconstruction
            
        Corrected_i = i+Motion_Vector(flag,1);
        Corrected_j = j+Motion_Vector(flag,2);

        Decoded_Ref_Frame_Y(i+1:i+4,j+1:j+4) = inv_Y + Ref_Frame_Y(Corrected_i+1:Corrected_i+4,Corrected_j+1:Corrected_j+4);
        Decoded_Ref_Frame_Cb(i+1:i+4,j+1:j+4) = inv_Cb + Ref_Frame_Cb(Corrected_i+1:Corrected_i+4,Corrected_j+1:Corrected_j+4);
        Decoded_Ref_Frame_Cr(i+1:i+4,j+1:j+4) = inv_Cr + Ref_Frame_Cr(Corrected_i+1:Corrected_i+4,Corrected_j+1:Corrected_j+4);
      
        end
    end
    Decoded_Ref_Frame(:,:,1) = Decoded_Ref_Frame_Y;
    Decoded_Ref_Frame(:,:,2) = Decoded_Ref_Frame_Cb;
    Decoded_Ref_Frame(:,:,3) = Decoded_Ref_Frame_Cr;
end