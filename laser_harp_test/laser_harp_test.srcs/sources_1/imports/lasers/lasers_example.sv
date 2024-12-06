module lasers_example (
	input logic vga_clk,
	input logic [9:0] DrawX, DrawY,
	input logic blank,
	input  logic [9:0] CursorX, CursorY, CursorS,
	input logic [7:0] btn_keycode,
	output logic [3:0] red, green, blue
);

logic cursor_on;

logic red_on;
logic orange_on;
logic yellow_on;
logic green_on;
logic blue_on;
logic indigo_on;
logic violet_on;

logic r_click;
logic l_click;

logic [18:0] rom_address;
logic [4:0] rom_q;
logic [4:0] rom_q_bg;

logic [3:0] palette_red, palette_green, palette_blue;
logic [3:0] bg_red, bg_green, bg_blue;

logic negedge_vga_clk;

logic [6:0] colors; // 0 if the color is being interrupted, 1 otherwise (default)
assign colors = '{default:1'b1};

int DistX, DistY, Size;
assign DistX = DrawX - CursorX;
assign DistY = DrawY - CursorY;
assign Size = CursorS;

always_comb
begin:Cursor_on_proc // determines whether we need to draw the cursor (within bounds of circle)
	if ( (DistX*DistX + DistY*DistY) <= (Size * Size) )
		cursor_on = 1'b1;
	else 
		cursor_on = 1'b0;
end

always_comb
begin:Red_on_proc
	if (DrawY <= 2*DrawX && DrawY >= 2*DrawX-12 && DrawY <= 360 && DrawY >= 11)
		red_on = 1'b1;
	else
		red_on = 1'b0;
end
always_comb
begin:Orange_on_proc
	if (DrawY <= 3*DrawX-240 && DrawY >= 3*DrawX-258 && DrawY <= 360 && DrawY >= 11)
		orange_on = 1'b1;
	else
		orange_on = 1'b0;
end
always_comb
begin:Yellow_on_proc
	if (DrawY <= 6*DrawX-960 && DrawY >= 6*DrawX-996 && DrawY <= 360 && DrawY >= 11)
		yellow_on = 1'b1;
	else
		yellow_on = 1'b0;
end
always_comb
begin:Green_on_proc
	if (DrawX <= 246 && DrawX >= 240 && DrawY <= 360 && DrawY >= 11)
		green_on = 1'b1;
	else
		green_on = 1'b0;
end
always_comb
begin:Blue_on_proc
	if (DrawY <= -6*DrawX+1956 && DrawY >= -6*DrawX+1920 && DrawY <= 360 && DrawY >= 11)
		blue_on = 1'b1;
	else
		blue_on = 1'b0;
end
always_comb
begin:Indigo_on_proc
	if (DrawY <= -3*DrawX+1218 && DrawY >= -3*DrawX+1200 && DrawY <= 360 && DrawY >= 11)
		indigo_on = 1'b1;
	else
		indigo_on = 1'b0;
end
always_comb
begin:Violet_on_proc
	if (DrawY <= -2*DrawX+972 && DrawY >= -2*DrawX+960 && DrawY <= 360 && DrawY >= 11)
		violet_on = 1'b1;
	else
		violet_on = 1'b0;
end


always_comb
begin
    case (btn_keycode)
        8'b00000001	:   begin 	// left-click
                            r_click = 1'b0;
                            l_click = 1'b1;
                        end
        8'b00000010	:   begin 	// right-click
                            r_click = 1'b1;
                            l_click = 1'b0;
                        end
        8'b00000011	:   begin	// left and right click
                            r_click = 1'b1;
                            l_click = 1'b1;
                        end
        default		:   begin
                            r_click = 1'b0;
                            l_click = 1'b0;
                        end
    endcase
end

// read from ROM on negedge, set pixel on posedge
assign negedge_vga_clk = ~vga_clk;

// address into the rom = (x*xDim)/640 + ((y*yDim)/480) * xDim
// this will stretch out the sprite across the entire screen
// assign rom_address = ((DrawX * 480) / 640) + (((DrawY * 480) / 480) * 480);
assign rom_address = ((DrawX * 640) / 640) + (((DrawY * 480) / 480) * 640);


// check only center of cursor
logic [2:0] q; // r=4, so d=8, 8*8=64
logic [3:0] r, g, b;
logic [17:0] pix_address;

assign pix_address = (CursorX * 480 / 640) + ((CursorY * 480 / 480) * 480);

bg_rom cursor_picture ( .addra(pix_address), .clka(negedge_vga_clk), .douta(q) );
bg_palette cursor_palette ( .index(q), .red(r), .green(g), .blue(b) );

//rom lasers ( .addra(rom_address), .clka(negedge_vga_clk), .douta(rom_q) );
//lasers_palette lasers_palette ( .index(rom_q), .red(palette_red), .green (palette_green), .blue  (palette_blue) );

bg_rom background ( .addra(rom_address), .clka(negedge_vga_clk), .douta(rom_q_bg) );
bg_palette bg_palette ( .index(rom_q_bg), .red(bg_red), .green (bg_green), .blue  (bg_blue) );
logic color_on;

always_comb 
begin:Color_on_proc
	if ({r,g,b} == {palette_red,palette_green,palette_blue} && {r,g,b} == {}) 
		color_on = 1'b0;
	else
		color_on = 1'b1;
end

logic red_int;
logic orange_int;
logic yellow_int;
logic green_int;
logic blue_int;
logic indigo_int;
logic violet_int;

always_comb
begin:Red_int_proc
	if (CursorY <= 2*CursorX && CursorY >= 2*CursorX-12 && CursorY <= 360 && CursorY >= 11)
		red_int = 1'b1;
	else
		red_int = 1'b0;
end
always_comb
begin:Orange_int_proc
	if (CursorY <= 3*CursorX-240 && CursorY >= 3*Cursor-258 && CursorY <= 360 && CursorY >= 11)
		orange_int = 1'b1;
	else
		orange_int = 1'b0;
end
always_comb
begin:Yellow_int_proc
	if (CursorY <= 6*CursorX-960 && CursorY >= 6*CursorX-996 && CursorY <= 360 && CursorY >= 11)
		yellow_int = 1'b1;
	else
		yellow_int = 1'b0;
end
always_comb
begin:Green_int_proc
	if (CursorX <= 246 && CursorX >= 240 &&CursorY <= 360 && CursorY >= 11)
		green_int = 1'b1;
	else
		green_int = 1'b0;
end
always_comb
begin:Blue_int_proc
	if (CursorY <= -6*CursorX+1956 && CursorY >= -6*CursorX+1920 && CursorY <= 360 && CursorY >= 11)
		blue_int = 1'b1;
	else
		blue_int = 1'b0;
end
always_comb
begin:Indigo_int_proc
	if (CursorY <= -3*CursorX+1218 && CursorY >= -3*CursorX+1200 && CursorY <= 360 && CursorY >= 11)
		indigo_int = 1'b1;
	else
		indigo_int = 1'b0;
end
always_comb
begin:Violet_int_proc
	if (CursorY <= -2*CursorX+972 && CursorY >= -2*CursorX+960 && CursorY <= 360 && CursorY >= 11)
		violet_int = 1'b1;
	else
		violet_int = 1'b0;
end

// always_comb 
// begin:Color_on_proc
// 	if ({r,g,b} == {palette_red,palette_green,palette_blue}) 
// 		color_on = 1'b0;
// 	else
// 		color_on = 1'b1;
// end

always_ff @ (posedge vga_clk) begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;

	if (blank) begin  // This is when the non-blanking interval begins
	    if ((cursor_on == 1'b1)) begin 
			// or import cursor palette
            red <= 4'hf;
            green <= 4'hf;
            blue <= 4'hf;
			/*
			DrawCursorX = DrawX // how to make drawcursor x to from 0 to width of cursor depending on drawX?
			*/
        end    
	    else begin
		  // draw lasers
			// if ((!color_on) && (DrawY < CursorY)) begin // being interrupted and above the cursor
			// 	// draw background instead of lasers - NEED TO ADD BG ROM
			// 	// red <= bg_red;
			// 	// green <= bg_green;
			// 	// blue <= bg_blue;

			// 	red <= 4'h0;
			// 	green <= 4'h0;
			// 	blue <= 4'h0;
				
			// end
			// roygbiv: {4'hF, 4'h3, 4'h3}, {4'hF, 4'h9, 4'h4}, {4'hF, 4'hD, 4'h5}, {4'h7, 4'hD, 4'h5}, {4'h7, 4'hD, 4'h5}, {4'h3, 4'hB, 4'hF}, {4'h0, 4'h4, 4'hA}, {4'h5, 4'h1, 4'hE}
			if (red_on && (!red_int || DrawY > CursorY)) begin
				red <= 4'hF;
				green <= 4'h3;
				blue <= 4'h3;
			end	
			else if (orange_on && (!orange_int || DrawY > CursorY)) begin
				red <= 4'hF;
				green <= 4'h9;
				blue <= 4'h4;
			end	
			else if (yellow_on && (!yellow_int || DrawY > CursorY)) begin
				
				red <= 4'hF;
				green <= 4'hD;
				blue <= 4'h5;
			end	
			else if (green_on && (!green_int || DrawY > CursorY)) begin
				red <= 4'h7;
				green <= 4'hD;
				blue <= 4'h5;
			end	
			else if (blue_on && (!blue_int || DrawY > CursorY)) begin
				red <= 4'h3;
				green <= 4'hB;
				blue <= 4'hF;
			end	
			else if (indigo_on && (!indigo_int || DrawY > CursorY)) begin
				red <= 4'h0;
				green <= 4'h4;
				blue <= 4'hA;
			end	
			else if (violet_on && (!violet_int || DrawY > CursorY)) begin
				red <= 4'h5;
				green <= 4'h1;
				blue <= 4'hE;
			end	
			else begin // not being interrupted
				red <= bg_red;
				green <= bg_green;
				blue <= bg_blue;
			end

		end
	end
end



//lasers_rom lasers_rom (
//	.clka   (negedge_vga_clk),
//	.addra (rom_address),
//	.douta (rom_q)
//);

// instantiate background palette
/*
bg_rom bg_rom (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta  (rom_q_bg)
);

cursor_palette cursor_palette (
	.index (rom_q_bq),
	.red   (bg_red),
	.green (bg_green),
	.blue  (bg_blue)
);
*/


// instantiate cursor palette
/*
cursor_rom cursor_rom (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta  (rom_q_cursor)
);

cursor_palette cursor_palette (
	.index (rom_q_cursor),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);
*/


endmodule
