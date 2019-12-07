    
function [img1,f4comp,f4decomp,img2,f2comp,f2decomp,fcomp,fdecomp,fdash,loss1,Loss2,Loss3,compressionRatio]= Hierarchical_JPEG(image,quality)
    
    %Subsampling F4
    img1=imresize(image,0.25, 'bilinear');

    %Subsampling F2
    img2=imresize(image,0.5, 'bilinear');
    
 %F4 RGBtoYUV Create Matrix Encoding and Decoding
    yCbCr = convertImage(img1,true);
    yCbCr = double(yCbCr);
    sampledImage = chromasample(yCbCr);
    sampledImage = DCTCreateMatrix(sampledImage,8,false);
    sampledImage = DCTQuantization(sampledImage,false,quality); %Compress the image
    f4comp=sampledImage;
    sampledImage = DCTQuantization(sampledImage,true,quality);  %Decompress the image   
    sampledImage = DCTCreateMatrix(sampledImage,8,true);
    sampledImage = uint8(sampledImage);
    sampledImage = convertImage(sampledImage,false);

    f4decomp=sampledImage;
    f4dash=sampledImage;
    
    %Use Upsampling to resize to F2
    [h,w,d]=size(f4dash);
    Ef4dash=imresize(f4dash,[h*2,w*2],'bilinear');
    
    imwrite(Ef4dash,'UpsampledF4.png');
    %Find the difference D2
    d2=imabsdiff(img2,Ef4dash);

    %compute errros and print 
    checkk=imresize(f4dash,[h*4,w*4],'bilinear');
    %losss=imabsdiff(image,checkk);
    loss1=RMSE(image,checkk);
    loss1=loss1(:,:,1);
    

 %F2 RGBtoYUV, Create Matrix, Encoding and Decoding
    yCbCr = convertImage(d2,true);
    yCbCr = double(yCbCr);
    sampledImage2 = chromasample(yCbCr);
    sampledImage2 = DCTCreateMatrix(sampledImage2,8,false);   
    sampledImage2 = DCTQuantization(sampledImage2,false,quality); %Compress the image
    f2comp=sampledImage2;   
    sampledImage2 = DCTQuantization(sampledImage2,true,quality);  %Decompress the image
    sampledImage2 = DCTCreateMatrix(sampledImage2,8,true);
    sampledImage2 = uint8(sampledImage2);
    sampledImage2 = convertImage(sampledImage2,false);

    f2decomp=sampledImage2;
    d2dash=sampledImage2;

    f2dash= imadd(Ef4dash,d2dash);       %Result f2dash

    %Upsampling f2dash
    [h,w,~]=size(f2dash);
    Ef2dashh=imresize(f2dash,[h*2,w*2],'bilinear');
    
    imwrite(Ef2dashh,'UpsampledF2.png');
    %Find the Difference d1
    d1=imabsdiff(image,Ef2dashh); 
    
    %compute errros and print them
    losss2=RMSE(image,Ef2dashh);
    Loss2=losss2(:,:,1);
    

  %F0 RGBToYUV,DCT matrix, encoding and decoding 
    YCbCr = convertImage(d1,true);
    YCbCr = double(YCbCr);
    sampledImage3 = chromasample(YCbCr);
    sampledImage3 = DCTCreateMatrix(sampledImage3,8,false);
    sampledImage3 = DCTQuantization(sampledImage3,false,quality);  %Compress the image
    fcomp=sampledImage3;
    sampledImage3 = DCTQuantization(sampledImage3,true,quality);  %Decompress the image
    sampledImage3 = DCTCreateMatrix(sampledImage3,8,true);
    sampledImage3 = uint8(sampledImage3);
    sampledImage3 = convertImage(sampledImage3,false);
    fdecomp=sampledImage3;
    d1dash=sampledImage3;
      
    %Find Fdash result
    fdash= imadd(Ef2dashh,d1dash); 
    
    [h,w,~]=size(fdash);
    check2=imresize(f2dash,[h*2,w*2],'bilinear');
    imagecheck=imresize(image,[h*2,w*2],'bilinear');
    
    %d=imabsdiff(imagecheck,check2);
    losss3=RMSE(imagecheck,check2);
    %compute errros and print them
    Loss3=losss3(:,:,1);
   

     %Compression Ratio
    imwrite(image,'Original.png');
    imwrite(fdash,'Final.png');
    compressionRatio=CompressionRatio('Original.png','Final.png');
    disp(compressionRatio);
     
end