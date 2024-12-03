`timescale 1ns / 1ps

module tb_ons(

    );
    reg [5:0]  X;
    wire [10:0] Y;
    
    ons ons_dut(.X(X), .Y(Y));
    
    integer i;
    
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        for(i=1; i<=40; i=i+1) begin
            X = i; #1;
            if(Y == (i*28 + ((i % 2 == 1) ? (i+1)/2 : i/2))) begin
                passes = passes + 1;
            end
            else begin
                fails = fails + 1;
            end
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 40) $display("ALL PASSED!\n");
        if(fails  == 40) $display("all failed!\n");
    end
    
endmodule
