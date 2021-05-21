module PC #(parameter bits=8) (input logic clk, rst,
									input logic [bits-1:0] d, 
									output logic [bits-1:0] q);

    always_ff @(posedge clk, posedge rst) 
        if (rst) q <= 0;
        else q <= d;

endmodule
