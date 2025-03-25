`timescale 1ns / 10ps
`include "cpu_types_pkg.vh"
`include "register_file_if.vh"
`include "alu_if.vh"
module system_tb ();

	localparam CLK_PERIOD = 2.5ns;
    
	logic clk, nRst;
	logic led;
	logic [6:0] m_sequence;
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
	

	always begin
    	clk = 0;
    	#(CLK_PERIOD / 2.0);
    	clk = 1;
    	#(CLK_PERIOD / 2.0);
	end
    
	system DUT(
                .clk(clk),
                .nRst(nRst),
                .led(led), 
				.m_sequence(m_sequence),
				.HEX0(HEX0),
				.HEX1(HEX1),
				.HEX2(HEX2),
				.HEX3(HEX3),
				.HEX4(HEX4),
				.HEX5(HEX5),
				.HEX6(HEX6),
				.HEX7(HEX7));
					 
	initial begin
    	nRst = 0;
    	#(CLK_PERIOD);
    	nRst = 1;
		m_sequence = '0;
		#(CLK_PERIOD)
		m_sequence = 7'b1100100;
    	#(CLK_PERIOD*10);
   	 
		$finish
	end
               	 
endmodule
                	
