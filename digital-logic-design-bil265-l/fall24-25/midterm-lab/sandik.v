`timescale 1ns / 1ps

module sandik(
    input [1:0] T,
    input [1:0] H,
    output S
);

wire notH1;
wire notH0;
not (notH1, H[1]);
not (notH0, H[0]);

wire notH1notH0;
and(notH1notH0, notH1, notH0);

wire T0notH1;
and(T0notH1, T[0], notH1);

wire T0notH0;
and(T0notH0, T[0], notH0);

wire T1notH1;
and(T1notH1, T[1], notH1);

wire T1notH0;
and(T1notH0, T[1], notH0);

wire T1T0;
and(T1T0, T[1], T[0]);

or(S, notH1notH0, T0notH1, T0notH0, T1notH1, T1notH0, T1T0);

endmodule
