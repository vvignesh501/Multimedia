  function W = de_quant(DeZigZag_Y,DeZigZag_Cb,DeZigZag_Cr)

Z(:,:,1)=DeZigZag_Y;
Z(:,:,2)=DeZigZag_Cb;
Z(:,:,3)=DeZigZag_Cr;

QP=22;


Vi = [10 16 13
      11 18 14
      13 20 16
      14 23 18
      16 25 20
      18 29 23];
 
 x = rem(QP,6);
 
 a = Vi(x+1,1);
 b = Vi(x+1,2);
 c = Vi(x+1,3);

 V = [a c a c
      c b c b
      a c a c
      c b c b];
  
 % find the inverse quantized coefficients
  W = Z.*V;
    
end
