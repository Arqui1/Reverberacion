module Alu #(parameter bits=32)(input logic [3:0] s,
										input logic [bits-1:0] a,b,
										output logic [bits-1:0] outAlu,
										output logic [3:0] flag);

	logic [bits-1:0] andO, orO, shiftl, shiftr, sumO, resO, multO, divO;
	logic cout, flagN, flagZ, flagO, foaux;
	logic [3:0] flagAux;
	
	//aritmetica
	sumALU #(bits) sumAlu(a,b,sumO,cout);
	resALU #(bits) resAlu(a,b,resO);
	mulALU #(bits) mulAlu(a,b,multO);
	divALU #(bits) divAlu(a,b,divO);

	andALU #(bits) andAlu(a,b,andO);
	orALU #(bits) orAlu(a,b,orO);
	
	//flags
	flagN #(bits) fN(s,outAlu,flagN);
	flagZ #(bits) fZ(s,outAlu,flagZ);
	flagO #(bits) fO(a,b,outAlu,s,flagO);
	
	//Corrimientos
	shiftL #(bits) sl(a,b,shiftl);
	shiftR #(bits) sr(a,b,shiftr);
	
	assign flagAux = {cout, flagN, flagZ, flagO};
	
	muxflag mf(s,flagAux,flag);
	
	muxALU #(bits) muxalu(s,
							sumO,
							resO,
							multO,
							divO,
							andO,
							orO,
							shiftl,
							shiftr,
							b,
							outAlu);
	
endmodule
