module lasers_example (
	input logic vga_clk,
	input logic [9:0] DrawX, DrawY,
	input logic blank,
	input  logic [9:0] CursorX, CursorY, CursorS,
	input logic [7:0] btn_keycode,
	output logic [3:0] red, green, blue,
	output logic red_click_out,
  output logic orange_click_out,
  output logic yellow_click_out,
  output logic green_click_out,
  output logic blue_click_out,
  output logic indigo_click_out,
  output logic violet_click_out
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
logic [4:0] rom_q_bg;

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
begin:Color_on_proc
	// red
	if (DrawY >= 2*DrawX-12 && DrawY <= 2*DrawX && DrawY <= 360 && DrawY >= 10)
		red_on = 1'b1;
	else
		red_on = 1'b0;
	// orange
	if (DrawY >= 3*DrawX-258 && DrawY <= 3*DrawX-240 && DrawY <= 360 && DrawY >= 10)
		orange_on = 1'b1;
	else
		orange_on = 1'b0;
	// yellow
	if (DrawY >= 6*DrawX-996 && DrawY <= 6*DrawX-960 && DrawY <= 360 && DrawY >= 10)
		yellow_on = 1'b1;
	else
		yellow_on = 1'b0;
	// green
	if (DrawX >= 240 && DrawX <= 246 && DrawY <= 360 && DrawY >= 10)
		green_on = 1'b1;
	else
		green_on = 1'b0;
	// blue
	if (DrawY >= -6*DrawX+1920 && DrawY <= -6*DrawX+1956 && DrawY <= 360 && DrawY >= 10)
		blue_on = 1'b1;
	else
		blue_on = 1'b0;
	// indigo
	if (DrawY >= -3*DrawX+1200 && DrawY <= -3*DrawX+1218 && DrawY <= 360 && DrawY >= 10)
		indigo_on = 1'b1;
	else
		indigo_on = 1'b0;
	//violet
	if (DrawY >= -2*DrawX+960 && DrawY <= -2*DrawX+972 && DrawY <= 360 && DrawY >= 10)
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
assign rom_address = DrawX + (DrawY * 640);


// check only center of cursor
logic [2:0] q; // r=4, so d=8, 8*8=64
logic [3:0] r, g, b;
logic [17:0] pix_address;

// assign pix_address = (CursorX * 480 / 640) + ((CursorY * 480 / 480) * 480);
assign pix_address = CursorX + (CursorY * 640);
// bg_rom cursor_picture ( .addra(pix_address), .clka(negedge_vga_clk), .douta(q) );
// bg_palette cursor_palette ( .index(q), .red(r), .green(g), .blue(b) );

bg_rom background ( .addra(rom_address), .clka(negedge_vga_clk), .douta(rom_q_bg) );
bg_palette bg_palette ( .index(rom_q_bg), .red(bg_red), .green (bg_green), .blue  (bg_blue) );
logic color_on;

logic red_int;
logic orange_int;
logic yellow_int;
logic green_int;
logic blue_int;
logic indigo_int;
logic violet_int;

logic red_click_next;
logic orange_click_next;
logic yellow_click_next;
logic green_click_next;
logic blue_click_next;
logic indigo_click_next;
logic violet_click_next;

logic red_click;
logic orange_click;
logic yellow_click;
logic green_click;
logic blue_click;
logic indigo_click;
logic violet_click;

assign red_click_out = red_click;
assign orange_click_out = orange_click;
assign yellow_click_out = yellow_click;
assign green_click_out = green_click;
assign blue_click_out = blue_click;
assign indigo_click_out = indigo_click;
assign violet_click_out = violet_click;

logic [9:0] RedY;
logic [9:0] OrangeY;
logic [9:0] YellowY;
logic [9:0] GreenY;
logic [9:0] BlueY;
logic [9:0] IndigoY;
logic [9:0] VioletY;

logic [9:0] RedY_next;
logic [9:0] OrangeY_next;
logic [9:0] YellowY_next;
logic [9:0] GreenY_next;
logic [9:0] BlueY_next;
logic [9:0] IndigoY_next;
logic [9:0] VioletY_next;

logic RedCarrot_on;
logic OrangeCarrot_on;
logic YellowCarrot_on;
logic GreenCarrot_on;
logic BlueCarrot_on;
logic IndigoCarrot_on;
logic VioletCarrot_on;

always_comb 
begin:Carrot_on_proc
	// red
	if (DrawY <= 348 && DrawY >= 3*DrawX-192 && DrawY >= -3*DrawX+870) begin
		RedCarrot_on = 1'b1;
	end
	else begin
		RedCarrot_on = 1'b0;
	end
	// orange
	if (DrawY <= 348 && DrawY >= 3*DrawX-258 && DrawY >= -3*DrawX+936) begin
		OrangeCarrot_on = 1'b1;
	end
	else begin
		OrangeCarrot_on = 1'b0;
	end
	// yellow
	if (DrawY <= 348 && DrawY >= 3*DrawX-324 && DrawY >= -3*DrawX+1002) begin
		YellowCarrot_on = 1'b1;
	end
	else begin
		YellowCarrot_on = 1'b0;
	end
	// green
	if (DrawY <= 348 && DrawY >= 3*DrawX-390 && DrawY >= -3*DrawX+1068) begin
		GreenCarrot_on = 1'b1;
	end
	else begin
		GreenCarrot_on = 1'b0;
	end
	// blue
	if (DrawY <= 348 && DrawY >= 3*DrawX-456 && DrawY >= -3*DrawX+1134) begin
		BlueCarrot_on = 1'b1;
	end
	else begin
		BlueCarrot_on = 1'b0;
	end
	// indigo
	if (DrawY <= 348 && DrawY >= 3*DrawX-522 && DrawY >= -3*DrawX+1200) begin
		IndigoCarrot_on = 1'b1;
	end
	else begin
		IndigoCarrot_on = 1'b0;
	end
	// violet
	if (DrawY <= 348 && DrawY >= 3*DrawX-588 && DrawY >= -3*DrawX+1266) begin
		VioletCarrot_on = 1'b1;
	end
	else begin
		VioletCarrot_on = 1'b0;
	end
end

always_comb
begin:Red_int_proc

// new
	if (l_click) begin
		if (CursorY <= 348 && CursorY >= 3*CursorX-192 && CursorY >= -3*CursorX+870 && red_click) begin 
			red_click_next= 1'b0;
			RedY_next = 9'd10;
		end
		else if (CursorY >= 2*CursorX-16 && CursorY <= 2*CursorX+4 && CursorY <= 360 && CursorY >= 11) begin
			red_click_next = 1'b1;
			RedY_next = CursorY;
		end
	end
	else begin
		if (CursorY <= 348 && CursorY >= 3*CursorX-192 && CursorY >= -3*CursorX+870 && red_click)
			red_int = 1'b0;
		if (CursorY >= 2*CursorX-16 && CursorY <= 2*CursorX+4 && CursorY <= 360 && CursorY >= 11)
			red_int = 1'b1;
		else
			red_int = 1'b0;
	end

// old
	// if (CursorY >= 2*CursorX-16 && CursorY <= 2*CursorX+4 && CursorY <= 360 && CursorY >= 11) begin//(CursorY <= 2*CursorX && CursorY >= 2*CursorX-12 && CursorY <= 360 && CursorY >= 11)
	// 	if (l_click) begin
	// 		if (red_click) begin
	// 			red_click_next = 1'b0;
	// 			RedY_next = 9'd10;
	// 		end
	// 		else begin
	// 			red_click_next = 1'b1;
	// 			RedY_next = CursorY;
	// 		end
	// 	end
	// 	else 
	// 		red_int = 1'b1;
	// end
	// else
	// 	red_int = 1'b0;
end
always_comb
begin:Orange_int_proc
	if (l_click) begin
	    if (CursorY <= 350 && CursorY >= 341 && CursorX >= 194 && CursorX <= 204 && orange_click) begin
			orange_click_next = 1'b0;
			OrangeY_next = 9'd10;
		end
		else if (CursorY >= 3*CursorX-264 && CursorY <= 3*CursorX-234 && CursorY <= 360 && CursorY >= 11) begin
			orange_click_next = 1'b1;
			OrangeY_next = CursorY;
		end
		
	end
	else begin
		if (CursorY <= 350 && CursorY >= 341 && CursorX >= 194 && CursorX <= 204 && orange_click)
			orange_int = 1'b0;
		else if (CursorY >= 3*CursorX-264 && CursorY <= 3*CursorX-234 && CursorY <= 360 && CursorY >= 11)
			orange_int = 1'b1;
		else
			orange_int = 1'b0;
	end
	// if (CursorY >= 3*CursorX-264 && CursorY <= 3*CursorX-234 && CursorY <= 360 && CursorY >= 11) begin
	// 	if (l_click) begin
	// 		if (orange_click) begin
	// 			orange_click_next = 1'b0;
	// 			OrangeY_next = 9'd10;
	// 		end
	// 		else begin
	// 			orange_click_next = 1'b1;
	// 			OrangeY_next = CursorY;
	// 		end
	// 	end
	// 	else 
	// 		orange_int = 1'b1;
	// end
	// else
	// 	orange_int = 1'b0;
end
always_comb
begin:Yellow_int_proc
	if (CursorY >= 6*CursorX-1008 && CursorY <= 6*CursorX-948 && CursorY <= 360 && CursorY >= 11) begin
		if (l_click) begin
			if (yellow_click) begin
				yellow_click_next = 1'b0;
				YellowY_next = 9'd10;
			end
			else begin
				yellow_click_next = 1'b1;
				YellowY_next = CursorY;
			end
		end
		else 
			yellow_int = 1'b1;
	end
	else
		yellow_int = 1'b0;
end
always_comb
begin:Green_int_proc
	if (CursorX >= 238 && CursorX <= 248 && CursorY <= 360 && CursorY >= 11) begin
		if (l_click) begin
			if (green_click) begin
				green_click_next = 1'b0;
				GreenY_next = 9'd10;
			end
			else begin
				green_click_next = 1'b1;
				GreenY_next = CursorY;
			end
		end
		else 
			green_int = 1'b1;
	end
	else
		green_int = 1'b0;
end
always_comb
begin:Blue_int_proc
	if (CursorY >= -6*CursorX+1908 && CursorY <= -6*CursorX+1968 && CursorY <= 360 && CursorY >= 11) begin
		if (l_click) begin
			if (blue_click) begin
				blue_click_next = 1'b0;
				BlueY_next = 9'd10;
			end
			else begin
				blue_click_next = 1'b1;
				BlueY_next = CursorY;
			end
		end
		else 
			blue_int = 1'b1;
	end
	else
		blue_int = 1'b0;
end
always_comb
begin:Indigo_int_proc
	if ( CursorY >= -3*CursorX+1194 && CursorY <= -3*CursorX+1224 && CursorY <= 360 && CursorY >= 11) begin
		if (l_click) begin
			if (indigo_click) begin
					indigo_click_next = 1'b0;
					IndigoY_next = 9'd10;
			end
			else begin
				indigo_click_next = 1'b1;
				IndigoY_next = CursorY;
			end
		end
		else 
			indigo_int = 1'b1;
	end
	else
		indigo_int = 1'b0;
end
always_comb
begin:Violet_int_proc
	if (CursorY >= -2*CursorX+956 && CursorY <= -2*CursorX+976 && CursorY <= 360 && CursorY >= 11) begin
		if (l_click) begin
			if (violet_click) begin
					violet_click_next = 1'b0;
					VioletY_next = 9'd10;
			end
			else begin
				violet_click_next = 1'b1;
				VioletY_next = CursorY;
			end
		end
		else 
			violet_int = 1'b1;
	end
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
	
	red_click <= 1'b0;
	orange_click <= 1'b0;
	yellow_click <= 1'b0;
	green_click <= 1'b0;
	blue_click <= 1'b0;
	indigo_click <= 1'b0;
	violet_click <= 1'b0;

	RedY <= 9'd10;
	OrangeY <= 9'd10;
	YellowY <= 9'd10;
	GreenY <= 9'd10;
	BlueY <= 9'd10;
	IndigoY <= 9'd10;
	VioletY <= 9'd10;

	if (blank) begin  // This is when the non-blanking interval begins

	   RedY <= RedY_next;
	   OrangeY <= OrangeY_next;
	   YellowY <= YellowY_next;
	   GreenY <= GreenY_next;
	   BlueY <= BlueY_next;
	   IndigoY <= IndigoY_next;
	   VioletY <= VioletY_next;

	   red_click <= red_click_next;
	   orange_click <= orange_click_next;
	   yellow_click <= yellow_click_next;
	   green_click <= green_click_next;
	   blue_click <= blue_click_next;
	   indigo_click <= violet_click_next;
	   violet_click <= violet_click_next;

	    if ((cursor_on == 1'b1)) begin 
			// or import cursor palette
            red <= 4'hf;
            green <= 4'hf;
            blue <= 4'hf;
        end    
	    else begin
			// roygbiv: {4'hF, 4'h3, 4'h3}, {4'hF, 4'h9, 4'h4}, {4'hF, 4'hD, 4'h5}, {4'h7, 4'hD, 4'h5}, {4'h7, 4'hD, 4'h5}, {4'h3, 4'hB, 4'hF}, {4'h0, 4'h4, 4'hA}, {4'h5, 4'h1, 4'hE}
			// translucent roygbiv: {4'h7, 4'h1, 4'h1}, {4'h8, 4'h5, 4'h3}, {4'h7, 4'h6, 4'h2}, {4'h3, 4'h6, 4'h2}, {4'h1, 4'h5, 4'h7}, {4'h0, 4'h2, 4'h5}, {4'h2, 4'h0, 4'h7},
			if (red_on) begin
				// carrot
				if (red_click && RedCarrot_on) begin
					red <= 4'hf;
					green <= 4'hf;
					blue <= 4'hf;
				end
				// no color
				else if (red_click && DrawY < RedY) begin
					red <= bg_red;
					green <= bg_green;
					blue <= bg_blue;
				end
				// dim color
				else if ((red_int && (DrawY < CursorY)) || (red_int && red_click && DrawY > RedY)) begin
					red <= 4'h7;
					green <= 4'h1;
					blue <= 4'h1;
				end
				// normal color
				else begin  // ((!red_int || DrawY > CursorY)) 
					red <= 4'hF;
					green <= 4'h3;
					blue <= 4'h3;
				end
			end	
			else if (orange_on) begin
				// carrot
				if (orange_click && OrangeCarrot_on) begin
					red <= 4'hf;
					green <= 4'hf;
					blue <= 4'hf;
				end
				// no color
				else if (orange_click && DrawY < OrangeY) begin
					red <= bg_red;
					green <= bg_green;
					blue <= bg_blue;
				end
				// dim color
				else if ((orange_int && (DrawY < CursorY)) || (orange_int && orange_click && DrawY > OrangeY)) begin
					red <= 4'h8;
					green <= 4'h5;
					blue <= 4'h3;
				end
				// normal color
				else begin
					red <= 4'hF;
					green <= 4'h9;
					blue <= 4'h4;
				end
			end	
			else if (yellow_on) begin
				// carrot
				if (yellow_click && YellowCarrot_on) begin
					red <= 4'hf;
					green <= 4'hf;
					blue <= 4'hf;
				end
				// no color
				else if (yellow_click && DrawY < YellowY) begin
					red <= bg_red;
					green <= bg_green;
					blue <= bg_blue;
				end
				// dim color
				else if ((yellow_int && (DrawY < CursorY)) || (yellow_int && yellow_click && DrawY > YellowY)) begin
					red <= 4'h7;
					green <= 4'h6;
					blue <= 4'h2;
				end
				// normal color
				else begin
					red <= 4'hF;
					green <= 4'hD;
					blue <= 4'h5;
				end
			end	
			else if (green_on) begin
				if (!green_int || DrawY > CursorY) begin
					red <= 4'h7;
					green <= 4'hD;
					blue <= 4'h5;
				end
				else begin
					red <= 4'h3;
					green <= 4'h6;
					blue <= 4'h2;
				end
			end	
			else if (blue_on) begin
				if (!blue_int || DrawY > CursorY) begin
					red <= 4'h3;
					green <= 4'hB;
					blue <= 4'hF;
				end
				else begin
					red <= 4'h1;
					green <= 4'h5;
					blue <= 4'h7;
				end
			end	
			else if (indigo_on) begin
				if (!indigo_int || DrawY > CursorY) begin
					red <= 4'h0;
					green <= 4'h4;
					blue <= 4'hA;
				end
				else begin
					red <= 4'h0;
					green <= 4'h2;
					blue <= 4'h5;
				end
			end	
			else if (violet_on) begin
				if (!violet_int || DrawY > CursorY) begin
					red <= 4'h5;
					green <= 4'h1;
					blue <= 4'hE;
				end
				else begin
					red <= 4'h2;
					green <= 4'h0;
					blue <= 4'h7;
				end
			end	
			else begin // not drawing lasers
				red <= bg_red;
				green <= bg_green;
				blue <= bg_blue;
			end
		end
	end
end




endmodule
 