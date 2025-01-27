`timescale 1ns / 1ps

module tb_decoder(

    );

    localparam N = 12;

    reg clk;
    reg rst;
    reg basla;
    reg mod;
    reg [N-1:0] gelen_veri;
    wire [N-1:0] cikan_veri;
    wire bitti;

    decoder #(
        .N(N)
    ) decoder_dut(
        .clk(clk),
        .rst(rst),
        .basla(basla),
        .mod(mod),
        .gelen_veri(gelen_veri),
        .cikan_veri(cikan_veri),
        .bitti(bitti)
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

        basla = 1; mod = 0; gelen_veri = 12'b011100010110; #1; basla = 0;
        while(!bitti) #1;
        if(cikan_veri == 12'b010001110100 && bitti == 1) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, cikan_veri: %b, bitti: %b", cikan_veri, bitti);
            fails = fails + 1;
        end

        rst = 1;
        #55;
        rst = 0;

        basla = 1; mod = 1;
        gelen_veri = 'b011; #1;
        gelen_veri = 'b100; #1;
        gelen_veri = 'b010; #1;
        gelen_veri = 'b110; #1;
        basla = 0;
        while(!bitti) #1;
        if(cikan_veri == 12'b010001110100 && bitti == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, cikan_veri: %b, bitti: %b", cikan_veri, bitti);
            fails = fails + 1;
        end

        basla = 1; mod = 0;
        gelen_veri = 12'b000000011100; #1; basla = 0;
        basla = 0;
        while(!bitti) #1;
        if(cikan_veri == 12'b111000011001 && bitti == 1) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, cikan_veri: %b, bitti: %b", cikan_veri, bitti);
            fails = fails + 1;
        end

        basla = 1; mod = 1;
        gelen_veri = 'b111; #1;
        gelen_veri = 'b101; #1;
        gelen_veri = 'b110; #1;
        gelen_veri = 'b000; #1;
        basla = 0;
        while(!bitti) #1;
        if(cikan_veri == 12'b110110001010 && bitti == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, cikan_veri: %b, bitti: %b", cikan_veri, bitti);
            fails = fails + 1;
        end

        basla = 1; mod = 1;
        gelen_veri = 'b001; #1;
        gelen_veri = 'b110; #1;
        gelen_veri = 'b011; #1;
        gelen_veri = 'b100; #1;
        basla = 0;
        while(!bitti) #1;
        if(cikan_veri == 12'b000101101001 && bitti == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, cikan_veri: %b, bitti: %b", cikan_veri, bitti);
            fails = fails + 1;
        end

        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");

        $finish;
    end

endmodule
