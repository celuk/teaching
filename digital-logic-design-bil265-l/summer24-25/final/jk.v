`timescale 1ns / 1ps

module jk(
    input saat,
    input reset,
    input J,
    input K,
    output Q,
    output QN
);

    reg Q_reg;
    
    always @(posedge saat) begin
        if(reset) begin
            Q_reg <= 0;
        end
        else begin
            case ({J, K})
                2'b00: begin
                    Q_reg <= Q_reg;
                end
                2'b01: begin
                    Q_reg <= 0;
                end
                2'b10: begin
                    Q_reg <= 1;
                end
                2'b11: begin
                    Q_reg <= ~Q_reg;
                end
            endcase
        end
    end

    assign Q = Q_reg;
    assign QN = ~Q_reg;
endmodule
