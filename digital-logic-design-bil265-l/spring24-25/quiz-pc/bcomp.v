`timescale 1ns / 1ps

module bcomp(
    input A,
    input B,
    input C,
    output F
);

    wire notA;
    wire notB;
    wire notC;
    not(notA, A);
    not(notB, B);
    not(notC, C);

    wire notAC;
    wire BnotC;
    wire AnotB;
    and(notAC, notA, C);
    and(BnotC, B, notC);
    and(AnotB, A, notB);

    or(F, notAC, BnotC, AnotB);

endmodule
