library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity Fract_SFixedPoint_16_12 is
    port (
        i: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture structural of Fract_SFixedPoint_16_12 is
    -- no declarations
begin
    o <= (o'high downto 12 => '0') & i(11 downto 0);
end architecture;