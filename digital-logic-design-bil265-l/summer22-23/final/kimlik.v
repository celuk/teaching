`timescale 1ns / 1ps

module kimlik #(parameter BIT = 6)(
    input  saat,
    input  reset,
    input  basla,
    input  [BIT-1:0] kimlik_no,
    input  uyruk,
    output reg gecerli = 0,
    output reg bitti = 0
    );
    
    reg [BIT-1:0] yerli_reg   [9:0];
    reg [BIT-1:0] yabanci_reg [9:0];
    
    initial begin
        $readmemb("yerli.mem", yerli_reg);
        $readmemb("yabanci.mem", yabanci_reg);
    end
    
    reg gecerli_sonraki = 0;
    reg bitti_sonraki = 0;
    
    integer i;
    
    always @* begin
        gecerli_sonraki = 0;
        bitti_sonraki   = 0;
    
        if(basla) begin
            for(i = 0; i < 10; i = i + 1) begin
                if(uyruk) begin
                    if(kimlik_no == yabanci_reg[i]) begin
                        gecerli_sonraki = 1;
                    end
                end
                else begin
                    if(kimlik_no == yerli_reg[i]) begin
                        gecerli_sonraki = 1;
                    end
                end
            end
        
            bitti_sonraki = 1;
        end
    end
    
    always @(posedge saat) begin
        if(reset) begin
            gecerli <= 0;
            bitti   <= 0;
        end
        else begin
            gecerli <= gecerli_sonraki;
            bitti   <= bitti_sonraki;
        end
    end
    
endmodule

