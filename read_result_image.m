fpga_output = fopen('output_image.txt','r');
i=1;
while(~feof(fpga_output))
    text = fgets(fpga_output);
    a(i,:) = sscanf(text,'%d ');
    i = i+1;
end

fclose(fpga_output);
imshow(a./255)