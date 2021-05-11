module PC #(parameter bits=32) (input logic clk, rst,en,
									input logic [bits-1:0] d, 
									output logic [bits-1:0] q);

    always_ff @(posedge clk, posedge rst) 
        if (rst) 		q <= 0;
        else if (!en) q <= d;

endmodule
