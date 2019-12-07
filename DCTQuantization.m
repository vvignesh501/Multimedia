% Expects image to be a double
function imgOut = DCTQuantization(image, flag,quality)

    imgSize = size(image(:,:,1));

    image = double(image);
    
    luminance_mat = [ 16, 11, 10, 16, 24, 40, 51, 61;
        12, 12, 14, 19, 26, 58, 60, 55;
        14, 13, 16, 24, 40, 57, 69, 56;
        14, 17, 22, 29, 51, 87, 80, 62;
        18, 22, 37, 56, 68, 109, 103, 77;
        24, 35, 55, 64, 81, 104, 113, 92;
        49, 64, 78, 87, 103, 121, 120, 101;
        72, 92, 95, 98, 112, 100, 103, 99 ].*quality;

    chrominance_mat = [ 17, 18, 24, 47, 99, 99, 99, 99;
        18, 21, 26, 66, 99, 99, 99, 99;
        24, 26, 56, 99, 99, 99, 99, 99;
        47, 66, 99, 99, 99, 99, 99, 99;
        99, 99, 99, 99, 99, 99, 99, 99;
        99, 99, 99, 99, 99, 99, 99, 99;
        99, 99, 99, 99, 99, 99, 99, 99;
        99, 99, 99, 99, 99, 99, 99, 99 ].*quality;

    
    luminance_mat = double(luminance_mat);
    chrominance_mat = double(chrominance_mat);


    lum_size = size(luminance_mat);
    sizeRatio = ceil(imgSize ./ lum_size);
    luminance = repmat(luminance_mat, sizeRatio);
    luminance = luminance(1:imgSize(1), 1:imgSize(2)); 

    chrom_size = size(chrominance_mat);
    sizeRatio = ceil(imgSize ./ chrom_size);
    chrominance = repmat(chrominance_mat, sizeRatio);
    chrominance = chrominance(1:imgSize(1), 1:imgSize(2)); 

    if flag == true
        imgOut(:,:,1) = round(image(:,:,1) .* luminance);
        imgOut(:,:,2) = round(image(:,:,2) .* chrominance);
        imgOut(:,:,3) = round(image(:,:,3) .* chrominance);
    else
        imgOut(:,:,1) = round(image(:,:,1) ./ luminance);
        imgOut(:,:,2) = round(image(:,:,2) ./ chrominance);
        imgOut(:,:,3) = round(image(:,:,3) ./ chrominance);
    end

end

