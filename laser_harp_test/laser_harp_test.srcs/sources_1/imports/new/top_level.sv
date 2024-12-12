`timescale 1ns / 1ps
(*use_dsp="yes"*)
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
//module top_level(
//    input logic clk,
//    output logic SPKR,
//    output logic SPKL,
//    input  logic [7:0] SW,   // Switch input
//    output logic       [7:0]  hex_seg, // Hex display control
//	output logic       [3:0]  hex_grid // Hex display control
////	input logic VP,
////	input logic VN
//);

//logic [7:0] SW_s;

//sync_debounce SW_sync [7:0] (
//		.clk  (clk), 

//		.d    (SW), 
//		.q    (SW_s)
//	);	

////logic [4:0] channel;

////xadc_wiz_0 pot (
////        .dclk_in(clk),
////        .vn_in(VN),
////        .vp_in(VP),
////        .channel_out(channel)   
////);

//HexDriver hex (
//	.clk        (clk),
//	.in         ({4'b0, 4'b0, 4'b0, 4'b0}),
//	.hex_seg    (hex_seg),
//	.hex_grid   (hex_grid)
//);

//sine sine_wave (
//    .clk(clk),
//    .outR(SPKR),
//    .outL(SPKL),
//    .note_select(SW_s)
//);

// DO RE MI WORKS

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
integer resolution;

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
    .outR(outR),
    .outL(outL),
    .resolution(resolution),
    .phase_increment(phase_increment),
    .harmonics(harmonics)
);

//always_comb begin
//    case (SW_s)
//        16'b0000000000000001: 
//        begin
//        phase_increment = 1;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000000000010: begin
//        phase_increment = 2;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000000000100: begin
//        phase_increment = 3;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000000001000: begin
//        phase_increment = 4;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000000010000: begin
//        phase_increment = 5;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000000100000: begin
//        phase_increment = 6;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000001000000: begin
//        phase_increment = 7;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000010000000: begin
//        phase_increment = 8;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000100000000: begin
//        phase_increment = 1;   // SW0
//        harmonics = 1;
//        end
//        16'b0000001000000000: begin
//        phase_increment = 2;   // SW0
//        harmonics = 1;
//        end
//        16'b0000010000000000: begin
//        phase_increment = 3;   // SW0
//        harmonics = 1;
//        end
//        16'b0000100000000000: begin
//        phase_increment = 4;   // SW0
//        harmonics = 1;
//        end
//        16'b0001000000000000: begin
//        phase_increment = 5;   // SW0
//        harmonics = 1;
//        end
//        16'b0010000000000000: begin
//        phase_increment = 6;   // SW0
//        harmonics = 1;
//        end
//        16'b0100000000000000: begin
//        phase_increment = 7;   // SW0
//        harmonics = 1;
//        end
//        16'b1000000000000000: begin
//        phase_increment = 8;   // SW0
//        harmonics = 1;
//        end
//        default: phase_increment = 0;       // Default to 0 if no switch is active
//    endcase
//end

//logic flag;
//logic flag_next;

//always_ff @ (posedge clk) 
//begin
//    flag <= flag_next;  
//end

//always_comb begin
//    if (keycode == 8'b00000001)
//        begin
//           flag_next = 1'b1;   
//        end
//        else if (keycode == 8'b00000010)
//        begin
//           flag_next = 1'b0;
//        end   
//end 
              
//always_comb begin
//    if (flag) 
//    begin
//         phase_increment = 1;   // SW0
//         harmonics = 0;  
//    end
//    else 
//    begin
//         phase_increment = 2;   // SW0
//    end
//end

//always_comb begin
//    case (out)
//        6'b000001: 
//        begin
//            phase_increment = 1;   // SW0
//            harmonics = 0;
//        end
//        6'b000010: begin
//            phase_increment = 2;   // SW0
//            harmonics = 0;
//        end
//        6'b000100: begin
//            phase_increment = 3;   // SW0
//            harmonics = 0;
//        end
//        6'b001000: begin
//            phase_increment = 4;   // SW0
//            harmonics = 0;
//        end
//        6'b010000: begin
//            phase_increment = 5;   // SW0
//            harmonics = 0;
//        end
//        6'b100000: begin
//            phase_increment = 6;   // SW0
//            harmonics = 0;
//        end
//        default: phase_increment = 0;       // Default to 0 if no switch is active
//    endcase
//end

always_comb begin
    if(red_click || (out == 6'b000001))
        begin
//            phase_increment = 1;   // SW0
            resolution = 382;   // SW0
            phase_increment = 2;   // SW0
            harmonics = 0;
        end
    else if (orange_click || (out == 6'b000010)) 
        begin
            resolution = 340;   // SW0
            phase_increment = 2;   // SW0
            harmonics = 0;
        end
    else if (yellow_click || (out == 6'b000100)) 
        begin
            resolution = 303;   // SW0
            phase_increment = 2;   // SW0
            harmonics = 0;
        end
    else if (green_click || (out == 6'b001000)) 
        begin
            resolution = 288;   // SW0
            phase_increment = 2;   // SW0
            harmonics = 0;
        end
    else if (blue_click || (out == 6'b010000))
        begin
           resolution = 255;   // SW0
           phase_increment = 2;   // SW0
           harmonics = 0;
        end
    else if (indigo_click || (out == 6'b100000)) 
        begin
            resolution = 227;   // SW0
            phase_increment = 2;   // SW0
            harmonics = 0;
        end
    else if (violet_click) 
        begin
            resolution = 202;   // SW0
            phase_increment = 2;   // SW0
            harmonics = 0;
        end
    else 
        begin 
            phase_increment = 0;  
        end     // Default to 0 if no switch is active
end

//WORKING OVERALL 

//module top_level(
//    input logic clk,
//    output logic SPKR,
//    output logic SPKL,
//    input  logic [15:0] SW,   // Switch input
//    output logic       [7:0]  hex_seg, // Hex display control
//	output logic       [3:0]  hex_grid // Hex display control
//);

//logic [15:0] SW_s;
//integer phase_increment;

//sync_debounce SW_sync [15:0] (
//		.clk  (clk), 

//		.d    (SW), 
//		.q    (SW_s)
//	);	
	
//HexDriver hex (
//	.clk        (clk),
//	.in         ({4'b0, 4'b0, 4'b0, 4'b0}),
//	.hex_seg    (hex_seg),
//	.hex_grid   (hex_grid)
//);

//sine sine_wave (
//    .clk(clk),
//    .outR(SPKR),
//    .outL(SPKL),
//    .phase_increment(phase_increment),
//    .harmonics(harmonics)
//);

//logic harmonics;

//always_comb begin
//    case (SW_s)
//        16'b0000000000000001: 
//        begin
//        phase_increment = 1;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000000000010: begin
//        phase_increment = 2;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000000000100: begin
//        phase_increment = 3;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000000001000: begin
//        phase_increment = 4;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000000010000: begin
//        phase_increment = 5;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000000100000: begin
//        phase_increment = 6;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000001000000: begin
//        phase_increment = 7;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000010000000: begin
//        phase_increment = 8;   // SW0
//        harmonics = 0;
//        end
//        16'b0000000100000000: begin
//        phase_increment = 1;   // SW0
//        harmonics = 1;
//        end
//        16'b0000001000000000: begin
//        phase_increment = 2;   // SW0
//        harmonics = 1;
//        end
//        16'b0000010000000000: begin
//        phase_increment = 3;   // SW0
//        harmonics = 1;
//        end
//        16'b0000100000000000: begin
//        phase_increment = 4;   // SW0
//        harmonics = 1;
//        end
//        16'b0001000000000000: begin
//        phase_increment = 5;   // SW0
//        harmonics = 1;
//        end
//        16'b0010000000000000: begin
//        phase_increment = 6;   // SW0
//        harmonics = 1;
//        end
//        16'b0100000000000000: begin
//        phase_increment = 7;   // SW0
//        harmonics = 1;
//        end
//        16'b1000000000000000: begin
//        phase_increment = 8;   // SW0
//        harmonics = 1;
//        end
//        default: phase_increment = 0;       // Default to 0 if no switch is active
//    endcase
//end

endmodule

	
