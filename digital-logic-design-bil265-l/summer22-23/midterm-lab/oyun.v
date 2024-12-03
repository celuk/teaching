`timescale 1ns / 1ps

module oyun(
    input [1:0] X11,
    input [1:0] Y11,
    input [1:0] X12,
    input [1:0] Y12,
    input [1:0] X13,
    input [1:0] Y13,
    input [1:0] X21,
    input [1:0] Y21,
    input [1:0] X22,
    input [1:0] Y22,
    input [1:0] X23,
    input [1:0] Y23,
    output O
    );
    
    wire B1, B2, B3;
    
    tur tur1(
        .X1(X11),
        .Y1(Y11),
        .X2(X21),
        .Y2(Y21),
        .B(B1)
    );
    
    tur tur2(
        .X1(X12),
        .Y1(Y12),
        .X2(X22),
        .Y2(Y22),
        .B(B2)
    );
    
    tur tur3(
        .X1(X13),
        .Y1(Y13),
        .X2(X23),
        .Y2(Y23),
        .B(B3)
    );
    
    wire B1B2;
    wire B2B3;
    wire B1B3;
    
    and(B1B2, B1, B2);
    and(B2B3, B2, B3);
    and(B1B3, B1, B3);
    or(O, B1B2, B2B3, B1B3);
    
endmodule
