`timescale 1ns / 1ps

module ffli_devre(
    input saat,
    input reset,
    input A,
    input B,
    output C,
    output D,
    output E
    );

    reg Q_reg1;
    reg Q_reg2;
    reg Q_reg3;
    reg Q_reg4;
    reg Q_reg5;

    always @(posedge saat) begin
        if (reset) begin
            Q_reg1 <= 0;
            Q_reg2 <= 0;
            Q_reg3 <= 0;
            Q_reg4 <= 0;
            Q_reg5 <= 0;
        end
        else begin
            // tffler if yerine xorla da yapilabilir
            // Q_reg1 <= A ^ Q_reg1;

            //tff1
            if(A) begin
                Q_reg1 <= ~Q_reg1;
            end

            // tff2
            if(Q_reg1) begin
                Q_reg2 <= ~Q_reg2;
            end

            // tff3
            if(~Q_reg1) begin
                Q_reg3 <= ~Q_reg3;
            end

            // tff4
            if(B) begin
                Q_reg4 <= ~Q_reg4;
            end

            // tff5
            if(~Q_reg2 & Q_reg3) begin
                Q_reg5 <= ~Q_reg5;
            end
        end
    end

    assign C = Q_reg2;
    assign E = ~Q_reg3 | Q_reg4;
    assign D = ~Q_reg5;
endmodule
