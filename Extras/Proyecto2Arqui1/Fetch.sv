module Fetch (input logic clk,rst,en,modeSelector,
					//input logic pcWrite,
					input logic [31:0]pcNext,
					output logic [31:0]instr, pc, nextPcOut);
					
	logic [31:0] instr1,instr2;
					
	PC #(32) pcflipflop(clk, rst, en, pcNext, pc);
	sumador #(32) add1(pc, 32'h1, nextPcOut);
	InstrucMemory  ROM1(pc, instr1);
	InstrucMemory2 ROM2(pc, instr2);
	mux_ #(32)  muxMode(modeSelector,instr1,instr2,instr);
	
endmodule
