`timescale 1ns / 1ps

module sube1(
    input A,
    input B,
    input C,
    output [1:0] F
    );
    
    wire AorB;
    or(AorB, A, B);

    wire AxorC;
    xor(AxorC, A, C);

    wire BandC;
    and(BandC, B, C);

    or(F[1], AorB, BandC);
    and(F[0], AxorC, BandC);
endmodule
