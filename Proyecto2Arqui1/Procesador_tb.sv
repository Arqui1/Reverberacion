module Procesador_tb();

logic clk,rst,modeSelector,write,Status;
logic [31:0] Data;
int file1,file2;

Procesador processor(clk,rst,modeSelector,write,Data);

	initial
	begin
		clk = 0;
		Status = 0;
		rst = 1;
		#2
		rst = 0;
		modeSelector = 1;
	end
	
	always
	begin
		#5 clk=!clk;
		
		if(Status == 1'b0)begin // "Limpiar" el archivo
			Status = 1'b1; 
			file1 = $fopen("C:/QuartusProjects/Files/OUT1.txt","w");
			$fclose(file1);
			file2 = $fopen("C:/QuartusProjects/Files/OUT2.txt","w");
			$fclose(file2);
		end
		
		if((~clk) && Status && write)begin
			if(modeSelector)begin
				file2 = $fopen("C:/QuartusProjects/Files/OUT2.txt","a");
				$fwrite(file2,"%d\n",Data);
				$fclose(file2);
			end
			else begin
				file1 = $fopen("C:/QuartusProjects/Files/OUT1.txt","a");
				$fwrite(file1,"%d\n",Data);
				$fclose(file1);
			end
		end
	end

endmodule
