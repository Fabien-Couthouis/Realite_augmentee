function[imFinale] = PutHand(ImVid,ImInc,xVect,yVect)

CarreBlanc = zeros(1000, 1000, 'double');

% Définition des images
[imBase] = ImVid;
[Carre] = CarreBlanc;


% Définition des points des 2 images

x1 = 0;
y1 = 0;
x2 = 0;
y2 = size(Carre,2);
x3 = size(Carre,1);
y3 = 0;
x4 = size(Carre,1);
y4 = size(Carre,2);

xCarreVect = [x1,x2,x3,x4];
yCarreVect = [y1,y2,y3,y4];


xInc1 = 0;
yInc1 = 0;
xInc2 = 0;
yInc2 = size(ImInc,2);
xInc3 = size(ImInc,1);
yInc3 = 0;
xInc4 = size(ImInc,1);
yInc4 = size(ImInc,2);

xIncVect = [xInc1,xInc2,xInc3,xInc4];
yIncVect = [yInc1,yInc2,yInc3,yInc4];


% Calcul de la matrice d'homographie
H = homographyEstimate(xCarreVect,yCarreVect,xVect,yVect);
HInc = homographyEstimate(xCarreVect,yCarreVect,xIncVect,yIncVect);


% Incruste
imFinale = homographyProjection(H,Carre,imBase);
imIncHomo = homographyProjection(HInc,Carre,ImInc);


% Définition du masque (avec for (en commenté) et sans for)


% for height = 720:1000;
%     for width = 320:770;
%         if (imFinale(height,width,2)<105 || (imFinale(height,width,1)>118 && imFinale(height,width,2)<125 && imFinale(height,width,3)<140) || (imFinale(height,width,1)>110 && imFinale(height,width,2)<120))
%             CarreBlanc(height,width,1)=1;
%             CarreBlanc(height,width,2)=1;
%             CarreBlanc(height,width,3)=1;
%         end
%     end
% end


imFinaleRed = imFinale(720:1000,320:770,:);
CarreBlancRed1 = imFinaleRed(:,:,2)<105;
CarreBlancRed2 = (imFinaleRed(:,:,1)>118).*(imFinaleRed(:,:,2)<125).*(imFinaleRed(:,:,3)<140);
CarreBlancRed3 = (imFinaleRed(:,:,1)>110).*(imFinaleRed(:,:,2)<120);

CarreBlanc(720:1000,320:770) = (CarreBlancRed1 + CarreBlancRed2 + CarreBlancRed3)>0;


% Superposition du masque

imFinale(:,:,1) = imFinale(:,:,1).*CarreBlanc;
imFinale(:,:,2) = imFinale(:,:,2).*CarreBlanc;
imFinale(:,:,3) = imFinale(:,:,3).*CarreBlanc;
Main = imFinale;


% On met la main avec le fond à incruster (avec for (en commenté) et sans for)


% for height = 1:1000;
%     for width = 1:1000;
%         if (imFinale(height,width,1)==0)
%             imFinale(height,width,1)=imToPutHomo(height,width,1);
%             imFinale(height,width,2)=imToPutHomo(height,width,2);
%             imFinale(height,width,3)=imToPutHomo(height,width,3);
%         end
%     end
% end

trouImFinale = imFinale(:,:,1)==0;

imFinale(:,:,1)= Main(:,:,1)+trouImFinale.*(imIncHomo(:,:,1));
imFinale(:,:,2)= Main(:,:,2)+trouImFinale.*(imIncHomo(:,:,2));
imFinale(:,:,3)= Main(:,:,3)+trouImFinale.*(imIncHomo(:,:,3));


