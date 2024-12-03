`timescale 1ns / 1ps

module tb_penguenler(
    );

    reg saat;
    reg reset;
    reg [14:0]avlanan_balik;
    wire bitti;
    wire [6:0]en_kisa, en_uzun, ortalama;
    wire [2:0]hizli_penguen, yavas_penguen;
    
    penguenler uut(
    .saat(saat),
    .reset(reset),
    .avlanan_balik(avlanan_balik),
    .bitti(bitti),
    .en_kisa(en_kisa),
    .en_uzun(en_uzun),
    .hizli_penguen(hizli_penguen),
    .yavas_penguen(yavas_penguen),
    .ortalama(ortalama)
    );
    
    always begin
        saat = ~saat; #0.5;
    end

    integer passes = 0;
    integer fails = 0;
    
    initial begin
        saat = 0;
        reset = 0;
        avlanan_balik = 15'b001_001_001_001_111;
        #5;
        if(bitti == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end    
        else begin
            $display("test1 failed, bitti: %d, en_kisa: %d, en_uzun: %d, ortalama: %d, hizli_penguen: %d, yavas_penguen: %d", bitti, en_kisa, en_uzun, ortalama, hizli_penguen, yavas_penguen);
            fails = fails + 1;
        end

        avlanan_balik = 15'b111_111_111_111_000;
        #5;
        if(bitti == 1 && en_kisa == 4 && en_uzun == 9 && ortalama == 8 && hizli_penguen == 1 && yavas_penguen == 5) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end    
        else begin
            $display("test2 failed, bitti: %d, en_kisa: %d, en_uzun: %d, ortalama: %d, hizli_penguen: %d, yavas_penguen: %d", bitti, en_kisa, en_uzun, ortalama, hizli_penguen, yavas_penguen);
            fails = fails + 1;
        end

        reset = 1;
        #2;
        if(bitti == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
         end     
         else begin
             $display("test3 failed, bitti: %d, en_kisa: %d, en_uzun: %d, ortalama: %d, hizli_penguen: %d, yavas_penguen: %d", bitti, en_kisa, en_uzun, ortalama, hizli_penguen, yavas_penguen);
             fails = fails + 1;
         end

        reset = 0;
        avlanan_balik = 15'b111_111_111_111_111;
        #20;
        if(bitti == 1 && en_kisa == 4 && en_uzun == 4 && ortalama == 4 && hizli_penguen == 5 && yavas_penguen == 5) begin
           $display("TEST4 PASSED");
           passes = passes + 1;
        end     
        else begin
            $display("test4 failed, bitti: %d, en_kisa: %d, en_uzun: %d, ortalama: %d, hizli_penguen: %d, yavas_penguen: %d", bitti, en_kisa, en_uzun, ortalama, hizli_penguen, yavas_penguen);
            fails = fails + 1;
        end

        reset = 1;
        #2;
        reset = 0;
        avlanan_balik = 15'b001_111_101_011_011;
        #5;
        avlanan_balik = 15'b111_011_111_011_011;
        #1500;
        if(bitti == 1 && en_kisa == 4 && en_uzun == 12 && ortalama == 8 && hizli_penguen == 4 && yavas_penguen == 2) begin
           $display("TEST5 PASSED");
           passes = passes + 1;
        end
        else begin
            $display("test5 failed, bitti: %d, en_kisa: %d, en_uzun: %d, ortalama: %d, hizli_penguen: %d, yavas_penguen: %d", bitti, en_kisa, en_uzun, ortalama, hizli_penguen, yavas_penguen);
            fails = fails + 1;
        end

        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");

        $finish;
    end
    
endmodule
