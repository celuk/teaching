`timescale 1ns / 1ps

module tb_sayac_boru(

    );

    reg saat;
    reg reset;
    reg [7:0] baslangic_degeri;
    reg yon;
    reg [2:0] miktar;
    wire [7:0] sayac1_sonuc;
    wire [7:0] sayac2_sonuc;
    wire bitti;
    sayac_boru sayac_boru_dut (
        .saat(saat),
        .reset(reset),
        .baslangic_degeri(baslangic_degeri),
        .yon(yon),
        .miktar(miktar),
        .sayac1_sonuc(sayac1_sonuc),
        .sayac2_sonuc(sayac2_sonuc),
        .bitti(bitti)
    );

    wire [7:0] sayac1_sonuc_test;
    wire [7:0] sayac2_sonuc_test;
    wire bitti_test;
    sayac_boru_test sayac_boru_test_dut (
        .saat(saat),
        .reset(reset),
        .baslangic_degeri(baslangic_degeri),
        .yon(yon),
        .miktar(miktar),
        .sayac1_sonuc(sayac1_sonuc_test),
        .sayac2_sonuc(sayac2_sonuc_test),
        .bitti(bitti_test)
    );

    always begin
        #0.5 saat = ~saat;
    end

    integer corrects = 0;
    integer total_corrects = 0;

    integer passes = 0;
    integer fails = 0;

    initial begin
        saat = 0;
        reset = 1;
        #1;
        reset = 0;

        corrects = 0;
        baslangic_degeri = 0;
        yon = 1;
        miktar = 3;
        #255;
        baslangic_degeri = 250;
        yon = 0;
        miktar = 7;

        #1;

        while(!bitti) begin
            if(sayac1_sonuc == sayac1_sonuc_test && sayac2_sonuc == sayac2_sonuc_test) begin
                corrects = corrects + 1;
            end
            #1;
        end
        if(sayac1_sonuc == 136 && sayac2_sonuc == 252 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, sayac1_sonuc: %d, sayac2_sonuc: %d, bitti: %d, corrects: %d", sayac1_sonuc, sayac2_sonuc, bitti, corrects);
            fails = fails + 1;
        end
        total_corrects = total_corrects + corrects;

        #1;

        while(!bitti) begin
            if(sayac1_sonuc == sayac1_sonuc_test && sayac2_sonuc == sayac2_sonuc_test) begin
                corrects = corrects + 1;
            end
            #1;
        end
        if(sayac1_sonuc == 129 && sayac2_sonuc == 250 && bitti == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, sayac1_sonuc: %d, sayac2_sonuc: %d, bitti: %d, corrects: %d", sayac1_sonuc, sayac2_sonuc, bitti, corrects);
            fails = fails + 1;
        end
        total_corrects = total_corrects + corrects;

        reset = 1;
        #1;
        reset = 0;

        corrects = 0;
        baslangic_degeri = 200;
        yon = 0;
        miktar = 5;
        #99;
        baslangic_degeri = 101;
        yon = 1;
        miktar = 1;

        #1;

        while(!bitti) begin
            if(sayac1_sonuc == sayac1_sonuc_test && sayac2_sonuc == sayac2_sonuc_test) begin
                corrects = corrects + 1;
            end
            #1;
        end
        if(sayac1_sonuc == 201 && sayac2_sonuc == 254 && bitti == 1) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, sayac1_sonuc: %d, sayac2_sonuc: %d, bitti: %d, corrects: %d", sayac1_sonuc, sayac2_sonuc, bitti, corrects);
            fails = fails + 1;
        end
        total_corrects = total_corrects + corrects;

        #1;

        while(!bitti) begin
            if(sayac1_sonuc == sayac1_sonuc_test && sayac2_sonuc == sayac2_sonuc_test) begin
                corrects = corrects + 1;
            end
            #1;
        end
        if(sayac1_sonuc == 141 && sayac2_sonuc == 0 && bitti == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, sayac1_sonuc: %d, sayac2_sonuc: %d, bitti: %d, corrects: %d", sayac1_sonuc, sayac2_sonuc, bitti, corrects);
            fails = fails + 1;
        end
        total_corrects = total_corrects + corrects;

        reset = 1;
        #1;
        reset = 0;

        corrects = 0;
        baslangic_degeri = 200;
        yon = 0;
        miktar = 5;
        #99;
        baslangic_degeri = 101;
        yon = 1;
        miktar = 0;

        #1;

        while(!bitti) begin
            if(sayac1_sonuc == sayac1_sonuc_test && sayac2_sonuc == sayac2_sonuc_test) begin
                corrects = corrects + 1;
            end
            #1;
        end
        if(sayac1_sonuc == 101 && sayac2_sonuc == 0 && bitti == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, sayac1_sonuc: %d, sayac2_sonuc: %d, bitti: %d, corrects: %d", sayac1_sonuc, sayac2_sonuc, bitti, corrects);
            fails = fails + 1;
        end
        total_corrects = total_corrects + corrects;

        #1;

        while(!bitti) begin
            if(sayac1_sonuc == sayac1_sonuc_test && sayac2_sonuc == sayac2_sonuc_test) begin
                corrects = corrects + 1;
            end
            #1;
        end
        if(sayac1_sonuc == 101 && sayac2_sonuc == 0 && bitti == 1) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, sayac1_sonuc: %d, sayac2_sonuc: %d, bitti: %d, corrects: %d", sayac1_sonuc, sayac2_sonuc, bitti, corrects);
            fails = fails + 1;
        end
        total_corrects = total_corrects + corrects;

        $display("%d passes, %d fails, %d corrects\n", passes, fails, total_corrects);
        
        if(passes == 6 && total_corrects == 1397) $display("ALL PASSED!\n");
        if(fails  == 6) $display("all failed!\n");

        $finish;
    end

endmodule

module sayac_boru_test(
    input saat,
    input reset,
    input [7:0] baslangic_degeri,
    input yon,
    input [2:0] miktar,
    output [7:0] sayac1_sonuc,
    output [7:0] sayac2_sonuc,
    output bitti
    );

    wire sayac1_hazir;
    wire [2:0] sayac1_cikis_miktar;
    wire sayac1_cikis_yon;
    sayac sayac1(
        .saat(saat),
        .reset(reset),
        .basla(1'b1),
        .baslangic_degeri(baslangic_degeri),
        .yon(yon),
        .miktar(miktar),
        .sonuc(sayac1_sonuc),
        .hazir(sayac1_hazir),
        .mesgul(), // onemsiz
        .cikis_miktar(sayac1_cikis_miktar),
        .cikis_yon(sayac1_cikis_yon)
    );

    reg sayac2_basla;
    reg [7:0] sayac2_baslangic_degeri;
    reg sayac2_yon;
    reg [2:0] sayac2_miktar;
    wire sayac2_mesgul;
    sayac sayac2(
        .saat(saat),
        .reset(reset),
        .basla(sayac2_basla && ~sayac1_hazir), // sayac1'in hazir oldugu cevrimden sonraki cevrim baslasin
        .baslangic_degeri(sayac2_baslangic_degeri),
        .yon(sayac2_yon),
        .miktar(sayac2_miktar),
        .sonuc(sayac2_sonuc),
        .hazir(bitti),
        .mesgul(sayac2_mesgul),
        .cikis_miktar(), // onemsiz
        .cikis_yon() // onemsiz
    );

    reg sayac1_hazir_tut;

    always @(posedge saat) begin
        if(reset) begin
            sayac2_basla <= 0;
            sayac2_baslangic_degeri <= 0;
            sayac2_yon <= 0;
            sayac2_miktar <= 0;
            sayac1_hazir_tut <= 0;
        end
        else begin
            sayac1_hazir_tut <= sayac2_basla ? 0 : (sayac1_hazir ? 1 : sayac1_hazir_tut);
            sayac2_basla <= ~sayac2_mesgul && sayac1_hazir_tut;
            sayac2_baslangic_degeri <= sayac1_hazir ? sayac1_sonuc : sayac2_baslangic_degeri;
            sayac2_yon <= sayac1_hazir ? ~sayac1_cikis_yon : sayac2_yon;
            sayac2_miktar <= sayac1_hazir ? 
                             (sayac1_cikis_miktar == 7 ? 7 : sayac1_cikis_miktar+1) : sayac2_miktar;
        end
    end
    
endmodule
