module Fetch (input logic clk,
					input logic rst,
					//input logic pcWrite,
					input logic [31:0]pcNext,
					output logic [31:0]instr, nextPcOut);
	
	logic [31:0] pc;
					
	PC #(32) pcflipflop(clk, rst, pcNext, pc);
	adder add1(pc, 32'h1, nextPcOut);
	InstrucMemory ROM(pc,instr);
	
endmodule
