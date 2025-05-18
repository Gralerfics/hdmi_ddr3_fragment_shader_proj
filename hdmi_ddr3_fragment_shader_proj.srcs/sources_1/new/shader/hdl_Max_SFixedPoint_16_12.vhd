library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity Max_SFixedPoint_16_12 is
    port (
        a: in std_logic_vector(28 downto 0);
        b: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture structural of Max_SFixedPoint_16_12 is
    -- no declarations
begin
    o <= a when signed(a) > signed(b) else b;
end architecture;