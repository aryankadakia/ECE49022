`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2025 09:29:31 AM
// Design Name: 
// Module Name: test_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_tb();
    logic [7:0] a;
    logic [7:0] b;
    logic [7:0] out;
    
    test DUT (.a(a), .b(b), .out(out));
    
    initial begin 
        a = 0;
        b = 0;
        
        #(5ns);
        
        a = 2;
        b = 5;
        
        #(5ns);
        
        $finish;
    
    
    end 
endmodule
