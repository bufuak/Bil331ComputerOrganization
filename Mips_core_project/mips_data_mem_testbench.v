module mips_data_mem_testbench();

reg [31:0] mem_address;
reg [31:0] write_data;
reg [5:0] opcode;
reg sig_mem_read;
reg sig_mem_write;
reg clk;
wire [31:0] read_data;

mips_data_mem DataTB (read_data, mem_address, write_data,opcode,sig_mem_read,sig_mem_write,clk);

initial begin
mem_address = 32'b00000000000000000000000000000001; write_data = 32'b01111111111111111111111000111100; opcode=6'b100100;  sig_mem_read=1'b1; sig_mem_write=1'b0; clk =1'b0; #10; // lbu
mem_address = 32'b00000000000000000000000000000001; write_data = 32'b01111111111111111111111111111100; opcode=6'b100100;  sig_mem_read=1'b1; sig_mem_write=1'b0; clk =1'b1; #10; // lbu

mem_address = 32'b00000000000000000000000000000001; write_data = 32'b01111111111110000001111111111100; opcode=6'b100101;  sig_mem_read=1'b1; sig_mem_write=1'b0; clk =1'b0; #10; // lhu
mem_address = 32'b00000000000000000000000000000001; write_data = 32'b01111111111111111111111111111100; opcode=6'b100101;  sig_mem_read=1'b1; sig_mem_write=1'b0; clk =1'b1; #10; // lhu

mem_address = 32'b00000000000000000000000000000001; write_data = 32'b01111111111111111110011111111100; opcode=6'b100011;  sig_mem_read=1'b1; sig_mem_write=1'b0; clk =1'b0; #10; // lw
mem_address = 32'b00000000000000000000000000000001; write_data = 32'b01111111111111111111111111111100; opcode=6'b100011;  sig_mem_read=1'b1; sig_mem_write=1'b0; clk =1'b1; #10; // lw


mem_address = 32'b00000000000000000000000000000101; write_data = 32'b01111111111111111111111111111100; opcode=6'b101000;  sig_mem_read=1'b0; sig_mem_write=1'b1; clk =1'b0; #10; // sb
mem_address = 32'b00000000000000000000000000000100; write_data = 32'b01111111111111111111111111111100; opcode=6'b101000;  sig_mem_read=1'b0; sig_mem_write=1'b1; clk =1'b1; #10; // sb

mem_address = 32'b00000000000000000000000000000010; write_data = 32'b01111111111111111111111111111100; opcode=6'b101001;  sig_mem_read=1'b0; sig_mem_write=1'b1; clk =1'b0; #10; // sh
mem_address = 32'b00000000000000000000000000000011; write_data = 32'b01111111111111111111111111111100; opcode=6'b101001;  sig_mem_read=1'b0; sig_mem_write=1'b1; clk =1'b1; #10; // sh

mem_address = 32'b00000000000000000000000000000110; write_data = 32'b01111111111111111111111111111100; opcode=6'b101011;  sig_mem_read=1'b0; sig_mem_write=1'b1; clk =1'b0; #10; // sw
mem_address = 32'b00000000000000000000000000000010; write_data = 32'b01111111111111111111111111111100; opcode=6'b101011;  sig_mem_read=1'b0; sig_mem_write=1'b1; clk =1'b1; #10; // sw


end

initial
begin
$monitor("time = %2d,opcode=%6b,, mem_address=%32b ,write_data=%32b ,read_data=%32b, sig_mem_read=%1b, sig_mem_write=%1b, clk=%1b", $time,opcode,mem_address,write_data,read_data, sig_mem_read,sig_mem_write,clk);
end




endmodule