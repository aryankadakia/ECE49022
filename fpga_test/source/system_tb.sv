`timescale 1ns / 10ps
`include "cpu_types_pkg.vh"
`include "register_file_if.vh"
`include "alu_if.vh"
module system_tb ();

	localparam CLK_PERIOD = 2.5ns;
    
	logic clk, nRst;
	logic led;
    logic start;
	logic [6:0] m_sequence;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;

	string tb_state;
	

	always begin
    	clk = 0;
    	#(CLK_PERIOD / 2.0);
    	clk = 1;
    	#(CLK_PERIOD / 2.0);
	end
    
	system DUT(
                .clk(clk),
                .nRst(nRst),
				.m_sequence(m_sequence),
                .start(start),
				.peak_found(peak_found));
					 
	initial begin
    	nRst = 0;
		m_sequence = '0;
		start = 0;
    	#(CLK_PERIOD);
    	nRst = 1;
		m_sequence = 7'b1100100;
        start = 1;
		@(posedge clk);
		tb_state = "SHIFT 1";
		#(CLK_PERIOD);
		start = 0;
		tb_state = "SHIFT 2";
		#(CLK_PERIOD);
		tb_state = "SHIFT 3";
		#(CLK_PERIOD);
		tb_state = "SHIFT 4";
		#(CLK_PERIOD);
		tb_state = "SHIFT 5";
		#(CLK_PERIOD);
		tb_state = "SHIFT 6";
		#(CLK_PERIOD);
		tb_state = "SHIFT 7";
		#(CLK_PERIOD);
		tb_state = "SHIFT 8";
		#(CLK_PERIOD);
		tb_state = "SHIFT 9";
		#(CLK_PERIOD);
		tb_state = "SHIFT 10";
		#(CLK_PERIOD);
		tb_state = "SHIFT 11";
		#(CLK_PERIOD);
		tb_state = "SHIFT 12";
		#(CLK_PERIOD);
		tb_state = "SHIFT 13";
        #(CLK_PERIOD);
		tb_state = "";
		#(CLK_PERIOD*2)
   	 
        $finish;
	end
               	 
endmodule
                	
