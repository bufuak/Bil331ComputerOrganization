library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        result          : out    vl_logic_vector(31 downto 0);
        read_data_1     : in     vl_logic_vector(31 downto 0);
        read_data_2     : in     vl_logic_vector(31 downto 0);
        shmat           : in     vl_logic_vector(4 downto 0);
        opcode          : in     vl_logic_vector(5 downto 0);
        functioncode    : in     vl_logic_vector(5 downto 0);
        clk             : in     vl_logic
    );
end ALU;
