`timescale 1ns / 1ps

module tb_at_yarisi(

    );
    
    reg  [1:0] beyaz_at_hiz;
    reg  [1:0] siyah_at_hiz;
    reg  [1:0] boz_at_hiz;
    reg  [1:0] beyaz_jokey_komut;
    reg  [1:0] siyah_jokey_komut;
    reg  [1:0] boz_jokey_komut;
    wire [1:0] kazanan_at;
    
    at_yarisi at_yarisi_dut(
        .beyaz_at_hiz(beyaz_at_hiz),
        .siyah_at_hiz(siyah_at_hiz),
        .boz_at_hiz(boz_at_hiz),
        .beyaz_jokey_komut(beyaz_jokey_komut),
        .siyah_jokey_komut(siyah_jokey_komut),
        .boz_jokey_komut(boz_jokey_komut),
        .kazanan_at(kazanan_at)
    );
    
    wire [1:0] kazanan_at_test;
    at_yarisi_test at_yarisi_test_dut(
        .beyaz_at_hiz(beyaz_at_hiz),
        .siyah_at_hiz(siyah_at_hiz),
        .boz_at_hiz(boz_at_hiz),
        .beyaz_jokey_komut(beyaz_jokey_komut),
        .siyah_jokey_komut(siyah_jokey_komut),
        .boz_jokey_komut(boz_jokey_komut),
        .kazanan_at(kazanan_at_test)
    );
    
    integer i;
    integer j;
    integer k;
    integer l;
    integer m;
    integer n;
    
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        for(i=0; i<4; i=i+1) begin
            beyaz_at_hiz = i;
            for(j=0; j<4; j=j+1) begin
                siyah_at_hiz = j;
                for(k=0; k<4; k=k+1) begin
                    boz_at_hiz = k;
                    for(l=0; l<3; l=l+1) begin
                        beyaz_jokey_komut = l;
                        for(m=0; m<3; m=m+1) begin
                            siyah_jokey_komut = m;
                            for(n=0; n<3; n=n+1) begin
                                boz_jokey_komut = n; #1;
                                
                                if(kazanan_at == kazanan_at_test) begin
                                    passes = passes + 1;
                                end
                                else begin
                                    fails = fails + 1;
                                end
                            end
                        end
                    end
                end
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 1728) $display("ALL PASSED!\n");
        if(fails  == 1728) $display("all failed!\n");
        
        $finish;
    end
    
endmodule

module at_yarisi_test(
    input  [1:0] beyaz_at_hiz,
    input  [1:0] siyah_at_hiz,
    input  [1:0] boz_at_hiz,
    input  [1:0] beyaz_jokey_komut,
    input  [1:0] siyah_jokey_komut,
    input  [1:0] boz_jokey_komut,
    output [1:0] kazanan_at
    );
    
    wire [1:0] beyaz_at_son_hiz;
    
    // h0.k0 + h1.k0 + h1.k1 + h1.h0
    wire bh0andbk0;
    and(bh0andbk0, beyaz_at_hiz[0], beyaz_jokey_komut[0]);
    wire bh1andbk0;
    and(bh1andbk0, beyaz_at_hiz[1], beyaz_jokey_komut[0]);
    wire bh1andbk1;
    and(bh1andbk1, beyaz_at_hiz[1], beyaz_jokey_komut[1]);
    wire bh1andbh0;
    and(bh1andbh0, beyaz_at_hiz[1], beyaz_at_hiz[0]);
    or(beyaz_at_son_hiz[1], bh0andbk0, bh1andbk0, bh1andbk1, bh1andbh0);
    
    // h0'.k0 + h0.k1 + h1.k0 + h1.h0'.k1'
    wire nbh1, nbh0, nbk1, nbk0;
    not(nbh1, beyaz_at_hiz[1]);
    not(nbh0, beyaz_at_hiz[0]);
    not(nbk1, beyaz_jokey_komut[1]);
    
    wire nbh0andnbk0;
    and(nbh0andnbk0, nbh0, beyaz_jokey_komut[0]);
    wire bh0andbk1;
    and(bh0andbk1, beyaz_at_hiz[0], beyaz_jokey_komut[1]);
    wire bh1andnbh0andnbk1;
    and(bh1andnbh0andnbk1, beyaz_at_hiz[1], nbh0, nbk1);
    or(beyaz_at_son_hiz[0], nbh0andnbk0, bh0andbk1, bh1andbk0, bh1andnbh0andnbk1);
    
    
    wire [1:0] siyah_at_son_hiz;
    
    // h0.k0 + h1.k0 + h1.k1 + h1.h0
    wire sh0andsk0;
    and(sh0andsk0, siyah_at_hiz[0], siyah_jokey_komut[0]);
    wire sh1andsk0;
    and(sh1andsk0, siyah_at_hiz[1], siyah_jokey_komut[0]);
    wire sh1andsk1;
    and(sh1andsk1, siyah_at_hiz[1], siyah_jokey_komut[1]);
    wire sh1andsh0;
    and(sh1andsh0, siyah_at_hiz[1], siyah_at_hiz[0]);
    or(siyah_at_son_hiz[1], sh0andsk0, sh1andsk0, sh1andsk1, sh1andsh0);
    
    // h0'.k0 + h0.k1 + h1.k0 + h1.h0'.k1'
    wire nsh1, nsh0, nsk1, nsk0;
    not(nsh1, siyah_at_hiz[1]);
    not(nsh0, siyah_at_hiz[0]);
    not(nsk1, siyah_jokey_komut[1]);
    
    wire nsh0andnsk0;
    and(nsh0andnsk0, nsh0, siyah_jokey_komut[0]);
    wire sh0andsk1;
    and(sh0andsk1, siyah_at_hiz[0], siyah_jokey_komut[1]);
    wire sh1andnsh0andnsk1;
    and(sh1andnsh0andnsk1, siyah_at_hiz[1], nsh0, nsk1);
    or(siyah_at_son_hiz[0], nsh0andnsk0, sh0andsk1, sh1andsk0, sh1andnsh0andnsk1);
    
    
    wire [1:0] boz_at_son_hiz;
    
    // h0.k0 + h1.k0 + h1.k1 + h1.h0
    wire bzh0andbzk0;
    and(bzh0andbzk0, boz_at_hiz[0], boz_jokey_komut[0]);
    wire bzh1andbzk0;
    and(bzh1andbzk0, boz_at_hiz[1], boz_jokey_komut[0]);
    wire bzh1andbzk1;
    and(bzh1andbzk1, boz_at_hiz[1], boz_jokey_komut[1]);
    wire bzh1andbzh0;
    and(bzh1andbzh0, boz_at_hiz[1], boz_at_hiz[0]);
    or(boz_at_son_hiz[1], bzh0andbzk0, bzh1andbzk0, bzh1andbzk1, bzh1andbzh0);
    
    // h0'.k0 + h0.k1 + h1.k0 + h1.h0'.k1'
    wire nbzh1, nbzh0, nbzk1, nbzk0;
    not(nbzh1, boz_at_hiz[1]);
    not(nbzh0, boz_at_hiz[0]);
    not(nbzk1, boz_jokey_komut[1]);
    
    wire nbzh0andnbzk0;
    and(nbzh0andnbzk0, nbzh0, boz_jokey_komut[0]);
    wire bzh0andbzk1;
    and(bzh0andbzk1, boz_at_hiz[0], boz_jokey_komut[1]);
    wire bzh1andnbzh0andnbzk1;
    and(bzh1andnbzh0andnbzk1, boz_at_hiz[1], nbzh0, nbzk1);
    or(boz_at_son_hiz[0], nbzh0andnbzk0, bzh0andbzk1, bzh1andbzk0, bzh1andnbzh0andnbzk1);
    
    
    wire A, B, C, D, E, F;
    buf(A, beyaz_at_son_hiz[1]);
    buf(B, beyaz_at_son_hiz[0]);
    buf(C, siyah_at_son_hiz[1]);
    buf(D, siyah_at_son_hiz[0]);
    buf(E, boz_at_son_hiz[1]);
    buf(F, boz_at_son_hiz[0]);
    
    wire nA, nB, nC, nD, nE, nF;
    not(nA, A);
    not(nB, B);
    not(nC, C);
    not(nD, D);
    not(nE, E);
    not(nF, F);
    
    // K1 = A'C'E + B'C'EF + A'D'EF + B'D'EF + A'B'C'D'F
    wire w11, w12, w13, w14, w15;
    and(w11, nA, nC, E);
    and(w12, nB, nC, E, F);
    and(w13, nA, nD, E, F);
    and(w14, nB, nD, E, F);
    and(w15, nA, nB, nC, nD, F);
    or(kazanan_at[1], w11, w12, w13, w14, w15);
    
    // K0 = A'CE' + A'CF' + A'CD + B'CD + A'B'DE'
    wire w21, w22, w23, w24, w25;
    and(w21, nA, C, nE);
    and(w22, nA, C, nF);
    and(w23, nA, C, D);
    and(w24, nB, C, D);
    and(w25, nA, nB, D, nE);
    or(kazanan_at[0], w21, w22, w23, w24, w25);
    
endmodule
