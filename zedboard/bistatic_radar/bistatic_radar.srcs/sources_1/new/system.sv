`timescale 1ns / 1ps
`include "register_file_if.vh"

module system(
    input logic CLK,
    input logic nRst,
    input logic [6:0] m_sequence,
    input logic start,
    output logic peak_found
    );

    register_file_if rfif();
	register_file RF (CLK, nRst, rfif);

    parameter MAX_SHIFT = 12;

    // sample (larger array)
	logic [18:0] sample;
	assign sample = {m_sequence[5:0], m_sequence, m_sequence[6:1]};

	typedef enum logic [1:0] {IDLE, SHIFT, DONE} state_t;

	state_t state, next_state;

	logic [3:0] counter, next_counter;
	logic [6:0] port_output;
	logic [4:0] upper_bound, lower_bound;
	logic [3:0] sum;
	logic [3:0] peak;

    always_ff @(posedge CLK, negedge nRst) begin 
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
		rfif.WEN = '0;
		rfif.wsel = '0;
		rfif.wdat = '0;
		case(state)
			SHIFT: begin
				port_output = m_sequence & sample[18 - counter -: 7];
				for (int i = 0; i < 7; i++) begin
					sum = sum + port_output[i];
				end
				if(port_output == m_sequence) begin 
					peak_found = 1;
					peak = sum;
					rfif.WEN = 1;
					rfif.wsel = 4;
					rfif.wdat = peak;
				end 
			end
		endcase
	end 



endmodule
