`timescale 1ns / 1ps

module tb_aes256();

    reg clk_i;
    reg rst_i;
    reg [255:0] anahtar_i;
    reg [127:0] metin_i;
    reg gecerli_i;
    reg mod_i;
    wire [127:0] metin_o;
    wire hazir_o;
    wire gecerli_o;

    aes256 aes256_dut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .anahtar_i(anahtar_i),
        .metin_i(metin_i),
        .gecerli_i(gecerli_i),
        .mod_i(mod_i),
        .metin_o(metin_o),
        .hazir_o(hazir_o),
        .gecerli_o(gecerli_o)
    );

    always begin
        clk_i = ~clk_i;
        #5;
    end

    integer passes = 0;
    integer fails = 0;

    initial begin
        clk_i = 0;
        rst_i = 1;
        #10;
        rst_i = 0;

        // TEST1
        anahtar_i = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
        metin_i = 128'h00112233445566778899aabbccddeeff;

        gecerli_i = 0;
        
        mod_i = 0;
        
        #20;
        
        while(!hazir_o) #10;
        
        gecerli_i = 1;
        #10;
        gecerli_i = 0; // sifreleme basladiktan sonra gecerli_i'nin 1 olup olmamasi onemli olmamali
        
        while(!gecerli_o) #10;

        if (metin_o == 128'h8ea2b7ca516745bfeafc49904b496089) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, metin_o %h, hazir_o %b, gecerli_o %b", metin_o, hazir_o, gecerli_o);
            fails = fails + 1;
        end

        // TEST2
        while(!hazir_o) #10;

        mod_i = 1;
        gecerli_i = 1;
        #10;
        gecerli_i = 0;

        while(!gecerli_o) #10;

        if (metin_o == 128'heab487e68ec92db4ac288a24757b0262) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, metin_o %h, hazir_o %b, gecerli_o %b", metin_o, hazir_o, gecerli_o);
            fails = fails + 1;
        end

        // TEST3
        while(!hazir_o) #10;

        anahtar_i = 256'h603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4;
        metin_i = 128'h6bc1bee22e409f96e93d7e117393172a;
        gecerli_i = 1;
        mod_i = 0;
        #10;
        // sifreleme basladiktan sonra gecerli_i'nin 1 olup olmamasi onemli olmamali
        // iceride bufferlamazsaniz burada hata almaniz olasi
        // islem yapilirken bu degere gore degil, modul hazirken gecerli_i sinyalinin ilk 1 oldugu cevrime gore sifrelemeyi yapmalisiniz
        anahtar_i = 256'hffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff;
        metin_i = 128'h11111111111111111111111111111111;
        //gecerli_i = 0;

        while(!gecerli_o) #10;

        if (metin_o == 128'hf3eed1bdb5d2a03c064b5a7e3db181f8) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, metin_o %h, hazir_o %b, gecerli_o %b", metin_o, hazir_o, gecerli_o);
            fails = fails + 1;
        end

        // TEST4
        while(!hazir_o) #10;

        anahtar_i = 256'h603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4;
        metin_i = 128'h6bc1bee22e409f96e93d7e117393172a;
        gecerli_i = 1;
        mod_i = 1;
        #10;
        gecerli_i = 0;

        while(!gecerli_o) #10;

        if (metin_o == 128'h25cde6ca74d3539c375b66c3892cf70a) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, metin_o %h, hazir_o %b, gecerli_o %b", metin_o, hazir_o, gecerli_o);
            fails = fails + 1;
        end

        // TEST5
        while(!hazir_o) #10;

        anahtar_i = 256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f;
        metin_i = 128'h202122232425262728292a2b2c2d2e2f;
        gecerli_i = 1;
        mod_i = 0;
        #10;
        gecerli_i = 0;

        while(!gecerli_o) #10;

        if (metin_o == 128'h61a6936e4e8f101c1cc1f993b542a0d4) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, metin_o %h, hazir_o %b, gecerli_o %b", metin_o, hazir_o, gecerli_o);
            fails = fails + 1;
        end

        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");

        $finish;
    end

endmodule
