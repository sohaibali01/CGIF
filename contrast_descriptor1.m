
function [retval] = contrast_descriptor1(I)

% imshow(mat2gray(I));
padSize=60;
I=padarray(I,[padSize padSize],'replicate');
% [nrows ncols]=size(I);

I=mat2gray(I-mean(I(:)));


%% atrous based
K1=(1/4).*[1 2 1]';       %% 1D linear atrous vector
K1=conv(K1,K1);
nplanes=2;

LP=I;

for j=1:nplanes

    %%% Get 2D response %%%% 
        Kernel=K1*K1';      %%% contruct 2D filter from 1D linear filter
        LP(:,:,j+1)=imfilter(LP(:,:,j),Kernel);
        wave_plane=(LP(:,:,j)-LP(:,:,j+1))./(LP(:,:,j+1)+0.03);
        K1=upsample(K1,2);      %%% upsample the 1D linear filter
        K1=K1(1:length(K1)-1,:);  %%% remove last element (zero) of filter to make number of elements odd

        LOG_scaled4(:,:,j) = wave_plane;
end

retval=mat2gray(sum(LOG_scaled4,3));
retval=retval(padSize+1:end-padSize,padSize+1:end-padSize);
