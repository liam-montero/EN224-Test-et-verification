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
use IEEE.NUMERIC_STD.ALL;

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
process (CLK, RESET)
begin
	if RESET = '0' 
		then etat_present <= 0;
	else if CLK'event and CLK = '1' then
		etat_present <= etat_suivant;
	end if;
end process;


--évolution
process (etat_present, idata_en)
begin
	case etat_present is
		when et0 => if idata_en = '1' then etat_suivant <= et1
				    else etat_suivant <= et0
					end if; 
		
		when et1 => etat_suivant <= et2;

		when et2 => etat_suivant <= et0;

		when others => etat_suivant <= et0;
	end case;
end process;

--Mise à jour des sorties
while (idata_a /= idata_b) loop
	if (idata_a > idata_b) then
		idata_a <= idata_a - idata_b;
	else
		idata_b <= idata_b - idata_a;
	end if;
	odata <= idata_a;
end loop;


odata_en <= '1' when etat_present = et2 else
		    '0';

end Ar;