se = strel('cube', 3);


%{
view all mitochondria
mitochondria i%3 = 0
astrocyte i%3 = 1
endfoot i%3 = 2
%}

mito_3d = zeros(1600, 1600, 24);


for i = 0:23
    [im1, camp] = imread("../Images_Kathie/02_15501_APPwt_Mito_Lck_AQP4_60X_z.tif", i*3+1);
    mito_3d(:,:,i+1) = im1;
     
end

data_open1 = imopen(mito_3d, se);


min_pix = min(data_open1, [], 'all');
max_pix = max(data_open1, [], 'all');

data_open1 = (data_open1 - min_pix)/max_pix;
mito_3d = (mito_3d-min(mito_3d, [], 'all'))/max(mito_3d, [], 'all');

data_open1_bw = imbinarize(data_open1,'global');
data_proto_bw = imbinarize(mito_3d,'global');


for i = 0:23
    imwrite(data_open1_bw(:,:,i+1), 'contour_se3_3d_bw.tif', 'WriteMode', 'append',  'Compression','none');
end



cc1 = bwconncomp(data_open1_bw, 26);
cc_proto = bwconncomp(data_proto_bw, 26);
s1 = regionprops(cc1, 'centroid');
disp(cc1);
disp(cc_proto);
centroids = cat(1, s1.Centroid);
    
%plot3(range(1600), range(1600), data_bw);

%{
figure();
imshow(data_bw);
hold on
plot(centroids(:,1), centroids(:,2), "b*");
hold off
%}
    

    


