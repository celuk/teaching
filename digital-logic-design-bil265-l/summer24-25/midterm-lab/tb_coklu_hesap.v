`timescale 1ns / 1ps

module tb_coklu_hesap(

    );
    
    reg [3:0] sayi1;
    reg [3:0] sayi2;
    reg [1:0] islem;
    
    wire [1:0] sonuc;
    coklu_hesap coklu_hesap_dut(
        .sayi1(sayi1),
        .sayi2(sayi2),
        .islem(islem),
        .sonuc(sonuc)
    );

    wire [1:0] sonuc_test;
    coklu_hesap_test coklu_hesap_test_dut(
        .sayi1(sayi1),
        .sayi2(sayi2),
        .islem(islem),
        .sonuc(sonuc_test)
    );

    integer i;
    integer j;
    integer k;
    
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        for(i=0; i<16; i=i+1) begin
            sayi1 = i;
            for(j=0; j<16; j=j+1) begin
                sayi2 = j;
                for(k=0; k<4; k=k+1) begin
                    islem = k; #1;

                    // soruda verilmeyen durumlari test etme
                    if(!(islem == 2'b11
                        &&
                        ((sayi1 == 6 && sayi2 == 6)
                        || (sayi1 == 6 && sayi2 == 10)
                        || (sayi1 == 6 && sayi2 == 14)
                        || (sayi1 == 10 && sayi2 == 6)
                        || (sayi1 == 10 && sayi2 == 10)
                        || (sayi1 == 10 && sayi2 == 14)
                        || (sayi1 == 14 && sayi2 == 6)
                        || (sayi1 == 14 && sayi2 == 10)
                        || (sayi1 == 14 && sayi2 == 14)))
                    ) begin
                        if(sonuc == sonuc_test) begin
                            passes = passes + 1;
                        end
                        else begin
                            fails = fails + 1;
                        end
                    end
                end
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 1015) $display("ALL PASSED!\n");
        if(fails  == 1015) $display("all failed!\n");
        
        $finish;
    end
endmodule

module coklu_hesap_test(
    input [3:0] sayi1,
    input [3:0] sayi2,
    input [1:0] islem,
    output reg [1:0] sonuc
    );

    wire sayi1_asal, sayi1_tek, sayi1_kat4, sayi1_tamkare;
    hesap hesap1(
        .sayi(sayi1),
        .asal(sayi1_asal),
        .tek(sayi1_tek),
        .kat4(sayi1_kat4),
        .tamkare(sayi1_tamkare)
    );

    wire sayi2_asal, sayi2_tek, sayi2_kat4, sayi2_tamkare;
    hesap hesap2(
        .sayi(sayi2),
        .asal(sayi2_asal),
        .tek(sayi2_tek),
        .kat4(sayi2_kat4),
        .tamkare(sayi2_tamkare)
    );

    reg [2:0] sayi1_ozellik_sayisi; // max 4
    reg [2:0] sayi2_ozellik_sayisi;

    always @(*) begin
        sonuc = 2'b00;
        
        case (islem)
            2'b00: begin
                sayi1_ozellik_sayisi = sayi1_asal + sayi1_tek + sayi1_kat4 + sayi1_tamkare;
                sayi2_ozellik_sayisi = sayi2_asal + sayi2_tek + sayi2_kat4 + sayi2_tamkare;

                sonuc[1] = (sayi1_ozellik_sayisi > sayi2_ozellik_sayisi);
                sonuc[0] = (sayi2_ozellik_sayisi > sayi1_ozellik_sayisi);

                if(sayi1_ozellik_sayisi == sayi2_ozellik_sayisi) sonuc = 2'b00;
            end
            2'b01: begin
                sonuc[1] = (sayi1_asal & sayi2_asal)
                         | (sayi1_tek & sayi2_tek)
                         | (sayi1_kat4 & sayi2_kat4)
                         | (sayi1_tamkare & sayi2_tamkare);

                sonuc[0] = (sayi1_asal & ~sayi2_asal)
                         | (sayi1_tek & ~sayi2_tek)
                         | (sayi1_kat4 & ~sayi2_kat4)
                         | (sayi1_tamkare & ~sayi2_tamkare);
            end
            2'b10: begin
                if((sayi1_asal && sayi1_tek) || (sayi2_tamkare && sayi2_kat4)) begin
                    sonuc = 2'b11;
                end else begin
                    sonuc = 2'b00;
                end
            end
            2'b11: begin
                if(sayi1_asal || sayi2_asal) begin
                    sonuc = 2'b11;
                end
                else if(sayi1_tamkare || sayi2_tamkare) begin
                    sonuc = 2'b10;
                end
                else if(sayi1_kat4 || sayi2_kat4) begin
                    sonuc = 2'b01;
                end
                else if(sayi1_tek || sayi2_tek) begin
                    sonuc = 2'b00;
                end
                // her iki sayida da hicbir ozelligin olmadigi durum verilmemis, o yuzden de burada atanmiyor ve test edilmiyor
            end
        endcase
    end
endmodule
