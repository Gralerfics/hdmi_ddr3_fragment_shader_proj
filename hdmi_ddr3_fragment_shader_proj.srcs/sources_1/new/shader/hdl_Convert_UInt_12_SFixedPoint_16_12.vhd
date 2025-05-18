library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity Convert_UInt_12_SFixedPoint_16_12 is
    port (
        i: in std_logic_vector(11 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture structural of Convert_UInt_12_SFixedPoint_16_12 is
    -- no declarations
begin
    o <= (1 to 5 => '0') & i(11 downto 0) & (1 to 12 => '0');
end architecture;