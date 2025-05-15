library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity MinPositiveXandOneMinusX_SFixedPoint_16_12 is
    port (
        i: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture structural of MinPositiveXandOneMinusX_SFixedPoint_16_12 is
    -- no declarations
begin
    o <= i when unsigned(i) < to_unsigned(2048, 29) else std_logic_vector(to_unsigned(4096, 29) - unsigned(i));
end architecture;