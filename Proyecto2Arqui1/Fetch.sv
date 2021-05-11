module Fetch (input logic clk,rst,en,
					//input logic pcWrite,
					input logic [31:0]pcNext,
					output logic [31:0]instr, pc, nextPcOut);
					
	PC #(32) pcflipflop(clk, rst, en, pcNext, pc);
	sumador #(32) add1(pc, 32'h1, nextPcOut);
	InstrucMemory ROM(pc, instr);
	
endmodule
