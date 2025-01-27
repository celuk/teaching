`timescale 1ns / 1ps

module tb_catch(

    );

    reg clk;
    reg rst;
    reg [3:0] yon;
    wire durum;
    wire [3:0] yakalama_sayisi;

    catch catch_dut(
        .clk(clk),
        .rst(rst),
        .yon(yon),
        .durum(durum),
        .yakalama_sayisi(yakalama_sayisi)
    );

    always begin
        clk = ~clk; #0.5;
    end

    integer passes = 0;
    integer fails = 0;

    initial begin
        clk = 0;
        rst = 1;
        #1;
        rst = 0;

        yon = 4'b0100; #1;
        yon = 4'b1100; #1;
        yon = 4'b0010; #1;
        yon = 4'b1111; #1;
        yon = 4'b1010; #1;
        yon = 4'b0110; #1;
        #1;
        if(durum == 1 && yakalama_sayisi == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, durum: %d, yakalama_sayisi: %d", durum, yakalama_sayisi);
            fails = fails + 1;
        end

        rst = 1;
        #55;
        rst = 0;

        yon = 4'b0000; #1;
        yon = 4'b1110; #1;
        yon = 4'b0000; #1;
        yon = 4'b0000; #1;
        yon = 4'b0000; #1;
        yon = 4'b0000; #1;
        yon = 4'b0000; #1;
        yon = 4'b0000; #1;
        yon = 4'b0010; #1;
        yon = 4'b0000; #1;
        yon = 4'b0000; #1;
        yon = 4'b0000; #1;
        yon = 4'b0000; #1;
        yon = 4'b0001; #1;
        #1;
        if(durum == 0 && yakalama_sayisi == 5) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, durum: %d, yakalama_sayisi: %d", durum, yakalama_sayisi);
            fails = fails + 1;
        end

        repeat (100) begin
            yon = $random % 16; #1;
        end
        #1;
        if(durum == 0 && yakalama_sayisi == 12) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, durum: %d, yakalama_sayisi: %d", durum, yakalama_sayisi);
            fails = fails + 1;
        end

        rst = 1;
        #1;
        rst = 0;

        yon = 4'b0100; #1;
        yon = 4'b1100; #1;
        yon = 4'b0010; #1;
        repeat(5) begin
            yon = 4'b0110; #1;
            yon = 4'b1001; #1;
            yon = 4'b0110; #1;
        end
        yon = 4'b0110; #1;
        yon = 4'b1001; #1;
        yon = 4'b1100; #1;
        //#1;
        if(durum == 1 && yakalama_sayisi == 15) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, durum: %d, yakalama_sayisi: %d", durum, yakalama_sayisi);
            fails = fails + 1;
        end

        rst = 1;
        #1;
        rst = 0;
        
        yon = 4'b0100; #1;
        yon = 4'b1100; #1;
        repeat(8) begin
            yon = 4'b0101; #1;
            yon = 4'b1010; #1;
            yon = 4'b0101; #1;
        end
        #1;
        if(durum == 0 && yakalama_sayisi == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, durum: %d, yakalama_sayisi: %d", durum, yakalama_sayisi);
            fails = fails + 1;
        end

        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");

        $finish;
    end
    
endmodule
