`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2024 05:51:37 PM
// Design Name: 
// Module Name: math_package
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

package math_pkg;

  //import dpi task      C Name = SV function name

  import "DPI-C" pure function real cos (input real rTheta);

  import "DPI-C" pure function real sin (input real rTheta);

  import "DPI-C" pure function real log (input real rVal);

  import "DPI-C" pure function real log10 (input real rVal);

endpackage : math_pkg