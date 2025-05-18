library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity BinaryMultiplexer_SFixedPoint_16_12 is
    port (
        i0: in std_logic_vector(28 downto 0);
        i1: in std_logic_vector(28 downto 0);
        sel: in std_logic_vector(0 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture structural of BinaryMultiplexer_SFixedPoint_16_12 is
    -- no declarations
begin
    o <= i1 when sel = "1" else i0;
end architecture;