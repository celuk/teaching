`timescale 1ns / 1ps

module fibonacci(
    input saat,
    input reset,
    output [3:0] Q
);

    // 1 sayaci
    wire Jg;
    wire Kg;
    wire Qg;
    wire QNg;

    assign Jg = (QN3 & QN2 & QN1 & Q0);
    assign Kg = Jg;

    jk jkg(
        .saat(saat),
        .reset(reset),
        .J(Jg),
        .K(Kg),
        .Q(Qg),
        .QN(QNg)
    );

    // fibonacci sayaci
    wire J3;
    wire K3;
    wire Q3;
    wire QN3;

    assign J3 = (Q3 & QN2 & QN1 & QN0) | (QN3 & Q2 & QN1 & Q0);
    assign K3 = ~J3;

    jk jk3(
        .saat(saat),
        .reset(reset),
        .J(J3),
        .K(K3),
        .Q(Q3),
        .QN(QN3)
    );

    wire J2;
    wire K2;
    wire Q2;
    wire QN2;

    assign J2 = (Q3 & QN2 & QN1 & QN0) | (QN3 & QN2 & Q1 & Q0);
    assign K2 = ~J2;

    jk jk2(
        .saat(saat),
        .reset(reset),
        .J(J2),
        .K(K2),
        .Q(Q2),
        .QN(QN2)
    );

    wire J1;
    wire K1;
    wire Q1;
    wire QN1;

    assign J1 = (Qg & QN3 & QN2 & QN1 & Q0) | (Q2 & QN0) | (Q3 & QN2 & Q0) | (Q2 & Q1) | (Q1 & QN0);
    assign K1 = ~J1;

    jk jk1(
        .saat(saat),
        .reset(reset),
        .J(J1),
        .K(K1),
        .Q(Q1),
        .QN(QN1)
    );

    wire J0;
    wire K0;
    wire Q0;
    wire QN0;

    assign J0 = (QNg & QN3 & QN2 & QN1 & Q0) | (QN2 & QN1 & QN0) | (QN3 & QN2 & Q1);
    assign K0 = ~J0;

    jk jk0(
        .saat(saat),
        .reset(reset),
        .J(J0),
        .K(K0),
        .Q(Q0),
        .QN(QN0)
    );

    assign Q = {Q3, Q2, Q1, Q0};
endmodule
