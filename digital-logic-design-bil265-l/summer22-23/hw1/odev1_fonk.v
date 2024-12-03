`timescale 1ns / 1ps

// (A'BCD' + BCE')' + (C'D' + ABD)
// AD + AE + B' + C' + DE

module odev1_fonk(
    input A, B, C, D, E,
    output F
    );
    
    wire nA, nC, nD, nE;
    
    not(nA, A);
    not(nC, C);
    not(nD, D);
    not(nE, E);
    
    wire nABCnD;
    and(nABCnD, nA, B, C, nD); // A'BCD'
    
    wire BCnE;
    and(BCnE, B, C, nE); // BCE'
    
    wire or1;
    or(or1, nABCnD, BCnE); // (A'BCD' + BCE')
    wire nor1;
    not(nor1, or1); // (A'BCD' + BCE')'
    
    wire nCnD;
    and(nCnD, nC, nD); // C'D'
    
    wire ABD;
    and(ABD, A, B, D); // ABD
    
    wire or2;
    or(or2, nCnD, ABD);
    
    or(F, nor1, or2);
    
endmodule
