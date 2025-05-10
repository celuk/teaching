`timescale 1ns / 1ps

module sayac(
    input saat,
    input reset,
    input basla,
    input [7:0] baslangic_degeri,
    input yon,
    input [2:0] miktar,
    output reg [7:0] sonuc,
    output reg hazir,
    output reg mesgul,
    output [2:0] cikis_miktar,
    output cikis_yon
    );

    assign cikis_miktar = miktar;
    assign cikis_yon = yon;

    reg [7:0] sonuc_sonraki;
    reg hazir_sonraki;
    reg mesgul_sonraki;

    reg sayac_yon_sonraki;
    reg sayac_yon;

    always @* begin
        sonuc_sonraki = sonuc;
        hazir_sonraki = 0;
        mesgul_sonraki = 0;
        sayac_yon_sonraki = sayac_yon;

        if(~mesgul) begin
            if(basla) begin
                mesgul_sonraki = 1;
                
                sonuc_sonraki = baslangic_degeri;

                sayac_yon_sonraki = yon;

                if(miktar == 0) begin
                    hazir_sonraki = 1;
                end

                if(yon) begin
                    if((baslangic_degeri + miktar) > 255) begin
                        hazir_sonraki = 1;
                    end
                end
                else begin
                    if (baslangic_degeri < miktar) begin
                        hazir_sonraki = 1;
                    end
                end
            end
        end
        else begin // sayma islemi
            // 1 cevrim sonra mesgulu 0 yapmak için
            if(miktar == 0 
               || (yon && ((baslangic_degeri + miktar) > 255))
               || (~yon && (baslangic_degeri < miktar))
               || (yon && sayac_yon && ((sonuc + miktar) > 255)) // sinir kosullari
               || (yon && ~sayac_yon && ((sonuc + miktar - 1) > 255))
               || (~yon && sayac_yon && ((sonuc+1) < miktar))
               || (~yon && ~sayac_yon && (sonuc < miktar))) begin
                mesgul_sonraki = 0;
            end
            else begin
                mesgul_sonraki = 1;
                
                if(yon) begin
                    if(sayac_yon) begin
                        sonuc_sonraki = sonuc + miktar;

                        if (miktar == 1 && ((sonuc_sonraki + miktar) > 255)) begin
                            hazir_sonraki = 1;
                        end
                        else if((sonuc_sonraki + miktar - 1) > 255) begin // 1 azalip miktar artip asmiyorsa
                            hazir_sonraki = 1;
                        end
                    end
                    else begin
                        sonuc_sonraki = sonuc - 1;

                        if((sonuc_sonraki + miktar) > 255) begin
                            hazir_sonraki = 1;
                        end
                    end
                end
                else begin
                    if(sayac_yon) begin
                        sonuc_sonraki = sonuc + 1;

                        if (sonuc_sonraki < miktar) begin
                            hazir_sonraki = 1;
                        end
                    end
                    else begin
                        sonuc_sonraki = sonuc - miktar;

                        if (miktar == 1 && (sonuc_sonraki < miktar)) begin
                            hazir_sonraki = 1;
                        end
                        else if (sonuc_sonraki + 1 < miktar) begin // 1 artip miktar azalip asmiyorsa
                            hazir_sonraki = 1;
                        end
                    end
                end

                if(miktar == 1) begin
                    sayac_yon_sonraki = sayac_yon;
                end
                else begin
                    sayac_yon_sonraki = ~sayac_yon; // ...-ileri-geri-ileri-...
                end
            end
        end
    end

    always @(posedge saat) begin
        if(reset) begin
            sonuc <= 0;
            hazir <= 0;
            mesgul <= 0;
            sayac_yon <= 0;
        end
        else begin
            sonuc <= sonuc_sonraki;
            hazir <= hazir_sonraki;
            mesgul <= mesgul_sonraki;
            sayac_yon <= sayac_yon_sonraki;
        end
    end
    
endmodule
