function[mov]=transformationVideo(video, nbreTrame, imIncruste)
    %Initialisation
    mov = VideoWriter('F_1.avi');
    open(mov);
    [imBase] = read(video,1);
    
    %Positionnement des coins initiaux de la feuille
    figure; imshow(imBase);
    nbPoints = 4;
    [XNow,YNow]=ginput(nbPoints);
    %Initialisation des variables à l'état initial (image 1 de la vidéo)
    XNext=XNow ; YNext=YNow;

    for i = 1:nbreTrame
       % Définition des images
        [imBase] = read(video,i);
        
        % Définition des points des 2 images
        XPrev = XNow;
        YPrev = YNow;
        XNow = XNext;
        YNow = YNext;
        D=detector(imBase);
        [XNext,YNext] = nearestCorner(D,nbPoints,XNow,YNow,XPrev,YPrev);
       
        % On récupère la main
        imHand = PutHand(imBase,imIncruste,YNext,XNext);

        xInc1 = 0;
        yInc1 = 0;
        xInc2 = 0;
        yInc2 = size(imHand,2);
        xInc3 = size(imHand,1);
        yInc3 = 0;
        xInc4 = size(imHand,1);
        yInc4 = size(imHand,2);

        xIncVect = [xInc1,xInc2,xInc3,xInc4];
        yIncVect = [yInc1,yInc2,yInc3,yInc4];
        
        %Matrice d'homographie
        H = homographyEstimate(YNext,XNext,xIncVect,yIncVect); 
        
        imFinale = homographyProjection(H,imBase,imHand); % Incrustation

        writeVideo(mov, imFinale); % On met l'image dans la video finale
    end
    close(mov); %Fermeture du fichier
end





