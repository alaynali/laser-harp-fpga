`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/28/2024 05:04:43 PM
// Design Name: 
// Module Name: sine
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

module sine(
        input logic clk,
        output logic outR,
        output logic outL,
        input integer phase_increment,
        input logic harmonics,
        input integer resolution
    );

parameter COUNTS_PER_INTERVAL = 2000;
//parameter RESOLUTION = 256; // Samples per sine wave period

logic [15:0] counter;
logic [15:0] sample_fun;
logic [15:0] sample_2nd;
logic [15:0] sample_3rd;
logic [15:0] sample_4th;
logic [15:0] sample_5th;
integer phase_fun = 0;
integer phase_2nd = 0;
integer phase_3rd = 0;
integer phase_4th = 0;
integer phase_5th = 0;

// Fundamental frequency table for 50kHz, 2000
logic [15:0] sine_lut_fun [0:255] = {
    16'd1000,
    16'd1024,
    16'd1049,
    16'd1073,
    16'd1098,
    16'd1122,
    16'd1146,
    16'd1170,
    16'd1195,
    16'd1219,
    16'd1242,
    16'd1266,
    16'd1290,
    16'd1313,
    16'd1336,
    16'd1359,
    16'd1382,
    16'd1405,
    16'd1427,
    16'd1449,
    16'd1471,
    16'd1492,
    16'd1514,
    16'd1534,
    16'd1555,
    16'd1575,
    16'd1595,
    16'd1615,
    16'd1634,
    16'd1653,
    16'd1671,
    16'd1689,
    16'd1707,
    16'd1724,
    16'd1740,
    16'd1757,
    16'd1773,
    16'd1788,
    16'd1803,
    16'd1817,
    16'd1831,
    16'd1844,
    16'd1857,
    16'd1870,
    16'd1881,
    16'd1893,
    16'd1903,
    16'd1914,
    16'd1923,
    16'd1932,
    16'd1941,
    16'd1949,
    16'd1956,
    16'd1963,
    16'd1970,
    16'd1975,
    16'd1980,
    16'd1985,
    16'd1989,
    16'd1992,
    16'd1995,
    16'd1997,
    16'd1998,
    16'd1999,
    16'd2000,
    16'd1999,
    16'd1998,
    16'd1997,
    16'd1995,
    16'd1992,
    16'd1989,
    16'd1985,
    16'd1980,
    16'd1975,
    16'd1970,
    16'd1963,
    16'd1956,
    16'd1949,
    16'd1941,
    16'd1932,
    16'd1923,
    16'd1914,
    16'd1903,
    16'd1893,
    16'd1881,
    16'd1870,
    16'd1857,
    16'd1844,
    16'd1831,
    16'd1817,
    16'd1803,
    16'd1788,
    16'd1773,
    16'd1757,
    16'd1740,
    16'd1724,
    16'd1707,
    16'd1689,
    16'd1671,
    16'd1653,
    16'd1634,
    16'd1615,
    16'd1595,
    16'd1575,
    16'd1555,
    16'd1534,
    16'd1514,
    16'd1492,
    16'd1471,
    16'd1449,
    16'd1427,
    16'd1405,
    16'd1382,
    16'd1359,
    16'd1336,
    16'd1313,
    16'd1290,
    16'd1266,
    16'd1242,
    16'd1219,
    16'd1195,
    16'd1170,
    16'd1146,
    16'd1122,
    16'd1098,
    16'd1073,
    16'd1049,
    16'd1024,
    16'd1000,
    16'd975,
    16'd950,
    16'd926,
    16'd901,
    16'd877,
    16'd853,
    16'd829,
    16'd804,
    16'd780,
    16'd757,
    16'd733,
    16'd709,
    16'd686,
    16'd663,
    16'd640,
    16'd617,
    16'd594,
    16'd572,
    16'd550,
    16'd528,
    16'd507,
    16'd485,
    16'd465,
    16'd444,
    16'd424,
    16'd404,
    16'd384,
    16'd365,
    16'd346,
    16'd328,
    16'd310,
    16'd292,
    16'd275,
    16'd259,
    16'd242,
    16'd226,
    16'd211,
    16'd196,
    16'd182,
    16'd168,
    16'd155,
    16'd142,
    16'd129,
    16'd118,
    16'd106,
    16'd96,
    16'd85,
    16'd76,
    16'd67,
    16'd58,
    16'd50,
    16'd43,
    16'd36,
    16'd29,
    16'd24,
    16'd19,
    16'd14,
    16'd10,
    16'd7,
    16'd4,
    16'd2,
    16'd1,
    16'd0,
    16'd0,
    16'd0,
    16'd1,
    16'd2,
    16'd4,
    16'd7,
    16'd10,
    16'd14,
    16'd19,
    16'd24,
    16'd29,
    16'd36,
    16'd43,
    16'd50,
    16'd58,
    16'd67,
    16'd76,
    16'd85,
    16'd96,
    16'd106,
    16'd118,
    16'd129,
    16'd142,
    16'd155,
    16'd168,
    16'd182,
    16'd196,
    16'd211,
    16'd226,
    16'd242,
    16'd259,
    16'd275,
    16'd292,
    16'd310,
    16'd328,
    16'd346,
    16'd365,
    16'd384,
    16'd404,
    16'd424,
    16'd444,
    16'd465,
    16'd485,
    16'd507,
    16'd528,
    16'd550,
    16'd572,
    16'd594,
    16'd617,
    16'd640,
    16'd663,
    16'd686,
    16'd709,
    16'd733,
    16'd757,
    16'd780,
    16'd804,
    16'd829,
    16'd853,
    16'd877,
    16'd901,
    16'd926,
    16'd950,
    16'd975
};

 //First harmonic at 100kHz, 1000
logic [15:0] sine_lut_1st [0:255] = {
    16'd500,
    16'd512,
    16'd524,
    16'd536,
    16'd549,
    16'd561,
    16'd573,
    16'd585,
    16'd597,
    16'd609,
    16'd621,
    16'd633,
    16'd645,
    16'd656,
    16'd668,
    16'd679,
    16'd691,
    16'd702,
    16'd713,
    16'd724,
    16'd735,
    16'd746,
    16'd757,
    16'd767,
    16'd777,
    16'd787,
    16'd797,
    16'd807,
    16'd817,
    16'd826,
    16'd835,
    16'd844,
    16'd853,
    16'd862,
    16'd870,
    16'd878,
    16'd886,
    16'd894,
    16'd901,
    16'd908,
    16'd915,
    16'd922,
    16'd928,
    16'd935,
    16'd940,
    16'd946,
    16'd951,
    16'd957,
    16'd961,
    16'd966,
    16'd970,
    16'd974,
    16'd978,
    16'd981,
    16'd985,
    16'd987,
    16'd990,
    16'd992,
    16'd994,
    16'd996,
    16'd997,
    16'd998,
    16'd999,
    16'd999,
    16'd1000,
    16'd999,
    16'd999,
    16'd998,
    16'd997,
    16'd996,
    16'd994,
    16'd992,
    16'd990,
    16'd987,
    16'd985,
    16'd981,
    16'd978,
    16'd974,
    16'd970,
    16'd966,
    16'd961,
    16'd957,
    16'd951,
    16'd946,
    16'd940,
    16'd935,
    16'd928,
    16'd922,
    16'd915,
    16'd908,
    16'd901,
    16'd894,
    16'd886,
    16'd878,
    16'd870,
    16'd862,
    16'd853,
    16'd844,
    16'd835,
    16'd826,
    16'd817,
    16'd807,
    16'd797,
    16'd787,
    16'd777,
    16'd767,
    16'd757,
    16'd746,
    16'd735,
    16'd724,
    16'd713,
    16'd702,
    16'd691,
    16'd679,
    16'd668,
    16'd656,
    16'd645,
    16'd633,
    16'd621,
    16'd609,
    16'd597,
    16'd585,
    16'd573,
    16'd561,
    16'd549,
    16'd536,
    16'd524,
    16'd512,
    16'd500,
    16'd487,
    16'd475,
    16'd463,
    16'd450,
    16'd438,
    16'd426,
    16'd414,
    16'd402,
    16'd390,
    16'd378,
    16'd366,
    16'd354,
    16'd343,
    16'd331,
    16'd320,
    16'd308,
    16'd297,
    16'd286,
    16'd275,
    16'd264,
    16'd253,
    16'd242,
    16'd232,
    16'd222,
    16'd212,
    16'd202,
    16'd192,
    16'd182,
    16'd173,
    16'd164,
    16'd155,
    16'd146,
    16'd137,
    16'd129,
    16'd121,
    16'd113,
    16'd105,
    16'd98,
    16'd91,
    16'd84,
    16'd77,
    16'd71,
    16'd64,
    16'd59,
    16'd53,
    16'd48,
    16'd42,
    16'd38,
    16'd33,
    16'd29,
    16'd25,
    16'd21,
    16'd18,
    16'd14,
    16'd12,
    16'd9,
    16'd7,
    16'd5,
    16'd3,
    16'd2,
    16'd1,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd1,
    16'd2,
    16'd3,
    16'd5,
    16'd7,
    16'd9,
    16'd12,
    16'd14,
    16'd18,
    16'd21,
    16'd25,
    16'd29,
    16'd33,
    16'd38,
    16'd42,
    16'd48,
    16'd53,
    16'd59,
    16'd64,
    16'd71,
    16'd77,
    16'd84,
    16'd91,
    16'd98,
    16'd105,
    16'd113,
    16'd121,
    16'd129,
    16'd137,
    16'd146,
    16'd155,
    16'd164,
    16'd173,
    16'd182,
    16'd192,
    16'd202,
    16'd212,
    16'd222,
    16'd232,
    16'd242,
    16'd253,
    16'd264,
    16'd275,
    16'd286,
    16'd297,
    16'd308,
    16'd320,
    16'd331,
    16'd343,
    16'd354,
    16'd366,
    16'd378,
    16'd390,
    16'd402,
    16'd414,
    16'd426,
    16'd438,
    16'd450,
    16'd463,
    16'd475,
    16'd487
};

// Second harmonic at 150kHz, 666
logic [15:0] sine_lut_2nd [0:255] = {
    16'd333,
    16'd341,
    16'd349,
    16'd357,
    16'd365,
    16'd373,
    16'd381,
    16'd389,
    16'd397,
    16'd405,
    16'd413,
    16'd421,
    16'd429,
    16'd437,
    16'd445,
    16'd452,
    16'd460,
    16'd467,
    16'd475,
    16'd482,
    16'd489,
    16'd497,
    16'd504,
    16'd511,
    16'd518,
    16'd524,
    16'd531,
    16'd537,
    16'd544,
    16'd550,
    16'd556,
    16'd562,
    16'd568,
    16'd574,
    16'd579,
    16'd585,
    16'd590,
    16'd595,
    16'd600,
    16'd605,
    16'd609,
    16'd614,
    16'd618,
    16'd622,
    16'd626,
    16'd630,
    16'd634,
    16'd637,
    16'd640,
    16'd643,
    16'd646,
    16'd649,
    16'd651,
    16'd653,
    16'd656,
    16'd657,
    16'd659,
    16'd661,
    16'd662,
    16'd663,
    16'd664,
    16'd665,
    16'd665,
    16'd665,
    16'd666,
    16'd665,
    16'd665,
    16'd665,
    16'd664,
    16'd663,
    16'd662,
    16'd661,
    16'd659,
    16'd657,
    16'd656,
    16'd653,
    16'd651,
    16'd649,
    16'd646,
    16'd643,
    16'd640,
    16'd637,
    16'd634,
    16'd630,
    16'd626,
    16'd622,
    16'd618,
    16'd614,
    16'd609,
    16'd605,
    16'd600,
    16'd595,
    16'd590,
    16'd585,
    16'd579,
    16'd574,
    16'd568,
    16'd562,
    16'd556,
    16'd550,
    16'd544,
    16'd537,
    16'd531,
    16'd524,
    16'd518,
    16'd511,
    16'd504,
    16'd497,
    16'd489,
    16'd482,
    16'd475,
    16'd467,
    16'd460,
    16'd452,
    16'd445,
    16'd437,
    16'd429,
    16'd421,
    16'd413,
    16'd405,
    16'd397,
    16'd389,
    16'd381,
    16'd373,
    16'd365,
    16'd357,
    16'd349,
    16'd341,
    16'd333,
    16'd324,
    16'd316,
    16'd308,
    16'd300,
    16'd292,
    16'd284,
    16'd276,
    16'd268,
    16'd260,
    16'd252,
    16'd244,
    16'd236,
    16'd228,
    16'd220,
    16'd213,
    16'd205,
    16'd198,
    16'd190,
    16'd183,
    16'd176,
    16'd168,
    16'd161,
    16'd154,
    16'd147,
    16'd141,
    16'd134,
    16'd128,
    16'd121,
    16'd115,
    16'd109,
    16'd103,
    16'd97,
    16'd91,
    16'd86,
    16'd80,
    16'd75,
    16'd70,
    16'd65,
    16'd60,
    16'd56,
    16'd51,
    16'd47,
    16'd43,
    16'd39,
    16'd35,
    16'd31,
    16'd28,
    16'd25,
    16'd22,
    16'd19,
    16'd16,
    16'd14,
    16'd12,
    16'd9,
    16'd8,
    16'd6,
    16'd4,
    16'd3,
    16'd2,
    16'd1,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd1,
    16'd2,
    16'd3,
    16'd4,
    16'd6,
    16'd8,
    16'd9,
    16'd12,
    16'd14,
    16'd16,
    16'd19,
    16'd22,
    16'd25,
    16'd28,
    16'd31,
    16'd35,
    16'd39,
    16'd43,
    16'd47,
    16'd51,
    16'd56,
    16'd60,
    16'd65,
    16'd70,
    16'd75,
    16'd80,
    16'd86,
    16'd91,
    16'd97,
    16'd103,
    16'd109,
    16'd115,
    16'd121,
    16'd128,
    16'd134,
    16'd141,
    16'd147,
    16'd154,
    16'd161,
    16'd168,
    16'd176,
    16'd183,
    16'd190,
    16'd198,
    16'd205,
    16'd213,
    16'd220,
    16'd228,
    16'd236,
    16'd244,
    16'd252,
    16'd260,
    16'd268,
    16'd276,
    16'd284,
    16'd292,
    16'd300,
    16'd308,
    16'd316,
    16'd324
};

// Third harmonic at 200kHz, 500
logic [15:0] sine_lut_3rd [0:255] = {
    16'd250,
    16'd256,
    16'd262,
    16'd268,
    16'd274,
    16'd280,
    16'd286,
    16'd292,
    16'd298,
    16'd304,
    16'd310,
    16'd316,
    16'd322,
    16'd328,
    16'd334,
    16'd339,
    16'd345,
    16'd351,
    16'd356,
    16'd362,
    16'd367,
    16'd373,
    16'd378,
    16'd383,
    16'd388,
    16'd393,
    16'd398,
    16'd403,
    16'd408,
    16'd413,
    16'd417,
    16'd422,
    16'd426,
    16'd431,
    16'd435,
    16'd439,
    16'd443,
    16'd447,
    16'd450,
    16'd454,
    16'd457,
    16'd461,
    16'd464,
    16'd467,
    16'd470,
    16'd473,
    16'd475,
    16'd478,
    16'd480,
    16'd483,
    16'd485,
    16'd487,
    16'd489,
    16'd490,
    16'd492,
    16'd493,
    16'd495,
    16'd496,
    16'd497,
    16'd498,
    16'd498,
    16'd499,
    16'd499,
    16'd499,
    16'd500,
    16'd499,
    16'd499,
    16'd499,
    16'd498,
    16'd498,
    16'd497,
    16'd496,
    16'd495,
    16'd493,
    16'd492,
    16'd490,
    16'd489,
    16'd487,
    16'd485,
    16'd483,
    16'd480,
    16'd478,
    16'd475,
    16'd473,
    16'd470,
    16'd467,
    16'd464,
    16'd461,
    16'd457,
    16'd454,
    16'd450,
    16'd447,
    16'd443,
    16'd439,
    16'd435,
    16'd431,
    16'd426,
    16'd422,
    16'd417,
    16'd413,
    16'd408,
    16'd403,
    16'd398,
    16'd393,
    16'd388,
    16'd383,
    16'd378,
    16'd373,
    16'd367,
    16'd362,
    16'd356,
    16'd351,
    16'd345,
    16'd339,
    16'd334,
    16'd328,
    16'd322,
    16'd316,
    16'd310,
    16'd304,
    16'd298,
    16'd292,
    16'd286,
    16'd280,
    16'd274,
    16'd268,
    16'd262,
    16'd256,
    16'd250,
    16'd243,
    16'd237,
    16'd231,
    16'd225,
    16'd219,
    16'd213,
    16'd207,
    16'd201,
    16'd195,
    16'd189,
    16'd183,
    16'd177,
    16'd171,
    16'd165,
    16'd160,
    16'd154,
    16'd148,
    16'd143,
    16'd137,
    16'd132,
    16'd126,
    16'd121,
    16'd116,
    16'd111,
    16'd106,
    16'd101,
    16'd96,
    16'd91,
    16'd86,
    16'd82,
    16'd77,
    16'd73,
    16'd68,
    16'd64,
    16'd60,
    16'd56,
    16'd52,
    16'd49,
    16'd45,
    16'd42,
    16'd38,
    16'd35,
    16'd32,
    16'd29,
    16'd26,
    16'd24,
    16'd21,
    16'd19,
    16'd16,
    16'd14,
    16'd12,
    16'd10,
    16'd9,
    16'd7,
    16'd6,
    16'd4,
    16'd3,
    16'd2,
    16'd1,
    16'd1,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd1,
    16'd1,
    16'd2,
    16'd3,
    16'd4,
    16'd6,
    16'd7,
    16'd9,
    16'd10,
    16'd12,
    16'd14,
    16'd16,
    16'd19,
    16'd21,
    16'd24,
    16'd26,
    16'd29,
    16'd32,
    16'd35,
    16'd38,
    16'd42,
    16'd45,
    16'd49,
    16'd52,
    16'd56,
    16'd60,
    16'd64,
    16'd68,
    16'd73,
    16'd77,
    16'd82,
    16'd86,
    16'd91,
    16'd96,
    16'd101,
    16'd106,
    16'd111,
    16'd116,
    16'd121,
    16'd126,
    16'd132,
    16'd137,
    16'd143,
    16'd148,
    16'd154,
    16'd160,
    16'd165,
    16'd171,
    16'd177,
    16'd183,
    16'd189,
    16'd195,
    16'd201,
    16'd207,
    16'd213,
    16'd219,
    16'd225,
    16'd231,
    16'd237,
    16'd243
};

// Fourth harmonic at 250khz, 400
logic [15:0] sine_lut_4th [0:255] = {
    16'd200,
    16'd204,
    16'd209,
    16'd214,
    16'd219,
    16'd224,
    16'd229,
    16'd234,
    16'd239,
    16'd243,
    16'd248,
    16'd253,
    16'd258,
    16'd262,
    16'd267,
    16'd271,
    16'd276,
    16'd281,
    16'd285,
    16'd289,
    16'd294,
    16'd298,
    16'd302,
    16'd306,
    16'd311,
    16'd315,
    16'd319,
    16'd323,
    16'd326,
    16'd330,
    16'd334,
    16'd337,
    16'd341,
    16'd344,
    16'd348,
    16'd351,
    16'd354,
    16'd357,
    16'd360,
    16'd363,
    16'd366,
    16'd368,
    16'd371,
    16'd374,
    16'd376,
    16'd378,
    16'd380,
    16'd382,
    16'd384,
    16'd386,
    16'd388,
    16'd389,
    16'd391,
    16'd392,
    16'd394,
    16'd395,
    16'd396,
    16'd397,
    16'd397,
    16'd398,
    16'd399,
    16'd399,
    16'd399,
    16'd399,
    16'd400,
    16'd399,
    16'd399,
    16'd399,
    16'd399,
    16'd398,
    16'd397,
    16'd397,
    16'd396,
    16'd395,
    16'd394,
    16'd392,
    16'd391,
    16'd389,
    16'd388,
    16'd386,
    16'd384,
    16'd382,
    16'd380,
    16'd378,
    16'd376,
    16'd374,
    16'd371,
    16'd368,
    16'd366,
    16'd363,
    16'd360,
    16'd357,
    16'd354,
    16'd351,
    16'd348,
    16'd344,
    16'd341,
    16'd337,
    16'd334,
    16'd330,
    16'd326,
    16'd323,
    16'd319,
    16'd315,
    16'd311,
    16'd306,
    16'd302,
    16'd298,
    16'd294,
    16'd289,
    16'd285,
    16'd281,
    16'd276,
    16'd271,
    16'd267,
    16'd262,
    16'd258,
    16'd253,
    16'd248,
    16'd243,
    16'd239,
    16'd234,
    16'd229,
    16'd224,
    16'd219,
    16'd214,
    16'd209,
    16'd204,
    16'd200,
    16'd195,
    16'd190,
    16'd185,
    16'd180,
    16'd175,
    16'd170,
    16'd165,
    16'd160,
    16'd156,
    16'd151,
    16'd146,
    16'd141,
    16'd137,
    16'd132,
    16'd128,
    16'd123,
    16'd118,
    16'd114,
    16'd110,
    16'd105,
    16'd101,
    16'd97,
    16'd93,
    16'd88,
    16'd84,
    16'd80,
    16'd76,
    16'd73,
    16'd69,
    16'd65,
    16'd62,
    16'd58,
    16'd55,
    16'd51,
    16'd48,
    16'd45,
    16'd42,
    16'd39,
    16'd36,
    16'd33,
    16'd31,
    16'd28,
    16'd25,
    16'd23,
    16'd21,
    16'd19,
    16'd17,
    16'd15,
    16'd13,
    16'd11,
    16'd10,
    16'd8,
    16'd7,
    16'd5,
    16'd4,
    16'd3,
    16'd2,
    16'd2,
    16'd1,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd1,
    16'd2,
    16'd2,
    16'd3,
    16'd4,
    16'd5,
    16'd7,
    16'd8,
    16'd10,
    16'd11,
    16'd13,
    16'd15,
    16'd17,
    16'd19,
    16'd21,
    16'd23,
    16'd25,
    16'd28,
    16'd31,
    16'd33,
    16'd36,
    16'd39,
    16'd42,
    16'd45,
    16'd48,
    16'd51,
    16'd55,
    16'd58,
    16'd62,
    16'd65,
    16'd69,
    16'd73,
    16'd76,
    16'd80,
    16'd84,
    16'd88,
    16'd93,
    16'd97,
    16'd101,
    16'd105,
    16'd110,
    16'd114,
    16'd118,
    16'd123,
    16'd128,
    16'd132,
    16'd137,
    16'd141,
    16'd146,
    16'd151,
    16'd156,
    16'd160,
    16'd165,
    16'd170,
    16'd175,
    16'd180,
    16'd185,
    16'd190,
    16'd195
};

// Fifth harmonic at 300kHz, 333
logic [15:0] sine_lut_5th [0:255] = {
    16'd166,
    16'd170,
    16'd174,
    16'd178,
    16'd182,
    16'd186,
    16'd190,
    16'd194,
    16'd198,
    16'd202,
    16'd206,
    16'd210,
    16'd214,
    16'd218,
    16'd222,
    16'd226,
    16'd230,
    16'd233,
    16'd237,
    16'd241,
    16'd244,
    16'd248,
    16'd252,
    16'd255,
    16'd259,
    16'd262,
    16'd265,
    16'd268,
    16'd272,
    16'd275,
    16'd278,
    16'd281,
    16'd284,
    16'd287,
    16'd289,
    16'd292,
    16'd295,
    16'd297,
    16'd300,
    16'd302,
    16'd304,
    16'd307,
    16'd309,
    16'd311,
    16'd313,
    16'd315,
    16'd317,
    16'd318,
    16'd320,
    16'd321,
    16'd323,
    16'd324,
    16'd325,
    16'd326,
    16'd328,
    16'd328,
    16'd329,
    16'd330,
    16'd331,
    16'd331,
    16'd332,
    16'd332,
    16'd332,
    16'd332,
    16'd333,
    16'd332,
    16'd332,
    16'd332,
    16'd332,
    16'd331,
    16'd331,
    16'd330,
    16'd329,
    16'd328,
    16'd328,
    16'd326,
    16'd325,
    16'd324,
    16'd323,
    16'd321,
    16'd320,
    16'd318,
    16'd317,
    16'd315,
    16'd313,
    16'd311,
    16'd309,
    16'd307,
    16'd304,
    16'd302,
    16'd300,
    16'd297,
    16'd295,
    16'd292,
    16'd289,
    16'd287,
    16'd284,
    16'd281,
    16'd278,
    16'd275,
    16'd272,
    16'd268,
    16'd265,
    16'd262,
    16'd259,
    16'd255,
    16'd252,
    16'd248,
    16'd244,
    16'd241,
    16'd237,
    16'd233,
    16'd230,
    16'd226,
    16'd222,
    16'd218,
    16'd214,
    16'd210,
    16'd206,
    16'd202,
    16'd198,
    16'd194,
    16'd190,
    16'd186,
    16'd182,
    16'd178,
    16'd174,
    16'd170,
    16'd166,
    16'd162,
    16'd158,
    16'd154,
    16'd150,
    16'd146,
    16'd142,
    16'd138,
    16'd134,
    16'd130,
    16'd126,
    16'd122,
    16'd118,
    16'd114,
    16'd110,
    16'd106,
    16'd102,
    16'd99,
    16'd95,
    16'd91,
    16'd88,
    16'd84,
    16'd80,
    16'd77,
    16'd73,
    16'd70,
    16'd67,
    16'd64,
    16'd60,
    16'd57,
    16'd54,
    16'd51,
    16'd48,
    16'd45,
    16'd43,
    16'd40,
    16'd37,
    16'd35,
    16'd32,
    16'd30,
    16'd28,
    16'd25,
    16'd23,
    16'd21,
    16'd19,
    16'd17,
    16'd15,
    16'd14,
    16'd12,
    16'd11,
    16'd9,
    16'd8,
    16'd7,
    16'd6,
    16'd4,
    16'd4,
    16'd3,
    16'd2,
    16'd1,
    16'd1,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd0,
    16'd1,
    16'd1,
    16'd2,
    16'd3,
    16'd4,
    16'd4,
    16'd6,
    16'd7,
    16'd8,
    16'd9,
    16'd11,
    16'd12,
    16'd14,
    16'd15,
    16'd17,
    16'd19,
    16'd21,
    16'd23,
    16'd25,
    16'd28,
    16'd30,
    16'd32,
    16'd35,
    16'd37,
    16'd40,
    16'd43,
    16'd45,
    16'd48,
    16'd51,
    16'd54,
    16'd57,
    16'd60,
    16'd64,
    16'd67,
    16'd70,
    16'd73,
    16'd77,
    16'd80,
    16'd84,
    16'd88,
    16'd91,
    16'd95,
    16'd99,
    16'd102,
    16'd106,
    16'd110,
    16'd114,
    16'd118,
    16'd122,
    16'd126,
    16'd130,
    16'd134,
    16'd138,
    16'd142,
    16'd146,
    16'd150,
    16'd154,
    16'd158,
    16'd162
};

always_ff @(posedge clk)
    if (counter >= COUNTS_PER_INTERVAL - 1) begin
        counter <= 0;
        sample_fun <= sine_lut_fun[phase_fun];
        sample_2nd <= sine_lut_2nd[phase_2nd];
        sample_3rd <= sine_lut_3rd[phase_3rd];
        sample_4th <= sine_lut_4th[phase_4th];
        sample_5th <= sine_lut_5th[phase_5th];
        phase_fun <= (phase_fun + phase_increment) % resolution;
        phase_2nd <= (phase_2nd + 2*phase_increment) % resolution;
        phase_3rd <= (phase_3rd + 3*phase_increment) % resolution;
        phase_4th <= (phase_4th + 4*phase_increment) % resolution;
        phase_5th <= (phase_5th + 5*phase_increment) % resolution;
    end else
        counter <= counter + 1;
	
always_ff @(posedge clk)
begin
    if (harmonics)
        begin
         outR <= (counter < (sample_fun + sample_2nd/2 + sample_3rd/3 + sample_4th/5 + sample_5th/10));
    	 outL <= (counter < (sample_fun + sample_2nd/2 + sample_3rd/3 + sample_4th/5 + sample_5th/10));
//            outR <= (counter < (sample_1 + sample_2/2 + sample_3/3));
//            outL <= (counter < (sample_1 + sample_2/2 + sample_3/3));
        end
    else
    begin
        outR <= (counter < sample_fun);
    	outL <= (counter < sample_fun);
    end
end









// WORKS FOR DEMO
//parameter COUNTS_PER_INTERVAL = 4000;
//parameter RESOLUTION = 256; // Samples per sine wave period

//// phase increment = fbase x resolution / sampling rate

//// counts per interval = fclock / f sampling
//logic [15:0] counter;
//logic [15:0] sample_1;
//logic [15:0] sample_2;
//logic [15:0] sample_3;
//integer phase_1 = 0;
//integer phase_2 = 0;
//integer phase_3 = 0;

//// Fundamental frequency of 25kHz

//logic [15:0] sine_lut_1st [0:255] = {
//    16'd2000,
//    16'd2049,
//    16'd2098,
//    16'd2147,
//    16'd2196,
//    16'd2244,
//    16'd2293,
//    16'd2341,
//    16'd2390,
//    16'd2438,
//    16'd2485,
//    16'd2533,
//    16'd2580,
//    16'd2627,
//    16'd2673,
//    16'd2719,
//    16'd2765,
//    16'd2810,
//    16'd2855,
//    16'd2899,
//    16'd2942,
//    16'd2985,
//    16'd3028,
//    16'd3069,
//    16'd3111,
//    16'd3151,
//    16'd3191,
//    16'd3230,
//    16'd3268,
//    16'd3306,
//    16'd3343,
//    16'd3379,
//    16'd3414,
//    16'd3448,
//    16'd3481,
//    16'd3514,
//    16'd3546,
//    16'd3576,
//    16'd3606,
//    16'd3635,
//    16'd3662,
//    16'd3689,
//    16'd3715,
//    16'd3740,
//    16'd3763,
//    16'd3786,
//    16'd3807,
//    16'd3828,
//    16'd3847,
//    16'd3865,
//    16'd3883,
//    16'd3899,
//    16'd3913,
//    16'd3927,
//    16'd3940,
//    16'd3951,
//    16'd3961,
//    16'd3970,
//    16'd3978,
//    16'd3984,
//    16'd3990,
//    16'd3994,
//    16'd3997,
//    16'd3999,
//    16'd4000,
//    16'd3999,
//    16'd3997,
//    16'd3994,
//    16'd3990,
//    16'd3984,
//    16'd3978,
//    16'd3970,
//    16'd3961,
//    16'd3951,
//    16'd3940,
//    16'd3927,
//    16'd3913,
//    16'd3899,
//    16'd3883,
//    16'd3865,
//    16'd3847,
//    16'd3828,
//    16'd3807,
//    16'd3786,
//    16'd3763,
//    16'd3740,
//    16'd3715,
//    16'd3689,
//    16'd3662,
//    16'd3635,
//    16'd3606,
//    16'd3576,
//    16'd3546,
//    16'd3514,
//    16'd3481,
//    16'd3448,
//    16'd3414,
//    16'd3379,
//    16'd3343,
//    16'd3306,
//    16'd3268,
//    16'd3230,
//    16'd3191,
//    16'd3151,
//    16'd3111,
//    16'd3069,
//    16'd3028,
//    16'd2985,
//    16'd2942,
//    16'd2899,
//    16'd2855,
//    16'd2810,
//    16'd2765,
//    16'd2719,
//    16'd2673,
//    16'd2627,
//    16'd2580,
//    16'd2533,
//    16'd2485,
//    16'd2438,
//    16'd2390,
//    16'd2341,
//    16'd2293,
//    16'd2244,
//    16'd2196,
//    16'd2147,
//    16'd2098,
//    16'd2049,
//    16'd2000,
//    16'd1950,
//    16'd1901,
//    16'd1852,
//    16'd1803,
//    16'd1755,
//    16'd1706,
//    16'd1658,
//    16'd1609,
//    16'd1561,
//    16'd1514,
//    16'd1466,
//    16'd1419,
//    16'd1372,
//    16'd1326,
//    16'd1280,
//    16'd1234,
//    16'd1189,
//    16'd1144,
//    16'd1100,
//    16'd1057,
//    16'd1014,
//    16'd971,
//    16'd930,
//    16'd888,
//    16'd848,
//    16'd808,
//    16'd769,
//    16'd731,
//    16'd693,
//    16'd656,
//    16'd620,
//    16'd585,
//    16'd551,
//    16'd518,
//    16'd485,
//    16'd453,
//    16'd423,
//    16'd393,
//    16'd364,
//    16'd337,
//    16'd310,
//    16'd284,
//    16'd259,
//    16'd236,
//    16'd213,
//    16'd192,
//    16'd171,
//    16'd152,
//    16'd134,
//    16'd116,
//    16'd100,
//    16'd86,
//    16'd72,
//    16'd59,
//    16'd48,
//    16'd38,
//    16'd29,
//    16'd21,
//    16'd15,
//    16'd9,
//    16'd5,
//    16'd2,
//    16'd0,
//    16'd0,
//    16'd0,
//    16'd2,
//    16'd5,
//    16'd9,
//    16'd15,
//    16'd21,
//    16'd29,
//    16'd38,
//    16'd48,
//    16'd59,
//    16'd72,
//    16'd86,
//    16'd100,
//    16'd116,
//    16'd134,
//    16'd152,
//    16'd171,
//    16'd192,
//    16'd213,
//    16'd236,
//    16'd259,
//    16'd284,
//    16'd310,
//    16'd337,
//    16'd364,
//    16'd393,
//    16'd423,
//    16'd453,
//    16'd485,
//    16'd518,
//    16'd551,
//    16'd585,
//    16'd620,
//    16'd656,
//    16'd693,
//    16'd731,
//    16'd769,
//    16'd808,
//    16'd848,
//    16'd888,
//    16'd930,
//    16'd971,
//    16'd1014,
//    16'd1057,
//    16'd1100,
//    16'd1144,
//    16'd1189,
//    16'd1234,
//    16'd1280,
//    16'd1326,
//    16'd1372,
//    16'd1419,
//    16'd1466,
//    16'd1514,
//    16'd1561,
//    16'd1609,
//    16'd1658,
//    16'd1706,
//    16'd1755,
//    16'd1803,
//    16'd1852,
//    16'd1901,
//    16'd1950
//};

//// Second Harmonic for 50kHz
//logic [15:0] sine_lut_2nd [0:255] = {
//    16'd1000,
//    16'd1024,
//    16'd1049,
//    16'd1073,
//    16'd1098,
//    16'd1122,
//    16'd1146,
//    16'd1170,
//    16'd1195,
//    16'd1219,
//    16'd1242,
//    16'd1266,
//    16'd1290,
//    16'd1313,
//    16'd1336,
//    16'd1359,
//    16'd1382,
//    16'd1405,
//    16'd1427,
//    16'd1449,
//    16'd1471,
//    16'd1492,
//    16'd1514,
//    16'd1534,
//    16'd1555,
//    16'd1575,
//    16'd1595,
//    16'd1615,
//    16'd1634,
//    16'd1653,
//    16'd1671,
//    16'd1689,
//    16'd1707,
//    16'd1724,
//    16'd1740,
//    16'd1757,
//    16'd1773,
//    16'd1788,
//    16'd1803,
//    16'd1817,
//    16'd1831,
//    16'd1844,
//    16'd1857,
//    16'd1870,
//    16'd1881,
//    16'd1893,
//    16'd1903,
//    16'd1914,
//    16'd1923,
//    16'd1932,
//    16'd1941,
//    16'd1949,
//    16'd1956,
//    16'd1963,
//    16'd1970,
//    16'd1975,
//    16'd1980,
//    16'd1985,
//    16'd1989,
//    16'd1992,
//    16'd1995,
//    16'd1997,
//    16'd1998,
//    16'd1999,
//    16'd2000,
//    16'd1999,
//    16'd1998,
//    16'd1997,
//    16'd1995,
//    16'd1992,
//    16'd1989,
//    16'd1985,
//    16'd1980,
//    16'd1975,
//    16'd1970,
//    16'd1963,
//    16'd1956,
//    16'd1949,
//    16'd1941,
//    16'd1932,
//    16'd1923,
//    16'd1914,
//    16'd1903,
//    16'd1893,
//    16'd1881,
//    16'd1870,
//    16'd1857,
//    16'd1844,
//    16'd1831,
//    16'd1817,
//    16'd1803,
//    16'd1788,
//    16'd1773,
//    16'd1757,
//    16'd1740,
//    16'd1724,
//    16'd1707,
//    16'd1689,
//    16'd1671,
//    16'd1653,
//    16'd1634,
//    16'd1615,
//    16'd1595,
//    16'd1575,
//    16'd1555,
//    16'd1534,
//    16'd1514,
//    16'd1492,
//    16'd1471,
//    16'd1449,
//    16'd1427,
//    16'd1405,
//    16'd1382,
//    16'd1359,
//    16'd1336,
//    16'd1313,
//    16'd1290,
//    16'd1266,
//    16'd1242,
//    16'd1219,
//    16'd1195,
//    16'd1170,
//    16'd1146,
//    16'd1122,
//    16'd1098,
//    16'd1073,
//    16'd1049,
//    16'd1024,
//    16'd1000,
//    16'd975,
//    16'd950,
//    16'd926,
//    16'd901,
//    16'd877,
//    16'd853,
//    16'd829,
//    16'd804,
//    16'd780,
//    16'd757,
//    16'd733,
//    16'd709,
//    16'd686,
//    16'd663,
//    16'd640,
//    16'd617,
//    16'd594,
//    16'd572,
//    16'd550,
//    16'd528,
//    16'd507,
//    16'd485,
//    16'd465,
//    16'd444,
//    16'd424,
//    16'd404,
//    16'd384,
//    16'd365,
//    16'd346,
//    16'd328,
//    16'd310,
//    16'd292,
//    16'd275,
//    16'd259,
//    16'd242,
//    16'd226,
//    16'd211,
//    16'd196,
//    16'd182,
//    16'd168,
//    16'd155,
//    16'd142,
//    16'd129,
//    16'd118,
//    16'd106,
//    16'd96,
//    16'd85,
//    16'd76,
//    16'd67,
//    16'd58,
//    16'd50,
//    16'd43,
//    16'd36,
//    16'd29,
//    16'd24,
//    16'd19,
//    16'd14,
//    16'd10,
//    16'd7,
//    16'd4,
//    16'd2,
//    16'd1,
//    16'd0,
//    16'd0,
//    16'd0,
//    16'd1,
//    16'd2,
//    16'd4,
//    16'd7,
//    16'd10,
//    16'd14,
//    16'd19,
//    16'd24,
//    16'd29,
//    16'd36,
//    16'd43,
//    16'd50,
//    16'd58,
//    16'd67,
//    16'd76,
//    16'd85,
//    16'd96,
//    16'd106,
//    16'd118,
//    16'd129,
//    16'd142,
//    16'd155,
//    16'd168,
//    16'd182,
//    16'd196,
//    16'd211,
//    16'd226,
//    16'd242,
//    16'd259,
//    16'd275,
//    16'd292,
//    16'd310,
//    16'd328,
//    16'd346,
//    16'd365,
//    16'd384,
//    16'd404,
//    16'd424,
//    16'd444,
//    16'd465,
//    16'd485,
//    16'd507,
//    16'd528,
//    16'd550,
//    16'd572,
//    16'd594,
//    16'd617,
//    16'd640,
//    16'd663,
//    16'd686,
//    16'd709,
//    16'd733,
//    16'd757,
//    16'd780,
//    16'd804,
//    16'd829,
//    16'd853,
//    16'd877,
//    16'd901,
//    16'd926,
//    16'd950,
//    16'd975
//};

//// Third harmonic
//logic [15:0] sine_lut_3rd [0:255] = {
//    16'd666,
//    16'd682,
//    16'd699,
//    16'd715,
//    16'd731,
//    16'd748,
//    16'd764,
//    16'd780,
//    16'd796,
//    16'd812,
//    16'd828,
//    16'd844,
//    16'd859,
//    16'd875,
//    16'd891,
//    16'd906,
//    16'd921,
//    16'd936,
//    16'd951,
//    16'd966,
//    16'd980,
//    16'd995,
//    16'd1009,
//    16'd1023,
//    16'd1036,
//    16'd1050,
//    16'd1063,
//    16'd1076,
//    16'd1089,
//    16'd1101,
//    16'd1114,
//    16'd1126,
//    16'd1137,
//    16'd1149,
//    16'd1160,
//    16'd1171,
//    16'd1181,
//    16'd1191,
//    16'd1201,
//    16'd1211,
//    16'd1220,
//    16'd1229,
//    16'd1238,
//    16'd1246,
//    16'd1254,
//    16'd1261,
//    16'd1269,
//    16'd1275,
//    16'd1282,
//    16'd1288,
//    16'd1294,
//    16'd1299,
//    16'd1304,
//    16'd1308,
//    16'd1313,
//    16'd1316,
//    16'd1320,
//    16'd1323,
//    16'd1325,
//    16'd1327,
//    16'd1329,
//    16'd1331,
//    16'd1332,
//    16'd1332,
//    16'd1333,
//    16'd1332,
//    16'd1332,
//    16'd1331,
//    16'd1329,
//    16'd1327,
//    16'd1325,
//    16'd1323,
//    16'd1320,
//    16'd1316,
//    16'd1313,
//    16'd1308,
//    16'd1304,
//    16'd1299,
//    16'd1294,
//    16'd1288,
//    16'd1282,
//    16'd1275,
//    16'd1269,
//    16'd1261,
//    16'd1254,
//    16'd1246,
//    16'd1238,
//    16'd1229,
//    16'd1220,
//    16'd1211,
//    16'd1201,
//    16'd1191,
//    16'd1181,
//    16'd1171,
//    16'd1160,
//    16'd1149,
//    16'd1137,
//    16'd1126,
//    16'd1114,
//    16'd1101,
//    16'd1089,
//    16'd1076,
//    16'd1063,
//    16'd1050,
//    16'd1036,
//    16'd1023,
//    16'd1009,
//    16'd995,
//    16'd980,
//    16'd966,
//    16'd951,
//    16'd936,
//    16'd921,
//    16'd906,
//    16'd891,
//    16'd875,
//    16'd859,
//    16'd844,
//    16'd828,
//    16'd812,
//    16'd796,
//    16'd780,
//    16'd764,
//    16'd748,
//    16'd731,
//    16'd715,
//    16'd699,
//    16'd682,
//    16'd666,
//    16'd650,
//    16'd633,
//    16'd617,
//    16'd601,
//    16'd584,
//    16'd568,
//    16'd552,
//    16'd536,
//    16'd520,
//    16'd504,
//    16'd488,
//    16'd473,
//    16'd457,
//    16'd441,
//    16'd426,
//    16'd411,
//    16'd396,
//    16'd381,
//    16'd366,
//    16'd352,
//    16'd337,
//    16'd323,
//    16'd309,
//    16'd296,
//    16'd282,
//    16'd269,
//    16'd256,
//    16'd243,
//    16'd231,
//    16'd218,
//    16'd206,
//    16'd195,
//    16'd183,
//    16'd172,
//    16'd161,
//    16'd151,
//    16'd141,
//    16'd131,
//    16'd121,
//    16'd112,
//    16'd103,
//    16'd94,
//    16'd86,
//    16'd78,
//    16'd71,
//    16'd63,
//    16'd57,
//    16'd50,
//    16'd44,
//    16'd38,
//    16'd33,
//    16'd28,
//    16'd24,
//    16'd19,
//    16'd16,
//    16'd12,
//    16'd9,
//    16'd7,
//    16'd5,
//    16'd3,
//    16'd1,
//    16'd0,
//    16'd0,
//    16'd0,
//    16'd0,
//    16'd0,
//    16'd1,
//    16'd3,
//    16'd5,
//    16'd7,
//    16'd9,
//    16'd12,
//    16'd16,
//    16'd19,
//    16'd24,
//    16'd28,
//    16'd33,
//    16'd38,
//    16'd44,
//    16'd50,
//    16'd57,
//    16'd63,
//    16'd71,
//    16'd78,
//    16'd86,
//    16'd94,
//    16'd103,
//    16'd112,
//    16'd121,
//    16'd131,
//    16'd141,
//    16'd151,
//    16'd161,
//    16'd172,
//    16'd183,
//    16'd195,
//    16'd206,
//    16'd218,
//    16'd231,
//    16'd243,
//    16'd256,
//    16'd269,
//    16'd282,
//    16'd296,
//    16'd309,
//    16'd323,
//    16'd337,
//    16'd352,
//    16'd366,
//    16'd381,
//    16'd396,
//    16'd411,
//    16'd426,
//    16'd441,
//    16'd457,
//    16'd473,
//    16'd488,
//    16'd504,
//    16'd520,
//    16'd536,
//    16'd552,
//    16'd568,
//    16'd584,
//    16'd601,
//    16'd617,
//    16'd633,
//    16'd650
//};

//always_ff @(posedge clk)
//    if (counter >= COUNTS_PER_INTERVAL - 1) begin
//        counter <= 0;
//        sample_1 <= sine_lut_1st[phase_1];
//        sample_2 <= sine_lut_2nd[phase_2];
//        sample_3 <= sine_lut_3rd[phase_3];
//        phase_1 <= (phase_1 + phase_increment) & (RESOLUTION - 1);
//        phase_2 <= (phase_2 + (phase_increment << 1))  & (RESOLUTION - 1);
//        phase_3 <= (phase_3 + (((phase_increment << 1) + phase_increment)) >> 2) & (RESOLUTION - 1);
//    end else
//        counter <= counter + 1;
	
//always_ff @(posedge clk)
//begin
//    if (harmonics)
//        begin
//            outR <= (counter < (sample_1 + (sample_2 >> 1) + (sample_3 >> 2)));
//            outL <= (counter < (sample_1 + (sample_2 >> 1) + (sample_3 >> 2)));
//        end
//    else
//    begin
//        outR <= (counter < sample_1);
//    	outL <= (counter < sample_1);
//    end
//end	
 
endmodule

