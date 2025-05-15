library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity Multiply_SFixedPoint_16_12_SFixedPoint_16_12_Truncated_Truncator is
    port (
        i: in std_logic_vector(57 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture structural of Multiply_SFixedPoint_16_12_SFixedPoint_16_12_Truncated_Truncator is
    -- no declarations
begin
    o <= i(40 downto 12);
end architecture;