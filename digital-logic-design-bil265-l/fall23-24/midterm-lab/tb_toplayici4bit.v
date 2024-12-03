`timescale 1ns / 1ps

module tb_toplayici4bit(

    );
    
    reg  [3:0] A;
    reg  [3:0] B;
    reg  Cin;
    wire [3:0] S;
    wire Cout;
    
    toplayici4bit toplayici4bit_dut(
        .A(A), 
        .B(B), 
        .Cin(Cin), 
        .S(S), 
        .Cout(Cout)
    );
    
    integer i;
    integer j;
    integer k;
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        for(i=0; i<16; i=i+1) begin
            A = i;
            for(j=0; j<16; j=j+1) begin
                B = j;
                for(k=0; k<2; k=k+1) begin
                    Cin = k; #1;
                    if((A+B+Cin) == {Cout, S}) begin
                        $display("passed! A: %b, B: %b, Cout: %d, S: %d", A, B, Cout, S);
                        passes = passes + 1;
                    end
                    else begin
                        $display("FAILED! A: %b, B: %b, Cout: %d, S: %d", A, B, Cout, S);
                        fails = fails + 1;
                    end
                end
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 512) $display("ALL PASSED!\n");
        if(fails  == 512) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
