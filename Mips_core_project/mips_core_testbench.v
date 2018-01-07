module mips_testbench ();

//reg [31:0] instruction_set;
wire [31:0] result;

mips_core mips_testbench(result);

initial begin
//....continue for all instruction types.... must be least 9 control
//							  |01234567890123456789012345678901
//instruction_set = 32'b00000000000000000000100011000000; #10; // sll 1 0 3
//instruction_set = 32'b00000000000000010001000011000011; #10; // sra 2 0 3
//instruction_set = 32'b00000000000000100001100010000010; #10; // srl 3 0 3
//instruction_set = 32'b00000000011000100010000000101011; #10; // sltu 4 3 2
//instruction_set = 32'b00000000001000100010100000100000; #10; // add 5 1 2
//instruction_set = 32'b00000000101001000011000000100001; #10; // addu 6 3 4
//instruction_set = 32'b00000000110001010011100000100010; #10; // sub  7 6 5 
//instruction_set = 32'b00000000110001010100000000000100; #10; // and 8 6 5
//instruction_set = 32'b00000000110001010100100000000101; #10; // or 9 6 5
//instruction_set = 32'b00110000000000011111111111111111; #10; // andi 0 
//instruction_set = 32'b00110100001000101111111111111111; #10; // ori 1 
//instruction_set = 32'b00100000010000110000000000000001; #10; // addi 2 
//instruction_set = 32'b10100000000000010000000000000000; #10; // sb
//instruction_set = 32'b10100100000000010000000000000001; #10; // sh
//instruction_set = 32'b10101100000000010000000000000010; #10; // sw
end

initial
begin
$monitor("time = %2d,result=%32b", $time,  result);
end




endmodule