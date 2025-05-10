`timescale 1ns / 1ps

module alarm #(parameter K=0) (
    input saat,
    input reset,
    input [6:0] sicaklik,
    output reg [2*K+6:0] ortalama_sicaklik, // K=0 max 7 bit, K=1 max 9 bit
    output reg alarm_cal
    );

    reg [2*K+6:0] son4temp [3:0];
    reg [2*K+6:0] son4temp_sonraki [3:0];
    
    reg [2*K+6:0] ortalama_sicaklik_sonraki;

    reg alarm_cal_sonraki;

    reg [6:0] alarm_esigi [0:0];

    initial begin
        $readmemb("esik.mem", alarm_esigi);
    end
    
	always @* begin
		ortalama_sicaklik_sonraki = 0;
        alarm_cal_sonraki = 0;
	
		son4temp_sonraki[0] = son4temp[1];
		son4temp_sonraki[1] = son4temp[2];
        son4temp_sonraki[2] = son4temp[3];
		son4temp_sonraki[3] = sicaklik;
		
		ortalama_sicaklik_sonraki = (son4temp_sonraki[0] + son4temp_sonraki[1] + son4temp_sonraki[2] + son4temp_sonraki[3]) / 4;
        if(ortalama_sicaklik_sonraki >= alarm_esigi[0]) alarm_cal_sonraki = 1;
        else alarm_cal_sonraki = 0;
        
        if(K) ortalama_sicaklik_sonraki = ortalama_sicaklik_sonraki + 273;
	end

    always @(posedge saat) begin
    	if(reset) begin
    		son4temp[0] <= 0;
    		son4temp[1] <= 0;
    		son4temp[2] <= 0;
            son4temp[3] <= 0;
    		ortalama_sicaklik <= 0;
            alarm_cal <= 0;
    	end
    	else begin
    		son4temp[0] <= son4temp_sonraki[0];
    		son4temp[1] <= son4temp_sonraki[1];
    		son4temp[2] <= son4temp_sonraki[2];
            son4temp[3] <= son4temp_sonraki[3];
    		ortalama_sicaklik <= ortalama_sicaklik_sonraki;
            alarm_cal <= alarm_cal_sonraki;
    	end
    end

endmodule
