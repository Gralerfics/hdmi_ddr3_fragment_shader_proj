library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity FragCoordValueConvertor_UInt_12_SFixedPoint_16_12 is
    port (
        i: in std_logic_vector(11 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture structural of FragCoordValueConvertor_UInt_12_SFixedPoint_16_12 is
    -- no declarations
begin
    o(23 downto 12) <= i;
    o(28 downto 24) <= (others => '0');
    o(11 downto 0) <= (others => '0');
end architecture;