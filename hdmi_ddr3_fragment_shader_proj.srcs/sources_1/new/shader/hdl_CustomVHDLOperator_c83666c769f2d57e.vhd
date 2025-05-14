library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity CustomVHDLOperator_c83666c769f2d57e is
    port (
        i: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture Behavioral of CustomVHDLOperator_c83666c769f2d57e is
    -- no declarations
begin
    o <= std_logic_vector(shift_right(signed(i), 7));
end architecture;
