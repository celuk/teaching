`timescale 1ns / 1ps

// (AB'CD'E' + B'C' + D) + (A'BD' + BDE)'
// A + B' + D

module odev1_fonk(
    input A, B, C, D, E,
    output F
    );
    
    wire nB;
    not(nB, B);
    
    or(F, A, nB, D);
    
endmodule
