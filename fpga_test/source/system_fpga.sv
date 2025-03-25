`include "cpu_types_pkg.vh"
`include "register_file_if.vh"
`include "alu_if.vh"

module system_fpga (
	input logic clk,
	input logic nRst,
	input logic [6:0] m_sequence,
	input logic start,
	input logic next_shift,
	output logic led,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7
);

	// import types
    import cpu_types_pkg::*;

	register_file_if rfif();
	register_file RF (clk, nRst, rfif);

	alu_if aluif();
	alu ALU (aluif);

	parameter MAX_SHIFT = 13;

	// sample (larger array)
	logic [18:0] sample;
	assign sample = {m_sequence[5:0], m_sequence, m_sequence[6:1]};

	typedef enum logic [1:0] {IDLE, SHIFT, DONE} state_t;

	state_t state, next_state;
	logic peak_found;

	logic [3:0] counter, next_counter;
	logic [6:0] port_output;
	logic [4:0] upper_bound, lower_bound;
	logic [3:0] sum;
	logic [3:0] peak;


	always_ff @(posedge clk, negedge nRst) begin 
		if(!nRst) begin 
			state <= IDLE;
			counter <= '0;
		end 
		else begin
			state <= next_state;
			counter <= next_counter;
		end 
	end 

	always_comb begin : NEXT_STATE_LOGIC
		next_state = state;
		next_counter = counter;
		case(state)
			IDLE: next_state = (start) ? SHIFT : IDLE;
			SHIFT: begin 
				if(counter < MAX_SHIFT) begin 
					next_state = SHIFT;
					next_counter = counter + 1; 
				end
				else begin 
					next_state = DONE;
				end
			end  
			DONE: next_state = IDLE;
		endcase
	end 

	always_comb begin : OUTPUT_LOGIC
		peak_found = 0;
		port_output = '0;
		sum = '0;
		peak = '0;
		case(state)
			SHIFT: begin
				port_output = m_sequence & sample[18 - counter -: 7];
				for (int i = 0; i < 7; i++) begin
					sum = sum + port_output[i];
				end
				if(port_output == m_sequence) begin 
					peak_found = 1;
					peak = sum;
				end 
			end
		endcase
	end 
	
	
	// typedef enum logic [3:0] { IDLE,
	// 					 	   SHIFT1, SHIFT2, SHIFT3, SHIFT4, SHIFT5, SHIFT6, SHIFT7, SHIFT8, SHIFT9, SHIFT10, SHIFT11, SHIFT12, SHIFT13,
	// 					       DONE} state_t;
	
	// state_t state, next_state;
	// logic [6:0] port_output; 
	// //logic [3:0] counter;
	// logic peak_detected;
	// logic [6:0] peak_value;
	// //logic [3:0] sum_result;
	// //logic [6:0] window;

	// always_ff @ (posedge clk, negedge nRst) begin 
	// 	if(!nRst) begin 
	// 		state <= IDLE;
	// 	end 
	// 	else begin 
	// 		state <= next_state;
	// 	end 
	// end 

	// always_comb begin : NEXT_STATE_LOGIC
	// 	next_state = state;
	// 	case(state)
	// 		IDLE: next_state = (~start) ? SHIFT1 : IDLE;
	// 		SHIFT1: next_state = (~next_shift) ? SHIFT2 : SHIFT1;
	// 		SHIFT2: next_state = (~next_shift) ? SHIFT3 : SHIFT2;
	// 		SHIFT3: next_state = (~next_shift) ? SHIFT4 : SHIFT3;
	// 		SHIFT4: next_state = (~next_shift) ? SHIFT5 : SHIFT4;
	// 		SHIFT5: next_state = (~next_shift) ? SHIFT6 : SHIFT5;
	// 		SHIFT6: next_state = (~next_shift) ? SHIFT7 : SHIFT6;
	// 		SHIFT7: next_state = (~next_shift) ? SHIFT8 : SHIFT7;
	// 		SHIFT8: next_state = (~next_shift) ? SHIFT9 : SHIFT8;
	// 		SHIFT9: next_state = (~next_shift) ? SHIFT10 : SHIFT9;
	// 		SHIFT10: next_state = (~next_shift) ? SHIFT11 : SHIFT10;
	// 		SHIFT11: next_state = (~next_shift) ? SHIFT12 : SHIFT11;
	// 		SHIFT12: next_state = (~next_shift) ? SHIFT13 : SHIFT12;
	// 		SHIFT13: next_state = (~next_shift) ? DONE : SHIFT13;
	// 		DONE: next_state = IDLE;
	// 	endcase
	// end 

	// always_comb begin 
	// 	port_output = '0;
	// 	peak_detected = '0;
	// 	led = 0;
	// 	HEX0 = '1;
	// 	HEX1 = '1;
	// 	HEX2 = '1;
	// 	HEX3 = '1;
	// 	HEX4 = '1;
	// 	HEX5 = '1;
	// 	HEX6 = '1;
	// 	HEX7 = '1;
	// 	case(state)
	// 		IDLE: begin 
	// 			HEX0 = '1;
	// 			HEX1 = '1;
	// 			HEX2 = '1;
	// 			HEX3 = '1;
	// 			HEX4 = '1;
	// 			HEX5 = '1;
	// 			HEX6 = '1;
	// 			HEX7 = '1;
	// 		end
	// 		SHIFT1: begin 
	// 			port_output = m_sequence & sample[18:12];
	// 			if(port_output == m_sequence) begin
	// 				peak_detected = 1;
	// 				led = 1;
	// 			end 
	// 			unique casez (port_output[0])
	// 				'h0: HEX0 = 7'b1000000;
    //         		'h1: HEX0 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[1])
	// 				'h0: HEX1 = 7'b1000000;
    //         		'h1: HEX1 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[2])
	// 				'h0: HEX2 = 7'b1000000;
    //         		'h1: HEX2 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[3])
	// 				'h0: HEX3 = 7'b1000000;
    //         		'h1: HEX3 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[4])
	// 				'h0: HEX4 = 7'b1000000;
    //         		'h1: HEX4 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[5])
	// 				'h0: HEX5 = 7'b1000000;
    //         		'h1: HEX5 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[6])
	// 				'h0: HEX6 = 7'b1000000;
    //         		'h1: HEX6 = 7'b1111001;
	// 			endcase
	// 		end
	// 		SHIFT2: begin 
	// 			port_output = m_sequence & sample[17:11];
	// 			if(port_output == m_sequence) begin
	// 				peak_detected = 1;
	// 				led = 1;
	// 			end 
	// 			unique casez (port_output[0])
	// 				'h0: HEX0 = 7'b1000000;
    //         		'h1: HEX0 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[1])
	// 				'h0: HEX1 = 7'b1000000;
    //         		'h1: HEX1 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[2])
	// 				'h0: HEX2 = 7'b1000000;
    //         		'h1: HEX2 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[3])
	// 				'h0: HEX3 = 7'b1000000;
    //         		'h1: HEX3 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[4])
	// 				'h0: HEX4 = 7'b1000000;
    //         		'h1: HEX4 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[5])
	// 				'h0: HEX5 = 7'b1000000;
    //         		'h1: HEX5 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[6])
	// 				'h0: HEX6 = 7'b1000000;
    //         		'h1: HEX6 = 7'b1111001;
	// 			endcase
	// 		end	
	// 		SHIFT3: begin 
	// 			port_output = m_sequence & sample[16:10];
	// 			if(port_output == m_sequence) begin
	// 				peak_detected = 1;
	// 				led = 1;
	// 			end 
	// 			unique casez (port_output[0])
	// 				'h0: HEX0 = 7'b1000000;
    //         		'h1: HEX0 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[1])
	// 				'h0: HEX1 = 7'b1000000;
    //         		'h1: HEX1 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[2])
	// 				'h0: HEX2 = 7'b1000000;
    //         		'h1: HEX2 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[3])
	// 				'h0: HEX3 = 7'b1000000;
    //         		'h1: HEX3 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[4])
	// 				'h0: HEX4 = 7'b1000000;
    //         		'h1: HEX4 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[5])
	// 				'h0: HEX5 = 7'b1000000;
    //         		'h1: HEX5 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[6])
	// 				'h0: HEX6 = 7'b1000000;
    //         		'h1: HEX6 = 7'b1111001;
	// 			endcase
	// 		end
	// 		SHIFT4: begin 
	// 			port_output = m_sequence & sample[15:9];
	// 			if(port_output == m_sequence) begin
	// 				peak_detected = 1;
	// 				led = 1;
	// 			end 
	// 			unique casez (port_output[0])
	// 				'h0: HEX0 = 7'b1000000;
    //         		'h1: HEX0 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[1])
	// 				'h0: HEX1 = 7'b1000000;
    //         		'h1: HEX1 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[2])
	// 				'h0: HEX2 = 7'b1000000;
    //         		'h1: HEX2 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[3])
	// 				'h0: HEX3 = 7'b1000000;
    //         		'h1: HEX3 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[4])
	// 				'h0: HEX4 = 7'b1000000;
    //         		'h1: HEX4 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[5])
	// 				'h0: HEX5 = 7'b1000000;
    //         		'h1: HEX5 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[6])
	// 				'h0: HEX6 = 7'b1000000;
    //         		'h1: HEX6 = 7'b1111001;
	// 			endcase
	// 		end
	// 		SHIFT5: begin 
	// 			port_output = m_sequence & sample[14:8];
	// 			if(port_output == m_sequence) begin
	// 				peak_detected = 1;
	// 				led = 1;
	// 			end 
	// 			unique casez (port_output[0])
	// 				'h0: HEX0 = 7'b1000000;
    //         		'h1: HEX0 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[1])
	// 				'h0: HEX1 = 7'b1000000;
    //         		'h1: HEX1 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[2])
	// 				'h0: HEX2 = 7'b1000000;
    //         		'h1: HEX2 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[3])
	// 				'h0: HEX3 = 7'b1000000;
    //         		'h1: HEX3 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[4])
	// 				'h0: HEX4 = 7'b1000000;
    //         		'h1: HEX4 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[5])
	// 				'h0: HEX5 = 7'b1000000;
    //         		'h1: HEX5 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[6])
	// 				'h0: HEX6 = 7'b1000000;
    //         		'h1: HEX6 = 7'b1111001;
	// 			endcase
	// 		end
	// 		SHIFT6: begin 
	// 			port_output = m_sequence & sample[13:7];
	// 			if(port_output == m_sequence) begin
	// 				peak_detected = 1;
	// 				led = 1;
	// 			end 
	// 			unique casez (port_output[0])
	// 				'h0: HEX0 = 7'b1000000;
    //         		'h1: HEX0 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[1])
	// 				'h0: HEX1 = 7'b1000000;
    //         		'h1: HEX1 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[2])
	// 				'h0: HEX2 = 7'b1000000;
    //         		'h1: HEX2 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[3])
	// 				'h0: HEX3 = 7'b1000000;
    //         		'h1: HEX3 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[4])
	// 				'h0: HEX4 = 7'b1000000;
    //         		'h1: HEX4 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[5])
	// 				'h0: HEX5 = 7'b1000000;
    //         		'h1: HEX5 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[6])
	// 				'h0: HEX6 = 7'b1000000;
    //         		'h1: HEX6 = 7'b1111001;
	// 			endcase
	// 		end
	// 		SHIFT7: begin 
	// 			port_output = m_sequence & sample[12:6];
	// 			if(port_output == m_sequence) begin
	// 				peak_detected = 1;
	// 				led = 1;
	// 			end 
	// 			unique casez (port_output[0])
	// 				'h0: HEX0 = 7'b1000000;
    //         		'h1: HEX0 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[1])
	// 				'h0: HEX1 = 7'b1000000;
    //         		'h1: HEX1 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[2])
	// 				'h0: HEX2 = 7'b1000000;
    //         		'h1: HEX2 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[3])
	// 				'h0: HEX3 = 7'b1000000;
    //         		'h1: HEX3 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[4])
	// 				'h0: HEX4 = 7'b1000000;
    //         		'h1: HEX4 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[5])
	// 				'h0: HEX5 = 7'b1000000;
    //         		'h1: HEX5 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[6])
	// 				'h0: HEX6 = 7'b1000000;
    //         		'h1: HEX6 = 7'b1111001;
	// 			endcase
	// 		end
	// 		SHIFT8: begin 
	// 			port_output = m_sequence & sample[11:5];
	// 			if(port_output == m_sequence) begin
	// 				peak_detected = 1;
	// 				led = 1;
	// 			end 
	// 			unique casez (port_output[0])
	// 				'h0: HEX0 = 7'b1000000;
    //         		'h1: HEX0 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[1])
	// 				'h0: HEX1 = 7'b1000000;
    //         		'h1: HEX1 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[2])
	// 				'h0: HEX2 = 7'b1000000;
    //         		'h1: HEX2 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[3])
	// 				'h0: HEX3 = 7'b1000000;
    //         		'h1: HEX3 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[4])
	// 				'h0: HEX4 = 7'b1000000;
    //         		'h1: HEX4 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[5])
	// 				'h0: HEX5 = 7'b1000000;
    //         		'h1: HEX5 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[6])
	// 				'h0: HEX6 = 7'b1000000;
    //         		'h1: HEX6 = 7'b1111001;
	// 			endcase
	// 		end
	// 		SHIFT9: begin 
	// 			port_output = m_sequence & sample[10:4];
	// 			if(port_output == m_sequence) begin
	// 				peak_detected = 1;
	// 				led = 1;
	// 			end 
	// 			unique casez (port_output[0])
	// 				'h0: HEX0 = 7'b1000000;
    //         		'h1: HEX0 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[1])
	// 				'h0: HEX1 = 7'b1000000;
    //         		'h1: HEX1 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[2])
	// 				'h0: HEX2 = 7'b1000000;
    //         		'h1: HEX2 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[3])
	// 				'h0: HEX3 = 7'b1000000;
    //         		'h1: HEX3 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[4])
	// 				'h0: HEX4 = 7'b1000000;
    //         		'h1: HEX4 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[5])
	// 				'h0: HEX5 = 7'b1000000;
    //         		'h1: HEX5 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[6])
	// 				'h0: HEX6 = 7'b1000000;
    //         		'h1: HEX6 = 7'b1111001;
	// 			endcase
	// 		end
	// 		SHIFT10: begin 
	// 			port_output = m_sequence & sample[9:3];
	// 			if(port_output == m_sequence) begin
	// 				peak_detected = 1;
	// 				led = 1;
	// 			end 
	// 			unique casez (port_output[0])
	// 				'h0: HEX0 = 7'b1000000;
    //         		'h1: HEX0 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[1])
	// 				'h0: HEX1 = 7'b1000000;
    //         		'h1: HEX1 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[2])
	// 				'h0: HEX2 = 7'b1000000;
    //         		'h1: HEX2 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[3])
	// 				'h0: HEX3 = 7'b1000000;
    //         		'h1: HEX3 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[4])
	// 				'h0: HEX4 = 7'b1000000;
    //         		'h1: HEX4 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[5])
	// 				'h0: HEX5 = 7'b1000000;
    //         		'h1: HEX5 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[6])
	// 				'h0: HEX6 = 7'b1000000;
    //         		'h1: HEX6 = 7'b1111001;
	// 			endcase
	// 		end
	// 		SHIFT11: begin 
	// 			port_output = m_sequence & sample[8:2];
	// 			if(port_output == m_sequence) begin
	// 				peak_detected = 1;
	// 				led = 1;
	// 			end 
	// 			unique casez (port_output[0])
	// 				'h0: HEX0 = 7'b1000000;
    //         		'h1: HEX0 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[1])
	// 				'h0: HEX1 = 7'b1000000;
    //         		'h1: HEX1 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[2])
	// 				'h0: HEX2 = 7'b1000000;
    //         		'h1: HEX2 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[3])
	// 				'h0: HEX3 = 7'b1000000;
    //         		'h1: HEX3 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[4])
	// 				'h0: HEX4 = 7'b1000000;
    //         		'h1: HEX4 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[5])
	// 				'h0: HEX5 = 7'b1000000;
    //         		'h1: HEX5 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[6])
	// 				'h0: HEX6 = 7'b1000000;
    //         		'h1: HEX6 = 7'b1111001;
	// 			endcase
	// 		end
	// 		SHIFT12: begin 
	// 			port_output = m_sequence & sample[7:1];
	// 			if(port_output == m_sequence) begin
	// 				peak_detected = 1;
	// 				led = 1;
	// 			end 
	// 			unique casez (port_output[0])
	// 				'h0: HEX0 = 7'b1000000;
    //         		'h1: HEX0 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[1])
	// 				'h0: HEX1 = 7'b1000000;
    //         		'h1: HEX1 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[2])
	// 				'h0: HEX2 = 7'b1000000;
    //         		'h1: HEX2 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[3])
	// 				'h0: HEX3 = 7'b1000000;
    //         		'h1: HEX3 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[4])
	// 				'h0: HEX4 = 7'b1000000;
    //         		'h1: HEX4 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[5])
	// 				'h0: HEX5 = 7'b1000000;
    //         		'h1: HEX5 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[6])
	// 				'h0: HEX6 = 7'b1000000;
    //         		'h1: HEX6 = 7'b1111001;
	// 			endcase
	// 		end
	// 		SHIFT13: begin 
	// 			port_output = m_sequence & sample[6:0];
	// 			if(port_output == m_sequence) begin
	// 				peak_detected = 1;
	// 				led = 1;
	// 			end 
	// 			unique casez (port_output[0])
	// 				'h0: HEX0 = 7'b1000000;
    //         		'h1: HEX0 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[1])
	// 				'h0: HEX1 = 7'b1000000;
    //         		'h1: HEX1 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[2])
	// 				'h0: HEX2 = 7'b1000000;
    //         		'h1: HEX2 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[3])
	// 				'h0: HEX3 = 7'b1000000;
    //         		'h1: HEX3 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[4])
	// 				'h0: HEX4 = 7'b1000000;
    //         		'h1: HEX4 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[5])
	// 				'h0: HEX5 = 7'b1000000;
    //         		'h1: HEX5 = 7'b1111001;
	// 			endcase
	// 			unique casez (port_output[6])
	// 				'h0: HEX6 = 7'b1000000;
    //         		'h1: HEX6 = 7'b1111001;
	// 			endcase
	// 		end
	// 		DONE: begin 
				
	// 		end 

	// 			//alu_fpga alufpga (.CLOCK_50(clk), .port_output(port_output), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3), .HEX4(HEX4), .HEX5(HEX5), .HEX6(HEX6), .HEX7(HEX7));
	// 	endcase
	// end 

	
endmodule