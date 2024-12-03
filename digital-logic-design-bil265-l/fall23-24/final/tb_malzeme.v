`timescale 1ns / 1ps

module tb_malzeme(

    );
    
    reg saat;
    reg reset;
    reg basla;
    reg sos;
    reg tuzlu;
    wire secilen_malzeme;
    wire [3:0] malzeme_miktari;
    wire cikis_tuzlu;
    wire bitti;
    
    malzeme malzeme_dut(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .sos(sos),
        .tuzlu(tuzlu),
        .secilen_malzeme(secilen_malzeme),
        .malzeme_miktari(malzeme_miktari),
        .cikis_tuzlu(cikis_tuzlu),
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
        
        basla = 1; sos = 1; tuzlu = 0; #1;
        
        if(secilen_malzeme == 1 && malzeme_miktari == 7 && cikis_tuzlu == 0 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, secilen_malzeme: %d, malzeme_miktari: %d, cikis_tuzlu: %d, bitti: %d", secilen_malzeme, malzeme_miktari, cikis_tuzlu, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        basla = 1; sos = 0; tuzlu = 0; #1;
        
        if(secilen_malzeme == 1 && malzeme_miktari == 6 && cikis_tuzlu == 0 && bitti == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, secilen_malzeme: %d, malzeme_miktari: %d, cikis_tuzlu: %d, bitti: %d", secilen_malzeme, malzeme_miktari, cikis_tuzlu, bitti);
            fails = fails + 1;
        end
        
        basla = 0; sos = 1; tuzlu = 0; #1;
        
        if(bitti == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, secilen_malzeme: %d, malzeme_miktari: %d, cikis_tuzlu: %d, bitti: %d", secilen_malzeme, malzeme_miktari, cikis_tuzlu, bitti);
            fails = fails + 1;
        end
        
        basla = 1; sos = 0; tuzlu = 1; #1;
        
        if(malzeme_miktari == 0 && cikis_tuzlu == 1 && bitti == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, secilen_malzeme: %d, malzeme_miktari: %d, cikis_tuzlu: %d, bitti: %d", secilen_malzeme, malzeme_miktari, cikis_tuzlu, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        basla = 0; sos = 0; tuzlu = 1; #1;
        
        if(bitti == 0) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, secilen_malzeme: %d, malzeme_miktari: %d, cikis_tuzlu: %d, bitti: %d", secilen_malzeme, malzeme_miktari, cikis_tuzlu, bitti);
            fails = fails + 1;
        end
        
        basla = 1; sos = 1; tuzlu = 1; #1;
        
        if(malzeme_miktari == 0 && cikis_tuzlu == 1 && bitti == 1) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, secilen_malzeme: %d, malzeme_miktari: %d, cikis_tuzlu: %d, bitti: %d", secilen_malzeme, malzeme_miktari, cikis_tuzlu, bitti);
            fails = fails + 1;
        end
        
        basla = 1; sos = 1; tuzlu = 0; #20;
        
        if(secilen_malzeme == 1 && malzeme_miktari == 7 && cikis_tuzlu == 0 && bitti == 1) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, secilen_malzeme: %d, malzeme_miktari: %d, cikis_tuzlu: %d, bitti: %d", secilen_malzeme, malzeme_miktari, cikis_tuzlu, bitti);
            fails = fails + 1;
        end
        
        basla = 1; sos = 1; tuzlu = 0; #500;
        
        if(secilen_malzeme == 1 && malzeme_miktari == 7 && cikis_tuzlu == 0 && bitti == 1) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, secilen_malzeme: %d, malzeme_miktari: %d, cikis_tuzlu: %d, bitti: %d", secilen_malzeme, malzeme_miktari, cikis_tuzlu, bitti);
            fails = fails + 1;
        end
        
        basla = 1; sos = 1; tuzlu = 1; #13;
        
        if(malzeme_miktari == 0 && cikis_tuzlu == 1 && bitti == 1) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, secilen_malzeme: %d, malzeme_miktari: %d, cikis_tuzlu: %d, bitti: %d", secilen_malzeme, malzeme_miktari, cikis_tuzlu, bitti);
            fails = fails + 1;
        end
        
        basla = 1; sos = 0; tuzlu = 0; #49;
        
        if(secilen_malzeme == 1 && malzeme_miktari == 6 && cikis_tuzlu == 0 && bitti == 1) begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, secilen_malzeme: %d, malzeme_miktari: %d, cikis_tuzlu: %d, bitti: %d", secilen_malzeme, malzeme_miktari, cikis_tuzlu, bitti);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
