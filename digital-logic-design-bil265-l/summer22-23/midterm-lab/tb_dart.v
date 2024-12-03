`timescale 1ns / 1ps

module tb_dart(

    );
    
    reg  [1:0] X;
    reg  [1:0] Y;
    wire [1:0] P;
    
    dart dart_dut(.X(X), .Y(Y), .P(P));
    
    reg [1:0] Xans [15:0];
    reg [1:0] Yans [15:0];
    reg [1:0] Pans [15:0];
    
    integer i;
    integer passes = 0;
    integer fails = 0;
    
    initial begin
        
        Xans[0 ] = 0; Yans[0 ] = 0; Pans[0 ] = 0;
        Xans[1 ] = 0; Yans[1 ] = 1; Pans[1 ] = 0;
        Xans[2 ] = 0; Yans[2 ] = 2; Pans[2 ] = 0;
        Xans[3 ] = 0; Yans[3 ] = 3; Pans[3 ] = 0;
        Xans[4 ] = 1; Yans[4 ] = 0; Pans[4 ] = 0;
        Xans[5 ] = 1; Yans[5 ] = 1; Pans[5 ] = 1;
        Xans[6 ] = 1; Yans[6 ] = 2; Pans[6 ] = 2;
        Xans[7 ] = 1; Yans[7 ] = 3; Pans[7 ] = 1;
        Xans[8 ] = 2; Yans[8 ] = 0; Pans[8 ] = 0;
        Xans[9 ] = 2; Yans[9 ] = 1; Pans[9 ] = 2;
        Xans[10] = 2; Yans[10] = 2; Pans[10] = 3;
        Xans[11] = 2; Yans[11] = 3; Pans[11] = 2;
        Xans[12] = 3; Yans[12] = 0; Pans[12] = 0;
        Xans[13] = 3; Yans[13] = 1; Pans[13] = 1;
        Xans[14] = 3; Yans[14] = 2; Pans[14] = 2;
        Xans[15] = 3; Yans[15] = 3; Pans[15] = 1;
        
        for(i=0; i<16; i=i+1) begin
            X = Xans[i]; Y = Yans[i]; #1;
            if(P == Pans[i]) begin
                $display("passed! X: %d, Y: %d, P: %d", X, Y, P);
                passes = passes + 1;
            end
            else begin
                $display("FAILED! X: %d, Y: %d, P: %d", X, Y, P);
                fails = fails + 1;
            end
        end
        
        $display("\n%d passes, %d fails\n", passes, fails);
        
        if(passes == 16) $display("ALL PASSED!\n");
        if(fails  == 16) $display("all failed!\n");
        
        $finish;
    end
    
endmodule

