`define DELAY 20
module likeALU_testbench(); 
reg[4:0] inp_A, inp_B;
reg[1:0] select;
wire[4:0] out;

likeALU likeALUtb (out, inp_A, inp_B,select);

initial begin
inp_A = 5'b10101; inp_B = 5'b11111; select = 2'b00;
#`DELAY;
inp_A = 5'b10101; inp_B = 5'b11111; select = 2'b01;
#`DELAY;
inp_A = 5'b10101; inp_B = 5'b11111; select = 2'b10;
#`DELAY;
inp_A = 5'b10101; inp_B = 5'b11111; select = 2'b11;
#`DELAY;
inp_A = 5'b11111; inp_B = 5'b11111; select = 2'b00;
#`DELAY;
inp_A = 5'b11111; inp_B = 5'b11111; select = 2'b01;
#`DELAY;
inp_A = 5'b11111; inp_B = 5'b11111; select = 2'b10;
#`DELAY;
inp_A = 5'b11111; inp_B = 5'b11111; select = 2'b11;
end
 
 
initial
begin
$monitor("time = %2d, inp_A =%5b, inp_B=%5b, select=%2b, out=%5b", $time, inp_A, inp_B, select, out);

end
endmodule