module InstrucMemory2(input logic [31:0] address,
				output logic [31:0] instruc);

	logic [31:0] ROM[80:0];
	initial
		$readmemh("C:/Users/danie/OneDrive/Documentos/TEC/Arqui 1/Proyectos/Proyecto Grupal/Files/ROMInstruc2.txt",ROM);
		assign instruc = ROM[address[31:0]];

endmodule
