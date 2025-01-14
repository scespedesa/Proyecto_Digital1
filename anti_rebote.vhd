library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Recordando el diseño del registro de desplazamiento, se necesita de entrada una señal de reloj 
-- para hacer el muestreo del pulsador, la señal del pulsador y de salida la señal limpia del pulsador

-- * Construye la entidad con las señales de entrada y salida requeridas.
entity anti_rebote is 
	port(
	clk, pulsador: in std_logic;
	cambio : out std_logic);
	
end anti_rebote;

architecture registro of anti_rebote is

	signal desplazamiento : std_logic_vector (5 downto 0) := "111111" ;

	-- * Declara una señal vector de longitud mayor a 3 bits (este será el registro de desplazamiento).

begin

	-- * Coloca en la lista sensible las señales que ejecutarían el bloque process.
	process(clk)
	
	begin
	
		-- Un desplazamiento en un registro se puede realizar con el operador de concatenación &. 
		-- Por ejemplo si tiene un vector (registro) de 3 posiciones y quiere realizar un corrimiento hacia 
		-- la izquierda incluyendo un valor en la primera posicion, debe proceder de la siguiente manera:
		-- reg <= reg(1 downto 0) & btn;
		
		-- * Crea un condicional que se ejecute por flanco de subida de su señal de reloj. Dentro de este cree
		-- el registro de desplazamiento (considerar la lógica negativa de la tarjeta). 
		
		if rising_edge(clk) then
		
			desplazamiento <= desplazamiento (4 downto 0) & pulsador;
			
			if desplazamiento = "000000" then
				cambio <= '0';
			else
				cambio <= '1';
			end if;
			
		end if;
				
		-- Para definir la salida de acuerdo a los bits almacenados en el registro tiene dos opciones,
		-- la sentencia if-then o su análoga when-else.
		-- * Utiliza la de su preferencia.
		
	-- Sentencia secuencial if-then:
		
--		if reg = "111" then
--			bto <= '1';
--		else
--			bto <= '0';
--		end if;
	
	end process;
	
-- Sentencia concurrente análoga when-else :

--	bto <= '1' when reg = "111" else '0';

end registro;