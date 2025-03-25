// Arithmetic Logic Unit (ALU)

`ifndef ALU_IF_VH
`define ALU_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface alu_if;
  // import types
  import cpu_types_pkg::*;

  logic negative, overflow, zero;
  word_t port_a, port_b, port_output; 
  aluop_t aluop;

  // alu ports
  modport alu (
    input port_a, port_b, aluop,
    output negative, port_output, overflow, zero
  );
  // alu tb
  modport tb (
    input negative, port_output, overflow, zero,
    output port_a, port_b, aluop
  );
endinterface

`endif // ALU_IF_VH
