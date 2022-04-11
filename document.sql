--Practica M02-UF3-

--ejercicio1

LOAD DATA 

-- 1. Cargar datos a BD (1.5 puntos)
/*Utilice el documento world_temp_stats.sql para crear una nueva base de datos para
desarrollar la práctica.
Con los documentos .csv que encontrará en el POU dentro del archivo comprimido
DATA_world_temp_stats.zip:
1. city.csv
2. continent.csv
3. country.csv
4. temp_by_city.csv (partido en 3 archivos)
5. temp_by_country.csv
6. temp_by_major_city.csv
7. temp_by_state.csv
8. temp_global.csv
Cargue los datos dentro de las tablas de la base de datos world_temp_stats que
acaba de crear usando el operador LOAD DATA.
Compruebe que los datos están bien cargados en cada tabla y que el recuento de filas
(select count(*) ...) cuadra con el número de filas de cada archivo original. Debe tener en
cuenta que en la primera fila de alguno de los archivos puede haber el header de la tabla, es en
decir, del nombre de las columnas. Esta primera fila no debe cargarla en la base de
datos. También pueden contener filas nulas al inicio del archivo que deberá saltar.
Entregue:
• Acumule el código SQL necesario dentro del documento .sql a entregar.
• Capturas de pantalla de prueba dentro de la memoria escrita.*/

-- Cargar datos de tabla city:
LOAD DATA INFILE 'C:/PracticaM02UF3/DATA_world_temp_starts/city.csv'
INTO TABLE city FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES
TERMINATED BY '\n';


-- Cargar datos de tabla continent ( NB: hay  que ignorar la premira linia IGNORE 1 LINES):
LOAD DATA INFILE 'C:/PracticaM02UF3/DATA_world_temp_starts/continent.csv'
INTO TABLE continent FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES
TERMINATED BY '\n' IGNORE 1 LINES ;


-- Cargar datos de tabla country:
LOAD DATA INFILE 'C:/PracticaM02UF3/DATA_world_temp_starts/country.csv'
INTO TABLE country FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES
TERMINATED BY '\n';


-- Cargar datos de tabla temp_by_city:
LOAD DATA INFILE 'C:/PracticaM02UF3/DATA_world_temp_starts/temp_by_city.csv'
INTO TABLE temp_by_city FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES
TERMINATED BY '\n';

-- temp_by_city_2:
LOAD DATA INFILE 'C:/PracticaM02UF3/DATA_world_temp_starts/temp_by_city_2.csv'
INTO TABLE temp_by_city FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES
TERMINATED BY '\n' IGNORE 1 LINES ;

-- temp_by_city_3:
LOAD DATA INFILE 'C:/PracticaM02UF3/DATA_world_temp_starts/temp_by_city_3.csv'
INTO TABLE temp_by_city FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES
TERMINATED BY '\n';


-- Cargar datos de tabla temp_by_country:
LOAD DATA INFILE 'C:/PracticaM02UF3/DATA_world_temp_starts/temp_by_country.csv'
INTO TABLE temp_by_country FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES
TERMINATED BY '\n' IGNORE 1 LINES ;


-- Cargar datos de tabla temp_by_major_city
LOAD DATA INFILE 'C:/PracticaM02UF3/DATA_world_temp_starts/temp_by_major_city.csv'
INTO TABLE temp_by_major_city FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES
TERMINATED BY '\n';


-- Cargar datos de tabla temp_by_state
LOAD DATA INFILE 'C:/PracticaM02UF3/DATA_world_temp_starts/temp_by_state.csv'
INTO TABLE temp_by_state FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES
TERMINATED BY '\n' IGNORE 1 LINES ;


-- Cargar datos de tabla temp_global
LOAD DATA INFILE 'C:/PracticaM02UF3/DATA_world_temp_starts/temp_global.csv'
INTO TABLE temp_global FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LINES
TERMINATED BY '\n' IGNORE 2 LINES ;

--2. Procedure pCheckTableRowCount (2 puntos)
/*Cree un procedure nuevo que llamaremos pCheckTableRowCount dentro de la base de
datos world_temp_stats. Este procedimiento tendrá un parámetro de entrada de tipos
CHAR(1).
El objetivo de este procedimiento es el de crear y llenar una tabla resumen con el recuento
de filas para cada tabla de la base de datos world_temp_stats.
Dentro de este procedimiento crearemos una nueva tabla (si no existe) llamada
table_stats que tendrá las siguientes cinco columnas: id BIGINT AUTO_INCREMENT,
table_name VARCHAR(30), row_count INT, count_date DATETIME, execution_type
CHAR(1). Extra: En lugar de CHAR(1), puede usar un tipo de datos ENUM para la
columna execution_type que sólo acepte los valores 'P', 'E' o 'T'.
El procedimiento utilizará el diccionario de datos information_schema para identificar todos
los nombres de tablas de la base de datos world_temp_stats (excepto la tabla table_stats
que tendremos que evitarlo) e insertará una fila para cada una de ellas acompañada por su
recuento de filas, la fecha en la que ha sido efectuado y el origen de la ejecución del
procedimiento. Pista: Puede usar un cursor que le permita iterar sobre el nombre de las
tablas y usando una sentencia dinámica efectúe el recuento de filas y finalmente lo
inserte en la tabla table_stats.
Cuando hagamos su CALL indicaremos el valor ‘P’ por el parámetro de entrada para indicar que
la ejecución ha sido hecha de forma asíncrona con un llamamiento manual al procedimiento.
Si el procedimiento se ejecuta más de una vez, debe ir acumulando los resultados en la
tabla table_stats para tener un seguimiento de los cambios de volúmenes de filas que debe
tenido cada mesa. No borraremos la tabla si ya existe previamente.
Después de ejecutar el procedimiento, si hacemos un select en la mesa, debería tener un aspecto
como el siguiente ejemplo (datos inventados):

Entregue:
• Código SQL necesario dentro del documento .sql: procedure definition + CALL
de ejemplo.
• Screenshots de prueba dentro de la memoria donde se vea la ejecución y las
datos de la tabla.*/
DELIMITER $$

DROP PROCEDURE IF EXISTS pCheckTableRowCount $$
CREATE PROCEDURE pCheckTableRowCount (IN par CHAR(1))
BEGIN 


END $$
DELIMITER ;


--3. Procedure pCityMean (1.5 puntos)
/*Cree un procedimiento nuevo llamado pCityMean.
Dado un país como input de entrada, el procedimiento deberá generarse automáticamente
un archivo de export por cada ciudad del país solicitado. Este archivo deberá contener: el
recuento de muestras diferentes de datos de temperatura por año, junto con el
promedio de temperatura anual.
El nombre del archivo deberá ser “PAIS_CIUTAT_temp_analisis.csv”, donde PAIS y CIUDAD
vendrán según la ejecución del procedure.
Dentro del archivo, cada uno de los valores deberá estar comprendido opcionalmente entre “ “,
se deberá utilizar el punto y coma como separador de campos y el salto de línea como
separador de filas.
Ejemplo de archivo de export generado con datos inventados:

Nota: Recuerde que si los archivos ya existen, provocará errores. No pasa nada, borre
los archivos cada vez para realizar pruebas. No le pedimos controlar esta situación.
Entregue:
• Código SQL necesario dentro del documento .sql: procedure definition + CALL
de ejemplo.
• Entregue un zip con todos los csv de las ciudades de un país cualquiera.
• Screenshots de prueba de ejecución dentro de la memoria.*/

DELIMITER $$

DROP PROCEDURE IF EXISTS pCityMean $$
CREATE PROCEDURE pCityMean (IN vPais char(52))
BEGIN

    OPEN curCity;
    bucle: LOOP
        FETCH curCity INTO vCity;
        IF done = 1 THEN
         LEAVE bucle;
        END IF;
        
    SELECT 
    SET @aux= CONCAT(SELECT c. INTO OUTFILE '",vPais," "_" ",vCiudad" "_temp_analisis".csv'
        LINES TERMINATED BY '\n'
        FROM country AS co, city AS c
        WHERE c.Name = '", vCiudad"'
            AND co.Name = '", vPais,"');

END $$
DELIMITER ;

CALL pCityMean('France');

--4. Procedure pCheckStateName(1 punto)
/*Cree un procedure que sirva para hacer una auditoría sobre el nombre de los states de la
tabla temp_by_state. Queremos revisar que no existan valores incorrectos.
Usando cursores, haga que se revise uno a uno los nombres de los estados verificando que la primera
letra esté escrita en mayúscula y el resto del nombre en minúscula. En caso de no ser así,
se tendrá que realizar un update para arreglar el nombre. Una vez terminado, el procedure deberá
devolver por parámetro de salida el número de cambios registrados.
Pista: Verificación Mayúsculas/Minúsculas
CONCAT(UCASE(LEFT(c_nombre, 1)), LCASE(SUBSTRING(c_nombre, 2)));
Entregue:
• Código SQL necesario dentro del documento .sql: procedure definition + CALL
de ejemplo.
• Screenshots de prueba de la ejecución dentro de la memoria.*/

DROP PROCEDURE IF EXISTS pCheckStateName $$
CREATE PROCEDURE pCheckStateName (IN vPais char(52))
BEGIN
    
END $$
DELIMITER ;

CALL pCityMean();

--5. Procedure pRangeSearch (1 punto)
/*Cree un procedure que liste el nombre de los países sobre los que tenemos datos de
temperatura entre dos años concretos que pasaremos por dos parámetros de entrada.
Es necesario comprobar que los años que nos han dado por parámetro son válidos.
También extraeremos por variable de salida el recuento de países comprendidos entre los
dos años del parámetro de entrada.
Nota: Consideraremos que un año por parámetro de entrada es válido si es > 1800 y menor
o igual al año actual.
Entregue:
• Código SQL necesario dentro del documento .sql: procedure definition + CALL
de ejemplo y ejemplo de uso de la variable de salida.
• Screenshots de prueba de ejecución dentro de la memoria.*/


--6. Event eRowCount (1 punto)
/*Implemente un evento que cada diez minutos ejecute el procedimiento
pCheckTableRowCount sólo durante el mes de Abril de ese año.
El evento hará un CALL al procedimiento con el valor 'E' como parámetro de entrada para
de indicar que el recuento ha sido realizado a través de una ejecución planificada a través de un
evento. Recuerde activar el evento scheduler para activar la ejecución de los eventos planificados.
Haz capturas de pantalla de la tabla table_stats donde se vean las filas generadas por el evento
de forma automática durante al menos dos ejecuciones automáticas (20 minutos).
Nota: Debido a que este evento se ejecutará cada 10 minutos y usará una parte relevante de
recursos de su servidor local de bases de datos, unos puede ir bien detener el evento
scheduler una vez realizado el trabajo de las capturas.
Ejemplo de lo que se espera en la tabla table_stats en lo referente al tipo de ejecución ‘E’:

Entregue:
• Código SQL necesario dentro del documento .sql.
• Screenshots de prueba dentro de la memoria de los datos de la tabla.*/


--7. Triggers I (1 puntos)
/*Siempre después de que se inserte o de que se elimine una fila nueva dentro de la mesa City,
queremos que se ejecute el procedimiento pCheckTableRowCount pasándole como parámetro
la ‘T’ de trigger.
Ejemplo de muestra de la tabla table_stats con datos inventados después de que
se ejecuten los triggers:

Entregue:
• Código SQL necesario dentro del documento .sql: código triggers + INSERTs y
DELETAS de muestra.
• Screenshots de prueba dentro de la memoria donde se vea la tabla table_stats y
las ejecuciones de INSERT o DELETE que han disparado al trigger.
*/


--8. Triggers II (1.5 puntos)
/*Siempre que se actualice una de las filas en temp_by_city, será necesario validar que
AverageTemperatureUncertainty y AverageTemperature no estén vacíos. En caso de no
tener valor, se insertará el valor promedio de todas las ciudades cercanas. Definimos como
ciudades cercanas aquellas donde la latitud y longitud varía +/- 4º.
Pista: latitud y longitud son tipo VARCHAR (y tienen un aspecto similar a “57.05N”).
Primero habrá que tomar sólo la parte numérica (ver función SUBSTRING), y después
cambiar el tipo VARCHAR a DECIMAL (ver función CAST )
Código necesario: CAST(SUBSTRING(Latitude, 1,2) AS DECIMAL(4,2)) +/- 4
Entregue:
• Código SQL necesario dentro del documento .sql: código triggers + UPDATEs de
muestra.
• Screenshots de prueba dentro de la memoria donde se vea la tabla table_stats y
las ejecuciones de INSERT o DELETE que han disparado al trigger.*/


--9. Triggers III (1.5 puntos)
/*Debido a que la tabla temp_global contiene datos importantes sobre el calentamiento global en
queremos controlar las modificaciones de sus datos.
Por tanto, crearemos la tabla log_temp_global con los campos: id BIGINT
AUTO_INCREMENT, alert_level VARCHAR(20), column_name VARCHAR(50), old_value
FLOAT(5,3), new_value FLOAT(5,3), log_time DATETIME.
Una vez creada haremos el trigger (o triggers) correspondientes para registrar cada cambio en
una columna de datos (todos los que cumplen el filtro ‘Land%’) de la tabla
temp_global.
Hay que tener en cuenta:
• Si el cambio es del año anterior o más antiguo, el nivel de alerta a registrar debe ser:
ERROR
• Si el cambio es del mes anterior, el nivel de alerta a registrar debe ser: WARNING
• Si el cambio es del mes actual, el nivel de alerta debe ser: INFO
• En column_name indicaremos la columna que ha sufrido el cambio.
• En old_value indicaremos el valor antes de la modificación.
• En new_value indicaremos el valor después de la modificación.
Ejemplo de la tabla log_temp_global con datos inventados:

Entregue:
• Código SQL necesario dentro del documento .sql.
• Screenshots de prueba dentro de la memoria, desarrollo escrito, y
captura de la tabla log_temp_global con los datos generados.*/

-- CREAR TABLA 
CREATE TABLE IF NOT EXISTS log_temp_global (
    id BIGINT AUTO_INCREMENT, 
    alert_level VARCHAR(20), 
    column_name VARCHAR(50), 
    old_value FLOAT(5,3),
    new_value FLOAT(5,3),
    log_time DATETIME
);

-- CREAR TRIGGER
DELIMITER $$
DROP TRIGGER IF EXISTS nom_trigger $$
CREATE TRIGGER nom_trigger AFTER UPDATE ON temp_global
FOR EACH ROW
BEGIN
    IF YEAR(NEW.dt) > YEAR(NEW.dt)) THEN
        INSERT INTO tabletrig VALUES (OLD.id, 'ERROR', ); 
    ELSEIF MONTH(NEW.dt) > MONTH(NEW.dt)) THEN
        INSERT INTO tabletrig VALUES (OLD.id, 'WARNING')
    ELSE
        INSERT INTO tabletrig VALUES ('INFO')
    END $$

    IF 
DELIMITER ;


--ejemplo
BEGIN

	IF OLD.nombre <> NEW.nombre THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo nombre. El valor antiguao era ",OLD.nombre,". El valor nuevo es ",NEW.nombre,"."));
	END IF;
	
	IF OLD.apellido <> NEW.apellido THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo apellido. El valor antiguao era ",OLD.apellido,". El valor nuevo es ",NEW.apellido,"."));
	END IF;

	IF OLD.apellido2 <> NEW.apellido2 THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo apellido2. El valor antiguao era ",OLD.apellido2,". El valor nuevo es ",NEW.apellido2,"."));
	END IF;

	IF OLD.correo_electronico <> NEW.correo_electronico THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo correo_electronico. El valor antiguao era ",OLD.correo_electronico,". El valor nuevo es ",NEW.correo_electronico,"."));
	END IF;

	IF OLD.dni <> NEW.dni THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo dni. El valor antiguao era ",OLD.dni,". El valor nuevo es ",NEW.dni,"."));
	END IF;

END $$
