`timescale 1ns / 1ps

module tb_servis(

    );

    reg saat;
    reg reset;
    reg basla;
    reg demlendi;
    reg filtrele;
    reg filtre_tipi;
    wire bitti;
    wire bosalt;
    wire [4:0] kahve_sayisi;

    servis servis_dut(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .demlendi(demlendi),
        .filtrele(filtrele),
        .filtre_tipi(filtre_tipi),
        .bitti(bitti),
        .bosalt(bosalt),
        .kahve_sayisi(kahve_sayisi)
    );
    
    always begin
        saat = ~saat; #0.5;
    end

    integer passes = 0;
    integer fails = 0;
    
    initial begin
        saat = 0;
        reset = 1; #13;
        reset = 0;
        
        basla = 1; demlendi = 1; filtrele = 1; filtre_tipi = 0; #1;
        
        if(kahve_sayisi == 2 && bosalt == 0 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, kahve_sayisi: %d, bosalt: %d, bitti: %d", kahve_sayisi, bosalt, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        basla = 1; demlendi = 1; filtrele = 1; filtre_tipi = 1; #1;
        
        if(kahve_sayisi == 3 && bosalt == 0 && bitti == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, kahve_sayisi: %d, bosalt: %d, bitti: %d", kahve_sayisi, bosalt, bitti);
            fails = fails + 1;
        end
        
        basla = 0; demlendi = 1; filtrele = 1; filtre_tipi = 0; #1;
        
        if(kahve_sayisi == 3 && bosalt == 0 && bitti == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, kahve_sayisi: %d, bosalt: %d, bitti: %d", kahve_sayisi, bosalt, bitti);
            fails = fails + 1;
        end
        
        basla = 1; demlendi = 1; filtrele = 0; filtre_tipi = 0; #1;
        
        if(kahve_sayisi == 4 && bosalt == 0 && bitti == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, kahve_sayisi: %d, bosalt: %d, bitti: %d", kahve_sayisi, bosalt, bitti);
            fails = fails + 1;
        end

        basla = 0; demlendi = 1; filtrele = 1; filtre_tipi = 1; #20;
        
        if(kahve_sayisi == 4 && bosalt == 0 && bitti == 0) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, kahve_sayisi: %d, bosalt: %d, bitti: %d", kahve_sayisi, bosalt, bitti);
            fails = fails + 1;
        end
        
        basla = 1; demlendi = 1; filtrele = 1; filtre_tipi = 0; #1;
        
        if(kahve_sayisi == 6 && bosalt == 0 && bitti == 1) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, kahve_sayisi: %d, bosalt: %d, bitti: %d", kahve_sayisi, bosalt, bitti);
            fails = fails + 1;
        end
        
        basla = 1; demlendi = 0; filtrele = 1; filtre_tipi = 0; #13;
        
        if(kahve_sayisi == 6 && bosalt == 0 && bitti == 1) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, kahve_sayisi: %d, bosalt: %d, bitti: %d", kahve_sayisi, bosalt, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #14;
        reset = 0;
        
        basla = 1; demlendi = 1; filtrele = 1; filtre_tipi = 0; #25;
        basla = 1; demlendi = 1; filtrele = 1; filtre_tipi = 1; #2;
        
        if(kahve_sayisi == 3 && bosalt == 0 && bitti == 1) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, kahve_sayisi: %d, bosalt: %d, bitti: %d", kahve_sayisi, bosalt, bitti);
            fails = fails + 1;
        end
        
        basla = 1; demlendi = 1; filtrele = 0; filtre_tipi = 0; #22;
        
        if(kahve_sayisi == 0 && bosalt == 1 && bitti == 1) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, kahve_sayisi: %d, bosalt: %d, bitti: %d", kahve_sayisi, bosalt, bitti);
            fails = fails + 1;
        end
        
        basla = 1; demlendi = 1; filtrele = 0; filtre_tipi = 0; #1;
        
        if(kahve_sayisi == 1 && bosalt == 0 && bitti == 1) begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, kahve_sayisi: %d, bosalt: %d, bitti: %d", kahve_sayisi, bosalt, bitti);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end

endmodule
