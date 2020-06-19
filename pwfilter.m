function q = pwfilter(I, p, r, eps)
%Code for
%   "Contrast Aware Guided Image Filtering"
%   The code and the algorithm are for non-comercial use only.

%   - guidance image: I (colored Image/single channel image)
%   - filtering input image: p (colored Image/single channel image)
%   - local window radius: r
%   - regularization parameter: eps

[hei, wid] = size(I);
N = boxfilter(ones(hei, wid), r); % the size of each local patch; N=(2r+1)^2 except for boundary pixels.

mean_I = boxfilter(I, r) ./ N;
mean_p = boxfilter(p, r) ./ N;
mean_Ip = boxfilter(I.*p, r) ./ N;
cov_Ip = mean_Ip - mean_I .* mean_p; % this is the covariance of (I, p) in each local patch.
mean_II = boxfilter(I.*I, r) ./ N;
var_I = mean_II - mean_I .* mean_I;

var = contrast_descriptor1(I);    %eq.11 in paper
var =  boxfilter(var, r); 

a = cov_Ip ./ (var_I + eps./var);  
b = mean_p - a .* mean_I; 

mean_a = boxfilter(a, r) ./ N;  %average of coefficient a
mean_b = boxfilter(b, r) ./ N;  %average of coefficient b

q = mean_a .* I + mean_b; 
end