`timescale 1ns / 1ps

module toplayici4bit(
    input  [3:0] A,
    input  [3:0] B,
    input  Cin,
    output [3:0] S,
    output Cout
    );
    
    wire Carry1, Carry2, Carry3;
    tamtoplayici tt0(.A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(Carry1));
    tamtoplayici tt1(.A(A[1]), .B(B[1]), .Cin(Carry1), .S(S[1]), .Cout(Carry2));
    tamtoplayici tt2(.A(A[2]), .B(B[2]), .Cin(Carry2), .S(S[2]), .Cout(Carry3));
    tamtoplayici tt3(.A(A[3]), .B(B[3]), .Cin(Carry3), .S(S[3]), .Cout(Cout));
endmodule
