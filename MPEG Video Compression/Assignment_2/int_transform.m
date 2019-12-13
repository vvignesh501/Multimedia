function W = int_transform(VectorBlock_Y,VectorBlock_Cb,VectorBlock_Cr)
 
Cf =  [1 1 1 1
      2 1 -1 -2
      1 -1 -1 1
      1 -2 2 -1];

X(:,:,1)=VectorBlock_Y;
X(:,:,2)=VectorBlock_Cb;
X(:,:,3)=VectorBlock_Cr;

W= Cf.*X.*Cf';

end