library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity CustomVHDLOperator_cce8f0fc727add67 is
    port (
        a: in std_logic_vector(28 downto 0);
        b: in std_logic_vector(28 downto 0);
        o: out std_logic_vector(28 downto 0)
    );
end entity;

architecture Behavioral of CustomVHDLOperator_cce8f0fc727add67 is
    -- no declarations
begin
    o <= a when signed(a) < signed(b) else b;
end architecture;
