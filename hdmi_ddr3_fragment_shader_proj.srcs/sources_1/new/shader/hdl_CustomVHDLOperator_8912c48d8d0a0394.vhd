library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity CustomVHDLOperator_8912c48d8d0a0394 is
    port (
        i_clamped: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(7 downto 0)
    );
end entity;

architecture Behavioral of CustomVHDLOperator_8912c48d8d0a0394 is
    -- no declarations
begin
    o <= i_clamped(11 downto 4);
end architecture;
