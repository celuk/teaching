`timescale 1ns / 1ps

module sube1_xor(
    input X,
    input Y,
    output Z
    );
    
    wire [1:0] F1;
    // F1[0] = ~X & Y
    sube1 sube1_inst1 (
        .A(X),
        .B(Y),
        .C(1'b1),
        .F(F1)
    );
    
    wire [1:0] F2;
    // F2[0] = X & ~Y
    sube1 sube1_inst2 (
        .A(Y),
        .B(X),
        .C(1'b1),
        .F(F2)
    );
    
    // Z = (~X & Y) | (X & ~Y)
    or(Z, F1[0], F2[0]);
endmodule
