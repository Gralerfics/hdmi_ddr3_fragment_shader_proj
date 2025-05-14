library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity CustomVHDLOperator_c2dcbe3e0178494f is
    port (
        i: in std_logic_vector(11 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture Behavioral of CustomVHDLOperator_c2dcbe3e0178494f is
    -- no declarations
begin
    o(23 downto 12) <= i;
    o(28 downto 24) <= (others => '0');
    o(11 downto 0) <= (others => '0');
end architecture;
