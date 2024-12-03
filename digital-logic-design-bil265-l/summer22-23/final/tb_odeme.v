`timescale 1ns / 1ps

module tb_odeme(

    );
    
    reg saat;
    reg reset;
    reg basla;
    reg [7:0] ucret;
    reg [8:0] bakiye;
    wire onay;
    wire [8:0] k_bakiye;
    wire bitti;
    
    odeme odeme_dut(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .ucret(ucret),
        .bakiye(bakiye),
        .onay(onay),
        .k_bakiye(k_bakiye),
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
        
        basla = 1; ucret = 14; bakiye = 45; #1;
        
        if(onay == 1 && k_bakiye == 31 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, onay: %d, k_bakiye: %d, bitti: %d", onay, k_bakiye, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        basla = 0; ucret = 56; bakiye = 13; #1;
        
        if(bitti == 0) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, onay: %d, k_bakiye: %d, bitti: %d", onay, k_bakiye, bitti);
            fails = fails + 1;
        end
        
        basla = 0; ucret = 22; bakiye = 99; #1;
        
        if(bitti == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, onay: %d, k_bakiye: %d, bitti: %d", onay, k_bakiye, bitti);
            fails = fails + 1;
        end
        
        basla = 1; ucret = 77; bakiye = 87; #1;
        
        if(onay == 1 && k_bakiye == 10 && bitti == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, onay: %d, k_bakiye: %d, bitti: %d", onay, k_bakiye, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        basla = 1; ucret = 69; bakiye = 11; #1;
        
        if(onay == 0 && k_bakiye == 11 && bitti == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, onay: %d, k_bakiye: %d, bitti: %d", onay, k_bakiye, bitti);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");
        
        $finish;
    end
    
endmodule

