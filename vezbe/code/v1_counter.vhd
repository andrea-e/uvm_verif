library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity counter is
  port (
    clk  : in  std_logic;
    rst  : in  std_logic;
    ce_i : in  std_logic;
    up_i : in  std_logic;
    q_o  : out std_logic_vector(3 downto 0)
  );
end counter;

architecture rtl of counter is
  signal count_s: std_logic_vector(3 downto 0);
begin

  counter_p: process (clk)
  begin
    if clk = '1' and clk'event then
      if rst = '1' then
        count_s <= (others => '0');
      elsif ce_i = '1' then
        if up_i = '1' then
          count_s <= count_s + 1;
        else
          count_s <= count_s - 1;
        end if;
      end if;
    end if;
  end process;

  q_o <= count_s;

end rtl;
