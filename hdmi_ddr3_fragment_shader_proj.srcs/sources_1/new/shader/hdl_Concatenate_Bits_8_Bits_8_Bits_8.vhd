library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity Concatenate_Bits_8_Bits_8_Bits_8 is
    port (
        r: in std_logic_vector(7 downto 0);
        g: in std_logic_vector(7 downto 0);
        b: in std_logic_vector(7 downto 0);
        o: out std_logic_vector(23 downto 0)
    );
end entity;

architecture structural of Concatenate_Bits_8_Bits_8_Bits_8 is
    -- no declarations
begin
    o <= r & g & b;
end architecture;