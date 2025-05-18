library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity Convert_SFixedPoint_36_12_SFixedPoint_16_12 is
    port (
        i: in std_logic_vector(48 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture structural of Convert_SFixedPoint_36_12_SFixedPoint_16_12 is
    -- no declarations
begin
    o <= i(28 downto 0);
end architecture;