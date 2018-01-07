library verilog;
use verilog.vl_types.all;
entity \_5bitadder\ is
    port(
        S               : out    vl_logic_vector(4 downto 0);
        C               : out    vl_logic;
        A               : in     vl_logic_vector(4 downto 0);
        B               : in     vl_logic_vector(4 downto 0);
        C0              : in     vl_logic
    );
end \_5bitadder\;
