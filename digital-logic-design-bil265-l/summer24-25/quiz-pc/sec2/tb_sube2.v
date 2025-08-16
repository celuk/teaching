`timescale 1ns / 1ps

module tb_sube2(

    );

    reg A;
    reg B;
    reg C;

    wire [1:0] F;

    sube2 sube2_dut(
        .A(A),
        .B(B),
        .C(C),
        .F(F)
    );

    integer passes = 0;
    integer fails = 0;

    initial begin
        A = 0; B = 0; C = 0; #1;
        if(F == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, F: %d", F);
            fails = fails + 1;
        end

        A = 0; B = 0; C = 1; #1;
        if(F == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, F: %d", F);
            fails = fails + 1;
        end

        A = 0; B = 1; C = 0; #1;
        if(F == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, F: %d", F);
            fails = fails + 1;
        end

        A = 0; B = 1; C = 1; #1;
        if(F == 0) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, F: %d", F);
            fails = fails + 1;
        end

        A = 1; B = 0; C = 0; #1;
        if(F == 0) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, F: %d", F);
            fails = fails + 1;
        end

        A = 1; B = 0; C = 1; #1;
        if(F == 1) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, F: %d", F);
            fails = fails + 1;
        end

        A = 1; B = 1; C = 0; #1;
        if(F == 3) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, F: %d", F);
            fails = fails + 1;
        end

        A = 1; B = 1; C = 1; #1;
        if(F == 0) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, F: %d", F);
            fails = fails + 1;
        end

        $display("\n%d passes, %d fails\n", passes, fails);

        if(passes == 8) $display("ALL PASSED!\n");
        if(fails  == 8) $display("all failed!\n");

        $finish;
    end
endmodule
