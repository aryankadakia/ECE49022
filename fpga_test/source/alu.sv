// Arithmetic Logic Unit (ALU)
`include "alu_if.vh"
`include "cpu_types_pkg.vh"
import cpu_types_pkg::*;

module alu(
    alu_if.alu aluif
);

always_comb begin : ALU
    aluif.overflow = 1'b0;

    if(aluif.port_a > 0 && aluif.port_b > 0) begin 

    end 

    case(aluif.aluop) //casez 
        ALU_ADD: begin 
            aluif.port_output = $signed(aluif.port_a) + $signed(aluif.port_b);
            if(!aluif.port_a[31] && !aluif.port_b[31] && aluif.port_output[31]) begin 
                aluif.overflow = 1'b1;
            end 
            else if(aluif.port_a[31] && aluif.port_b[31] && !aluif.port_output[31]) begin
                aluif.overflow = 1'b1;
            end 
        end 
        ALU_SUB: begin 
            aluif.port_output = $signed(aluif.port_a) - $signed(aluif.port_b);
            if(aluif.port_a[31] && !aluif.port_b[31] && !aluif.port_output[31]) begin 
                aluif.overflow = 1'b1;
            end 
            else if (!aluif.port_a[31] && aluif.port_b[31] && aluif.port_output[31]) begin 
                aluif.overflow = 1'b1;
            end 
        end 
        ALU_SLL: begin 
            aluif.port_output = aluif.port_a << aluif.port_b[4:0];
        end 
        ALU_SRL: begin
            aluif.port_output = aluif.port_a >> aluif.port_b[4:0];
        end
        ALU_SRA: begin
            aluif.port_output = $signed(aluif.port_a) >>> $signed(aluif.port_b[4:0]);
        end
        ALU_AND: begin 
            aluif.port_output = aluif.port_a & aluif.port_b;
        end 
        ALU_OR: begin 
            aluif.port_output = aluif.port_a | aluif.port_b;
        end 
        ALU_XOR: begin
            aluif.port_output = aluif.port_a ^ aluif.port_b;
        end 
        ALU_SLT: begin 
            aluif.port_output = ($signed(aluif.port_a) < $signed(aluif.port_b)) ? 1 : 0;
        end 
        ALU_SLTU: begin
            //aluif.port_output = (aluif.port_a < aluif.port_b) ? 1 : 0;
             aluif.port_output = $signed(aluif.port_a) * $signed(aluif.port_b);
        end 
    endcase
end

assign aluif.zero = (aluif.port_output == 32'b0);
assign aluif.negative = (aluif.port_output[31]);

endmodule