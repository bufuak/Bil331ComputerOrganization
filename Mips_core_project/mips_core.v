module mips_core(result);

output reg [31:0] result;
wire [31:0] instruction;
wire [31:0] read_data_1;
wire [31:0] read_data_2;
reg [31:0] ALU_mux;
reg [4:0] REG_dst_mux;
reg [31:0] REG_write_mux;
wire [31:0] ALU_result;
wire [31:0] MEM_result;
reg [5:0] functioncode;
reg [4:0] rs;
reg [4:0] rt;
reg [4:0] rd;
reg [4:0] shmat;
reg [5:0] opcode;
reg [31:0] imm;
reg signed [25:0] adress;
reg signed [31:0] branchadress;
reg [31:0] jumpadress;
reg [31:0] PC;
reg clk;
reg write_reg_signal;
reg read_mem_signal;
reg write_mem_signal;

initial clk=0;
initial write_reg_signal=0;
initial write_mem_signal=0;
initial PC=32'b0;


mips_registers regblock(read_data_1, read_data_2, REG_write_mux, rs, rt, REG_dst_mux, write_reg_signal, clk );
ALU ALUblock(ALU_result,read_data_1,ALU_mux,shmat,opcode,functioncode,clk);
mips_data_mem MEMblock(MEM_result,ALU_result,read_data_2,opcode,read_mem_signal,write_mem_signal,clk);
mips_instr_mem INSblock(instruction,PC);
always @(read_data_1 or read_data_2 or instruction)
begin
if(instruction==32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx)
	$finish;
opcode = instruction[31:26];
rs = instruction[25:21];
rt = instruction[20:16];
rd = instruction[15:11];
shmat = instruction[10:6];
functioncode = instruction[5:0];
imm = instruction[15:0];
adress = instruction[25:0];
if (opcode==6'b000000)			   // R type
	begin
	REG_dst_mux = rd;
	write_mem_signal=0; // R type'ta memorye yazılmıyor.
	read_mem_signal=0;  // R type'ta memoryden okunmuyor.
	if (functioncode==6'b001000) //jr'de registera bir şey yazılmıyor
		write_reg_signal=0;
	else
		write_reg_signal=1;
	#2;
	ALU_mux = read_data_2;
	clk = !clk;
	#7;		
	REG_write_mux = ALU_result;	
	result = REG_write_mux;
	#1;	
	if (functioncode==6'b001000) //jr ise pc rs dir
		PC=read_data_1;
	else
		PC=PC+4;	
	clk = !clk;	
	end
else							// I or J type
	begin	
	if(opcode==6'b000011)		// If jal
		REG_dst_mux = 5'b11111;				// REG_dst_mux = R[31]
	else								// or
		REG_dst_mux = rt;						// rt
		
		
	if(opcode==6'b100011 | opcode==6'b100100 | opcode==6'b100101 | opcode==6'b110000 | opcode==6'b001111) //	loads
		begin
		read_mem_signal=1;
		write_mem_signal=0;
		write_reg_signal=1;
		end
	else if(opcode==6'b101000 | opcode==6'b101001 | opcode==6'b111000 | opcode == 6'b101011) // stores
		begin
		write_mem_signal=1;
		write_reg_signal=0;
		read_mem_signal=0;
		end
	else if(opcode==6'b000100 | opcode==6'b000101 | opcode==6'b000010) // beq or bne or j
		begin
		write_mem_signal=0;
		read_mem_signal=0;
		write_reg_signal=0;
		end
	else										// others write to reg
		begin
		write_reg_signal=1;
		write_mem_signal=0;
		read_mem_signal=0;
		end
	#2;	
	if(imm[15]==1'b1 && (opcode!=6'b001100) && (opcode!=6'b001101))	// SignExtImm
		ALU_mux = imm | 32'b11111111111111110000000000000000;
	else																					// andi ZeroExtImm ori ZeroExtImm
		ALU_mux = imm & 32'b00000000000000001111111111111111;
	clk = !clk;
	#7;	
	if(opcode==6'b000011)				// jal
		REG_write_mux = PC+8;
	else if(opcode==6'b100011 | opcode==6'b100100 | opcode==6'b100101 | opcode==6'b110000) //loads
		REG_write_mux = MEM_result;
	else if(opcode==6'b001111) //lui
		REG_write_mux = imm<<16;
	else										// or
		REG_write_mux = ALU_result;	
	result = REG_write_mux;
	#1;	
	if(opcode==6'b000100 | opcode==6'b000101 | opcode==6'b000010 | opcode==6'b000011)	// beq or bne or j or jal
		begin
		if(imm[15]==1'b1)
			branchadress = imm<<2 | 32'b11111111111111000000000000000000;
		else
			branchadress = imm<<2 & 32'b00000000000000111111111111111111;
			
		jumpadress = adress<<2 | PC[31:28]<<28;
		
		if(read_data_1==read_data_2 && opcode==6'b000100)	//beq
			PC = PC+4+branchadress;
		else if(read_data_1!=read_data_2 && opcode==6'b000101) //bne
			PC = PC+4+branchadress;
		else if(opcode==6'b000010)	// j
			PC = jumpadress;
		else if(opcode==6'b000011) // jal
			PC = jumpadress;
		else
			PC=PC+4;
		end
	else
		PC=PC+4;	
	clk = !clk;	
	end
	

end
endmodule      