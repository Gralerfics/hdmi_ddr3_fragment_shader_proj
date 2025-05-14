library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity shader_reserved is
    port (
        clock      : in  std_logic;
        reset      : in  std_logic;
        in_ready   : out std_logic;
        in_valid   : in  std_logic;
        out_ready  : in  std_logic;
        out_valid  : out std_logic;
        frag_x     : in  std_logic_vector(11 downto 0);
        frag_y     : in  std_logic_vector(11 downto 0);
        frag_color : out std_logic_vector(23 downto 0)
    );
end entity;

architecture arch of shader_reserved is
    signal in_ready_buf, tick: std_logic;
    signal x0, x0_next, y0, y0_next: std_logic_vector(11 downto 0);
    signal v0, v0_next: std_logic;
begin
    -- Shaking
    out_valid <= v0;
    in_ready_buf <= (not v0) or out_ready;
    tick <= in_ready_buf and in_valid;
    in_ready <= in_ready_buf;
    
    -- Level 0
--    process (clock, reset) begin
--        if reset = '1' then
--            v0 <= '0';
--        elsif in_ready == '1' then
--            v0 <= in_valid;
--        end if;
--    end process;
    process (clock, reset) begin
        if reset = '1' then
            x0 <= (others => '0');
            y0 <= (others => '0');
            v0 <= '0';
        elsif rising_edge(clock) and tick = '1' then
            x0 <= x0_next;
            y0 <= y0_next;
            v0 <= v0_next;
        end if;
    end process;
    
    x0_next <= frag_x;
    y0_next <= frag_y;
    v0_next <= in_valid;
    
    frag_color <= x"00FF00" when unsigned(x0) + unsigned(y0) <= 500 else x"0000FF";
end architecture;
