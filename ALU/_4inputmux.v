module _4inputmux(out, in, select );
input[3:0] in;
input[1:0] select;
output out;
integer select_integer;
always@( select )
	select_integer=select;
assign out = in[select_integer];

endmodule