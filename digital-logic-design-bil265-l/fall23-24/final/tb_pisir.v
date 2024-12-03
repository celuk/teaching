`timescale 1ns / 1ps

module tb_pisir(

    );
    
    reg saat;
    reg reset;
    reg basla;
    reg mayali;
    reg tuzlu;
    wire kabarik;
    wire cikis_tuzlu;
    wire [6:0] pizza_sayisi;
    wire bitti;
    
    pisir pisir_dut(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .mayali(mayali),
        .tuzlu(tuzlu),
        .kabarik(kabarik),
        .cikis_tuzlu(cikis_tuzlu),
        .pizza_sayisi(pizza_sayisi),
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
        
        basla = 1; mayali = 1; tuzlu = 0; #1;
        
        if(kabarik == 1 && cikis_tuzlu == 0 && pizza_sayisi == 1 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, kabarik: %d, cikis_tuzlu: %d, pizza_sayisi: %d, bitti: %d", kabarik, cikis_tuzlu, pizza_sayisi, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        basla = 1; mayali = 0; tuzlu = 0; #5;
        
        if(kabarik == 0 && cikis_tuzlu == 0 && pizza_sayisi == 5 && bitti == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, kabarik: %d, cikis_tuzlu: %d, pizza_sayisi: %d, bitti: %d", kabarik, cikis_tuzlu, pizza_sayisi, bitti);
            fails = fails + 1;
        end
        
        basla = 0; mayali = 1; tuzlu = 1; #10;
        
        if(pizza_sayisi == 5 && bitti == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, kabarik: %d, cikis_tuzlu: %d, pizza_sayisi: %d, bitti: %d", kabarik, cikis_tuzlu, pizza_sayisi, bitti);
            fails = fails + 1;
        end
        
        basla = 1; mayali = 1; tuzlu = 1; #15;
        
        if(kabarik == 0 && cikis_tuzlu == 1 && pizza_sayisi == 5 && bitti == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, kabarik: %d, cikis_tuzlu: %d, pizza_sayisi: %d, bitti: %d", kabarik, cikis_tuzlu, pizza_sayisi, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        basla = 0; mayali = 0; tuzlu = 0; #1;
        
        if(pizza_sayisi == 0 && bitti == 0) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, kabarik: %d, cikis_tuzlu: %d, pizza_sayisi: %d, bitti: %d", kabarik, cikis_tuzlu, pizza_sayisi, bitti);
            fails = fails + 1;
        end
        
        basla = 1; mayali = 1; tuzlu = 0; #100;
        
        if(kabarik == 1 && cikis_tuzlu == 0 && pizza_sayisi == 100 && bitti == 1) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, kabarik: %d, cikis_tuzlu: %d, pizza_sayisi: %d, bitti: %d", kabarik, cikis_tuzlu, pizza_sayisi, bitti);
            fails = fails + 1;
        end
        
        basla = 1; mayali = 0; tuzlu = 1; #100;
        
        if(kabarik == 0 && cikis_tuzlu == 1 && pizza_sayisi == 100 && bitti == 1) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, kabarik: %d, cikis_tuzlu: %d, pizza_sayisi: %d, bitti: %d", kabarik, cikis_tuzlu, pizza_sayisi, bitti);
            fails = fails + 1;
        end
        
        basla = 1; mayali = 0; tuzlu = 0; #99;
        
        if(kabarik == 0 && cikis_tuzlu == 0 && pizza_sayisi == 100 && bitti == 1) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, kabarik: %d, cikis_tuzlu: %d, pizza_sayisi: %d, bitti: %d", kabarik, cikis_tuzlu, pizza_sayisi, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        basla = 1; mayali = 1; tuzlu = 0; #99;
        
        if(kabarik == 1 && cikis_tuzlu == 0 && pizza_sayisi == 99 && bitti == 1) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, kabarik: %d, cikis_tuzlu: %d, pizza_sayisi: %d, bitti: %d", kabarik, cikis_tuzlu, pizza_sayisi, bitti);
            fails = fails + 1;
        end
        
        basla = 1; mayali = 0; tuzlu = 0; #2;
        
        if(kabarik == 0 && cikis_tuzlu == 0 && pizza_sayisi == 100 && bitti == 1) begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, kabarik: %d, cikis_tuzlu: %d, pizza_sayisi: %d, bitti: %d", kabarik, cikis_tuzlu, pizza_sayisi, bitti);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
