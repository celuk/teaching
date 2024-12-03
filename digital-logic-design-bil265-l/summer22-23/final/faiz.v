`timescale 1ns / 1ps

module faiz(
    input saat,
    input reset,
    input [3:0] enflasyon,
    output reg [5:0] faiz
    );
    
    reg [5:0] faiz_sonraki;
    
    reg [3:0] son3enf [2:0];
    reg [3:0] son3enf_sonraki [2:0];
    
    reg [5:0] kumulatif_enf;
    reg [5:0] kumulatif_enf_sonraki;
    
    initial begin
    	faiz = 0;
    	
    	son3enf[0] = 0;
    	son3enf[1] = 0;
    	son3enf[2] = 0;
    	son3enf_sonraki[0] = 0;
    	son3enf_sonraki[1] = 0;
    	son3enf_sonraki[2] = 0;
    	
    	kumulatif_enf = 0;
    	kumulatif_enf_sonraki = 0;
    end
    
    integer i;
    
	always @* begin
		faiz_sonraki = faiz;
		son3enf_sonraki[0] = son3enf[0];
		son3enf_sonraki[1] = son3enf[1];
		son3enf_sonraki[2] = son3enf[2];
		kumulatif_enf_sonraki = kumulatif_enf;
	
		son3enf_sonraki[0] = son3enf_sonraki[1];
		son3enf_sonraki[1] = son3enf_sonraki[2];
		son3enf_sonraki[2] = enflasyon;
		
		if(son3enf_sonraki[0] != 0 && son3enf_sonraki[1] != 0 && son3enf_sonraki[2] != 0) begin
			kumulatif_enf_sonraki = ((100 + son3enf_sonraki[0])*
									(100 + son3enf_sonraki[1])*
									(100 + son3enf_sonraki[2])/10000) % 100;
		
			faiz_sonraki = kumulatif_enf_sonraki + 2;
		end
	end

    always @(posedge saat) begin
    	if(reset) begin
    		faiz <= 0;
    		son3enf[0] <= 0;
    		son3enf[1] <= 0;
    		son3enf[2] <= 0;
    		kumulatif_enf <= 0;
    	end
    	else begin
    		faiz <= faiz_sonraki;
    		son3enf[0] <= son3enf_sonraki[0];
    		son3enf[1] <= son3enf_sonraki[1];
    		son3enf[2] <= son3enf_sonraki[2];
    		kumulatif_enf <= kumulatif_enf_sonraki;
    	end
    end
    
endmodule
