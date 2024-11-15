module lasers_example (
	input logic vga_clk,
	input logic [9:0] DrawX, DrawY,
	input logic blank,
	input  logic [9:0] CursorX, CursorY, CursorS,
	output logic [3:0] red, green, blue,
);

logic cursor_on;

logic [17:0] rom_address;
logic [2:0] rom_q;

logic [3:0] palette_red, palette_green, palette_blue;

logic negedge_vga_clk;

int DistX, DistY, Size;
assign DistX = DrawX - CursorX;
assign DistY = DrawY - CursorY;
assign Size = CursorS;

always_comb
begin:Cursor_on_proc
	if ( (DistX*DistX + DistY*DistY) <= (Size * Size) )
		cursor_on = 1'b1;
	else 
		cursor_on = 1'b0;
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
	
	    
	    //if
	       // Put cursor on screen
	       
	    //else
		  // Background colors 
		  red <= palette_red;
		  green <= palette_green;
		  blue <= palette_blue;
		
		
		
		
		
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

endmodule
