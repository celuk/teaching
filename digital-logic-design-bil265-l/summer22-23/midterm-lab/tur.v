`timescale 1ns / 1ps

module tur(
    input [1:0] X1,
    input [1:0] Y1,
    input [1:0] X2,
    input [1:0] Y2,
    output B
    );
    
    wire [1:0] P1;
    wire [1:0] P2;
    
    dart dart1(
        .X(X1),
        .Y(Y1),
        .P(P1)
    );
    
    dart dart2(
        .X(X2),
        .Y(Y2),
        .P(P2)
    );
    
    wire P11P21P20;
    and(P11P21P20, P1[1], P2[1], P2[0]);
    
    wire P11P10P21;
    and(P11P10P21, P1[1], P1[0], P2[1]);
    
    or(B, P11P21P20, P11P10P21);
    
endmodule
