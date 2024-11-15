module cursor_rom (
	input logic clock,
	input logic [9:0] address,
	output logic [0:0] q
);

logic [0:0] memory [0:767] /* synthesis ram_init_file = "./cursor/cursor.COE" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
