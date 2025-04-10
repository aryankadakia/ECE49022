`timescale 1ns / 1ps

module system_tb();

    localparam CLK_PERIOD = 2.5ns;
    
	logic CLK, nRst;
    logic start;
	logic [6:0] m_sequence;
    logic peak_found;

    string tb_state;
	

	always begin
    	CLK = 0;
    	#(CLK_PERIOD / 2.0);
    	CLK = 1;
    	#(CLK_PERIOD / 2.0);
	end

    system DUT(
            .CLK(CLK),
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
		//m_sequence = '{1, 1, -1, -1, 1, -1, -1};
        start = 1;
		@(posedge CLK);
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
