function [G] = gaussian(sigmag)
    filterSize = ceil(3*sigmag);
   [X,Y]=meshgrid(-filterSize:filterSize);
   G = exp(-(X.^2+Y.^2)/(2*sigmag^2))/(2*pi*sigmag^2);
end