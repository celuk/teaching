`timescale 1ns / 1ps

module demle #(parameter DERECE = 20)(
    input saat,
    input reset,
    input basla,
    input [4:0] tanecikler,
    input [7:0] su_miktari,
    input [6:0] hedef_sicaklik,
    output reg bitti = 0,
    output reg demlendi = 0,
    output reg [14:0] sure = 0
    );
    
    reg [14:0] sure_sonraki = 0;
    reg demlendi_sonraki = 0;
    reg bitti_sonraki = 0;
    
    reg [1:0] sayac = 0;
    reg [1:0] sayac_sonraki = 0;
    
    // 3. cevrimde 3 cevrim onceki baslaya göre bitti ve sonuclari vermek icin geciktiriliyor
    reg basla1 = 0;
    reg basla2 = 0;
    
    reg [4:0] tanecikler1 = 0;
    reg [4:0] tanecikler2 = 0;
    
    reg [7:0] su_miktari1 = 0;
    reg [7:0] su_miktari2 = 0;
    
    reg [6:0] hedef_sicaklik1 = 0;
    reg [6:0] hedef_sicaklik2 = 0;
    
    always @* begin
        bitti_sonraki = 0;
        
        if(basla2) begin
            if(hedef_sicaklik2 > DERECE) begin
                sure_sonraki = (hedef_sicaklik2 - DERECE) * su_miktari2 + tanecikler2;
                demlendi_sonraki = 1;
            end
            else begin
                sure_sonraki = 0;
                demlendi_sonraki = 0;
            end
            
            if(sayac == 2) begin // 3 onceki basla 1'se biter
                bitti_sonraki = 1;
            end
        end
        
        sayac_sonraki = sayac + 1;
    end
    
    always @(posedge saat) begin
        if(reset) begin
            sure <= 0;
            demlendi <= 0;
            bitti <= 0;
            
            sayac <= 0;
            
            basla1 <= 0;
            basla2 <= 0;
            tanecikler1 <= 0;
            tanecikler2 <= 0;
            su_miktari1 <= 0;
            su_miktari2 <= 0;
            hedef_sicaklik1 <= 0;
            hedef_sicaklik2 <= 0;
        end
        else begin
            basla1 <= basla;
            basla2 <= basla1;
            tanecikler1 <= tanecikler;
            tanecikler2 <= tanecikler1;
            su_miktari1 <= su_miktari;
            su_miktari2 <= su_miktari1;
            hedef_sicaklik1 <= hedef_sicaklik;
            hedef_sicaklik2 <= hedef_sicaklik1;
            
            if (sayac == 2) begin // 3 cevrim
                sayac <= 0;
            end
            else if(basla == 0) begin
                sayac <= 0;
            end
            else begin
                sayac <= sayac_sonraki;
            end
            
            sure <= sure_sonraki;
            demlendi <= demlendi_sonraki;
            bitti <= bitti_sonraki;
        end
    end
    
endmodule
