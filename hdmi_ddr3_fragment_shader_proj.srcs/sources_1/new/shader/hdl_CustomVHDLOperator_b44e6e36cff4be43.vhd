library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity CustomVHDLOperator_b44e6e36cff4be43 is
    port (
        i: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture Behavioral of CustomVHDLOperator_b44e6e36cff4be43 is
    -- no declarations
begin
    o <= std_logic_vector(shift_right(signed(i), 2));
end architecture;
