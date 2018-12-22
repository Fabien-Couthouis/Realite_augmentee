function [XNext, YNext] = nearestCorner(I,nbPoints, XNow,YNow,XPrev,YPrev)
%Renvoie l'emplacement du pixel à l'étape n+1, connaissant sa position
%aux étapes n (x2,y2)  et n-1 (x1,y1)

    %Demi taille de la fenêtre de recherche 
    windowSize = 18;
    XPred = zeros(1,nbPoints);
    YPred = zeros(1,nbPoints);
    XNext = zeros(1,nbPoints);
    YNext = zeros(1,nbPoints);

    %fenêtre de I étudiée
    for p=1:nbPoints
        %Point prédit
        XPred(p) = floor(XNow(p) + (XNow(p)-XPrev(p))/2);
        YPred(p) = floor(YNow(p) + (YNow(p)-YPrev(p))/2);
        
        studiedWindow = I(YPred(p)-windowSize:YPred(p)+windowSize,XPred(p)-windowSize:XPred(p)+windowSize);
         maxInRadius = max(max(studiedWindow));
        [YNext(p),XNext(p)] = find(studiedWindow == maxInRadius);
        
         %On attend un pixel entiers en sorties
        %On pense à renvoyer les pixels de I et non de la fenêtre de I étudiée
        XNext(p) = floor(XNext(p)+XPred(p)-windowSize);
        YNext(p) = floor(YNext(p)+YPred(p)-windowSize);
    end 
end