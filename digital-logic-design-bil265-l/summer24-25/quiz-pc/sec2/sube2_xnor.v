`timescale 1ns / 1ps

module sube2_xnor(
    input X,
    input Y,
    output Z
    );
    
    wire [1:0] F;
    // F[0] = X ^ Y
    sube2 sube2_inst (
        .A(1'b1),
        .B(X),
        .C(Y),
        .F(F)
    );
    
    // Z = ~(X ^ Y)
    not(Z, F[0]);
endmodule

