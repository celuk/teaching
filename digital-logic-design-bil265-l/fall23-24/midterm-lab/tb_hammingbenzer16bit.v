`timescale 1ns / 1ps

module tb_hammingbenzer16bit(

    );
    
    reg  [15:0] A;
    reg  [15:0] B;
    wire [4:0] HB;
    
    hammingbenzer16bit hammingbenzer16bit_dut(
        .A(A), 
        .B(B), 
        .HB(HB)
    );
    
    wire [15:0] HBw;
    assign HBw[0 ] = A[0 ] ~^ B[0 ];
    assign HBw[1 ] = A[1 ] ~^ B[1 ];
    assign HBw[2 ] = A[2 ] ~^ B[2 ];
    assign HBw[3 ] = A[3 ] ~^ B[3 ];
    assign HBw[4 ] = A[4 ] ~^ B[4 ];
    assign HBw[5 ] = A[5 ] ~^ B[5 ];
    assign HBw[6 ] = A[6 ] ~^ B[6 ];
    assign HBw[7 ] = A[7 ] ~^ B[7 ];
    assign HBw[8 ] = A[8 ] ~^ B[8 ];
    assign HBw[9 ] = A[9 ] ~^ B[9 ];
    assign HBw[10] = A[10] ~^ B[10];
    assign HBw[11] = A[11] ~^ B[11];
    assign HBw[12] = A[12] ~^ B[12];
    assign HBw[13] = A[13] ~^ B[13];
    assign HBw[14] = A[14] ~^ B[14];
    assign HBw[15] = A[15] ~^ B[15];
    
    reg [4:0] HBtotal = 0;
    
    integer i;
    integer j;
    integer k;
    reg [32:0] passes = 0;
    reg [32:0] fails = 0;
    
    initial begin
        // tum degerleri test etmek icin i ve j adim sayilarini 1 yapabilirsiniz
        for(i=0; i<65536; i=i+100) begin
            A = i;
            for(j=0; j<65536; j=j+111) begin
                B = j; #0.1;
                
                for(k=0; k<16; k=k+1) begin
                    HBtotal = HBtotal + HBw[k];
                end
                
                if(HBtotal == HB) begin
                    //$display("passed! A: %b, B: %b, HB: %d", A, B, HB);
                    passes = passes + 1;
                end
                else begin
                    //$display("FAILED! A: %b, B: %b, HB: %d", A, B, HB);
                    fails = fails + 1;
                end
                
                HBtotal = 0;
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 387696) $display("ALL PASSED!\n");
        if(fails  == 387696) $display("all failed!\n");
        
        // eger tum degerler test ediliyorsa
        //if(passes == 33'b100000000000000000000000000000000) $display("ALL PASSED!\n");
        //if(fails  == 33'b100000000000000000000000000000000) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
