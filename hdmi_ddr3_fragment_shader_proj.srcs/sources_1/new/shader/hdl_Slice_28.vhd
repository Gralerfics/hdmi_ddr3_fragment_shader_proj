library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity Slice_28 is
    port (
        i: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(0 downto 0)
    );
end entity;

architecture structural of Slice_28 is
    -- no declarations
begin
    o <= (0 => i(28));
end architecture;