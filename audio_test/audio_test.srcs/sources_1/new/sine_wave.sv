`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 05:56:37 PM
// Design Name: 
// Module Name: sine_wave
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


module sine_wave(output logic sine_out);

  import math_pkg::*;

  parameter  sampling_time = 5;

  const real pi = 3.1416;

  real       time_us, time_s ;

  bit        sampling_clock;

  real       freq = 20;

  real       offset = 2.5;

  real       ampl = 2.5;

  always sampling_clock = #(sampling_time) ~sampling_clock;

  always @(sampling_clock) begin

    time_us = $time/1000;

    time_s = time_us/1000000;

  end

  assign sine_out = offset + (ampl * sin(2*pi*freq*time_s));

endmodule
