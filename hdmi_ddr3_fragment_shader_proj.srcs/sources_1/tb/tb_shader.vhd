library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.types.all;

entity tb_shader is
end entity;

architecture arch of tb_shader is
    component shader is
        port (
            itime_us: in std_logic_vector(63 downto 0);
            frag_x: in std_logic_vector(11 downto 0);
            frag_y: in std_logic_vector(11 downto 0);
            frag_color: out std_logic_vector(23 downto 0)
        );
    end component;

    signal clk: std_logic;

    signal itime_us: std_logic_vector(63 downto 0);
    signal frag_x: std_logic_vector(11 downto 0);
    signal frag_y: std_logic_vector(11 downto 0);
    signal frag_color: std_logic_vector(23 downto 0);
begin
    uut: shader port map(
        itime_us => itime_us,
        frag_x => frag_x,
        frag_y => frag_y,
        frag_color => frag_color
    );

    process is
    begin
        clk <= '0';
        wait for 50 ns;
        clk <= '1';
        wait for 50 ns;
    end process;

    process is
    begin
        for x in 0 to 1023 loop
            frag_x <= std_logic_vector(to_unsigned(x, 12));
            for y in 0 to 767 loop
                frag_y <= std_logic_vector(to_unsigned(y, 12));
                wait until rising_edge(clk);
            end loop;
        end loop;
        wait;
    end process;

    itime_us <= std_logic_vector(to_unsigned(3407872, 64)); -- 3.25, 11.01
end architecture;