library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity CustomVHDLOperator_154b22bdc4e3734d is
    port (
        long: in std_logic_vector(28 downto 0);
        short: in std_logic_vector(28 downto 0);
        addend_0: out std_logic_vector(57 downto 0);
        addend_1: out std_logic_vector(57 downto 0);
        addend_2: out std_logic_vector(57 downto 0);
        addend_3: out std_logic_vector(57 downto 0);
        addend_4: out std_logic_vector(57 downto 0);
        addend_5: out std_logic_vector(57 downto 0);
        addend_6: out std_logic_vector(57 downto 0);
        addend_7: out std_logic_vector(57 downto 0);
        addend_8: out std_logic_vector(57 downto 0);
        addend_9: out std_logic_vector(57 downto 0);
        addend_10: out std_logic_vector(57 downto 0);
        addend_11: out std_logic_vector(57 downto 0);
        addend_12: out std_logic_vector(57 downto 0);
        addend_13: out std_logic_vector(57 downto 0);
        addend_14: out std_logic_vector(57 downto 0);
        addend_15: out std_logic_vector(57 downto 0);
        addend_16: out std_logic_vector(57 downto 0);
        addend_17: out std_logic_vector(57 downto 0);
        addend_18: out std_logic_vector(57 downto 0);
        addend_19: out std_logic_vector(57 downto 0);
        addend_20: out std_logic_vector(57 downto 0);
        addend_21: out std_logic_vector(57 downto 0);
        addend_22: out std_logic_vector(57 downto 0);
        addend_23: out std_logic_vector(57 downto 0);
        addend_24: out std_logic_vector(57 downto 0);
        addend_25: out std_logic_vector(57 downto 0);
        addend_26: out std_logic_vector(57 downto 0);
        addend_27: out std_logic_vector(57 downto 0);
        subend: out std_logic_vector(57 downto 0)
    );
end entity;

architecture Behavioral of CustomVHDLOperator_154b22bdc4e3734d is
    signal long_shifted: std_logic_vector(56 downto 0);
    signal long_sign: std_logic;
begin
    long_shifted <= long & (1 to 28 => '0');
    long_sign <= long(long'high);
    addend_0 <= (1 to 29 => long_sign) & long_shifted(56 downto 28) when short(0) = '1' else (others => '0');
    addend_1 <= (1 to 28 => long_sign) & long_shifted(56 downto 27) when short(1) = '1' else (others => '0');
    addend_2 <= (1 to 27 => long_sign) & long_shifted(56 downto 26) when short(2) = '1' else (others => '0');
    addend_3 <= (1 to 26 => long_sign) & long_shifted(56 downto 25) when short(3) = '1' else (others => '0');
    addend_4 <= (1 to 25 => long_sign) & long_shifted(56 downto 24) when short(4) = '1' else (others => '0');
    addend_5 <= (1 to 24 => long_sign) & long_shifted(56 downto 23) when short(5) = '1' else (others => '0');
    addend_6 <= (1 to 23 => long_sign) & long_shifted(56 downto 22) when short(6) = '1' else (others => '0');
    addend_7 <= (1 to 22 => long_sign) & long_shifted(56 downto 21) when short(7) = '1' else (others => '0');
    addend_8 <= (1 to 21 => long_sign) & long_shifted(56 downto 20) when short(8) = '1' else (others => '0');
    addend_9 <= (1 to 20 => long_sign) & long_shifted(56 downto 19) when short(9) = '1' else (others => '0');
    addend_10 <= (1 to 19 => long_sign) & long_shifted(56 downto 18) when short(10) = '1' else (others => '0');
    addend_11 <= (1 to 18 => long_sign) & long_shifted(56 downto 17) when short(11) = '1' else (others => '0');
    addend_12 <= (1 to 17 => long_sign) & long_shifted(56 downto 16) when short(12) = '1' else (others => '0');
    addend_13 <= (1 to 16 => long_sign) & long_shifted(56 downto 15) when short(13) = '1' else (others => '0');
    addend_14 <= (1 to 15 => long_sign) & long_shifted(56 downto 14) when short(14) = '1' else (others => '0');
    addend_15 <= (1 to 14 => long_sign) & long_shifted(56 downto 13) when short(15) = '1' else (others => '0');
    addend_16 <= (1 to 13 => long_sign) & long_shifted(56 downto 12) when short(16) = '1' else (others => '0');
    addend_17 <= (1 to 12 => long_sign) & long_shifted(56 downto 11) when short(17) = '1' else (others => '0');
    addend_18 <= (1 to 11 => long_sign) & long_shifted(56 downto 10) when short(18) = '1' else (others => '0');
    addend_19 <= (1 to 10 => long_sign) & long_shifted(56 downto 9) when short(19) = '1' else (others => '0');
    addend_20 <= (1 to 9 => long_sign) & long_shifted(56 downto 8) when short(20) = '1' else (others => '0');
    addend_21 <= (1 to 8 => long_sign) & long_shifted(56 downto 7) when short(21) = '1' else (others => '0');
    addend_22 <= (1 to 7 => long_sign) & long_shifted(56 downto 6) when short(22) = '1' else (others => '0');
    addend_23 <= (1 to 6 => long_sign) & long_shifted(56 downto 5) when short(23) = '1' else (others => '0');
    addend_24 <= (1 to 5 => long_sign) & long_shifted(56 downto 4) when short(24) = '1' else (others => '0');
    addend_25 <= (1 to 4 => long_sign) & long_shifted(56 downto 3) when short(25) = '1' else (others => '0');
    addend_26 <= (1 to 3 => long_sign) & long_shifted(56 downto 2) when short(26) = '1' else (others => '0');
    addend_27 <= (1 to 2 => long_sign) & long_shifted(56 downto 1) when short(27) = '1' else (others => '0');
    subend <= (1 to 1 => long_sign) & long_shifted(56 downto 0) when short(28) = '1' else (others => '0');
end architecture;
