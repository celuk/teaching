`timescale 1ns / 1ps

module tb_bavul(

    );
    
    reg saat;
    reg reset;
    reg basla;
    reg [5:0] agirlik;
    wire [7:0] ucret;
    wire bitti;
    
    bavul bavul_dut(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .agirlik(agirlik),
        .ucret(ucret),
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
        
        basla = 1; agirlik = 14; #1;
        
        if(ucret == 45 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, ucret: %d, bitti: %d", ucret, bitti);
            fails = fails + 1;
        end
        
        basla = 0; agirlik = 40; #1;
        
        if(bitti == 0) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, ucret: %d, bitti: %d", ucret, bitti);
            fails = fails + 1;
        end
        
        basla = 1; agirlik = 40; #1;
        
        if(ucret == 45 && bitti == 1) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, ucret: %d, bitti: %d", ucret, bitti);
            fails = fails + 1;
        end
        
        basla = 1; agirlik = 45; #1;
        
        if(ucret == 101 && bitti == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, ucret: %d, bitti: %d", ucret, bitti);
            fails = fails + 1;
        end
        
        basla = 1; agirlik = 32; #1;
        
        if(ucret == 51 && bitti == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, ucret: %d, bitti: %d", ucret, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        basla = 0; agirlik = 63; #1;
        
        if(bitti == 0) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, ucret: %d, bitti: %d", ucret, bitti);
            fails = fails + 1;
        end
        
        basla = 1; agirlik = 63; #1;
        
        if(ucret == 198 && bitti == 1)  begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, ucret: %d, bitti: %d", ucret, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        basla = 1; agirlik = 59; #1;
        
        if(ucret == 45 && bitti == 1)  begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, ucret: %d, bitti: %d", ucret, bitti);
            fails = fails + 1;
        end
        
        basla = 1; agirlik = 10; #1;
        
        if(ucret == 5 && bitti == 1)  begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, ucret: %d, bitti: %d", ucret, bitti);
            fails = fails + 1;
        end
        
        basla = 1; agirlik = 2; #1;
        
        if(ucret == 0 && bitti == 1)  begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, ucret: %d, bitti: %d", ucret, bitti);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end
    
endmodule

