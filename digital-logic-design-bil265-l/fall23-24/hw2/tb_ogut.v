`timescale 1ns / 1ps

module tb_ogut(

    );
    
    reg saat;
    reg reset;
    reg basla;
    reg [3:0] cekirdekler;
    reg [1:0] boyut;
    wire bitti;
    wire [4:0] tanecikler;

    ogut ogut_dut(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .cekirdekler(cekirdekler),
        .boyut(boyut),
        .bitti(bitti),
        .tanecikler(tanecikler)
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
        
        basla = 1; cekirdekler = 14; boyut = 0; #1;
        
        if(tanecikler == 28 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, tanecikler: %d, bitti: %d", tanecikler, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        basla = 1; cekirdekler = 9; boyut = 1; #1;
        
        if(tanecikler == 14 && bitti == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, tanecikler: %d, bitti: %d", tanecikler, bitti);
            fails = fails + 1;
        end
        
        basla = 0; cekirdekler = 9; boyut = 1; #1;
        
        if(tanecikler == 0 && bitti == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, tanecikler: %d, bitti: %d", tanecikler, bitti);
            fails = fails + 1;
        end
        
        basla = 1; cekirdekler = 4; boyut = 2; #1;
        
        if(tanecikler == 4 && bitti == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, tanecikler: %d, bitti: %d", tanecikler, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        basla = 0; cekirdekler = 11; boyut = 1; #3;
        
        if(tanecikler == 0 && bitti == 0) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, tanecikler: %d, bitti: %d", tanecikler, bitti);
            fails = fails + 1;
        end
        
        basla = 1; cekirdekler = 11; boyut = 2; #1;
        
        if(tanecikler == 12 && bitti == 1) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, tanecikler: %d, bitti: %d", tanecikler, bitti);
            fails = fails + 1;
        end
        
        basla = 1; cekirdekler = 7; boyut = 0; #2;
        
        if(tanecikler == 14 && bitti == 1) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, tanecikler: %d, bitti: %d", tanecikler, bitti);
            fails = fails + 1;
        end
        
        basla = 1; cekirdekler = 3; boyut = 1; #5;
        
        if(tanecikler == 5 && bitti == 1) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, tanecikler: %d, bitti: %d", tanecikler, bitti);
            fails = fails + 1;
        end
        
        basla = 1; cekirdekler = 15; boyut = 2; #80;
        
        if(tanecikler == 17 && bitti == 1) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, tanecikler: %d, bitti: %d", tanecikler, bitti);
            fails = fails + 1;
        end
        
        basla = 1; cekirdekler = 0; boyut = 0; #1;
        
        if(tanecikler == 0 && bitti == 1) begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, tanecikler: %d, bitti: %d", tanecikler, bitti);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end

endmodule
