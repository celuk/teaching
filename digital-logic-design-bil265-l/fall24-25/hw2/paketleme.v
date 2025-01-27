`timescale 1ns / 1ps

module paketleme(
    input saat,
    input reset, 
    input basla,
    input kontrol_sonucu,
    input [9:0] kapasite,
    input bandrol,
    output reg bitti,
    output reg [2:0] maliyet,
    output reg [9:0] telefon_sayisi
    );
    
    reg bitti_sonraki;
    reg [2:0] maliyet_sonraki;
    reg [9:0] telefon_sayisi_sonraki;

    reg [9:0] kapasite_buffer;
    reg [9:0] kapasite_buffer_sonraki;

    always @* begin
        bitti_sonraki = 0;
        maliyet_sonraki = 0;
        telefon_sayisi_sonraki = telefon_sayisi;

        kapasite_buffer_sonraki = kapasite_buffer;

        if(basla) begin
            kapasite_buffer_sonraki = kapasite;
            if(kapasite < kapasite_buffer) begin
                telefon_sayisi_sonraki = 0;

                if(kontrol_sonucu && telefon_sayisi < kapasite) begin
                    telefon_sayisi_sonraki = telefon_sayisi_sonraki + 1;
                end
            end
            else begin
                if(kontrol_sonucu && telefon_sayisi < kapasite) begin
                    telefon_sayisi_sonraki = telefon_sayisi + 1;
                end
            end

            if(telefon_sayisi < kapasite) begin
                maliyet_sonraki = 1;
                if(bandrol) begin
                    maliyet_sonraki = maliyet_sonraki * 2;
                end
                if(kapasite < 200) begin
                    maliyet_sonraki = maliyet_sonraki * 3;
                end
            end

            bitti_sonraki = 1;
        end
    end

    always @(posedge saat) begin
        if(reset) begin
            bitti <= 0;
            maliyet <= 0;
            telefon_sayisi <= 0;
            kapasite_buffer <= 0;
        end
        else begin
            bitti <= bitti_sonraki;
            maliyet <= maliyet_sonraki;
            telefon_sayisi <= telefon_sayisi_sonraki;
            kapasite_buffer <= kapasite_buffer_sonraki;
        end
    end
    
endmodule
