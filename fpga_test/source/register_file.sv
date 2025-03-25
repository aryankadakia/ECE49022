// register file
`include "register_file_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module register_file (
    input logic CLK,
    input logic nRST,
    register_file_if.rf rfif
);

// 32 regs each 32 bit size
word_t [31:0] register; 
word_t [31:0] next_register; 

always_ff @(posedge CLK, negedge nRST) begin 
    if(!nRST) begin
        register <= '0;
    end 
    else begin 
        register <= next_register;
    end 
end 

always_comb begin : WRITE_READ
    next_register = register;
    rfif.rdat1  = '0;
    rfif.rdat2  = '0;
    if(rfif.WEN && rfif.wsel != 5'd0) begin
        next_register[rfif.wsel] = rfif.wdat;
    end
    if(rfif.rsel1) begin 
        rfif.rdat1 = register[rfif.rsel1];
    end 
    if(rfif.rsel2) begin 
        rfif.rdat2 = register[rfif.rsel2];
    end 
end

endmodule