//-------------------------------------------------------------------------
//    mb_usb_hdmi_top.sv                                                 --
//    Zuofu Cheng                                                        --
//    2-29-24                                                            --
//                                                                       --
//                                                                       --
//    Spring 2024 Distribution                                           --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module mb_usb_hdmi_top(
    input logic Clk,
    input logic reset_rtl_0,
    
    //USB signals
    input logic [0:0] gpio_usb_int_tri_i,
    output logic gpio_usb_rst_tri_o,
    input logic usb_spi_miso,
    output logic usb_spi_mosi,
    output logic usb_spi_sclk,
    output logic usb_spi_ss,
    
    //UART
    input logic uart_rtl_0_rxd,
    output logic uart_rtl_0_txd,
    
    //HDMI
    output logic hdmi_tmds_clk_n,
    output logic hdmi_tmds_clk_p,
    output logic [2:0]hdmi_tmds_data_n,
    output logic [2:0]hdmi_tmds_data_p,
        
    //HEX displays
    output logic [7:0] hex_segA,
    output logic [3:0] hex_gridA,
    output logic [7:0] hex_segB,
    output logic [3:0] hex_gridB,
    output logic SPKR,
    output logic SPKL,
    
    input logic [15:0] SW,
    
    input logic JAB_0,
	input logic JAB_1,
	input logic JAB_2,
	input logic JAB_3,
	input logic JAB_4,
	input logic JAB_5 
);
    
    logic [31:0] keycode0_gpio, keycode1_gpio;
    logic clk_25MHz, clk_125MHz, clk, clk_100MHz;
    logic locked;
    logic [9:0] drawX, drawY, ballxsig, ballysig, ballsizesig;

    logic hsync, vsync, vde;
    logic [3:0] red, green, blue;
    logic reset_ah;
    
    assign reset_ah = reset_rtl_0;
	
    sound audio (
    .clk(Clk),
    .SPKR(SPKR),
    .SPKL(SPKL),
    .SW(SW),
//    .keycode(keycode1_gpio[7:0])
    .red_click(red_click),
    .orange_click(orange_click),
    .yellow_click(yellow_click),
    .green_click(green_click),
    .blue_click(blue_click),
    .indigo_click(indigo_click),
    .violet_click(violet_click),
    .JAB_0(JAB_0),
	.JAB_1(JAB_1),
	.JAB_2(JAB_2),
	.JAB_3(JAB_3),
	.JAB_4(JAB_4),
	.JAB_5(JAB_5)
    );
    
    //Keycode HEX drivers
    hex_driver HexA (
        .clk(Clk),
        .reset(reset_ah),
        .in({SW[3:0], keycode1_gpio[27:24], keycode1_gpio[23:20], keycode1_gpio[19:16]}),
        .hex_seg(hex_segA),
        .hex_grid(hex_gridA)
    );
    
    hex_driver HexB (
        .clk(Clk),
        .reset(reset_ah),
        .in({keycode1_gpio[15:12], keycode1_gpio[11:8], keycode1_gpio[7:4], keycode1_gpio[3:0]}),
        .hex_seg(hex_segB),
        .hex_grid(hex_gridB)
    );
    
    mb_usb mb_block_i (
        .clk_100MHz(Clk),
        .gpio_usb_int_tri_i(gpio_usb_int_tri_i),
        .gpio_usb_keycode_0_tri_o(keycode0_gpio),
        .gpio_usb_keycode_1_tri_o(keycode1_gpio),
        .gpio_usb_rst_tri_o(gpio_usb_rst_tri_o),
        .reset_rtl_0(~reset_ah), //Block designs expect active low reset, all other modules are active high
        .uart_rtl_0_rxd(uart_rtl_0_rxd),
        .uart_rtl_0_txd(uart_rtl_0_txd),
        .usb_spi_miso(usb_spi_miso),
        .usb_spi_mosi(usb_spi_mosi),
        .usb_spi_sclk(usb_spi_sclk),
        .usb_spi_ss(usb_spi_ss)
    );
        
    //clock wizard configured with a 1x and 5x clock for HDMI
    clk_wiz_0 clk_wiz (
        .clk_out1(clk_25MHz),
        .clk_out2(clk_125MHz),
        .reset(reset_ah),
        .locked(locked),
        .clk_in1(Clk)
    );
    
    //VGA Sync signal generator
    vga_controller vga (
        .pixel_clk(clk_25MHz),
        .reset(reset_ah),
        .hs(hsync),
        .vs(vsync),
        .active_nblank(vde),
        .drawX(drawX),
        .drawY(drawY)
    );    

    //Real Digital VGA to HDMI converter
    hdmi_tx_0 vga_to_hdmi (
        //Clocking and Reset
        .pix_clk(clk_25MHz),
        .pix_clkx5(clk_125MHz),
        .pix_clk_locked(locked),
        //Reset is active LOW
        .rst(reset_ah),
        //Color and Sync Signals
        .red(red),
        .green(green),
        .blue(blue),
        .hsync(hsync),
        .vsync(vsync),
        .vde(vde),
        
        //aux Data (unused)
        .aux0_din(4'b0),
        .aux1_din(4'b0),
        .aux2_din(4'b0),
        .ade(1'b0),
        
        //Differential outputs
        .TMDS_CLK_P(hdmi_tmds_clk_p),          
        .TMDS_CLK_N(hdmi_tmds_clk_n),          
        .TMDS_DATA_P(hdmi_tmds_data_p),         
        .TMDS_DATA_N(hdmi_tmds_data_n)          
    );


logic [9:0] CursorX, CursorY, CursorS;

logic red_click;
logic orange_click;
logic yellow_click;
logic green_click;
logic blue_click;
logic indigo_click;
logic violet_click;

    lasers_example screen(
        .Reset(reset_ah),
        .vga_clk(clk_25MHz),
        .DrawX(drawX),
        .DrawY(drawY),
        .blank(vde),
        .JAB_0(JAB_0),
        .JAB_1(JAB_1),
        .JAB_2(JAB_2),
        .JAB_3(JAB_3),
        .JAB_4(JAB_4),
        .JAB_5(JAB_5),
        .SW(SW),
        .red(red),
        .green(green),
        .blue(blue),
        .CursorX(CursorX),
        .CursorY(CursorY),
        .CursorS(CursorS),
        .btn_keycode(keycode1_gpio[7:0]),
        .red_click_out(red_click),
        .orange_click_out(orange_click),
        .yellow_click_out(yellow_click),
        .green_click_out(green_click),
        .blue_click_out(blue_click),
        .indigo_click_out(indigo_click),
        .violet_click_out(violet_click)
    );
    
    cursor_impl cursor(
        .Reset(reset_ah),
        .frame_clk(vsync),
        .keycode(keycode1_gpio[31:0]),
        .CursorX(CursorX),
        .CursorY(CursorY),
        .CursorS(CursorS)
    );
    
    ila_0 ila (
        .clk(Clk),
        .probe0(keycode0_gpio[31:0]),
        .probe1(keycode1_gpio[31:0])
    );

    logic [15:0]	SW_s;

    sync_debounce SW_sync [15:0] (
		.clk  (clk), 

		.d    (SW), 
		.q    (SW_s)
	);	
    
endmodule
