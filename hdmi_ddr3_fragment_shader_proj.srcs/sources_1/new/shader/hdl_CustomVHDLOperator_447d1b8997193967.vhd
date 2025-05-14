library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity CustomVHDLOperator_447d1b8997193967 is
    port (
        ee: in std_logic_vector(28 downto 0);
        vv: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture Behavioral of CustomVHDLOperator_447d1b8997193967 is
    -- no declarations
begin
    o <= vv when ee(ee'high) = '1' else std_logic_vector(to_unsigned(4096, 29) - unsigned(vv));
end architecture;
