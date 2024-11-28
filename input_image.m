in_image = imread('test.png');
imshow(in_image)
gray_image = rgb2gray(in_image);
figure
imshow(gray_image)

gray_image_pad = [ zeros(1,302); zeros(200,1) gray_image zeros(200,1); zeros(1,302)];

fid = fopen('image_matrix.txt','w');
for i=1:(size(gray_image_pad,1))
    fprintf(fid,'%X ', gray_image_pad(i,:));    
    fprintf(fid,'\n');
end
fclose(fid);

F = [1 2 1                      %convolution
    0 0 0
    -1 -2 -1];

x= double(gray_image_pad);
for i=1:size(x,1)-size(F,1)+1
    for j=1:size(x,2)-size(F,2)+1
        y(i,j) = sum(sum (F.* (x(i:i+2 , j:j+2))));
    end
end

figure;
imshow(y)

for i=1:size(y,1)           %if like the if on conv module
    for j=1:size(y,2)
        if(y(i,j)>255)
            z(i,j)=255;
        elseif(y(i,j)<0)
            z(i,j)=0;
        else
            z(i,j)=y(i,j);
        end
    end
end
        
        

figure;
imshow(z)