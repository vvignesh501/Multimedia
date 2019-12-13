function [ans] = RMSE(im1,im2)
ans = sqrt(sum(sum(((im1-im2).^2)))/(size(im1, 1)*size(im1, 2)));
end