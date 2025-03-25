`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2025 06:14:17 PM
// Design Name: 
// Module Name: blinky
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


module blinky(
    input wire clk,
    input wire reset,
    input wire direction,
    output reg [7:0] leds
    );
    
    always @(posedge clk) begin
        if(reset == 1) begin 
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
