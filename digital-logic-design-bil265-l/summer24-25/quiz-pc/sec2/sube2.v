`timescale 1ns / 1ps

module sube2(
    input A,
    input B,
    input C,
    output [1:0] F
    );
    
    wire AandB;
    and(AandB, A, B);

    wire AorC;
    or(AorC, A, C);

    wire BxorC;
    xor(BxorC, B, C);

    and(F[1], AandB, BxorC);
    and(F[0], AorC, BxorC);
endmodule
