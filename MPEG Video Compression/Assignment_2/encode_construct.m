function [traverse_Y, traverse_Cb, traverse_Cr] = encode_construct(quant_Y,quant_Cb,quant_Cr)
     
traverse=[1 2 6 7; 3 5 8 13; 4 9 12 14; 10 11 15 16];
input_Y = reshape(quant_Y,[4 4]);
traverse_Y(traverse(:)) = input_Y;

input_Cb = reshape(quant_Cb,[4 4]);
traverse_Cb(traverse(:)) = input_Cb;

input_Cr = reshape(quant_Cr,[4 4]);
traverse_Cr(traverse(:)) = input_Cr;

end

        
        




