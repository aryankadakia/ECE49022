`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2025 04:08:51 PM
// Design Name: 
// Module Name: clock_divider
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


module clock_divider(
    input logic clk_in,
    output logic clk_out
    );
    
    parameter DIVIDER = 10000;
//    localparam WIDTH = $clog2(10000);
    reg [$clog2(DIVIDER)-1:0] count = 0;
    logic reset = 1;
    
    
    always_ff @ (posedge clk_in) begin 
        if(reset == 1) begin 
            reset <= 0;
            clk_out <= 0;
            count <= 0;
        end 
        else begin
            if(count == DIVIDER) begin 
                clk_out <= ~clk_out;
                count <= 0;
            end
            else begin 
                count <= count + 1;
            end  
        end 
    end 
endmodule
