module likeALU(out,inp_A,inp_B,select);
input[4:0] inp_A,inp_B;
input[1:0] select;
output[4:0] out;
wire[4:0] inpMux1;
wire[4:0] inpMux2;
wire[4:0] inpMux3;
wire[4:0] inpMux4;
wire[3:0] inpMux_1;
wire[3:0] inpMux_2;
wire[3:0] inpMux_3;
wire[3:0] inpMux_4;
wire[3:0] inpMux_5;
wire carry_out;
wire carry_in;
assign carry_in = 1'b0;
_5bitand InAandInB(inpMux1,inp_A,inp_B);
_5bitadder InAaddInB(inpMux2,carry_out,inp_A,inp_B,carry_in);
_5bitor InAorInB(inpMux3,inp_A,inp_B);
_5bitxor InxorInB(inpMux4,inp_A,inp_B);

assign inpMux_1[0]=inpMux1[0];
assign inpMux_1[1]=inpMux2[0];
assign inpMux_1[2]=inpMux3[0];
assign inpMux_1[3]=inpMux4[0];
_4inputmux muxof0(out[0],inpMux_1,select);

assign inpMux_2[0]=inpMux1[1];
assign inpMux_2[1]=inpMux2[1];
assign inpMux_2[2]=inpMux3[1];
assign inpMux_2[3]=inpMux4[1];
_4inputmux muxof1(out[1],inpMux_2,select);

assign inpMux_3[0]=inpMux1[2];
assign inpMux_3[1]=inpMux2[2];
assign inpMux_3[2]=inpMux3[2];
assign inpMux_3[3]=inpMux4[2];
_4inputmux muxof2(out[2],inpMux_3,select);

assign inpMux_4[0]=inpMux1[3];
assign inpMux_4[1]=inpMux2[3];
assign inpMux_4[2]=inpMux3[3];
assign inpMux_4[3]=inpMux4[3];
_4inputmux muxof3(out[3],inpMux_4,select);

assign inpMux_5[0]=inpMux1[4];
assign inpMux_5[1]=inpMux2[4];
assign inpMux_5[2]=inpMux3[4];
assign inpMux_5[3]=inpMux4[4];
_4inputmux muxof4(out[4],inpMux_5,select);

endmodule
