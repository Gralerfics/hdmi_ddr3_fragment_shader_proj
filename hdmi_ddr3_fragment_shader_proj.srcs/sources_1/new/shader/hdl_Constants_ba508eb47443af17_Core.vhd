library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity Constants_ba508eb47443af17_Core is
    port (
        c0_1: out std_logic_vector(28 downto 0);
        c0_95: out std_logic_vector(28 downto 0);
        c1: out std_logic_vector(28 downto 0);
        c3_75: out std_logic_vector(28 downto 0);
        c5: out std_logic_vector(28 downto 0);
        c5_5: out std_logic_vector(28 downto 0);
        c384: out std_logic_vector(28 downto 0)
    );
end entity;

architecture structural of Constants_ba508eb47443af17_Core is
    -- no declarations
begin
    c0_1 <= "00000000000000000000110011001";
    c0_95 <= "00000000000000000111100110011";
    c1 <= "00000000000000001000000000000";
    c3_75 <= "00000000000000011110000000000";
    c5 <= "00000000000000101000000000000";
    c5_5 <= "00000000000000101100000000000";
    c384 <= "00000000110000000000000000000";
end architecture;