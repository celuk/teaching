`timescale 1ns / 1ps

module tb_alarm(

    );

    localparam C=0;
    reg saat;
    reg reset;
    reg [6:0] sicaklik;
    wire [2*C+6:0] ortalama_sicaklik;
    wire alarm_cal;
    alarm #(C) alarm_celcius (
        .saat(saat),
        .reset(reset),
        .sicaklik(sicaklik),
        .ortalama_sicaklik(ortalama_sicaklik),
        .alarm_cal(alarm_cal)
    );

    localparam K=1;
    wire [2*K+6:0] ortalama_sicaklik_k;
    wire alarm_cal_k;
    alarm #(K) alarm_kelvin (
        .saat(saat),
        .reset(reset),
        .sicaklik(sicaklik),
        .ortalama_sicaklik(ortalama_sicaklik_k),
        .alarm_cal(alarm_cal_k)
    );

    always begin
        #0.5 saat = ~saat;
    end

    integer passes = 0;
    integer fails = 0;

    initial begin
        saat = 0;
        reset = 1;
        #1;
        reset = 0;

        // alarm_esigi = 51 (0110011) icin
        sicaklik = 32; #1;
        sicaklik = 45; #1;
        sicaklik = 39; #1;
        sicaklik = 48; #1;
        if(ortalama_sicaklik == 41 && alarm_cal == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, ortalama_sicaklik: %d, alarm_cal: %d", ortalama_sicaklik, alarm_cal);
            fails = fails + 1;
        end

        sicaklik = 70; #1;
        if(ortalama_sicaklik == 50 && alarm_cal == 0) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, ortalama_sicaklik: %d, alarm_cal: %d", ortalama_sicaklik, alarm_cal);
            fails = fails + 1;
        end

        sicaklik = 55; #1;
        if(ortalama_sicaklik == 53 && alarm_cal == 1) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, ortalama_sicaklik: %d, alarm_cal: %d", ortalama_sicaklik, alarm_cal);
            fails = fails + 1;
        end
        sicaklik = 0; #1;
        if(ortalama_sicaklik == 43 && alarm_cal == 0) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, ortalama_sicaklik: %d, alarm_cal: %d", ortalama_sicaklik, alarm_cal);
            fails = fails + 1;
        end

        sicaklik = 32; #1;
        sicaklik = 45; #1;
        sicaklik = 39; #1;
        sicaklik = 48; #1;
        sicaklik = 70; #1;
        sicaklik = 55; #1;
        sicaklik = 0;  #1;
        if(ortalama_sicaklik_k == 316 && alarm_cal_k == 0) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, ortalama_sicaklik: %d, alarm_cal: %d", ortalama_sicaklik_k, alarm_cal_k);
            fails = fails + 1;
        end

        reset = 1;
        #41;
        reset = 0;

        sicaklik = 15; #1;
        sicaklik = 88; #1;
        sicaklik = 43; #1;
        sicaklik = 67; #1;
        sicaklik = 12; #1;
        if(ortalama_sicaklik == 52 && alarm_cal == 1) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, ortalama_sicaklik: %d, alarm_cal: %d", ortalama_sicaklik, alarm_cal);
            fails = fails + 1;
        end

        sicaklik = 10; #1;
        sicaklik = 12; #1;
        if(ortalama_sicaklik == 25 && alarm_cal == 0) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, ortalama_sicaklik: %d, alarm_cal: %d", ortalama_sicaklik, alarm_cal);
            fails = fails + 1;
        end

        sicaklik = 127; #1;
        sicaklik = 125; #1;
        sicaklik = 123; #1;
        sicaklik = 120; #1;
        sicaklik = 124; #1;
        sicaklik = 126; #1;
        sicaklik = 64; #1;
        sicaklik = 32; #1;
        if(ortalama_sicaklik == 86 && alarm_cal == 1) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, ortalama_sicaklik: %d, alarm_cal: %d", ortalama_sicaklik, alarm_cal);
            fails = fails + 1;
        end

        sicaklik = 0; #1;
        sicaklik = 0; #1;
        sicaklik = 0; #1;
        sicaklik = 0; #1;
        if(ortalama_sicaklik == 0 && alarm_cal == 0) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, ortalama_sicaklik: %d, alarm_cal: %d", ortalama_sicaklik, alarm_cal);
            fails = fails + 1;
        end

        sicaklik = 96; #1;
        sicaklik = 48; #1;
        sicaklik = 16; #1;
        sicaklik = 80; #1;
        sicaklik = 20; #1;
        sicaklik = 22; #1;
        sicaklik = 19; #1;
        sicaklik = 18; #1;
        sicaklik = 21; #1;
        sicaklik = 23; #1;
        sicaklik = 127; #1;
        sicaklik = 127; #1;
        sicaklik = 127; #1;
        sicaklik = 127; #1;
        if(ortalama_sicaklik_k == 400 && alarm_cal_k == 1) begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, ortalama_sicaklik: %d, alarm_cal: %d", ortalama_sicaklik_k, alarm_cal_k);
            fails = fails + 1;
        end

        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end

endmodule
