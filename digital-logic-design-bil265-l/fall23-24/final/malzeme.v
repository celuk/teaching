`timescale 1ns / 1ps

module malzeme(
    input saat,
    input reset,
    input basla,
    input sos,
    input tuzlu,
    output reg secilen_malzeme = 0,
    output reg [3:0] malzeme_miktari = 0,
    output reg cikis_tuzlu = 0,
    output reg bitti = 0
    );
    
    reg secilen_malzeme_sonraki = 0;
    reg [3:0] malzeme_miktari_sonraki = 0;
    reg cikis_tuzlu_sonraki = 0;
    reg bitti_sonraki = 0;
    
    reg [9:0] malzemeler_reg [1:0];
    
    initial begin
        $readmemb("malzemeler.mem", malzemeler_reg);
    end
    
    integer i = 0;
    
    reg [3:0] miktar1 = 0;
    reg [3:0] miktar2 = 0;
    
    always @* begin
        secilen_malzeme_sonraki = 0;
        malzeme_miktari_sonraki = 0;
        cikis_tuzlu_sonraki = 0;
        bitti_sonraki = 0;
        
        miktar1 = 0;
        miktar2 = 0;
        
        if(basla) begin
            for(i=0; i<10; i=i+1) begin
                if(malzemeler_reg[0][i] == 1) begin
                    miktar1 = miktar1 + 1;
                end
                
                if(malzemeler_reg[1][i] == 1) begin
                    miktar2 = miktar2 + 1;
                end
            end
            
            if(miktar1 >= miktar2) begin
                secilen_malzeme_sonraki = 0;
                malzeme_miktari_sonraki = miktar1;
            end
            else begin
                secilen_malzeme_sonraki = 1;
                malzeme_miktari_sonraki = miktar2;
            end
            
            if(sos) begin
                malzeme_miktari_sonraki = malzeme_miktari_sonraki + 1;
            end
            
            if(tuzlu) begin
                malzeme_miktari_sonraki = 0;
                cikis_tuzlu_sonraki = 1;
            end
            
            bitti_sonraki = 1;
        end
    end
    
    always @(posedge saat) begin
        if(reset) begin
            secilen_malzeme <= 0;
            malzeme_miktari <= 0;
            cikis_tuzlu <= 0;
            bitti <= 0;
        end
        else begin
            secilen_malzeme <= secilen_malzeme_sonraki;
            malzeme_miktari <= malzeme_miktari_sonraki;
            cikis_tuzlu <= cikis_tuzlu_sonraki;
            bitti <= bitti_sonraki;
        end
    end
    
endmodule
