library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity Concatenate_Bits_16_Bits_8 is
    port (
        a: in std_logic_vector(15 downto 0);
        b: in std_logic_vector(7 downto 0);
        o: out std_logic_vector(23 downto 0)
    );
end entity;

architecture structural of Concatenate_Bits_16_Bits_8 is
    -- no declarations
begin
    o <= a & b;
end architecture;