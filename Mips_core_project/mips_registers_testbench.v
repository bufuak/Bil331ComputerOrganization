module mips_registers_testbench();

wire [31:0] read_data_1, read_data_2;
reg [31:0] write_data;
reg [4:0] read_reg_1, read_reg_2, write_reg;
reg signal_reg_write, clk;

mips_registers regblock(read_data_1, read_data_2, write_data, read_reg_1, read_reg_2, write_reg, signal_reg_write, clk );

initial begin
read_reg_1 = 5'b00000; read_reg_2 = 5'b00001; write_reg = 5'b00010; write_data = 32'b000000; clk=0; signal_reg_write=1;
#10;
read_reg_1 = 5'b00000; read_reg_2 = 5'b00001; write_reg = 5'b00010; write_data = 32'b101010; clk=1; signal_reg_write=1;
#10;
read_reg_1 = 5'b00001; read_reg_2 = 5'b00010; write_reg = 5'b00011; write_data = 32'b000000; clk=0; signal_reg_write=1;
#10;
read_reg_1 = 5'b00001; read_reg_2 = 5'b00010; write_reg = 5'b00011; write_data = 32'b010101; clk=1; signal_reg_write=1;
#10;
read_reg_1 = 5'b00010; read_reg_2 = 5'b00011; write_reg = 5'b00100; write_data = 32'b000000; clk=0; signal_reg_write=1;
#10;
read_reg_1 = 5'b00010; read_reg_2 = 5'b00011; write_reg = 5'b00100; write_data = 32'b111111; clk=1; signal_reg_write=1;
#10;

end


initial
begin
$monitor("time = %2d,clock=%d,read_reg_1 =%5b, read_reg_2=%5b read_data_1=%32b, read_data_2=%32b, result=%32b", $time, clk,read_reg_1, read_reg_2,read_data_1,read_data_2, write_data);
end



endmodule