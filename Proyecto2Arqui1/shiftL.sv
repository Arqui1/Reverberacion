module shiftL#	(parameter bits=32)(input logic [bits-1:0] num,
											input logic [bits-1:0] corrim,
											output logic [bits-1:0] out);
assign out = num << corrim;

endmodule