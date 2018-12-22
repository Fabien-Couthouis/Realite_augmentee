function[H] = homographyEstimate(xVect1,yVect1,xIncVect1,yIncVect1)

xInc1=xIncVect1(1);
xInc2=xIncVect1(2);
xInc3=xIncVect1(3);
xInc4=xIncVect1(4);

yInc1=yIncVect1(1);
yInc2=yIncVect1(2);
yInc3=yIncVect1(3);
yInc4=yIncVect1(4);

x1=xVect1(1);
x2=xVect1(2);
x3=xVect1(3);
x4=xVect1(4);

y1=yVect1(1);
y2=yVect1(2);
y3=yVect1(3);
y4=yVect1(4);


A = [xInc1 yInc1 1 0 0 0 -xInc1*x1 -yInc1*x1;
    0 0 0 xInc1 yInc1 1 -xInc1*y1 -yInc1*y1;
    xInc2 yInc2 1 0 0 0 -xInc2*x2 -yInc2*x2;
    0 0 0 xInc2 yInc2 1 -xInc2*y2 -yInc2*y2;
    xInc3 yInc3 1 0 0 0 -xInc3*x3 -yInc3*x3;
    0 0 0 xInc3 yInc3 1 -xInc3*y3 -yInc3*y3;
    xInc4 yInc4 1 0 0 0 -xInc4*x4 -yInc4*x4;
    0 0 0 xInc4 yInc4 1 -xInc4*y4 -yInc4*y4];

B = inv(A);

X = [x1; y1; x2; y2; x3; y3; x4; y4];

H1 = B*X;

H= [H1(1) H1(2) H1(3);
    H1(4) H1(5) H1(6);
    H1(7) H1(8) 1];