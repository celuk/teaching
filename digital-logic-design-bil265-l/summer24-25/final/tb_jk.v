`timescale 1ns / 1ps

module tb_jk(

    );

    reg saat;
    reg reset;
    reg J;
    reg K;
    wire Q;
    wire QN;

    jk jk_dut(
        .saat(saat),
        .reset(reset),
        .J(J),
        .K(K),
        .Q(Q),
        .QN(QN)
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

        J = 0; K = 0; #1;
        J = 0; K = 0; #1;
        J = 0; K = 1; #1;
        J = 1; K = 0; #1;
        J = 1; K = 1; #1;
        J = 0; K = 0; #1;
        J = 1; K = 0; #1;

        if(Q == 1 && QN == 0) begin
            $display("TEST1 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test1 failed, J: %b, K: %b, Q: %b, QN: %b", J, K, Q, QN);
            fails = fails + 1;
        end
        
        reset = 1;
        #40;
        reset = 0;

        J = 0; K = 1; #11;
        J = 0; K = 0; #1;

        if(Q == 0 && QN == 1) begin
            $display("TEST2 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test2 failed, J: %b, K: %b, Q: %b, QN: %b", J, K, Q, QN);
            fails = fails + 1;
        end

        J = 1; K = 0; #23;
        J = 0; K = 1; #5;
        J = 1; K = 1; #5;
        J = 0; K = 0; #1;
        J = 1; K = 0; #5;
        J = 0; K = 1; #5;
        J = 1; K = 1; #1;
        J = 0; K = 0; #1;

        if(Q == 1 && QN == 0) begin
            $display("TEST3 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test3 failed, J: %b, K: %b, Q: %b, QN: %b", J, K, Q, QN);
            fails = fails + 1;
        end

        J = 1; K = 1; #42;
        J = 0; K = 0; #1;

        if(Q == 1 && QN == 0) begin
            $display("TEST4 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test4 failed, J: %b, K: %b, Q: %b, QN: %b", J, K, Q, QN);
            fails = fails + 1;
        end

        J = 0; K = 0; #1;
        J = 1; K = 0; #5;
        J = 0; K = 1; #5;
        J = 1; K = 1; #1;
        J = 0; K = 0; #1;
        J = 1; K = 0; #5;
        J = 0; K = 1; #5;
        J = 1; K = 1; #1;
        J = 0; K = 0; #1;
        J = 1; K = 0; #5;
        J = 0; K = 1; #5;
        J = 1; K = 1; #1;
        J = 0; K = 0; #1;
        J = 1; K = 0; #5;
        J = 0; K = 1; #5;
        J = 1; K = 1; #1;
        J = 0; K = 0; #1;
        J = 1; K = 1; #5;

        if(Q == 0 && QN == 1) begin
            $display("TEST5 PASSED");
            passes = passes + 1;
        end
        else begin
            $display("test5 failed, J: %b, K: %b, Q: %b, QN: %b", J, K, Q, QN);
            fails = fails + 1;
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 5) $display("ALL PASSED!\n");
        if(fails  == 5) $display("all failed!\n");
        
        $finish;
    end
endmodule
