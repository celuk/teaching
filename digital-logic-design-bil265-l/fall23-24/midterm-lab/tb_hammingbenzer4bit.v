`timescale 1ns / 1ps

module tb_hammingbenzer4bit(

    );
    
    reg  [3:0] A;
    reg  [3:0] B;
    wire [2:0] HB;
    
    hammingbenzer4bit hammingbenzer4bit_dut(
        .A(A), 
        .B(B), 
        .HB(HB)
    );
    
    wire X = A[3] ~^ B[3];
    wire Y = A[2] ~^ B[2];
    wire Z = A[1] ~^ B[1];
    wire T = A[0] ~^ B[0];
    
    integer i;
    integer j;
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        for(i=0; i<16; i=i+1) begin
            A = i;
            for(j=0; j<16; j=j+1) begin
                B = j; #1;
                if((X+Y+Z+T) == HB) begin
                    //$display("passed! A: %b, B: %b, HB: %d", A, B, HB);
                    passes = passes + 1;
                end
                else begin
                    $display("FAILED! A: %b, B: %b, HB: %d", A, B, HB);
                    fails = fails + 1;
                end
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 256) $display("ALL PASSED!\n");
        if(fails  == 256) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
