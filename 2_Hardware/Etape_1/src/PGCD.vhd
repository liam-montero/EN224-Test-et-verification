----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2021 16:04:45
-- Design Name: 
-- Module Name: PGCD - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY PGCD IS
PORT ( 
	CLK      : in  STD_LOGIC;
	RESET    : in  STD_LOGIC;

	idata_a  : in  STD_LOGIC_VECTOR (31 downto 0);
	idata_b  : in  STD_LOGIC_VECTOR (31 downto 0);
	idata_en : in  STD_LOGIC;

	odata    : out STD_LOGIC_VECTOR (31 downto 0);
	odata_en : out STD_LOGIC
);
END PGCD;

Architecture Ar of PGCD is 
type etat is(et0, et1, et2);
signal etat_present, etat_suivant : etat;
begin

--mémorisation


--evolution
process (etat_present, idata_en)
begin
	case etat_present is
		when et0 => if idata_en = '1' then etat_suivant <= et1
				    else etat_suivant <= et0
					end if; 
		
		when et1 => etat_suivant <= et2;

		when et2 => etat_suivant <= et3;

		when others => etat_suivant <= et0;
	end case;
end process;




end Ar;