function [quant_Y, quant_Cb, quant_Cr] = quantization(X)

QP=22;
q = 15 + floor(QP/6);

MF =[13107 5243 8066
     11916 4660 7490
     10082 4194 6554
     9362  3647 5825
     8192  3355 5243
     7282  2893 4559];
 
x = rem(QP,6);
 
a = MF(x+1,1);
b = MF(x+1,2);
c = MF(x+1,3);

M = [a c a c
     c b c b
     a c a c
     c b c b];
 
Z = round(X.*(M/2^q));

quant_Y=Z(:,:,1);
quant_Cb=Z(:,:,2);
quant_Cr=Z(:,:,3);
end
