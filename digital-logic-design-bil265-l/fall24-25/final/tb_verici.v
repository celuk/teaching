`timescale 1ns / 1ps

module tb_verici(

    );

    localparam N = 12;

    reg clk;
    reg rst;
    reg basla;
    reg mod;
    reg [N-1:0] gelen_veri;
    wire [N-1:0] cikan_veri;
    wire bitti;

    verici #(
        .N(N)
    ) verici_dut(
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

    // max 20 adet 3 bitlik sayi arka arkaya gelebilir ama 32'lik tutalim arada cevrim kaybi olanlari tolere edelim
    reg [2:0] buffer [31:0];
    integer i;
    integer buffer_index = 0;
    integer match_counter = 0;

    initial begin
        for(i = 0; i < 32; i = i + 1) begin
            buffer[i] = 0;
        end

        clk = 0;
        rst = 1;
        #1;
        rst = 0;

        basla = 1; mod = 0; gelen_veri = 12'b011100010110; #1; basla = 0;
        while(!bitti) #1;
        if(cikan_veri == gelen_veri && bitti == 1) begin
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

        basla = 1; mod = 1; gelen_veri = 12'b011100010110; #1; basla = 0;
        buffer_index = 0;
        while(!bitti) begin
            buffer[buffer_index] = cikan_veri[2:0];
            buffer_index = buffer_index + 1;
            #1;
        end
        buffer[buffer_index] = cikan_veri[2:0];
        match_counter = 0;
        for (i = 0; i < N/3; i = i + 1) begin
            if (buffer[buffer_index - i] == gelen_veri[3*(i+1)-1 -: 3]) begin
                match_counter = match_counter + 1;
            end
        end
        if(match_counter == N/3 && bitti == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, cikan_veri: %b, bitti: %b", cikan_veri, bitti);
            fails = fails + 1;
        end

        basla = 1; mod = 0; gelen_veri = 12'b110010101011; #1; basla = 0;
        while(!bitti) #1;
        if(cikan_veri == gelen_veri && bitti == 1) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, cikan_veri: %b, bitti: %b", cikan_veri, bitti);
            fails = fails + 1;
        end

        basla = 1; mod = 1; gelen_veri = 12'b000111010101; #1; basla = 0;
        buffer_index = 0;
        while(!bitti) begin
            buffer[buffer_index] = cikan_veri[2:0];
            buffer_index = buffer_index + 1;
            #1;
        end
        buffer[buffer_index] = cikan_veri[2:0];
        match_counter = 0;
        for (i = 0; i < N/3; i = i + 1) begin
            if (buffer[buffer_index - i] == gelen_veri[3*(i+1)-1 -: 3]) begin
                match_counter = match_counter + 1;
            end
        end
        if(match_counter == N/3 && bitti == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, cikan_veri: %b, bitti: %b", cikan_veri, bitti);
            fails = fails + 1;
        end

        basla = 1; mod = 0; gelen_veri = 12'b111111111111; #1; basla = 0;
        while(!bitti) #1;
        if(cikan_veri == gelen_veri && bitti == 1) begin
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
