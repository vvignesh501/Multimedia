function [decoded_Y, decoded_Cb, decoded_Cr] = decode(Reconstructed_Data,Image,optionFlag,endd)

h=size(Image,1);
w=size(Image,2);
flag = 0;
recon_Data = pframes(Reconstructed_Data,endd);
recon_dec_Y = recon_Data(1,1:size(recon_Data,2)/3);
recon_dec_Cb = recon_Data(1,size(recon_Data,2)/3+1:2*size(recon_Data,2)/3);
recon_dec_Cr = recon_Data(1,2*size(recon_Data,2)/3+1:end);

for i = 0:4:h-4
    for j = 0:4:w-4
        flag = flag+1;     
        [recon_Y, recon_Cb, recon_Cr] = decode_reconstruct(recon_dec_Y((flag-1)*16+1:flag*16),recon_dec_Cb((flag-1)*16+1:flag*16),recon_dec_Cr((flag-1)*16+1:flag*16));
        W = de_quant(recon_Y,recon_Cb,recon_Cr);
        if ( optionFlag==2)
            [inv_Y, inv_Cb, inv_Cr] = inv_int_transform(W);
        end
        
        %% Image Reconstruction
        decoded_Y(i+1:i+4,j+1:j+4) = inv_Y;
        decoded_Cb(i+1:i+4,j+1:j+4) = inv_Cb;
        decoded_Cr(i+1:i+4,j+1:j+4) = inv_Cr;
    end
end

end