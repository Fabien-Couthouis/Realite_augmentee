CarreBlanc = zeros(100, 100, 3, 'uint8');
v = VideoReader('video.mp4');

% Définition des images
[imIncruste] = read(v,120);
[imBase] = CarreBlanc;


% Affichage de l'image non modifiée
figure(1)
colormap(map)
subplot(121)
image(imBase)
axis image
title('Image initiale')
hold on


% Définition des points des 2 images

x1 = 0;
y1 = 0;
x2 = 0;
y2 = size(imBase,2);
x3 = size(imBase,1);
y3 = 0;
x4 = size(imBase,1);
y4 = size(imBase,2);

xVect = [x1,x2,x3,x4];
yVect = [y1,y2,y3,y4];

xInc1 = 261;
yInc1 = 844;
xInc2 = 600;
yInc2 = 654;
xInc3 = 216;
yInc3 = 1471;
xInc4 = 595;
yInc4 = 1388;

xIncVect = [xInc1,xInc2,xInc3,xInc4];
yIncVect = [yInc1,yInc2,yInc3,yInc4];


% Calcul de la matrice d'homographie
H = homographyEstimate(xVect,yVect,xIncVect,yIncVect);


% Incruste
imFinale = homographyProjection(H,imBase,imIncruste);


% Recherche valeur seuil G,B

fondG = imFinale(80,30,2);
fondB = imFinale(80,30,3);
doigtG = imFinale(96,50,2);
doigtB = imFinale(96,50,3);


% Définition du masque
for height = 72:100;
    for width = 23:68;
%         CarreBlanc(height,width,1)=1;
        if (imFinale(height,width,2)<100)
            CarreBlanc(height,width,2)=1;
        end
        if (imFinale(height,width,3)<100)
            CarreBlanc(height,width,3)=1;
        end
        if (CarreBlanc(height,width,3)~=0)
            CarreBlanc(height,width,1)=1;
        end
    end
end

% Superposition du masque

imFinale = imFinale.*CarreBlanc;


% On remet la main dans la bonne forme

% Calcul de la matrice d'homographie
H2 = homographyEstimate(xIncVect,yIncVect,xVect,yVect);

% Incruste
imFinale = homographyProjection(H2,imIncruste,imFinale);


% Affichage image finale
subplot(122)
image(imFinale)
axis image
title('Image transformée')
