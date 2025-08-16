`timescale 1ns / 1ps

module tb_ffli_devre(

    );

    reg saat;
    reg reset;
    reg A;
    reg B;
    wire C;
    wire D;
    wire E;

    ffli_devre ffli_devre_dut(
        .saat(saat),
        .reset(reset),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .E(E)
    );

    always begin
        saat = ~saat; #0.5;
    end
    
    integer passes = 0;
    integer fails = 0;

    initial begin
        saat = 0;
        reset = 1;
        #1;
        reset = 0;

        A = 0; B = 0; #1;

        if(C == 0 && D == 1 && E == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, A: %b, B: %b, C: %b, D: %b, E: %b", A, B, C, D, E);
            fails = fails + 1;
        end
        
        reset = 1;
        #40;
        reset = 0;

        A = 0; B = 1; #11;

        if(C == 0 && D == 0 && E == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, A: %b, B: %b, C: %b, D: %b, E: %b", A, B, C, D, E);
            fails = fails + 1;
        end

        A = 1; B = 0; #23;

        if(C == 1 && D == 0 && E == 1) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, A: %b, B: %b, C: %b, D: %b, E: %b", A, B, C, D, E);
            fails = fails + 1;
        end

        A = 1; B = 1; #42;

        if(C == 0 && D == 1 && E == 1) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, A: %b, B: %b, C: %b, D: %b, E: %b", A, B, C, D, E);
            fails = fails + 1;
        end

        A = 0; B = 0; #1;

        if(C == 1 && D == 1 && E == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, A: %b, B: %b, C: %b, D: %b, E: %b", A, B, C, D, E);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");
        
        $finish;
    end
endmodule
