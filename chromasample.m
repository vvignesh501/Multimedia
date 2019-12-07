function image = chromasample(image)
    Cb = image(:,:,2);
    Cr = image(:,:,3);

    for i=1:size(Cb,1)
        for j=1:size(Cb,2)
            if mod(j, 2) == 1 && mod(i,2) == 1
                color = Cb(i,j);
            elseif mod (j, 2) == 1
                color = Cb(i-1,j);
            end
            Cb(i,j) = color;
        end
    end
    image(:,:,2) = Cb;
    
    for i=1:size(Cr,1)
        for j=1:size(Cr,2)
            if mod(j, 2) == 1 && mod(i,2) == 1
                color = Cr(i,j);
            elseif mod (j, 2) == 1
                color = Cr(i-1,j);
            end
            Cr(i,j) = color;
        end
    end
    image(:,:,3) = Cr;