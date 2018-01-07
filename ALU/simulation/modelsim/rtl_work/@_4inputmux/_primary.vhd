library verilog;
use verilog.vl_types.all;
entity \_4inputmux\ is
    port(
        \out\           : out    vl_logic;
        \in\            : in     vl_logic_vector(3 downto 0);
        \select\        : in     vl_logic_vector(1 downto 0)
    );
end \_4inputmux\;
