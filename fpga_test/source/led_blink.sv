module led_blink (
	input logic clk,
	input logic nRst,
	output logic led
);

	//logic [24:0] counter;
    
	always_ff @(posedge clk, negedge nRst) begin
    	if (!nRst) begin
        	led <= '0;
    	end
    	else begin
        	led <= ~led;
    	end
	end
    
	//assign led = counter[24:21];
endmodule

