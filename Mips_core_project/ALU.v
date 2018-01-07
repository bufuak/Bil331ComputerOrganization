module ALU (result, read_data_1, read_data_2,shmat,opcode,functioncode,clk);
	input [31:0] read_data_1;
	input [31:0] read_data_2;
	input [4:0] shmat;
	input [5:0] opcode;
	input [5:0] functioncode;
	input clk;
	output reg[31:0] result;
	reg signed [31:0] temp1;
	reg signed [31:0] temp2;
	reg signed [31:0] signed_result;
	
	always@(posedge clk)
		begin
		if(opcode==6'b001000)						// addi
			begin
			temp1=read_data_1;
			temp2=read_data_2;
			signed_result=temp1+temp2;
			result=signed_result;
			end
		else if(opcode==6'b001001)					// addiu
			result=read_data_1+read_data_2;
		else if(opcode==6'b001100)					// andi
			result=read_data_1&read_data_2;
		else if(opcode==6'b001101)					// ori
			result=read_data_1|read_data_2;
		else if(opcode==6'b001010)					// slti
			begin
			temp1=read_data_1;
			temp2=read_data_2;
			if(temp1<temp2)
				result=32'b1;
			else
				result=32'b0;
			end
		else if(opcode==6'b001011)					// sltiu
			begin
				if(read_data_1<read_data_2)
					result=32'b1;
				else
					result=32'b0;
			end
		else if(opcode==6'b100100 |opcode==6'b100101 |opcode==6'b110000 | opcode==6'b100011 // Memory
		| opcode==6'b101000 | opcode==6'b111000 | opcode==6'b101001 | opcode==6'b101011)	// Memory
			result=read_data_1+read_data_2;
		else if(opcode==6'b000000)					// R-types
			begin
			if(functioncode==6'b100000) //add
				begin
				temp1=read_data_1;
				temp2=read_data_2;
				signed_result=temp1+temp2;
				result=signed_result;
				end
			else if(functioncode==6'b100001) //addu
				result=read_data_1+read_data_2;
			else if(functioncode==6'b100100) //and
				result=read_data_1 & read_data_2;
			else if(functioncode==6'b100101) // or
				result=read_data_1 | read_data_2;
			else if(functioncode==6'b100111) // nor
				result=~(read_data_1 | read_data_2);
			else if(functioncode==6'b000000) // sll
				result=read_data_2 << shmat;
			else if(functioncode==6'b101010) // slt
				begin
				temp1=read_data_1;
				temp2=read_data_2;
				if(temp1<temp2)
					result=32'b1;
				else
					result=32'b0;
				end
			else if(functioncode==6'b101011)	// sltu
				begin
				if(read_data_1<read_data_2)
					result=32'b1;
				else
					result=32'b0;
				end
			else if(functioncode==6'b000011)	//sra
				result= $signed(read_data_2) >>> shmat;
			else if(functioncode==6'b000010) //srl
				result= read_data_2 >>> shmat;
			else if(functioncode==6'b100010) //sub
				begin
				temp1=read_data_1;
				temp2=read_data_2;
				signed_result=temp1-temp2;
				result=signed_result;
				end
			else if(functioncode==6'b100011) // subu
				result= read_data_1-read_data_2;
			end
		end
endmodule