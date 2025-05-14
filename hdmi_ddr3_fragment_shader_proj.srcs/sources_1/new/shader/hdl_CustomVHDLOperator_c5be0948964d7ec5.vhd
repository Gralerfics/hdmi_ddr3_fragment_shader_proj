library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity CustomVHDLOperator_c5be0948964d7ec5 is
    port (
        i: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture Behavioral of CustomVHDLOperator_c5be0948964d7ec5 is
    -- no declarations
begin
    o <= (others => '0') when i(i'high) = '1' else
         (i'high downto 12 => '0', others => '1') when i(i'high downto 12) /= (i'high downto 12 => '0') else
         (i'high downto 12 => '0') & i(11 downto 0);
end architecture;
