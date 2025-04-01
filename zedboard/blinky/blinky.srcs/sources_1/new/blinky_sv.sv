`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2025 03:39:57 PM
// Design Name: 
// Module Name: blinky_sv
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


module blinky_sv(
    input logic clk,
    input logic nRst,
    input logic direction,
    output logic [7:0] leds
    );
    
    logic divclk;
    clock_divider #(.DIVIDER(50_000_000)) div(.clk_in(clk), .clk_out(divclk));
    
    always @(posedge divclk) begin
        if(nRst == 1) begin 
            leds <= 1;
        end
        else begin 
            if(direction == 1) begin 
                leds <= {leds[6:0], leds[7]};
            end 
            else begin 
                leds <= {leds[0], leds[6:1]};
            end 
        end 
    end 
endmodule
