module _5bitxor(out,inp_A,inp_B);
input[4:0] inp_A;
input[4:0] inp_B;
output[4:0] out;
xor xorof0(out[0],inp_A[0],inp_B[0]);
xor xorof1(out[1],inp_A[1],inp_B[1]);
xor xorof2(out[2],inp_A[2],inp_B[2]);
xor xorof3(out[3],inp_A[3],inp_B[3]);
xor xorof4(out[4],inp_A[4],inp_B[4]);
endmodule