`timescale 1ns / 1ps

module tb_sube1_xor(

    );

    reg X;
    reg Y;

    wire Z;

    sube1_xor sube1_xor_dut(
        .X(X),
        .Y(Y),
        .Z(Z)
    );

    integer passes = 0;
    integer fails = 0;

    initial begin
        X = 0; Y = 0; #1;
        if(Z == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, Z: %b", Z);
            fails = fails + 1;
        end

        X = 0; Y = 1; #1;
        if(Z == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, Z: %b", Z);
            fails = fails + 1;
        end

        X = 1; Y = 0; #1;
        if(Z == 1) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, Z: %b", Z);
            fails = fails + 1;
        end

        X = 1; Y = 1; #1;
        if(Z == 0) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, Z: %b", Z);
            fails = fails + 1;
        end

        $display("\n%d passes, %d fails\n", passes, fails);

        if(passes == 4) $display("ALL PASSED!\n");
        if(fails  == 4) $display("all failed!\n");

        $finish;
    end
endmodule
