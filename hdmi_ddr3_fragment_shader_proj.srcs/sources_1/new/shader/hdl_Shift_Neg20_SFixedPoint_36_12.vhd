library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity Shift_Neg20_SFixedPoint_36_12 is
    port (
        i: in std_logic_vector(48 downto 0);
        o: out std_logic_vector(48 downto 0)
    );
end entity;

architecture structural of Shift_Neg20_SFixedPoint_36_12 is
    -- no declarations
begin
    o <= std_logic_vector(shift_right(signed(i), 20));
end architecture;