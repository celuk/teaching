`timescale 1ns / 1ps

module catch(
    input clk,
    input rst,
    input [3:0] yon,
    output reg durum,
    output reg [3:0] yakalama_sayisi
    );

    localparam [1:0] YUKARI = 0;
    localparam [1:0] ASAGI = 1;
    localparam [1:0] SOL = 2;
    localparam [1:0] SAG = 3;

    wire [1:0] yon1 = yon[3:2];
    wire [1:0] yon2 = yon[1:0];

    reg durum_sonraki;
    reg [3:0] yakalama_sayisi_sonraki;

    reg [1:0] konum1_y = 3;
    reg [1:0] konum1_y_sonraki;
    reg [1:0] konum1_x = 3;
    reg [1:0] konum1_x_sonraki;

    reg [1:0] konum2_y = 0;
    reg [1:0] konum2_y_sonraki;
    reg [1:0] konum2_x = 0;
    reg [1:0] konum2_x_sonraki;

    integer i, j;

    always @* begin
        durum_sonraki = 0;
        yakalama_sayisi_sonraki = yakalama_sayisi;

        konum1_y_sonraki = konum1_y;
        konum1_x_sonraki = konum1_x;
        konum2_y_sonraki = konum2_y;
        konum2_x_sonraki = konum2_x;

        if(yakalama_sayisi == 15) begin
            konum1_y_sonraki = 3;
            konum1_x_sonraki = 3;
            konum2_y_sonraki = 0;
            konum2_x_sonraki = 0;

            yakalama_sayisi_sonraki = 0;
        end

        if(yon1 == YUKARI) begin
            if(konum1_y != 3) begin
                konum1_y_sonraki = konum1_y + 1;
            end
        end
        else if(yon1 == ASAGI) begin
            if(konum1_y != 0) begin
                konum1_y_sonraki = konum1_y - 1;
            end
        end
        else if(yon1 == SOL) begin
            if(konum1_x != 3) begin
                konum1_x_sonraki = konum1_x + 1;
            end
        end
        else if(yon1 == SAG) begin
            if(konum1_x != 0) begin
                konum1_x_sonraki = konum1_x - 1;
            end
        end

        if(yon2 == YUKARI) begin
            if(konum2_y != 3) begin
                konum2_y_sonraki = konum2_y + 1;
            end
        end
        else if(yon2 == ASAGI) begin
            if(konum2_y != 0) begin
                konum2_y_sonraki = konum2_y - 1;
            end
        end
        else if(yon2 == SOL) begin
            if(konum2_x != 3) begin
                konum2_x_sonraki = konum2_x + 1;
            end
        end
        else if(yon2 == SAG) begin
            if(konum2_x != 0) begin
                konum2_x_sonraki = konum2_x - 1;
            end
        end

        if(konum1_y == konum2_y && konum1_x == konum2_x) begin
            durum_sonraki = 1;
            if(yakalama_sayisi != 15) begin
                yakalama_sayisi_sonraki = yakalama_sayisi + 1;
            end
            else begin
                yakalama_sayisi_sonraki = 1;
            end
        end
    end

    always @(posedge clk) begin
        if(rst) begin
            durum <= 0;
            yakalama_sayisi <= 0;

            konum1_y <= 3;
            konum1_x <= 3;
            konum2_y <= 0;
            konum2_x <= 0;
        end
        else begin
            durum <= durum_sonraki;
            yakalama_sayisi <= yakalama_sayisi_sonraki;

            konum1_y <= konum1_y_sonraki;
            konum1_x <= konum1_x_sonraki;
            konum2_y <= konum2_y_sonraki;
            konum2_x <= konum2_x_sonraki;
        end
    end
endmodule
