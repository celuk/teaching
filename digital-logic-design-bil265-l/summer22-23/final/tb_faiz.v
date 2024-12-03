`timescale 1ns / 1ps

module tb_faiz(

    );
    
    reg saat;
    reg reset;
    reg [3:0] enflasyon;
    wire [5:0] faiz;
    
    faiz faiz_dut(
        .saat(saat),
        .reset(reset),
        .enflasyon(enflasyon),
        .faiz(faiz)
    );
    
    always begin
        saat = ~saat; #0.5;
    end
    
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        saat = 0;
        reset = 0;
        
        enflasyon = 12; #1;
        enflasyon = 10; #1;
        enflasyon = 6;  #1;
        enflasyon = 5;  #1;
        enflasyon = 9;  #1;
        enflasyon = 15; #1;
        
        if(faiz == 33) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, enflasyon: %d, faiz: %d", enflasyon, faiz);
            fails = fails + 1;
        end
        
        reset = 1;
        #55;
        reset = 0;
        
        enflasyon = 1; #1;
        enflasyon = 2; #1;
        enflasyon = 4; #1;
        enflasyon = 3; #1;
        enflasyon = 5; #1;
        enflasyon = 8; #1;
        enflasyon = 15; #1;
        enflasyon = 11; #1;
        enflasyon = 10; #1;
        enflasyon = 14; #1;
        
        if(faiz == 41) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, enflasyon: %d, faiz: %d", enflasyon, faiz);
            fails = fails + 1;
        end
        
        reset = 1;
        #5;
        reset = 0;
        
        enflasyon = 4; #1;
        enflasyon = 4; #1;
        enflasyon = 4; #1;
        enflasyon = 4; #1;
        enflasyon = 4; #1;
        enflasyon = 4; #1;
        enflasyon = 4; #1;
        enflasyon = 4; #1;
        enflasyon = 4; #1;
        enflasyon = 4; #1;
        enflasyon = 4; #1;
        enflasyon = 4; #1;
        enflasyon = 4; #1;
        enflasyon = 4; #1;
        
        if(faiz == 14) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, enflasyon: %d, faiz: %d", enflasyon, faiz);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        enflasyon = 12; #1;
        enflasyon = 5; #1;
        
        if(faiz == 0) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, enflasyon: %d, faiz: %d", enflasyon, faiz);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        enflasyon = 9; #1;
        
        if(faiz == 0) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, enflasyon: %d, faiz: %d", enflasyon, faiz);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        enflasyon = 13; #1;
        enflasyon = 14; #1;
        enflasyon = 15; #1;
        
        if(faiz == 50) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, enflasyon: %d, faiz: %d", enflasyon, faiz);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        enflasyon = 1; #1;
        enflasyon = 2; #1;
        enflasyon = 3; #1;
        enflasyon = 4; #1;
        enflasyon = 5; #1;
        enflasyon = 6; #1;
        enflasyon = 7; #1;
        enflasyon = 8; #1;
        enflasyon = 9; #1;
        enflasyon = 10; #1;
        enflasyon = 11; #1;
        enflasyon = 12; #1;
        enflasyon = 13; #1;
        enflasyon = 14; #1;
        enflasyon = 15; #1;
        
        if(faiz == 50) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, enflasyon: %d, faiz: %d", enflasyon, faiz);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        enflasyon = 15; #1;
        enflasyon = 14; #1;
        enflasyon = 13; #1;
        enflasyon = 12; #1;
        enflasyon = 11; #1;
        enflasyon = 10; #1;
        enflasyon = 9;  #1;
        enflasyon = 8;  #1;
        enflasyon = 7;  #1;
        enflasyon = 6;  #1;
        enflasyon = 5;  #1;
        enflasyon = 4;  #1;
        enflasyon = 3;  #1;
        enflasyon = 2;  #1;
        enflasyon = 1;  #1;
        
        if(faiz == 8) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, enflasyon: %d, faiz: %d", enflasyon, faiz);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        enflasyon = 13; #1;
        enflasyon = 12; #1;
        enflasyon = 11; #1;
        enflasyon = 3;  #1;
        enflasyon = 2;  #1;
        enflasyon = 15; #1;
        enflasyon = 14; #1;
        enflasyon = 1;  #1;
        
        if(faiz == 34) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, enflasyon: %d, faiz: %d", enflasyon, faiz);
            fails = fails + 1;
        end
        
        reset = 1;
        #1;
        reset = 0;
        
        enflasyon = 15; #1;
        enflasyon = 15; #1;
        enflasyon = 14; #1;
        enflasyon = 10;  #1;
        enflasyon = 2;  #1;
        enflasyon = 15; #1;
        enflasyon = 5;  #1;
        
        if(faiz == 25) begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, enflasyon: %d, faiz: %d", enflasyon, faiz);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end
endmodule
