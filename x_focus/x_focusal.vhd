----------------------------------------------------------------------------------
-- Company: nabzgroup
-- Engineer: s.aghapoor
-- 
-- Create Date: 02/06/2021 02:25:45 PM
-- Design Name: 
-- Module Name: x_focusal - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;

entity x_focusal is
Port (
      i_clk               : in       std_logic;
      i_Radial_focus      : in       std_logic_vector(19 downto 0):="00000011001100110011";
      i_Res_coeff         : in       std_logic_vector(2 downto 0);
      i_k                 : in       std_logic_vector(6 downto 0);
      o_Z_focus1          : out      std_logic_vector(36 downto 0);
      o_X_focus1          : out      std_logic_vector(36 downto 0)
      );
end x_focusal;

architecture structral of x_focusal is


component rom_1014
generic(
     data_width_fixed_point: integer:=17;
     counter_out           : integer:=9
);
Port ( 
    i_clk               : in      STD_LOGIC;
    i_add               : in      STD_LOGIC_VECTOR (counter_out-1 downto 0);
    o_table_sin_saved   : out     STD_LOGIC_VECTOR (data_width_fixed_point-1 downto 0)
 );
end component;
---------------------------------------------
---------------------------------------------
component rom_1018
generic(
     data_width_fixed_point: integer:=17;
     counter_out           : integer:=9
);
Port ( 
    i_clk               : in      STD_LOGIC;
    i_add               : in      STD_LOGIC_VECTOR (counter_out-1 downto 0);
    o_table_cos_saved   : out     STD_LOGIC_VECTOR (data_width_fixed_point-1 downto 0)
);
end component;
---------------------------------------------
---------------------------------------------

-- signals
signal s_add                               :            std_logic_vector(8 downto 0);
signal s_add1                              :            std_logic_vector(9 downto 0);
signal s_table_sin_saved                   :            std_logic_vector(16 downto 0);
signal s_table_cos_saved                   :            std_logic_vector(16 downto 0);


begin
---------------------------------------------
---------------------------------------------
sin: rom_1014
generic map (
   data_width_fixed_point => 17,
   counter_out=>9
)
port map (
   i_clk => i_clk,
   i_add => s_add,
   o_table_sin_saved =>s_table_sin_saved
);
---------------------------------------------
---------------------------------------------
cos: rom_1018
generic map (
   data_width_fixed_point => 17,
   counter_out=>9
)
port map (
   i_clk => i_clk,
   i_add => s_add,
   o_table_cos_saved =>s_table_cos_saved
);

process(i_clk)
begin
 
       if (i_clk'event and i_clk='1') then
                                 s_add1  <=  (i_k-1)*i_Res_coeff + 1;
                                 s_add   <=   s_add1(8 downto 0)    ;
                                 o_X_focus1<= s_table_sin_saved *  i_Radial_focus;
                                 o_Z_focus1<= s_table_cos_saved *  i_Radial_focus;
end if;
end process;



end structral;
