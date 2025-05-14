library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BitsAdd_SInt_58_SInt_58 is
    port (
        a: in std_logic_vector(57 downto 0);
        b: in std_logic_vector(57 downto 0);
        r: out std_logic_vector(57 downto 0)
    );
end entity;

architecture Behavioral of BitsAdd_SInt_58_SInt_58 is
begin
    r <= std_logic_vector(unsigned(a) + unsigned(b));
end architecture;
