library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity CustomVHDLOperator_8cc207057edae2a2 is
    port (
        i: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture Behavioral of CustomVHDLOperator_8cc207057edae2a2 is
    -- no declarations
begin
    o <= i when unsigned(i) < to_unsigned(2048, 29) else std_logic_vector(to_unsigned(4096, 29) - unsigned(i));
end architecture;
