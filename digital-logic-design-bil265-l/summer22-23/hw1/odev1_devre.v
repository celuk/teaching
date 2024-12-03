`timescale 1ns / 1ps

module odev1_devre(
    input A, B, C,
    output F, Q
    );
    
    wire bA;
    buf(bA, A);
    
    wire nC;
    not(nC, C);
    
    wire AnorB;
    nor(AnorB, bA, B);
    
    wire nCand0;
    and(nCand0, nC, 1'b0);
    
    wire AnorBnandnC;
    nand(AnorBnandnC, AnorB, nC);
    
    xor(F, AnorBnandnC, nCand0);
    
    wire AnorBnandnCxnornCand0;
    xnor(AnorBnandnCxnornCand0, AnorBnandnC, nCand0);
    
    or(Q, F, AnorBnandnCxnornCand0);
    
endmodule
