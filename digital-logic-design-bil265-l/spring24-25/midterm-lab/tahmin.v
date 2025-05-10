`timescale 1ns / 1ps

module tahmin(
    input [1:0] sag_adim,
    input [1:0] asagi_adim,
    input [3:0] sayi,
    output [3:0] sayi_tahmin,
    output tahmin_dogru
    );
    
    wire nots1;
    wire nots0;
    wire nota1;
    wire nota0;
    not(nots1, sag_adim[1]);
    not(nots0, sag_adim[0]);
    not(nota1, asagi_adim[1]);
    not(nota0, asagi_adim[0]);

    // ST3 = S0A1 + S1A1
    wire s0a1;
    wire s1a1;
    and(s0a1, sag_adim[0], asagi_adim[1]);
    and(s1a1, sag_adim[1], asagi_adim[1]);
    or(sayi_tahmin[3], s0a1, s1a1);

    // ST2 = A1'A0 + S1'S0'A1
    wire nota1a0;
    wire nots1nots0a1;
    and(nota1a0, nota1, asagi_adim[0]);
    and(nots1nots0a1, nots1, nots0, asagi_adim[1]);
    or(sayi_tahmin[2], nota1a0, nots1nots0a1);

    // ST1 = S1A1' + S1'S0'A1 + S0A1'A0'
    wire s1nota1;
    //wire nots1nots0a1; // yukarida yapilmisi var
    wire s0nota1nota0;
    and(s1nota1, sag_adim[1], nota1);
    and(s0nota1nota0, sag_adim[0], nota1, nota0);
    or(sayi_tahmin[1], s1nota1, nots1nots0a1, s0nota1nota0);

    // ST0 = S0'A0' + S0'A1 + S1A0' + S1A1 + S1'S0A1'A0
    wire nots0nota0;
    wire nots0a1;
    wire s1nota0;
    // wire s1a1; // yukarida yapilmisi var
    wire nots1s0nota1a0;
    and(nots0nota0, nots0, nota0);
    and(nots0a1, nots0, asagi_adim[1]);
    and(s1nota0, sag_adim[1], nota0);
    and(nots1s0nota1a0, nots1, sag_adim[0], nota1, asagi_adim[0]);
    or(sayi_tahmin[0], nots0nota0, nots0a1, s1nota0, s1a1, nots1s0nota1a0);

    wire [3:0] karsilastirma;
    xnor(karsilastirma[3], sayi[3], sayi_tahmin[3]);
    xnor(karsilastirma[2], sayi[2], sayi_tahmin[2]);
    xnor(karsilastirma[1], sayi[1], sayi_tahmin[1]);
    xnor(karsilastirma[0], sayi[0], sayi_tahmin[0]);
    and(tahmin_dogru, karsilastirma[3], karsilastirma[2], karsilastirma[1], karsilastirma[0]);
endmodule
