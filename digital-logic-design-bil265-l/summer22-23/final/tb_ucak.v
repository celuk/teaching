`timescale 1ns / 1ps

module tb_ucak(

    );
    
    reg saat;
    reg reset;
    reg basla;
    reg o_yolcu;
    reg g_kimlik;
    wire kalkis;
    wire bitti;
    
    ucak ucak_dut(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .o_yolcu(o_yolcu),
        .g_kimlik(g_kimlik),
        .kalkis(kalkis),
        .bitti(bitti)
    );
    
    always begin
        saat = ~saat; #0.5;
    end
    
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        saat = 0;
        reset = 0;
        
        basla = 1; o_yolcu = 1; g_kimlik = 1; #1;
        basla = 1; o_yolcu = 0; g_kimlik = 0; #1;
        basla = 1; o_yolcu = 0; g_kimlik = 1; #1;
        basla = 1; o_yolcu = 1; g_kimlik = 0; #1;
        
        if(kalkis == 0 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, kalkis: %d, bitti: %d", kalkis, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        basla = 1; o_yolcu = 1; g_kimlik = 1; #1;
        
        if(kalkis == 0 && bitti == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, kalkis: %d, bitti: %d", kalkis, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        basla = 0; o_yolcu = 1; g_kimlik = 1; #1;
        basla = 0; o_yolcu = 1; g_kimlik = 1; #1;
        basla = 1; o_yolcu = 1; g_kimlik = 1; #50;
        
        if(kalkis == 1 && bitti == 1) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, kalkis: %d, bitti: %d", kalkis, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        basla = 0; o_yolcu = 1; g_kimlik = 1; #1;
        basla = 1; o_yolcu = 1; g_kimlik = 1; #55;
        basla = 0; o_yolcu = 1; g_kimlik = 1; #1;
        
        if(kalkis == 1 && bitti == 0) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, kalkis: %d, bitti: %d", kalkis, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        basla = 0; o_yolcu = 1; g_kimlik = 1; #1;
        basla = 1; o_yolcu = 1; g_kimlik = 1; #20;
        basla = 1; o_yolcu = 0; g_kimlik = 1; #20;
        basla = 1; o_yolcu = 1; g_kimlik = 0; #20;
        basla = 1; o_yolcu = 0; g_kimlik = 0; #20;
        basla = 0; o_yolcu = 1; g_kimlik = 1; #20;
        basla = 1; o_yolcu = 1; g_kimlik = 1; #29;
        basla = 0; o_yolcu = 1; g_kimlik = 1; #40;
        basla = 1; o_yolcu = 1; g_kimlik = 1; #1;
        
        if(kalkis == 1 && bitti == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, kalkis: %d, bitti: %d", kalkis, bitti);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");
        
        $finish;
    end
endmodule

