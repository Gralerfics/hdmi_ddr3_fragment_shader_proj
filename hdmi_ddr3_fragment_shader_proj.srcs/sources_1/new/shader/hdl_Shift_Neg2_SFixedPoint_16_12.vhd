library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity Shift_Neg2_SFixedPoint_16_12 is
    port (
        i: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture structural of Shift_Neg2_SFixedPoint_16_12 is
    -- no declarations
begin
    o <= std_logic_vector(shift_right(signed(i), 2));
end architecture;