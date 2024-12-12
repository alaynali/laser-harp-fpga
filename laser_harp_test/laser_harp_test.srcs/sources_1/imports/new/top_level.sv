`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/16/2024 05:10:27 PM
// Design Name: 
// Module Name: top_level
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

module sound(
    input logic clk,
    output logic SPKR,
    output logic SPKL,
    input  logic [15:0] SW,   // Switch input
    input logic red_click,
    input logic orange_click,
    input logic yellow_click,
    input logic green_click,
    input logic blue_click,
    input logic indigo_click,
    input logic violet_click,
    input logic JAB_0,
	input logic JAB_1,
	input logic JAB_2,
	input logic JAB_3,
	input logic JAB_4,
	input logic JAB_5
//    input logic [7:0] keycode
);

logic [15:0] SW_s;
integer phase_increment;	
logic harmonics;

logic [5:0]	out;

always_ff @(posedge clk)begin
    out <= {JAB_5,JAB_4,JAB_3,JAB_2,JAB_1, JAB_0}; 
end	

sync_debounce SW_sync [15:0] (
		.clk  (clk), 

		.d    (SW), 
		.q    (SW_s)
	);	
	
sine sine_wave (
    .clk(clk),
    .outR(SPKR),
    .outL(SPKL),
    .phase_increment(phase_increment),
    .harmonics(harmonics)
);

always_comb begin
    if(red_click || (out == 6'b000001))
        begin
            phase_increment = 1;   // SW0
        end
    else if (orange_click || (out == 6'b000010)) 
        begin
            phase_increment = 2;   // SW0
        end
    else if (yellow_click || (out == 6'b000100)) 
        begin
            phase_increment = 3;   // SW0
        end
    else if (green_click || (out == 6'b001000)) 
        begin
            phase_increment = 4;   // SW0
        end
    else if (blue_click || (out == 6'b010000))
        begin
            phase_increment = 5;   // SW0
        end
    else if (indigo_click || (out == 6'b100000)) 
        begin
            phase_increment = 6;   // SW0
        end
    else if (violet_click) 
        begin
            phase_increment = 7;   // SW0
        end
    else 
        begin 
            phase_increment = 0;  
        end     // Default to 0 if no switch is active
end


endmodule

	
