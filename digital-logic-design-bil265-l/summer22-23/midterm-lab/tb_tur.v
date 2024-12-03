`timescale 1ns / 1ps

module tb_tur(

    );
    
    reg [1:0] X1;
    reg [1:0] Y1;
    reg [1:0] X2;
    reg [1:0] Y2;
    wire B;
    
    tur tur_dut(.X1(X1), .Y1(Y1), .X2(X2), .Y2(Y2), .B(B));
    
    reg [1:0] Xans [15:0];
    reg [1:0] Yans [15:0];
    reg [1:0] Pans [15:0];
    
    integer i;
    integer j;
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
            X1 = Xans[i]; Y1 = Yans[i];
            for(j=0; j<16; j=j+1) begin
                X2 = Xans[j]; Y2 = Yans[j]; #1;
                if((Pans[i] + Pans[j] >= 5) == B) begin
                    passes = passes + 1;
                end
                else begin
                    fails = fails + 1;
                end
            end
        end
        
        $display("%d passes, %d fails\n", passes, fails);
        
        if(passes == 256) $display("ALL PASSED!\n");
        if(fails  == 256) $display("all failed!\n");
        
        $finish;
    end
    
endmodule
