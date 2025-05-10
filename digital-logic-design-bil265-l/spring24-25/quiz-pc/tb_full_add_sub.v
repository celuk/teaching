`timescale 1ns / 1ps

module tb_full_add_sub(

    );

reg a;
reg b;
reg carry_in;

wire result;

full_add_sub full_add_sub_dut(
    .a(a),
    .b(b),
    .carry_in(carry_in),
    .result(result),
    .carry_out(carry_out)
);

integer passes = 0;
integer fails = 0;

initial begin
    carry_in = 0; a = 0; b = 0; #1;
    if(carry_out == 0 && result == 0) begin
        $display("TEST1 PASSED");
        passes = passes + 1;
    end
    else begin
        $display("test1 failed, carry_out: %b, result: %b", carry_out, result);
        fails = fails + 1;
    end

    carry_in = 0; a = 0; b = 1; #1;
    if(carry_out == 0 && result == 1) begin
        $display("TEST2 PASSED");
        passes = passes + 1;
    end
    else begin
        $display("test2 failed, carry_out: %b, result: %b", carry_out, result);
        fails = fails + 1;
    end

    carry_in = 0; a = 1; b = 0; #1;
    if(carry_out == 0 && result == 1) begin
        $display("TEST3 PASSED");
        passes = passes + 1;
    end
    else begin
        $display("test3 failed, carry_out: %b, result: %b", carry_out, result);
        fails = fails + 1;
    end

    carry_in = 0; a = 1; b = 1; #1;
    if(carry_out == 1 && result == 0) begin
        $display("TEST4 PASSED");
        passes = passes + 1;
    end
    else begin
        $display("test4 failed, carry_out: %b, result: %b", carry_out, result);
        fails = fails + 1;
    end

    carry_in = 1; a = 0; b = 0; #1;
    if(result == 0) begin
        $display("TEST5 PASSED");
        passes = passes + 1;
    end
    else begin
        $display("test5 failed, carry_out: %b, result: %b", carry_out, result);
        fails = fails + 1;
    end

    carry_in = 1; a = 0; b = 1; #1;
    if(carry_out == 0 && result == 1) begin
        $display("TEST6 PASSED");
        passes = passes + 1;
    end
    else begin
        $display("test6 failed, carry_out: %b, result: %b", carry_out, result);
        fails = fails + 1;
    end

    carry_in = 1; a = 1; b = 0; #1;
    if(carry_out == 1 && result == 1) begin
        $display("TEST7 PASSED");
        passes = passes + 1;
    end
    else begin
        $display("test7 failed, carry_out: %b, result: %b", carry_out, result);
        fails = fails + 1;
    end

    carry_in = 1; a = 1; b = 1; #1;
    if(result == 0) begin
        $display("TEST8 PASSED");
        passes = passes + 1;
    end
    else begin
        $display("test8 failed, carry_out: %b, result: %b", carry_out, result);
        fails = fails + 1;
    end

    $display("\n%d passes, %d fails\n", passes, fails);
        
    if(passes == 8) $display("ALL PASSED!\n");
    if(fails  == 8) $display("all failed!\n");
    
    $finish;
end

endmodule
