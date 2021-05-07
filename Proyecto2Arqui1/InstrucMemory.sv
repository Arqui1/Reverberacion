module InstrucMemory(input logic [31:0] address,
				output logic [31:0] instruc);

	logic [31:0] ROM[1023:0];
	initial
		$readmemh("C:/Files/ROM.txt",ROM);
		assign instruc = ROM[address[31:0]];

endmodule