library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity CustomVHDLOperator_54eb70491d94dac4 is
    port (
        i: in std_logic_vector(57 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture Behavioral of CustomVHDLOperator_54eb70491d94dac4 is
    -- no declarations
begin
    o <= i(40 downto 12);
end architecture;
