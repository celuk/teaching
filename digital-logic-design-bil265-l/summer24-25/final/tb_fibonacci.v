`timescale 1ns / 1ps

module tb_jk(

    );

    reg saat;
    reg reset;
    wire [3:0] Q;

    fibonacci fibonacci_dut(
        .saat(saat),
        .reset(reset),
        .Q(Q)
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

        if(Q == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, Q: %d", Q);
            fails = fails + 1;
        end

        #1;

        if(Q == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, Q: %d", Q);
            fails = fails + 1;
        end
        
        #1;

        if(Q == 1) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, Q: %d", Q);
            fails = fails + 1;
        end

        #1;

        if(Q == 2) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, Q: %d", Q);
            fails = fails + 1;
        end

        #1;

        if(Q == 3) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, Q: %d", Q);
            fails = fails + 1;
        end

        #1;

        if(Q == 5) begin
            $display("TEST6 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test6 failed, Q: %d", Q);
            fails = fails + 1;
        end

        #1;

        if(Q == 8) begin
            $display("TEST7 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test7 failed, Q: %d", Q);
            fails = fails + 1;
        end

        #1;

        if(Q == 13) begin
            $display("TEST8 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test8 failed, Q: %d", Q);
            fails = fails + 1;
        end

        #1;

        if(Q == 0) begin
            $display("TEST9 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test9 failed, Q: %d", Q);
            fails = fails + 1;
        end

        #54;
        if(Q == 8) begin
            $display("TEST10 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test10 failed, Q: %d", Q);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 10) $display("ALL PASSED!\n");
        if(fails  == 10) $display("all failed!\n");
        
        $finish;
    end
endmodule
