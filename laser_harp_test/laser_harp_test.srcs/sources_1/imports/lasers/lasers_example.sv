module lasers_example (
	input logic vga_clk,
	input logic [9:0] DrawX, DrawY,
	input logic blank,
	input  logic [9:0] CursorX, CursorY, CursorS,
	input logic [7:0] btn_keycode,
	output logic [3:0] red, green, blue
);

logic cursor_on;
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
assign rom_address = ((DrawX * 480) / 640) + (((DrawY * 480) / 480) * 480);

// check every pixel of cursor
// logic [2:0] q [35:0]; // r=4, so d=8, 8*8=64
// logic [3:0] r [35:0]; 
// logic [3:0] g [35:0];
// logic [3:0] b [35:0];

// logic [17:0] pix_address [35:0];

// always_comb begin
//     for (integer i = 0; i < 6; i++) begin
//         for (integer j = 0; j < 6; j++) begin
//             pix_address[i*6 + j] = ((CursorX+i-Size) * 480 / 640) + (((CursorY+j-Size) * 480 / 480) * 480);
//         end
//     end
// end

// generate // instatiate rom and palette for each pixel covered by the cursor
// 	genvar i;
// 	genvar j;
// 	for (i = 0; i < 6; i++) begin:gen_loop1
// 		for (j = 0; j < 6; j++) begin:gen_loop2
// 			rom romgen ( .addra(pix_address[i*6+j]), .clka(negedge_vga_clk), .douta(q[i*6+j]) );
// 			lasers_palette palettegen ( .index(q[i*6+j]), .red(r[i*6+j]), .green(g[i*6+j]), .blue(b[i*6+j]) );
// 		end
// 	end
// endgenerate
//

// check only center of cursor
logic [2:0] q; // r=4, so d=8, 8*8=64
logic [3:0] r, g, b;
logic [17:0] pix_address;

assign pix_address = (CursorX * 480 / 640) + ((CursorY * 480 / 480) * 480);

rom cursor_picture ( .addra(pix_address), .clka(negedge_vga_clk), .douta(q) );
lasers_palette cursor_palette ( .index(q), .red(r), .green(g), .blue(b) );

rom lasers ( .addra(rom_address), .clka(negedge_vga_clk), .douta(rom_q) );
lasers_palette lasers_palette ( .index(rom_q), .red(palette_red), .green (palette_green), .blue  (palette_blue) );

rom_bkg background ( .addra(rom_address), .clka(negedge_vga_clk), .douta(rom_q_bg) );
bg_palette bkg_palette ( .index(rom_q_bg), .red(bg_red), .green (bg_green), .blue  (bg_blue) );

logic color_on;

always_comb 
begin:Color_on_proc
	if ({r,g,b} == {palette_red,palette_green,palette_blue}) 
		color_on = 1'b0;
	else
		color_on = 1'b1;
end

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
			if ((!color_on) && (DrawY < CursorY)) begin // being interrupted and above the cursor
				// draw background instead of lasers - NEED TO ADD BG ROM
				// red <= bg_red;
				// green <= bg_green;
				// blue <= bg_blue;

				red <= 4'h0;
				green <= 4'h0;
				blue <= 4'h0;
				
			end
			else begin // not being interrupted
				red <= palette_red;
				green <= palette_green;
				blue <= palette_blue;
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
