`timescale 1ns / 1ps

module tb_durum(

    );

    reg saat;
    reg reset;
    reg giris;
    wire cikis;

    durum durum_dut(
        .saat(saat),
        .reset(reset),
        .giris(giris),
        .cikis(cikis)
    );

    always begin
        saat = ~saat; #0.5;
    end
    
    integer corrects = 0;
    integer total_corrects = 0;
    
    integer passes = 0;
    integer fails = 0;

    initial begin
        saat = 0;
        reset = 1;
        #1;
        reset = 0;
        
        corrects = 0;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        total_corrects = total_corrects + corrects;
        
        if(cikis == 1 && corrects == 9) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, giris: %d, cikis: %d, %d corrects but should be 9", giris, cikis, corrects);
            fails = fails + 1;
        end
        
        reset = 1;
        #40;
        reset = 0;

        corrects = 0;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 1) corrects = corrects + 1;
        total_corrects = total_corrects + corrects;
        
        if(cikis == 1 && corrects == 8) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, giris: %d, cikis: %d, %d corrects but should be 8", giris, cikis, corrects);
            fails = fails + 1;
        end
        
        corrects = 0;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 0; #57; if(cikis == 0) corrects = corrects + 1;
        total_corrects = total_corrects + corrects;
        
        if(cikis == 0 && corrects == 8) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, giris: %d, cikis: %d, %d corrects but should be 8", giris, cikis, corrects);
            fails = fails + 1;
        end
        
        corrects = 0;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 0; #1; if(cikis == 0) corrects = corrects + 1;
        total_corrects = total_corrects + corrects;
        
        if(cikis == 0 && corrects == 12) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, giris: %d, cikis: %d, %d corrects but should be 12", giris, cikis, corrects);
            fails = fails + 1;
        end
        
        corrects = 0;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        giris = 1; #1; if(cikis == 1) corrects = corrects + 1;
        total_corrects = total_corrects + corrects;
        
        if(cikis == 1 && corrects == 13) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, giris: %d, cikis: %d, %d corrects but should be 13", giris, cikis, corrects);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails, %d corrects\n", passes, fails, total_corrects);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");
        
        $finish;        
    end

endmodule
