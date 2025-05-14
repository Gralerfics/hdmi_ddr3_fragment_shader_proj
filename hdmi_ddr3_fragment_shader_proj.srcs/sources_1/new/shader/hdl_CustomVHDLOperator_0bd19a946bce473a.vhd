library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity CustomVHDLOperator_0bd19a946bce473a is
    port (
        i: in std_logic_vector(63 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture Behavioral of CustomVHDLOperator_0bd19a946bce473a is
    -- no declarations
begin
    o <= '0' & i(35 downto 8);
end architecture;
