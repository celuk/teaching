`timescale 1ns / 1ps


module demle #(parameter DERECE = 20)(
    input saat,
    input reset,
    input basla,
    input [4:0] tanecikler,
    input [7:0] su_miktari,
    input [6:0] hedef_sicaklik,
    output bitti,
    output demlendi,
    output [14:0] sure
    );
    
    reg [14:0] sure_sonraki = 0;
    reg demlendi_sonraki = 0;
    reg bitti_sonraki = 0;
    
    reg [14:0] sure1 = 0;
    reg [14:0] sure2 = 0;
    reg [14:0] sure3 = 0;
    
    reg demlendi1 = 0;
    reg demlendi2 = 0;
    reg demlendi3 = 0;
    
    reg bitti1 = 0;
    reg bitti2 = 0;
    reg bitti3 = 0;
    
    assign sure = sure3;
    assign demlendi = demlendi3;
    assign bitti = bitti3;
    
    always @* begin
        sure_sonraki = 0;
        demlendi_sonraki = 0;
        bitti_sonraki = 0;
        
        if(basla) begin
            if(hedef_sicaklik > DERECE) begin
                sure_sonraki = (hedef_sicaklik - DERECE) * su_miktari + tanecikler;
                demlendi_sonraki = 1;
            end
            
            bitti_sonraki = 1;
        end
    end
    
    always @(posedge saat) begin
        if(reset) begin
            sure1 <= 0;
            demlendi1 <= 0;
            bitti1 <= 0;
        
            sure2 <= 0;
            demlendi2 <= 0;
            bitti2 <= 0;
        
            sure3 <= 0;
            demlendi3 <= 0;
            bitti3 <= 0;
        end
        else begin
            sure1 <= sure_sonraki;
            demlendi1 <= demlendi_sonraki;
            bitti1 <= bitti_sonraki;
            
            sure2 <= sure1;
            demlendi2 <= demlendi1;
            bitti2 <= bitti1;
        
            sure3 <= sure2;
            demlendi3 <= demlendi2;
            bitti3 <= bitti2;
        end
    end
    
endmodule

