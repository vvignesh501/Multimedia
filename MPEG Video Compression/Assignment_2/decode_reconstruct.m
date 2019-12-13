function [decod_traverse_Y, decod_traverse_Cb, decod_traverse_Cr] = decode_reconstruct(decod_Y,decod_Cb,decod_Cr)

    traverse = [1 2 6 7; 3 5 8 13; 4 9 12 14; 10 11 15 16];
    decod_traverse_Y = decod_Y(traverse);
    decod_traverse_Cb = decod_Cb(traverse);
    decod_traverse_Cr = decod_Cr(traverse);

    decod_traverse_Y = reshape(decod_traverse_Y,4,4);
    decod_traverse_Cb = reshape(decod_traverse_Cb,4,4);
    decod_traverse_Cr = reshape(decod_traverse_Cr,4,4);
            
end