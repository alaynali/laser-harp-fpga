// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (win64) Build 3671981 Fri Oct 14 05:00:03 MDT 2022
// Date        : Sat Nov 30 22:39:45 2024
// Host        : MSI running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/estel/project/laser-harp-fpga/audio_test/audio_test.gen/sources_1/ip/xadc_wiz_0_1/xadc_wiz_0_stub.v
// Design      : xadc_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7s50csga324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module xadc_wiz_0(dclk_in, busy_out, channel_out, eoc_out, eos_out, 
  alarm_out, vp_in, vn_in)
/* synthesis syn_black_box black_box_pad_pin="dclk_in,busy_out,channel_out[4:0],eoc_out,eos_out,alarm_out,vp_in,vn_in" */;
  input dclk_in;
  output busy_out;
  output [4:0]channel_out;
  output eoc_out;
  output eos_out;
  output alarm_out;
  input vp_in;
  input vn_in;
endmodule
