`timescale 1ns / 1ps

module tb_sandik(

    );
    
    reg [1:0] T;
    reg [1:0] H;
    wire S;
    
    sandik sandik_dut(
        .T(T),
        .H(H),
        .S(S)
    );
    
    reg [1:0] T_ans [15:0];
    reg [1:0] H_ans [15:0];
    reg S_ans [15:0];
    
    integer i;
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        T_ans[0 ] = 2'b00; H_ans[0 ] = 2'b00; S_ans[0 ] = 1'b1;
        T_ans[1 ] = 2'b00; H_ans[1 ] = 2'b01; S_ans[1 ] = 1'b0;
        T_ans[2 ] = 2'b00; H_ans[2 ] = 2'b10; S_ans[2 ] = 1'b0;
        T_ans[3 ] = 2'b00; H_ans[3 ] = 2'b11; S_ans[3 ] = 1'b0;
        T_ans[4 ] = 2'b01; H_ans[4 ] = 2'b00; S_ans[4 ] = 1'b1;
        T_ans[5 ] = 2'b01; H_ans[5 ] = 2'b01; S_ans[5 ] = 1'b1;
        T_ans[6 ] = 2'b01; H_ans[6 ] = 2'b10; S_ans[6 ] = 1'b1;
        T_ans[7 ] = 2'b01; H_ans[7 ] = 2'b11; S_ans[7 ] = 1'b0;
        T_ans[8 ] = 2'b10; H_ans[8 ] = 2'b00; S_ans[8 ] = 1'b1;
        T_ans[9 ] = 2'b10; H_ans[9 ] = 2'b01; S_ans[9 ] = 1'b1;
        T_ans[10] = 2'b10; H_ans[10] = 2'b10; S_ans[10] = 1'b1;
        T_ans[11] = 2'b10; H_ans[11] = 2'b11; S_ans[11] = 1'b0;
        T_ans[12] = 2'b11; H_ans[12] = 2'b00; S_ans[12] = 1'b1;
        T_ans[13] = 2'b11; H_ans[13] = 2'b01; S_ans[13] = 1'b1;
        T_ans[14] = 2'b11; H_ans[14] = 2'b10; S_ans[14] = 1'b1;
        T_ans[15] = 2'b11; H_ans[15] = 2'b11; S_ans[15] = 1'b1;
    
        for(i=0; i<16; i=i+1) begin
            T = T_ans[i]; H = H_ans[i]; #1;
            if(S == S_ans[i]) begin
                passes = passes + 1;
            end
            else begin
                fails = fails + 1;
                $display("test%d failed, S: %d", (i+1), S);
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 16) $display("ALL PASSED!\n");
        if(fails  == 16) $display("all failed!\n");
    end
    
endmodule
