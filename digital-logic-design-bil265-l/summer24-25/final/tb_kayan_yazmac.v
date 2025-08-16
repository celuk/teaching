`timescale 1ns / 1ps

module tb_kayan_yazmac(

    );

    localparam N = 2;

    reg saat;
    reg reset;
    reg basla;
    reg [5-1:0] sayi_giris;
    reg [4:0] miktar;
    wire [5-1:0] sayi_cikis;
    wire hazir;
    kayan_yazmac kayan_yazmac_dut( // N=5
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .sayi_giris(sayi_giris),
        .miktar(miktar),
        .sayi_cikis(sayi_cikis),
        .hazir(hazir)
    );

    wire [N-1:0] sayi_cikis2;
    wire hazir2;
    kayan_yazmac #(.N(N)) kayan_yazmac_dut2(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .sayi_giris(sayi_giris),
        .miktar(miktar),
        .sayi_cikis(sayi_cikis2),
        .hazir(hazir2)
    );

    always begin
        saat = ~saat; #0.5;
    end
    
    integer passes = 0;
    integer fails = 0;

    initial begin
        saat = 0;
        reset = 1;
        #1;
        reset = 0;

        miktar=6;
        basla = 1; sayi_giris=1; #1;
        basla = 0; sayi_giris=3; #1; //$display("sayi_cikis: %d, hazir: %d", sayi_cikis2, hazir2);
        basla = 0; sayi_giris=2; #1; //$display("sayi_cikis: %d, hazir: %d", sayi_cikis2, hazir2);
        basla = 0; sayi_giris=1; #1; //$display("sayi_cikis: %d, hazir: %d", sayi_cikis2, hazir2);
        basla = 0; sayi_giris=1; #1; //$display("sayi_cikis: %d, hazir: %d", sayi_cikis2, hazir2);
        basla = 0; sayi_giris=0; #1; //$display("sayi_cikis: %d, hazir: %d", sayi_cikis2, hazir2);
        #1; //$display("sayi_cikis: %d, hazir: %d", sayi_cikis2, hazir2);
        #1; //$display("sayi_cikis: %d, hazir: %d", sayi_cikis2, hazir2);

        if(sayi_cikis2 == 1 && hazir2 == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, sayi_cikis: %d, hazir: %d", sayi_cikis2, hazir2);
            fails = fails + 1;
        end
        
        reset = 1;
        #40;
        reset = 0;

        miktar=10;
        basla = 1; sayi_giris=12; #1;
        basla = 0; sayi_giris=7; #1;
        basla = 0; sayi_giris=31; #1;
        basla = 0; sayi_giris=7; #1;
        basla = 0; sayi_giris=10; #1; //$display("sayi_cikis: %d, hazir: %d", sayi_cikis, hazir);
        basla = 0; sayi_giris=14; #1; //$display("sayi_cikis: %d, hazir: %d", sayi_cikis, hazir);
        basla = 0; sayi_giris=14; #1; //$display("sayi_cikis: %d, hazir: %d", sayi_cikis, hazir);
        basla = 0; sayi_giris=14; #1; //$display("sayi_cikis: %d, hazir: %d", sayi_cikis, hazir);
        basla = 0; sayi_giris=25; #1; //$display("sayi_cikis: %d, hazir: %d", sayi_cikis, hazir);
        basla = 0; sayi_giris=13;

        if(sayi_cikis == 10 && hazir == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, sayi_cikis: %d, hazir: %d", sayi_cikis, hazir);
            fails = fails + 1;
        end

        basla = 1; sayi_giris=7; miktar=31; #30;

        if(sayi_cikis == 7 && hazir == 1) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, sayi_cikis: %d, hazir: %d", sayi_cikis, hazir);
            fails = fails + 1;
        end

        basla = 0; #10;

        basla = 1; sayi_giris=29; miktar=18; #9;
        basla = 0; sayi_giris=16; #8;

        if(sayi_cikis == 16 && hazir == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, sayi_cikis: %d, hazir: %d", sayi_cikis, hazir);
            fails = fails + 1;
        end

        #2;

        basla = 1; sayi_giris=13; miktar=25; #19;
        basla = 0; sayi_giris=11; #1;
        basla = 1; sayi_giris=13; #4;

        if(sayi_cikis == 11 && hazir == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, sayi_cikis: %d, hazir: %d", sayi_cikis, hazir);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");
        
        $finish;
    end
endmodule
