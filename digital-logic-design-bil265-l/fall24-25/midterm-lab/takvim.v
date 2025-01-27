`timescale 1ns / 1ps

module takvim(
    input [3:0] yil,
    input [10:0] gun,
    input [9:0] saat,
    output reg [4:0] yil_sonuc, // max 20 olabilir, yani 5 bit
    output reg [3:0] ay_sonuc,
    output reg [2:0] haftanin_gunu_sonuc,
    output artik_yil
);

assign artik_yil = (yil_sonuc % 4 == 0);

// max 7463 gun 15 saat olabilir
reg [12:0] toplam_gun_sayisi;

integer i;

always @(*) begin
    yil_sonuc = 0;
    ay_sonuc = 0;
    haftanin_gunu_sonuc = 0;

    // 0. yil artik yil fakat yil/4 ile bu +1 gelmiyor
    // 1 eklemek lazim
    // ama eger yil 0'i asiyorsa 1 eklemek lazim
    toplam_gun_sayisi = 358 * yil + (yil / 4) + (yil>0 ? 1:0);
    toplam_gun_sayisi = toplam_gun_sayisi + gun;
    toplam_gun_sayisi = toplam_gun_sayisi + (saat / 24);

    haftanin_gunu_sonuc = toplam_gun_sayisi % 7;

    // while ile ya da if-else ile de yapilabilir
    // while ile daha guzel olur hatta 21 siniri belirtmek yerine
    // toplam gun sayisindan cikara cikara yili bul
    for(i=0; i<21; i=i+1) begin // max 20 yil
        if(i % 4 == 0) begin
            if(toplam_gun_sayisi >= 359) begin
                toplam_gun_sayisi = toplam_gun_sayisi - 359;
                yil_sonuc = yil_sonuc + 1;
            end
        end
        else begin
            if(toplam_gun_sayisi >= 358) begin
                toplam_gun_sayisi = toplam_gun_sayisi - 358;
                yil_sonuc = yil_sonuc + 1;
            end
        end
    end

    // while ile ya da if-else ile de yapilabilir
    // while ile daha guzel olur hatta 12 siniri belirtmek yerine
    // geri kalan toplam gün sayisindan cikara cikara ayi bul
    for(i=0; i<12; i=i+1) begin
        if(i == 1) begin // subat
            if(yil_sonuc % 4 == 0) begin
                if(toplam_gun_sayisi >= 29) begin
                    toplam_gun_sayisi = toplam_gun_sayisi - 29;
                    ay_sonuc = ay_sonuc + 1;
                end
            end
            else begin
                if(toplam_gun_sayisi >= 28) begin
                    toplam_gun_sayisi = toplam_gun_sayisi - 28;
                    ay_sonuc = ay_sonuc + 1;
                end
            end
        end
        else begin
            if(toplam_gun_sayisi >= 30) begin
                toplam_gun_sayisi = toplam_gun_sayisi - 30;
                ay_sonuc = ay_sonuc + 1;
            end
        end
    end
end

endmodule

