% Expects imgIn to be a double
function image = DCTCreateMatrix(imgIn, N, flag)
    T = zeros(N,N);
    for i = 0:1:N-1
        for j = 0:1:N-1
            if j == 0
                xn = sqrt(1/N);
            else
                xn = sqrt(2/N);
            end
        T(j+1,i+1) =xn*cos( ((2*i+1)*j*pi) /(2*N));
        end
    end
    
    if flag == true
        dct = @(block_struct) T' * block_struct.data * T;
    else
        dct = @(block_struct) T * block_struct.data * T';
    end    
    
    if size(imgIn,3) > 1 % color image, more than one channel
        image(:,:,1) = blockproc(imgIn(:,:,1),[N N],dct,'PadPartialBlocks',true);
        image(:,:,2) = blockproc(imgIn(:,:,2),[N N],dct,'PadPartialBlocks',true);
        image(:,:,3) = blockproc(imgIn(:,:,3),[N N],dct,'PadPartialBlocks',true);
        image = image(1:size(imgIn,1), 1:size(imgIn,2), :); 
    else % grayscale image, only one channel
        image = blockproc(imgIn,[N N],dct,'PadPartialBlocks',true);
        image = image(1:size(imgIn,1), 1:size(imgIn,2));        
    end
    
end