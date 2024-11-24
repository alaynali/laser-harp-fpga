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

logic [17:0] rom_address;
logic [2:0] rom_q;

logic [3:0] palette_red, palette_green, palette_blue;

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

always_comb
begin: laser_interrupt
	genvar i;
	genvar j;
	for (i = BallX-Size; i < BallX+Size; i++) begin
		for (j = BallY-Size, j < BallY+Size; j++) begin
			logic pix_address = ((i * 480) / 640) + (((j * 480) / 480) * 480);
			// romq
			logic [2:0] q;
			logic [3:0] r, g, b;

			rom r (	.addra(pix_address), .clka(negedge_vga_clk), .douta(q) );
			lasers_palette l ( .index(q), .red(r), .green(g), .blue(b) );
			/*
				rgb colors from laser_palette
				{4'hF, 4'h8, 4'h1},
				{4'h6, 4'h3, 4'h8},
				{4'h1, 4'hB, 4'hE},
				{4'hF, 4'hE, 4'h1},
				{4'hD, 4'h2, 4'h2},
				{4'h3, 4'h3, 4'h8},
				{4'hA, 4'hD, 4'h3}
			*/
			case ({r,g,b})
				16'hF81	:	colors[0] = colors[0] & 1'b0;
				16'h638	:   colors[1] = colors[1] & 1'b0; 
				16'h1BE	:	colors[2] = colors[2] & 1'b0;
				16'hFE1	:	colors[3] = colors[3] & 1'b0;
				16'hD22	:	colors[4] = colors[4] & 1'b0;
				16'h338	:	colors[5] = colors[5] & 1'b0;
				16'hAD3	:	colors[6] = colors[5] & 1'b0;
				default	:	; // colors = colors;
			endcase
		end
	end
end

// read from ROM on negedge, set pixel on posedge
assign negedge_vga_clk = ~vga_clk;

// address into the rom = (x*xDim)/640 + ((y*yDim)/480) * xDim
// this will stretch out the sprite across the entire screen
assign rom_address = ((DrawX * 480) / 640) + (((DrawY * 480) / 480) * 480);

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
			logic color_on;
			case ({palette_red,palette_green,palette_blue})
				16'hF81	:	color_on = colors[0];
				16'h638	:   color_on = colors[1]; 
				16'h1BE	:	color_on = colors[2];
				16'hFE1	:	color_on = colors[3];
				16'hD22	:	color_on = colors[4];
				16'h338	:	color_on = colors[5];
				16'hAD3	:	color_on = colors[6];
				default	:	color_on = 0; // colors = colors;
			endcase	

			if ((!color_on) && (DrawY < CrusorY)) begin // being interrupted and above the cursor
				// draw background instead of lasers -- may need to add unique bg rom instead of just black later
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

rom picture (
    .addra(rom_address),
    .clka(negedge_vga_clk),
    .douta(rom_q)

);

//lasers_rom lasers_rom (
//	.clka   (negedge_vga_clk),
//	.addra (rom_address),
//	.douta (rom_q)
//);

lasers_palette lasers_palette (

	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
	
);

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
