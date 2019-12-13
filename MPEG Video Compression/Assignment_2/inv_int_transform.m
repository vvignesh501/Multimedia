function [inv_Y, inv_Cb, inv_Cr] = inv_int_transform(X)

Cf =  [1 1 1 1
      1 1/2 -1/2 -1
      1 -1 -1 1
      1/2 -1 1 -1/2];

Y=round(Cf'.*X.*Cf);

inv_Y = Y(:,:,1);
inv_Cb = Y(:,:,2);
inv_Cr = Y(:,:,3);

end