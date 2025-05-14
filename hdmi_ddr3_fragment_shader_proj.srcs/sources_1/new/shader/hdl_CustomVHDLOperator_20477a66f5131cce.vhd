library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity CustomVHDLOperator_20477a66f5131cce is
    port (
        i: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture Behavioral of CustomVHDLOperator_20477a66f5131cce is
    -- no declarations
begin
    o <= (o'high downto 12 => '0') & i(11 downto 0);
end architecture;
