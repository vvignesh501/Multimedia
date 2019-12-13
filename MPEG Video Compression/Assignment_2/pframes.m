function decode_frames = pframes(recon_data,endd)

[~, ind] = find(recon_data==endd);
 for k = 1:size(ind,2)
     flag = 0;
     i = 1;
     value = 0;
    if k == 1
        data = recon_data(1:ind(k)-1);
    else
        data = recon_data(ind(k-1)+1:ind(k)-1);
    end    

    while i <= size(data,2)

        current = data(i);
        flag = flag+1;
        value(1,flag) = current;
            if (current == 0)
                run = data(i+1);
                value(1,flag+1:flag+run) = current;
                flag = flag+run;
                i = i+1;
            end
        i = i+1;
    end
    decode = value;
    decode(max(size(decode,2)+1:16)) = 0;
    if k == 1
        decode_frames = decode;
    else
        decode_frames = [decode_frames,decode];
    end
 end
end