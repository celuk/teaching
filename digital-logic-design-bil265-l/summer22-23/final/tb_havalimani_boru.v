`timescale 1ns / 1ps

module tb_havalimani_boru(

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
    
    havalimani_boru #(.BIT(BIT)) havalimani_dut(
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
        
        kimlik_no = 'b000111; uyruk = 0; agirlik = 11; bakiye = 500; #52;
        
        if(kalkis == 0 && k_bakiye == 494) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        kimlik_no = 'b000111; uyruk = 0; agirlik = 11; bakiye = 500; #1;
        
        if(kalkis == 1 && k_bakiye == 494) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        kimlik_no = 'b000000; uyruk = 1; agirlik = 11; bakiye = 100; #400;
        
        if(kalkis == 0 && k_bakiye == 94) begin
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
        
        kimlik_no = 'b101011; uyruk = 1; agirlik = 14; bakiye = 102; #1;
        kimlik_no = 'b101011; uyruk = 1; agirlik = 14; bakiye = 107; #1;
        kimlik_no = 'b101011; uyruk = 1; agirlik = 14; bakiye = 104; #1;
        kimlik_no = 'b101011; uyruk = 1; agirlik = 14; bakiye = 106; #1;
        
        if(kalkis == 0 && k_bakiye == 57) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        kimlik_no = 'b000000; uyruk = 0; agirlik = 14; bakiye = 105; #50;
        kimlik_no = 'b111111; uyruk = 1; agirlik = 14; bakiye = 105; #50;
        kimlik_no = 'b100000; uyruk = 0; agirlik = 49; bakiye = 261; #4;
        kimlik_no = 'b100000; uyruk = 0; agirlik = 49; bakiye = 78; #3;
        
        if(kalkis == 0 && k_bakiye == 141) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        kimlik_no = 'b111011; uyruk = 0; agirlik = 14; bakiye = 105; #3;
        
        if(kalkis == 0 && k_bakiye == 78) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        kimlik_no = 'b111011; uyruk = 0; agirlik = 14; bakiye = 105; #37;
        
        if(kalkis == 0 && k_bakiye == 96) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        kimlik_no = 'b111011; uyruk = 0; agirlik = 10; bakiye = 105; #4;
        
        if(kalkis == 0 && k_bakiye == 100) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        kimlik_no = 'b111011; uyruk = 0; agirlik = 14; bakiye = 105; #1;
        
        if(kalkis == 1 && k_bakiye == 100) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, kalkis: %d, k_bakiye: %d", kalkis, k_bakiye);
            fails = fails + 1;
        end
        
        kimlik_no = 'b111011; uyruk = 0; agirlik = 13; bakiye = 105; #56;
        
        if(kalkis == 1 && k_bakiye == 97) begin
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
