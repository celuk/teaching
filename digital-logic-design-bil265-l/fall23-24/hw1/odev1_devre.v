`timescale 1ns / 1ps

module odev1_devre(
    input A, B, C,
    output F, Q
    );
    
    wire nA;
    not(nA, A);
    
    wire bC;
    buf(bC, C);
    
    wire AxnorB;
    xnor(AxnorB, nA, B);
    
    wire bCor0;
    or(bCor0, bC, 1'b0);
    
    wire nAxnorBandbC;
    and(nAxnorBandbC, AxnorB, bC);
    
    nor(Q, nAxnorBandbC, bCor0);
    
    wire nAxnorBandbCxorbCor0;
    xor(nAxnorBandbCxorbCor0, nAxnorBandbC, bCor0);
    
    nand(F, Q, nAxnorBandbCxorbCor0);
    
endmodule
