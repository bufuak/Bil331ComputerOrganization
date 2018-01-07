module mips_data_mem (read_data, mem_address,write_data,opcode,sig_mem_read, sig_mem_write,clk);
output reg [31:0] read_data;
input [31:0] mem_address;
input [31:0] write_data;
input [5:0] opcode;
input sig_mem_read;
input sig_mem_write;
input clk;

reg [31:0] data_mem  [63:0];


always @(mem_address or write_data) begin
	if(clk!=0)
	begin
		if (sig_mem_read) begin
			$readmemb("data.mem", data_mem);
			if(opcode==6'b100100)	// lbu
				read_data = data_mem[mem_address][7:0] & 32'b00000000000000000000000011111111;
			else if(opcode==6'b100101) //lhu
				read_data = data_mem[mem_address][15:0] & 32'b00000000000000001111111111111111;
			else if(opcode==6'b110000) //ll
				read_data = data_mem[mem_address];
			else if(opcode==6'b100011) //lw
				read_data = data_mem[mem_address];
		end

		if (sig_mem_write) begin
			$readmemb("data.mem", data_mem);
			if(opcode==6'b101011)	// sw
				data_mem[mem_address] = write_data;
			else if(opcode==6'b101000) // sb
				data_mem[mem_address][7:0] = write_data[7:0];
			else if(opcode==6'b111000) // sc rt atamasını yapmıyoruz
				data_mem[mem_address] = write_data;
			else if(opcode==6'b101001) // sh
				data_mem[mem_address][15:0] = write_data[15:0];
			$writememb("data.mem",data_mem);
		end
	end
end

endmodule