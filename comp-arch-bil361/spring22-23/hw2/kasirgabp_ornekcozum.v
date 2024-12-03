`timescale 1ns/1ps

module kasirgabp(
    input           saat,
    input           reset,
    input [31:0]    buyruk_adresi,
    input           onceki_buyruk_atladi,
    output          ongoru
);
    reg [2:0] genel_gecmis_yazmaci, genel_gecmis_yazmaci_next;
    reg [1:0] cift_kutuplu_sayac_tablosu[7:0], cift_kutuplu_sayac_tablosu_next[7:0];
    initial begin
        genel_gecmis_yazmaci_next = 3'b000;
        cift_kutuplu_sayac_tablosu_next[0] = 2'b00;
        cift_kutuplu_sayac_tablosu_next[1] = 2'b00;
        cift_kutuplu_sayac_tablosu_next[2] = 2'b00;
        cift_kutuplu_sayac_tablosu_next[3] = 2'b00;
        cift_kutuplu_sayac_tablosu_next[4] = 2'b00;
        cift_kutuplu_sayac_tablosu_next[5] = 2'b00;
        cift_kutuplu_sayac_tablosu_next[6] = 2'b00;
        cift_kutuplu_sayac_tablosu_next[7] = 2'b00;
    end
    wire [2:0] ongoru_tablo_adresi = genel_gecmis_yazmaci ^ buyruk_adresi[4:2];
    reg  [2:0] son_ongoru_tablo_adresi;
    reg	   son_ongoru;
    wire       son_ongoru_dogru = ~(son_ongoru ^ onceki_buyruk_atladi);
    always@*begin
        genel_gecmis_yazmaci_next = {genel_gecmis_yazmaci[2:1],onceki_buyruk_atladi};
        if(~onceki_buyruk_atladi && cift_kutuplu_sayac_tablosu[son_ongoru_tablo_adresi] != 2'd0)begin
            cift_kutuplu_sayac_tablosu_next[son_ongoru_tablo_adresi] = cift_kutuplu_sayac_tablosu_next[son_ongoru_tablo_adresi] - 2'd1;
        end
        if(onceki_buyruk_atladi && cift_kutuplu_sayac_tablosu[son_ongoru_tablo_adresi] != 2'd3)begin
            cift_kutuplu_sayac_tablosu_next[son_ongoru_tablo_adresi] = cift_kutuplu_sayac_tablosu_next[son_ongoru_tablo_adresi] + 2'd1;
        end
    end

    assign ongoru = cift_kutuplu_sayac_tablosu[ongoru_tablo_adresi][1];

    always@(posedge saat)begin
	if(reset)begin
	    genel_gecmis_yazmaci <= 2'b00;
	    cift_kutuplu_sayac_tablosu[0] <= 2'b00;
	    cift_kutuplu_sayac_tablosu[1] <= 2'b00;
	    cift_kutuplu_sayac_tablosu[2] <= 2'b00;
	    cift_kutuplu_sayac_tablosu[3] <= 2'b00;
	    cift_kutuplu_sayac_tablosu[4] <= 2'b00;
	    cift_kutuplu_sayac_tablosu[5] <= 2'b00;
	    cift_kutuplu_sayac_tablosu[6] <= 2'b00;
	    cift_kutuplu_sayac_tablosu[7] <= 2'b00;
	end else begin
	    genel_gecmis_yazmaci <= genel_gecmis_yazmaci_next;
	    cift_kutuplu_sayac_tablosu[0] <= cift_kutuplu_sayac_tablosu_next[0];
	    cift_kutuplu_sayac_tablosu[1] <= cift_kutuplu_sayac_tablosu_next[1];
	    cift_kutuplu_sayac_tablosu[2] <= cift_kutuplu_sayac_tablosu_next[2];
	    cift_kutuplu_sayac_tablosu[3] <= cift_kutuplu_sayac_tablosu_next[3];
	    cift_kutuplu_sayac_tablosu[4] <= cift_kutuplu_sayac_tablosu_next[4];
	    cift_kutuplu_sayac_tablosu[5] <= cift_kutuplu_sayac_tablosu_next[5];
	    cift_kutuplu_sayac_tablosu[6] <= cift_kutuplu_sayac_tablosu_next[6];
	    cift_kutuplu_sayac_tablosu[7] <= cift_kutuplu_sayac_tablosu_next[7];
	end
	son_ongoru_tablo_adresi <=  ongoru_tablo_adresi;
	son_ongoru <= ongoru; 
    end
endmodule
