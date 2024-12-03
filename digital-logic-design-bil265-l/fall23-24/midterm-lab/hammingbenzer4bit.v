`timescale 1ns / 1ps

module hammingbenzer4bit(
    input  [3:0] A,
    input  [3:0] B,
    output [2:0] HB
    );
    
    wire X, Y, Z, T;
    xnor(X, A[3], B[3]);
    xnor(Y, A[2], B[2]);
    xnor(Z, A[1], B[1]);
    xnor(T, A[0], B[0]);
    
    wire nX, nY, nZ, nT;
    not(nX, X);
    not(nY, Y);
    not(nZ, Z);
    not(nT, T);
    
    and(HB[2], X, Y, Z, T);
    
    wire nXZT;
    and(nXZT, nX, Z, T);
    wire nXYT;
    and(nXYT, nX, Y, T);
    wire YZnT;
    and(YZnT, Y, Z, nT);
    wire XnYT;
    and(XnYT, X, nY, T);
    wire XnYZ;
    and(XnYZ, X, nY, Z);
    wire XYnZ;
    and(XYnZ, X, Y, nZ);
    
    or(HB[1], nXZT, nXYT, YZnT, XnYT, XnYZ, XYnZ);
    
    wire nXnYnZT;
    and(nXnYnZT, nX, nY, nZ, T);
    wire nXnYZnT;
    and(nXnYZnT, nX, nY, Z, nT);
    wire nXYnZnT;
    and(nXYnZnT, nX, Y, nZ, nT);
    wire nXYZT;
    and(nXYZT, nX, Y, Z, T);
    wire XnYnZnT;
    and(XnYnZnT, X, nY, nZ, nT);
    wire XnYZT;
    and(XnYZT, X, nY, Z, T);
    wire XYnZT;
    and(XYnZT, X, Y, nZ, T);
    wire XYZnT;
    and(XYZnT, X, Y, Z, nT);
    
    or(HB[0],nXnYnZT, nXnYZnT, nXYnZnT, nXYZT, XnYnZnT, XnYZT, XYnZT, XYZnT);
    
endmodule
