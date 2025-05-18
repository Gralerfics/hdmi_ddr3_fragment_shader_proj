library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity Convert_SFixedPoint_16_12_UFixedPoint_8_0 is
    port (
        i: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(7 downto 0)
    );
end entity;

architecture structural of Convert_SFixedPoint_16_12_UFixedPoint_8_0 is
    -- no declarations
begin
    o <= i(19 downto 12);
end architecture;