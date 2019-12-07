% Expects image to be a uint8, returns uint8
function convertImage = convertImage(image, flag)
if flag==true
    image = im2double(image);
    
    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);
    
    Y  = R*0.229 + G*0.587 + B*0.144;
    Cb = R*-0.168736 + G*-0.331264 + B*0.5 + 0.5;
    Cr = R*0.5 + G*-0.418688 + B*-0.081312 + 0.5;   
    convertImage(:,:,1) = Y;
    convertImage(:,:,2) = Cb;
    convertImage(:,:,3) = Cr;
    
    convertImage = im2uint8(convertImage);
    
elseif flag==false
    image = double(image);
    
    Y = image(:,:,1);
    Cb = image(:,:,2);
    Cr = image(:,:,3);
    
    R = Y*1.000 + (Cb-128)*0.000 + (Cr-128)*1.403;
    G = Y*1.000 + (Cb-128)*-0.344 + (Cr-128)*-0.714;
    B = Y*1.000 + (Cb-128)*1.773 + (Cr-128)*0.000;   
    image(:,:,1) = R;
    image(:,:,2) = G;
    image(:,:,3) = B;
    
    convertImage = uint8(image);
        
end
end
