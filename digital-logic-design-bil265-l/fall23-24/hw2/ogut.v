`timescale 1ns / 1ps

module ogut(
    input saat,
    input reset,
    input basla,
    input [3:0] cekirdekler,
    input [1:0] boyut,
    output reg bitti = 0,
    output reg [4:0] tanecikler = 0
    );
    
    reg [4:0] tanecikler_sonraki = 0;
    reg bitti_sonraki = 0;
    
    always @* begin
        tanecikler_sonraki = 0;
        bitti_sonraki = 0;
        
        if(basla) begin
            case(boyut)
                2'b00: tanecikler_sonraki = cekirdekler * 2;
                2'b01: tanecikler_sonraki = cekirdekler * 1.5;
                2'b10: tanecikler_sonraki = cekirdekler * 1.1;
                default: tanecikler_sonraki = 0;
            endcase
            
            bitti_sonraki = 1;
        end
    end
    
    always @(posedge saat) begin
        if(reset) begin
            tanecikler <= 0;
            bitti <= 0;
        end
        else begin
            tanecikler <= tanecikler_sonraki;
            bitti <= bitti_sonraki;
        end
    end
    
endmodule
