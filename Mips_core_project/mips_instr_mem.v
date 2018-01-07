module mips_instr_mem(instruction, program_counter);
input [31:0] program_counter;
output reg[31:0] instruction;

reg [31:0] instruction_mem [254:0];

always @(program_counter)
	begin
	$readmemb("instruction.mem", instruction_mem);
	instruction = instruction_mem[program_counter/4];
	end
endmodule