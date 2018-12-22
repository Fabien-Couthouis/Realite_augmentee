%Detecteur de coins utilisant un double détecteur de Harris
    function [D] = detector(I)
    I = double (I);
    I = (I(:,:,1)+I(:,:,2)+I(:,:,3))/3;
    
    sigmad=2;
    sigmag1 = 3;
    sigmag2 = 5;
   
    [Ix,Iy] = gradient(I,sigmad); 
    H1 = harris(Ix,Iy,sigmag1);
    H2 = harris(Ix,Iy,sigmag2);

    D = H1.* abs(H2);  
 end

