module ALU_testbench();

reg [31:0] read_data_1;
reg [31:0] read_data_2;
reg [4:0] shmat;
reg [5:0] opcode;
reg [5:0] functioncode;
reg clk;
wire [31:0] result;

ALU ALUtb (result, read_data_1, read_data_2,shmat,opcode,functioncode,clk);

initial begin
read_data_1 = 32'b10000000000000000000000000000100; read_data_2 = 32'b01111111111111111111111111111100; shmat=5'b00010 ; opcode=6'b000000; functioncode = 6'b000011;  clk =1'b0; #10; // testing add
read_data_1 = 32'b10000000000000000000000000000100; read_data_2 = 32'b01111111111111111111111111111100; shmat=5'b00010 ; opcode=6'b000000; functioncode = 6'b000011;  clk =1'b1; #10; // testing add

read_data_1 = 32'b10000000000000000000000000000101; read_data_2 = 32'b00000000000000000000000000001101; shmat=5'b00000 ; opcode=6'b000000; functioncode =  6'b100000;  clk =1'b0; #10;	// testing addu
read_data_1 = 32'b10000000000000000000000000000101; read_data_2 = 32'b00000000000000000000000000001101; shmat=5'b00000 ; opcode=6'b000000; functioncode =  6'b100000;  clk =1'b1; #10;	// testing addu

read_data_1 = 32'b10101010101010101010101010101010; read_data_2 = 32'b11111111111111110000000000000000; shmat=5'b00000 ; opcode=6'b000000; functioncode =  6'b100100;  clk =1'b0; #10;	// testing and
read_data_1 = 32'b10101010101010101010101010101010; read_data_2 = 32'b11111111111111110000000000000000; shmat=5'b00000 ; opcode=6'b000000; functioncode =  6'b100100;  clk =1'b1; #10;	// testing and

read_data_1 = 32'b10101010101010101010101010101010; read_data_2 = 32'b11111111111111110000000000000000; shmat=5'b00000 ; opcode=6'b000000; functioncode =  6'b100101;  clk =1'b0; #10; // testing or
read_data_1 = 32'b10101010101010101010101010101010; read_data_2 = 32'b11111111111111110000000000000000; shmat=5'b00000 ; opcode=6'b000000; functioncode =  6'b100101;  clk =1'b1; #10; // testing or

read_data_1 = 32'b10000000000000000000000000000100; read_data_2 = 32'b00000000000000000000000000001101; shmat=5'b00011 ; opcode=6'b000000; functioncode =  6'b000000;  clk =1'b0; #10; // testing sll
read_data_1 = 32'b10000000000000000000000000000100; read_data_2 = 32'b00000000000000000000000000001101; shmat=5'b00011 ; opcode=6'b000000; functioncode =  6'b000000;  clk =1'b1; #10; // testing sll

read_data_1 = 32'b10000000000000000000000000001100; read_data_2 = 32'b10000000000000000000000000001101; shmat=5'b00000 ; opcode=6'b000000; functioncode =  6'b101011;  clk =1'b0; #10; // testing sltu
read_data_1 = 32'b10000000000000000000000000001100; read_data_2 = 32'b10000000000000000000000000001101; shmat=5'b00000 ; opcode=6'b000000; functioncode =  6'b101011;  clk =1'b1; #10; // testing sltu

read_data_1 = 32'b10000000000000000000000000000100; read_data_2 = 32'b10000000000000000000001000001100; shmat=5'b00011 ; opcode=6'b000000; functioncode =  6'b000011;  clk =1'b0; #10; // testing sra
read_data_1 = 32'b10000000000000000000000000000100; read_data_2 = 32'b10000000000000000000001000001100; shmat=5'b00011 ; opcode=6'b000000; functioncode =  6'b000011;  clk =1'b1; #10; // testing sra

read_data_1 = 32'b10000000000000000000000000000100; read_data_2 = 32'b10000000000000000000001000001100; shmat=5'b00010 ; opcode=6'b000000; functioncode =  6'b000010;  clk =1'b0; #10; // testing srl
read_data_1 = 32'b10000000000000000000000000000100; read_data_2 = 32'b10000000000000000000001000001100; shmat=5'b00010 ; opcode=6'b000000; functioncode =  6'b000010;  clk =1'b1; #10; // testing srl

read_data_1 = 32'b10000000000000000000000010001101; read_data_2 = 32'b10000000000000000000000000001100; shmat=5'b00000 ; opcode=6'b000000; functioncode =  6'b100010;  clk =1'b0; #10; // testing sub
read_data_1 = 32'b10000000000000000000000010001101; read_data_2 = 32'b10000000000000000000000000001100; shmat=5'b00000 ; opcode=6'b000000; functioncode =  6'b100010;  clk =1'b1; #10; // testing sub

read_data_1 = 32'b10000000000000000000000000000100; read_data_2 = 32'b10000000000000000000001000001100; shmat=5'b01000 ; opcode=6'b001000; functioncode =  6'b001100;  clk =1'b0; #10; // testing addi
read_data_1 = 32'b10000000000000000000000000000100; read_data_2 = 32'b10000000000000000000001000001100; shmat=5'b01000 ; opcode=6'b001000; functioncode =  6'b001100;  clk =1'b1; #10; // testing addi

read_data_1 = 32'b10000000000000000000000010001101; read_data_2 = 32'b10000000000000000000000000001100; shmat=5'b00000 ; opcode=6'b100100; functioncode =  6'b001100;  clk =1'b0; #10; // testing mem
read_data_1 = 32'b10000000000000000000000010001101; read_data_2 = 32'b10000000000000000000000000001100; shmat=5'b00000 ; opcode=6'b100100; functioncode =  6'b001100;  clk =1'b1; #10; // testing mem


end

initial
begin
$monitor("time = %2d,opcode=%6b, functioncode=%6b ,shmat =%5b, read_data_1=%32b ,read_data_2=%32b ,result=%32b, clk=%1b", $time,opcode,functioncode,shmat,read_data_1, read_data_2,result,clk);
end




endmodule