module _5bitand(out,inp_A,inp_B);
input[4:0] inp_A,inp_B;
output[4:0] out;
and andof0(out[0],inp_A[0],inp_B[0]);
and andof1(out[1],inp_A[1],inp_B[1]);
and andof2(out[2],inp_A[2],inp_B[2]);
and andof3(out[3],inp_A[3],inp_B[3]);
and andof4(out[4],inp_A[4],inp_B[4]);
endmodule