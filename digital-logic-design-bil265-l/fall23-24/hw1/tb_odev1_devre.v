`timescale 1ns / 1ps

module tb_odev1_devre(

    );
    
    reg A, B, C;
    wire F, Q;
    
    odev1_devre odev1_devre_dut(.A(A), .B(B), .C(C), .F(F), .Q(Q));
    
    reg A_ans [7:0];
    reg B_ans [7:0];
    reg C_ans [7:0];
    reg F_ans [7:0];
    reg Q_ans [7:0];
    
    integer i;
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        A_ans[0] = 0; B_ans[0] = 0; C_ans[0] = 0; F_ans[0] = 1; Q_ans[0] = 1;
        A_ans[1] = 0; B_ans[1] = 0; C_ans[1] = 1; F_ans[1] = 1; Q_ans[1] = 0;
        A_ans[2] = 0; B_ans[2] = 1; C_ans[2] = 0; F_ans[2] = 1; Q_ans[2] = 1;
        A_ans[3] = 0; B_ans[3] = 1; C_ans[3] = 1; F_ans[3] = 1; Q_ans[3] = 0;
        A_ans[4] = 1; B_ans[4] = 0; C_ans[4] = 0; F_ans[4] = 1; Q_ans[4] = 1;
        A_ans[5] = 1; B_ans[5] = 0; C_ans[5] = 1; F_ans[5] = 1; Q_ans[5] = 0;
        A_ans[6] = 1; B_ans[6] = 1; C_ans[6] = 0; F_ans[6] = 1; Q_ans[6] = 1;
        A_ans[7] = 1; B_ans[7] = 1; C_ans[7] = 1; F_ans[7] = 1; Q_ans[7] = 0;
        
        for(i=0; i<8; i=i+1) begin
            A = A_ans[i]; B = B_ans[i]; C = C_ans[i]; #1;
            
            if(F == F_ans[i]) begin
                passes = passes + 1;
            end
            else begin
                fails = fails + 1;
            end
            
            if(Q == Q_ans[i]) begin
                passes = passes + 1;
            end
            else begin
                fails = fails + 1;
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 16) $display("ALL PASSED!\n");
        if(fails  == 16) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
