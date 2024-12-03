`timescale 1ns / 1ps

module tb_havalimani(

    );
    localparam BIT = 6;
    
    reg saat;
    reg reset;
    reg [BIT-1:0] kimlik_no;
    reg uyruk;
    reg [5:0] agirlik;
    reg [8:0] bakiye;
    wire kalkis;
    wire [8:0] k_bakiye;
    
    havalimani #(.BIT(BIT)) havalimani_dut(
        .saat(saat),
        .reset(reset),
        .kimlik_no(kimlik_no),
        .uyruk(uyruk),
        .agirlik(agirlik),
        .bakiye(bakiye),
        .kalkis(kalkis),
        .k_bakiye(k_bakiye)
    );
    
    always begin
        saat = ~saat; #0.5;
    end
    
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        saat = 0;
        reset = 0;
        
        kimlik_no = 'b000111; uyruk = 0; agirlik = 50; bakiye = 100; #4;
        
        if(kalkis == 0 && k_bakiye == 55) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        kimlik_no = 'b110111; uyruk = 1; agirlik = 61; bakiye = 213; #4;
        
        if(kalkis == 0 && k_bakiye == 27) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        kimlik_no = 'b001000; uyruk = 1; agirlik = 14; bakiye = 200; #16;
        
        if(kalkis == 0 && k_bakiye == 155) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        kimlik_no = 'b101011; uyruk = 1; agirlik = 14; bakiye = 102; #20;
        
        if(kalkis == 0 && k_bakiye == 93) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        kimlik_no = 'b100000; uyruk = 0; agirlik = 49; bakiye = 78; #4;
        
        if(kalkis == 0 && k_bakiye == 33) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        kimlik_no = 'b010111; uyruk = 1; agirlik = 49; bakiye = 78; #8;
        
        if(kalkis == 0 && k_bakiye == 78) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        kimlik_no = 'b000011; uyruk = 0; agirlik = 14; bakiye = 100; #4;
        
        if(kalkis == 0 && k_bakiye == 55) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        // soruda kimlik gecerli girisi bavul modulune verilmemis
        // gercek hayata uymuyor, mantik olarak hatali ama soru hatali degil
        // o yuzden bunlar bavul modulundeki toplam yuke eklense ve 
        // sonrakilerin fiyatlarini degistirse bile kalkis icin etkisi olmamali
        kimlik_no = 'b000011; uyruk = 1; agirlik = 14; bakiye = 100; #200;
        
        kimlik_no = 'b111011; uyruk = 0; agirlik = 40; bakiye = 100; #192;
        
        if(kalkis == 0 && k_bakiye == 20) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        kimlik_no = 'b000111; uyruk = 0; agirlik = 45; bakiye = 102; #4;
        
        if(kalkis == 1 && k_bakiye == 1) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        kimlik_no = 'b000001; uyruk = 0; agirlik = 45; bakiye = 102; #52;
        kimlik_no = 'b111111; uyruk = 0; agirlik = 45; bakiye = 102; #4;
        kimlik_no = 'b000001; uyruk = 0; agirlik = 45; bakiye = 102; #52;
        kimlik_no = 'b111111; uyruk = 0; agirlik = 45; bakiye = 102; #4;
        
        if(kalkis == 1 && k_bakiye == 1) begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
