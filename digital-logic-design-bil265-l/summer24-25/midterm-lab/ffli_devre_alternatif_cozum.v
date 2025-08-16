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

    wire tff1Q, tff1Qn;
    T_FF tff1(
        .saat(saat),
        .reset(reset),
        .T(A),
        .Q(tff1Q),
        .Qn(tff1Qn)
    );

    wire tff2Qn;
    T_FF tff2(
        .saat(saat),
        .reset(reset),
        .T(tff1Q),
        .Q(C),
        .Qn(tff2Qn)
    );

    wire tff3Q, tff3Qn;
    T_FF tff3(
        .saat(saat),
        .reset(reset),
        .T(tff1Qn),
        .Q(tff3Q),
        .Qn(tff3Qn)
    );

    wire tff4Q;
    T_FF tff4(
        .saat(saat),
        .reset(reset),
        .T(B),
        .Q(tff4Q),
        .Qn()
    );

    wire andtff2Qntff3Q = tff2Qn & tff3Q;
    assign E = tff3Qn | tff4Q;

    T_FF tff5(
        .saat(saat),
        .reset(reset),
        .T(andtff2Qntff3Q),
        .Q(),
        .Qn(D)
    );
endmodule

module T_FF(
    input saat,
    input reset,
    input T,
    output Q,
    output Qn
);

    reg Q_reg;

    always @(posedge saat) begin
        if (reset) begin
            Q_reg <= 0;
        end
        else begin
            if(T) begin
                Q_reg <= ~Q_reg;
            end
            else begin
                Q_reg <= Q_reg;
            end
        end
    end

    assign Q = Q_reg;
    assign Qn = ~Q_reg;
endmodule
