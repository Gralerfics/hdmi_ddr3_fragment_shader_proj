library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity ITimeConvertor_UInt_64_SFixedPoint_16_12 is
    port (
        i: in std_logic_vector(63 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture structural of ITimeConvertor_UInt_64_SFixedPoint_16_12 is
    -- no declarations
begin
    o <= '0' & i(35 downto 8);
end architecture;