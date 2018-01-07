module instruction_testbench ();

reg [31:0] PC;
wire [31:0] instruction;

mips_instr_mem mips_instr_mem_testbench(instruction,PC);

initial begin

PC = 32'b00000000000000000000000000000000; #10; 
PC = 32'b00000000000000000000000000000100; #10; 
PC = 32'b00000000000000000000000000001000; #10; 
PC = 32'b00000000000000000000000000010000; #10; 
PC = 32'b00000000000000000000000000100000; #10; 
PC = 32'b00000000000000000000000001000000; #10; 
end

initial
begin
$monitor("time = %2d,PC==%32b, instruction=%32b", $time, PC, instruction);
end

endmodule