`timescale 1ns / 1ps

module tamtoplayici(
    input A,
    input B,
    input Cin,
    output S,
    output Cout
    );
    
    wire AxorB;
    xor(AxorB, A, B);
    xor(S, AxorB, Cin);
    
    wire AxorBandCin;
    and(AxorBandCin, AxorB, Cin);
    wire AandB;
    and(AandB, A, B);
    or(Cout, AxorBandCin, AandB);
    
endmodule
