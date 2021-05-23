module Extend(input logic [16:0] datain,
                output logic [31:0] dataout);
   assign dataout = {{15{datain[16]}}, datain};
   
endmodule
