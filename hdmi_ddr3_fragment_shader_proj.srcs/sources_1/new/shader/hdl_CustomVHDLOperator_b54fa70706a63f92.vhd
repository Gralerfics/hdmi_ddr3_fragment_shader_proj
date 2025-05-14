library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity CustomVHDLOperator_b54fa70706a63f92 is
    port (
        r: in std_logic_vector(7 downto 0);
        g: in std_logic_vector(7 downto 0);
        b: in std_logic_vector(7 downto 0);
        o: out std_logic_vector(23 downto 0)
    );
end entity;

architecture Behavioral of CustomVHDLOperator_b54fa70706a63f92 is
    -- no declarations
begin
    o <= r & g & b;
end architecture;
