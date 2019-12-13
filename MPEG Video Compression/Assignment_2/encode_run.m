function [encode_Y, encode_Cb, encode_Cr] = encode_run(encode_Y,encode_Cb,encode_Cr,EOB)
    
    for k =1:3
        if k == 1
            value=[];
            traverse = encode_Y;
        elseif k == 2
            value=[];
            traverse = encode_Cb;
        elseif k == 3
            value=[];
            traverse = encode_Cr;
        end
        loop =0;
        i = 1;
        while i <= size(traverse,2)

            current = traverse(i);
            loop = loop+1;
            value(1,loop) = current;
                if (current == 0)
                    run = 0;
                    if (find(traverse(i+1:end)~=0))
                        while traverse(i+1) == 0                
                            run = run + 1;
                            i = i+1;
                        end
                        value(1,loop+1) = run;
                        loop = loop+1;

                    end
                end
            i = i+1;
        end
        if k == 1
            encode_Y = value;
            encode_Y = encode_Y(1:find(encode_Y(1:end)~=0, 1, 'last' ));
            encode_Y = [encode_Y,EOB];
        elseif k == 2
            encode_Cb = value;
            encode_Cb = encode_Cb(1:find(encode_Cb(1:end)~=0, 1, 'last' ));
            encode_Cb = [encode_Cb,EOB];
        elseif k == 3
            encode_Cr = value;
            encode_Cr = encode_Cr(1:find(encode_Cr(1:end)~=0, 1, 'last' ));
            encode_Cr = [encode_Cr,EOB];
        end

    end
end

