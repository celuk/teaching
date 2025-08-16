`timescale 1ns / 1ps

module tb_kayan_yazmac_boru(

    );

    localparam N = 5;

    reg saat;
    reg reset;
    reg [N-1:0] sayi_giris;
    reg [4:0] miktar;
    wire [N-1:0] sayi_cikis;
    wire bitti;

    kayan_yazmac_boru #(.N(N)) kayan_yazmac_boru_dut(
        .saat(saat),
        .reset(reset),
        .sayi_giris(sayi_giris),
        .miktar(miktar),
        .sayi_cikis(sayi_cikis),
        .bitti(bitti)
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

        miktar=10;
        sayi_giris=7; #35;

        if(sayi_cikis == 3 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, sayi_cikis: %d, bitti: %d", sayi_cikis, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #40;
        reset = 0;

        sayi_giris=31; miktar=31; #140;

        if(sayi_cikis == 27 && bitti == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, sayi_cikis: %d, bitti: %d", sayi_cikis, bitti);
            fails = fails + 1;
        end

        sayi_giris=15; miktar=6; #53;

        if(sayi_cikis == 11 && bitti == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, sayi_cikis: %d, bitti: %d", sayi_cikis, bitti);
            fails = fails + 1;
        end

        sayi_giris=22; miktar=13; #100;

        if(sayi_cikis == 18 && bitti == 0) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, sayi_cikis: %d, bitti: %d", sayi_cikis, bitti);
            fails = fails + 1;
        end

        sayi_giris=3; miktar=5; #200;

        if(sayi_cikis == 0 && bitti == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, sayi_cikis: %d, bitti: %d", sayi_cikis, bitti);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");
        
        $finish;
    end
endmodule
