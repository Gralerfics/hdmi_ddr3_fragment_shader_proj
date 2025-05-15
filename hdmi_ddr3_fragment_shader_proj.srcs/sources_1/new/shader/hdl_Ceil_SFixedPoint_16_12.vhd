library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity Ceil_SFixedPoint_16_12 is
    port (
        i: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture structural of Ceil_SFixedPoint_16_12 is
    signal plus_one: std_logic_vector(29 - 1 downto 0);
begin
    o(11 downto 0) <= (others => '0');
    plus_one <= std_logic_vector(unsigned(i) + to_unsigned(4096, 29));o(o'high downto 12) <= i(i'high downto 12) when i(11 downto 0) = (11 downto 0 => '0') else plus_one(o'high downto 12);
end architecture;