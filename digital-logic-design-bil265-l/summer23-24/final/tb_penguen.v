`timescale 1ns / 1ps

module tb_penguen(
    );

    reg saat;
    reg reset;
    reg [2:0]avlanan_balik;
    wire bitti;
    wire [6:0]bitme_sure;

    penguen uut(
    .saat(saat),
    .reset(reset),
    .avlanan_balik(avlanan_balik),
    .bitti(bitti),
    .bitme_sure(bitme_sure)
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
        avlanan_balik = 3'b111;
        #3;
        avlanan_balik = 3'b000;
        #1;
        avlanan_balik = 3'b001;
        #1;

        if(bitti == 0)begin
           $display("TEST1 PASSED");
           passes = passes + 1;
        end
        else begin
            $display("test1 failed, bitti: %d, bitme_sure: %d", bitti, bitme_sure);
            fails = fails + 1;
        end

        avlanan_balik = 3'b111;
        #1;
        if(bitti == 1 && bitme_sure == 6)begin
           $display("TEST2 PASSED");
           passes = passes + 1;
        end
        else begin
            $display("test2 failed, bitti: %d, bitme_sure: %d", bitti, bitme_sure);
            fails = fails + 1;
        end

        #1;
        if(bitti == 1 && bitme_sure == 6)begin
           $display("TEST3 PASSED");
           passes = passes + 1;
        end
        else begin
            $display("test3 failed, bitti: %d, bitme_sure: %d", bitti, bitme_sure);
            fails = fails + 1;
        end

        #5;
        reset = 1;
        #20;
        if(bitti == 0)begin
           $display("TEST4 PASSED");
           passes = passes + 1;
        end    
        else begin
            $display("test4 failed, bitti: %d, bitme_sure: %d", bitti, bitme_sure);
            fails = fails + 1;
        end

        avlanan_balik = 3'b001; 
        reset = 1;
        #1;
        reset = 0;
        #10;
        avlanan_balik = 3'b101;
        #40;
        if(bitti == 1 && bitme_sure == 16)begin
           $display("TEST5 PASSED");
           passes = passes + 1;
        end    
        else begin
            $display("test5 failed, bitti: %d, bitme_sure: %d", bitti, bitme_sure);
            fails = fails + 1;
        end

        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");

        $finish;
    end
endmodule
