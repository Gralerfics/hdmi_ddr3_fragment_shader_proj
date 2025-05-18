library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity Convert_UInt_64_SFixedPoint_36_12 is
    port (
        i: in std_logic_vector(63 downto 0);
        o: out std_logic_vector(48 downto 0)
    );
end entity;

architecture structural of Convert_UInt_64_SFixedPoint_36_12 is
    -- no declarations
begin
    o <= i(36 downto 0) & (1 to 12 => '0');
end architecture;