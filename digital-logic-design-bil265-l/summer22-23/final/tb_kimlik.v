`timescale 1ns / 1ps

module tb_kimlik(

    );
    localparam BIT = 6;
    
    reg saat;
    reg reset;
    reg basla;
    reg [BIT-1:0] kimlik_no;
    reg uyruk;
    wire gecerli;
    wire bitti;
    
    kimlik #(.BIT(BIT)) kimlik_dut(
        .saat(saat),
        .reset(reset),
        .basla(basla),
        .kimlik_no(kimlik_no),
        .uyruk(uyruk),
        .gecerli(gecerli),
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
        
        basla = 1; kimlik_no = 'b000111; uyruk = 0; #1;
        
        if(gecerli == 1 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, gecerli: %d, bitti: %d", gecerli, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        basla = 0; kimlik_no = 'b000111; uyruk = 0; #1;
        
        if(bitti == 0) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, gecerli: %d, bitti: %d", gecerli, bitti);
            fails = fails + 1;
        end
        
        basla = 1; kimlik_no = 'b110111; uyruk = 1; #1;
        
        if(gecerli == 1 && bitti == 1) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, gecerli: %d, bitti: %d", gecerli, bitti);
            fails = fails + 1;
        end
        
        basla = 0; kimlik_no = 'b110111; uyruk = 1; #1;
        
        if(bitti == 0) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, gecerli: %d, bitti: %d", gecerli, bitti);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        basla = 1; kimlik_no = 'b000000; uyruk = 1; #1;
        
        if(gecerli == 0 && bitti == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, gecerli: %d, bitti: %d", gecerli, bitti);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");
        
        $finish;
    end
    
endmodule

