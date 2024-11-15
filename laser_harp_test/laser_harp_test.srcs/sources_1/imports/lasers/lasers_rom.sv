module lasers_rom (
	input logic clock,
	input logic [17:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:230399] /* synthesis ram_init_file = "./lasers/lasers.COE" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
