`timescale 1ns / 1ps

module durum(
    input saat,
    input reset,
    input giris,
    output cikis
    );
    
    reg [1:0] durum;
    reg [1:0] durum_sonraki;
    
    localparam A = 2'b00;
    localparam B = 2'b01;
    localparam C = 2'b10;
    localparam D = 2'b11;
    
    initial durum = A;

    always@* begin
        durum_sonraki = durum;
        
        case(durum)
            A: begin
                if(giris) durum_sonraki = A;
                else durum_sonraki = B;
            end
            B: begin
                if(giris) durum_sonraki = C;
                else durum_sonraki = D;
            end
            C: begin
                if(!giris) durum_sonraki = D;
            end
            D: begin
                if(giris) durum_sonraki = B;
                else durum_sonraki = A;
            end
        endcase
    end
    
    always@(posedge saat) begin
        if(reset) begin
            durum <= A;
        end
        else begin
            durum <= durum_sonraki;
        end
    end
    
    assign cikis = (durum == A) | (durum == C);
endmodule
