function[imBase] = homographyProjection(H,imBase,imIncruste)

imBaseLarg = size(imBase,1);
imBaseHaut = size(imBase,2);
imIncLarg = size(imIncruste,1);
imIncHaut = size(imIncruste,2);

for height = 1:imBaseHaut
    for width = 1:imBaseLarg
        a = [width;height;1];
        b = H\a ;
        pixel_ajout_x = b(1)/b(3); pixel_ajout_x = fix(pixel_ajout_x);
        pixel_ajout_y = b(2)/b(3); pixel_ajout_y = fix(pixel_ajout_y);
        if (pixel_ajout_x < imIncLarg ) && (pixel_ajout_x > 0) && (pixel_ajout_y < imIncHaut ) && (pixel_ajout_y > 0)
            imBase(width,height,1) = imIncruste(pixel_ajout_x,pixel_ajout_y,1);
            imBase(width,height,2) = imIncruste(pixel_ajout_x,pixel_ajout_y,2);
            imBase(width,height,3) = imIncruste(pixel_ajout_x,pixel_ajout_y,3);
        end
    end
end