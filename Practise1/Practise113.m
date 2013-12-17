function [ output_args ] = Practise113( input_args )
%PRACTISE113 Summary of this function goes here
%   Detailed explanation goes here
folder = './Hierro/';

images = dir([folder '*.' 'dcm']);
images_names = sort({images.name});
images_names(ismember(images_names,{'.','..'})) = [];
%reading each image
for imgIndex = 1:length(images_names)
    imgName = images_names{imgIndex};
    img = dicomread(strcat(folder,imgName));
    figure;
    imagesc(img);
end;
end

