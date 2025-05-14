library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BitsSubtract_SFixedPoint_16_12_SFixedPoint_16_12 is
    port (
        a: in std_logic_vector(28 downto 0);
        b: in std_logic_vector(28 downto 0);
        r: out std_logic_vector(28 downto 0)
    );
end entity;

architecture Behavioral of BitsSubtract_SFixedPoint_16_12_SFixedPoint_16_12 is
begin
    r <= std_logic_vector(unsigned(a) - unsigned(b));
end architecture;
