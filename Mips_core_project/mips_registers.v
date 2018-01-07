module mips_registers ( read_data_1, read_data_2, write_data, read_reg_1, read_reg_2, write_reg, signal_reg_write, clk );

	output reg[31:0] read_data_1, read_data_2;
	input [31:0] write_data;
	input [4:0] read_reg_1, read_reg_2, write_reg;
	input signal_reg_write, clk;
	reg [31:0] x,y;
	reg [31:0] registers [31:0];
	
	always @(read_reg_1 or read_reg_2 or write_reg or write_data)
		begin
		 if (clk==0)
			begin
			$readmemb("registers.mem",registers);
			x=registers[read_reg_1];
			y=registers[read_reg_2];
			read_data_1=x;
			read_data_2=y;
			$writememb("registers.mem",registers);
			end
		else
			begin
			if (signal_reg_write==1)
				begin
				registers[write_reg]=write_data;
				$writememb("registers.mem",registers);
				end
			end
		end
	
	
endmodule