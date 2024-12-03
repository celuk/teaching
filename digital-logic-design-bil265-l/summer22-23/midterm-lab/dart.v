`timescale 1ns / 1ps

module dart(
    input  [1:0] X,
    input  [1:0] Y,
    output [1:0] P
    );
    
    wire nX0, nY0;
    not(nX0, X[0]);
    not(nY0, Y[0]);
    
    wire X1nX0Y0;
    and(X1nX0Y0, X[1], nX0, Y[0]);
    
    wire X0Y1nY0;
    and(X0Y1nY0, X[0], Y[1], nY0);
    
    wire X1Y1nY0;
    and(X1Y1nY0, X[1], Y[1], nY0);
    
    or(P[1], X1nX0Y0, X0Y1nY0, X1Y1nY0);
    
    wire X0Y0;
    and(X0Y0, X[0], Y[0]);
    
    wire X1nX0Y1nY0;
    and(X1nX0Y1nY0, X[1], nX0, Y[1], nY0);
    
    or(P[0], X0Y0, X1nX0Y1nY0);
    
endmodule
