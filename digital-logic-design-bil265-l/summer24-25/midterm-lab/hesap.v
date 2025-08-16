`timescale 1ns / 1ps

module hesap(
    input [3:0] sayi,
    output asal,
    output tek,
    output kat4,
    output tamkare
    );

    // asal = S2.S1'.S0 + S3'.S1.S0 + S3'.S2'.S1 + S2'.S1.S0
    wire notS3, notS2, notS1, notS0;
    not(notS3, sayi[3]);
    not(notS2, sayi[2]);
    not(notS1, sayi[1]);
    not(notS0, sayi[0]);

    wire wa1, wa2, wa3, wa4;
    and(wa1, sayi[2], notS1, sayi[0]);
    and(wa2, notS3, sayi[1], sayi[0]);
    and(wa3, notS3, notS2, sayi[1]);
    and(wa4, notS2, sayi[1], sayi[0]);
    or(asal, wa1, wa2, wa3, wa4);

    // eger son biti 1 ise tek sayidir
    buf(tek, sayi[0]);

    // eger son iki biti 0 ise 4'un tam katidir
    nor(kat4, sayi[1], sayi[0]);

    // tamkare = S3'.S2.S1'.S0' + S2'.S1'.S0
    wire wt1, wt2;
    and(wt1, notS3, sayi[2], notS1, notS0);
    and(wt2, notS2, notS1, sayi[0]);
    or(tamkare, wt1, wt2);
endmodule
