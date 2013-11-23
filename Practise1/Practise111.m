function Practise111( input_args )
%PRACTISE111 Summary of this function goes here
%   Detailed explanation goes here

images = dir(['./' '*.' 'tif']);
images_names = sort({images.name});
niter = [28,34];
k = [13, 14, 15];
lambda = [ 0.125, 0.2, 0.25];
opcion = [1,2];

snrs = [];
valueIdx = 1;
solIdx = 1;

for img = 1:length(images_names)
    
    im = imread (strcat('./',images_names{img}));
    im = rgb2gray(im);
    im = double(im);
    
    for i = 1:length(niter)
        nitervalue = niter(i);
        for j = 1:length(k)
            kvalue = k(j);
            for l = 1:length(lambda);
                lambdavalue = lambda(l);
                for m = 1:length(opcion);
                    opcionvalue = opcion(m);
                    %figure('Name',  sprintf('Image %d ,nitervalue %d, kvalue %d, lambdavalue %d, opcionvalue %d',img, nitervalue, kvalue, lambdavalue,opcionvalue));
                    imdif = dif_aniso(im, nitervalue, kvalue, lambdavalue, opcionvalue);
                    %imagesc(imdif), colormap(gray),axis image;
                    
                    imdif2 = medfilt2(imdif,[3,3]);
                    imdifsub = abs(imdif2-imdif);

                    ima=max(imdifsub(:));
                    imi=min(imdifsub(:));
                    ims=std(imdifsub(:));
                    snr=20*log10((ima-imi)./ims);
                    
                    snrs = [snrs, snr];
                    values{valueIdx}.imdif = imdif;
                    values{valueIdx}.nitervalue = nitervalue;
                    values{valueIdx}.kvalue = kvalue;
                    values{valueIdx}.lambdavalue = lambdavalue;
                    values{valueIdx}.opcionvalue = opcionvalue;
                    valueIdx = valueIdx+1;
                end;
            end;
            
        end;
    end;
    
    [minSnr, minSnrIdx] = min(snrs);
    
    sol{solIdx}.imdif = values{minSnrIdx}.imdif;
    sol{solIdx}.nitervalue = values{minSnrIdx}.nitervalue;
    sol{solIdx}.kvalue = values{minSnrIdx}.kvalue;
    sol{solIdx}.lambdavalue = values{minSnrIdx}.lambdavalue;
    sol{solIdx}.opcionvalue = values{minSnrIdx}.opcionvalue;
    
    solIdx = solIdx+1;
    sums = [];
    values = [];
    valueIdx = 1;
end;

for s = 1:solIdx-1
    
    figure;
    imagesc(sol{s}.imdif), colormap(gray),axis image;
    
    sol{s}.nitervalue
    sol{s}.kvalue
    sol{s}.lambdavalue
    sol{s}.opcionvalue
end

end

