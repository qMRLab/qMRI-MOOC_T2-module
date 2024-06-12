% Define the model 
Model = mono_t2;

% Load data into environment, and rotate mask to be aligned with IR data
data = struct;
data.SEdata = double(load_nii_data('example_data/mono_t2_demo/mono_t2_data/SEdata.nii.gz'));
data.Mask = double(load_nii_data('example_data/mono_t2_demo/mono_t2_data/Mask.nii.gz'));

% Define fitting parameters
EchoTime  = [12.8000; 25.6000; 38.4000; 51.2000; 64.0000; 76.8000; 89.6000; 102.4000; 115.2000; 128.0000; 140.8000; 153.6000; 166.4000; 179.2000; 192.0000; 204.8000; 217.6000; 230.4000; 243.2000; 256.0000; 268.8000; 281.6000; 294.4000; 307.2000; 320.0000; 332.8000; 345.6000; 358.4000; 371.2000; 384.0000];
Model.Prot.SEdata.Mat = [ EchoTime ];
%FitResults = FitData(data,Model,0); % The '0' flag is so that no wait bar is shown.

% T2w MRI data at different TE values
TE_1 = imrotate(squeeze(data.SEdata(:,:,:,1).*data.Mask),-90);
TE_2 = imrotate(squeeze(data.SEdata(:,:,:,10).*data.Mask),-90);
TE_3 = imrotate(squeeze(data.SEdata(:,:,:,20).*data.Mask),-90);
TE_4 = imrotate(squeeze(data.SEdata(:,:,:,30).*data.Mask),-90);

% Extract the T2 map from FitResults and rotate it
T2_map = imrotate(squeeze(FitResults.T2.*data.Mask), -90);

% Plotting the images
figure;

subplot(2, 3, 1);
imagesc(TE_1);
colormap(gray);
colorbar;
axis image;
title('TE = 12.80 ms');
xlabel('X-axis');
ylabel('Y-axis');
caxis([0, 2500]);

subplot(2, 3, 2);
imagesc(TE_2);
colormap(gray);
colorbar;
axis image;
title('TE = 128.00 ms');
xlabel('X-axis');
ylabel('Y-axis');
caxis([0, 2500]);

subplot(2, 3, 3);
imagesc(TE_3);
colormap(gray);
colorbar;
axis image;
title('TE = 256.00 ms');
xlabel('X-axis');
ylabel('Y-axis');
caxis([0, 2500]);

subplot(2, 3, 4);
imagesc(TE_4);
T2_map = imrotate(squeeze(FitResults.T2.*data.Mask),-90);
xAxis = [0:size(T2_map,2)-1];
yAxis = [0:size(T2_map,1)-1];
colormap(gray);
colorbar;
axis image;
title('TE = 384.00 ms');
xlabel('X-axis');
ylabel('Y-axis');
caxis([0, 2500]);

subplot(2, 3, 5);
imagesc(T2_map);
colormap(gray); 
colorbar;
axis image;
title('T2 map');
xlabel('X-axis');
ylabel('Y-axis');
caxis([80, 150]);
