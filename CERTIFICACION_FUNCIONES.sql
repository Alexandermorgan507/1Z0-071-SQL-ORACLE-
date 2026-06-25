--ONLY FUNCTIONS 


---------------------------------------------------🔷FLOOR Y CEIL 🔷----------------------------------------------------------------------
--TENER EN CUENTA LA RECTA NUMERICA 0 como referencia 

--CEIL Y FLOOR SE DAN EL MISMO RESULTADO CON NUMEROS ENTEROS NEGATIVOS Y POSITIVOS 
--CEIL ES MAYOR A  FLOOR (CON NUMEROS POSITIVOS CON PUNTO DECIMAL)
--FLOOR ES MAYOR A CEIL(CON NUMEROS NEGATIVOS CON PUNTO DECIAML) 
select  ceil(100),floor(100),ceil(-10),floor(-10),ceil(15.3),floor(15.3),ceil(-10.20),floor(-10.20)
--CON POSITIVOS (PUNTO DECIMAL)
FROM DUAL;





-------------------------------------------------- 🔷 CONCAT 🔷 --------------------------------------------------------
--PARAMETROS 2
--RETONA CADENA 
--OPCIONALES : NINGUNO 

--CONCAT CON UN LITERAL Y UN NUMERO (CONVIERTE IMPLICITAMENTE A STRING)
SELECT CONCAT ('ALEX',1234) FROM DUAL;

--CONCATENA UN LITERAL CON UN NULL 
SELECT CONCAT('ALEX',NULL) FROM DUAL;

--CADENA CON UN NULL = CADENA 
SELECT CONCAT (NULL,FIRST_NAME)FROM HR.EMPLOYEES;

--CONCATENA PRIMER NOMBRE CON SEGUNDO NOMBRE SIN ESPACIOS
SELECT CONCAT(FIRST_NAME,LAST_NAME)FROM HR.EMPLOYEES;

--CONCADENA NULL CON NULL RESULTADO DARA NULL 
SELECT CONCAT (NULL,NULL)FROM HR.EMPLOYEES;

--CADENA CON LITERAL = CADENA
SELECT CONCAT(FIRST_NAME,'APELLIDO')FROM HR.EMPLOYEES;



-------------------------------------------------------------🔷 LENGHT 🔷--------------------------------------
--PARAMETROS 1
--RETORNA: NUMERO 
--OPCIONALES : NINGUNO 

--CUENTA CADENAS DE UN LITERAL INCLUIDO ESPACIOS 
SELECT LENGTH('ALEX XD') FROM DUAL ;

--CUENTA LAS LETRAS DE UNA COLUMNA DE CARACTERES
SELECT LENGTH(FIRST_NAME) FROM HR.EMPLOYEES;

--CUENTA TIPO DE DATOS NUMERICOS 
SELECT LENGTH(507) FROM DUAL ;

-----------------------------------------------------------------------🔷 SUBSTR 🔷-----------------------------------------------
--PARAMETROS:3 :CADENA,POSICION,LONGITUD
--RETORNA:CADENA
--OPCIONALES:LONGITUD AL OMITIR (EXTAE TODA LA CADENA) DEBE SER POSITIVO 

--SUBSTRE LA CADENA MORGAN DEL LITERAL 
SELECT SUBSTR('ALEXANDER MORGAN',11,6) FROM DUAL ;

--SE OMITE PARAMETRO LONGITUD
SELECT SUBSTR('ALEXANDER MORGAN',1) FROM DUAL ;

--POSICION NEGATIVA 
SELECT SUBSTR('ALEXANDER MORGAN',-7,7) FROM DUAL ;

--CON COLUMNAS (SI LA POSICION SUPERA EL LIMITE DE CARACTERES DEVUELVE CADENA VACIA )
SELECT SUBSTR(FIRST_NAME,3) FROM EMPLOYEES;

--USO CON NUMEROS CONVERCION IMPLICITA 
SELECT SUBSTR(1234,3) FROM EMPLOYEES;

------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------🔷 INSTR  🔷 -------------------------------------------------------------------------
--PARAMETROS: 4 :CADENA,SUBCADENA,POSICION,OCURRENCIA 
--RETORNA :NUMERO 
--OPCIONALES:2 POSICION(BUSCA TODO),OCURRENCIA(0 EL PRIMER PARECIDO)

--usando todos los parametros 
SELECT INSTR('ALEXANDER','ALEX',1,1)FROM DUAL;


--SI LA POSICION DE BUSQUEDA SE PASA A LA SUBCADENA DEVUELVE 0 
SELECT INSTR('ALEXANDER','ALEX',2,1)FROM DUAL;

--EMPIEZA EN POSICION 1 Y BUSCA LA PRIMERA OCURRENCIA 
SELECT INSTR('ALEXANDER ALEXANDER','ALEX',1,1)FROM DUAL;

--EMPIEZA EN POSICION 2 Y BUSCA LA 2 OCURRENCIA   devuelve 0 porque busca la primera y no esta entonces no puede ir por segunda
SELECT INSTR('ALEXANDER ALEXANDER','ALEX',2,2)FROM DUAL;

--EMPIEZA EN POSICION 1 Y BUSCA LA 2 OCURRENCIA aqui si la encuentra 
SELECT INSTR('ALEXANDER ALEXANDER','ALEX',1,2)FROM DUAL;

--busca la 3ra ocurrencia pero no la encontrara por que solo hay 2 ocurrencias 
SELECT INSTR('ALEXANDER ALEXANDER','ALEX',1,3)FROM DUAL;

-- con los omitibles  buscara la cadena la primera posicion y la primera  ocurrencia 
SELECT INSTR('ALEXANDER ALEXANDER','ALEX')FROM DUAL;

--USANDO UNA COLUMNA DE TABLA NORMAL 
SELECT INSTR(FIRST_NAME,'Eli')FROM HR.EMPLOYEES where FIRST_NAME like '%Eli%';


--INSTR USANDO NUMEROS (PONER EN COMILLAS SIMPLES )
SELECT INSTR('311231', '1') FROM dual; 

--si la subcadena esta vacia devuelve null
SELECT INSTR('ABC', '', 1, 1) FROM dual;


-- devuelve start position 
select INSTR('xd', '', start_position, occurrence)
from dual ;

--------------------------------------------------------------------------------------------------------------------


------------------------------------------------------ 🔷   RPAD / LPAD   🔷 -------------------------------------------------------------
--PARAMETROS:CADENA,TOTAL DE CARACTERES,CADENA AGREGAR
--DEVUELVE:CADENA
--OPCIONALES:NO

--CON UN LITERAL 9 + 3 (ING)
SELECT RPAD('ALEXANDER',12,'ING')FROM DUAL;

--CON UN NUMERO 
SELECT RPAD(1234,5,'5')FROM DUAL;

--CON UNA COLUMNA 
SELECT RPAD(FIRST_NAME,9,'ING')FROM HR.EMPLOYEES;

-----------------------------🔷LPAD🔷---------------------

--CON UN LITERAL 9 + 3 (ING)
SELECT LPAD('ALEXANDER',12,'ING')FROM DUAL;

--CON UN NUMERO 
SELECT LPAD(1234,5,'5')FROM DUAL;

--CON UNA COLUMNA 
SELECT LPAD(FIRST_NAME,9,'ING')FROM HR.EMPLOYEES;

-----------------------------------------------------------------------------------

--------------------------------------------------------------🔷 TRIM 🔷--------------------------------------
--PARAMETROS:2  TRIM([ [LEADING|TRAILING|BOTH] [carácter_a_eliminar] FROM ] cadena)
--DEVUELVE:CADENA
--OMITIBLES:[LEADING|TRAILING|BOTH],carácter_a_eliminar

--LEADING → Elimina el carácter solo al inicio (izquierda).
--TRAILING → Elimina el carácter solo al final (derecha).
--BOTH → Elimina el carácter en ambos lados (valor por defecto si no se especifica).

--CON UN LITERAL
SELECT TRIM(LEADING 'a' FROM 'abcba')FROM DUAL;    

SELECT TRIM (TRAILING '7' FROM 'JETMOTION507')FROM DUAL;

SELECT TRIM('x' from 'xxxAlexanderxxx')from dual;


--CON TODOS LOS PARAMETROS OMITIBLES POSIBLES (ELIMINA ESPACIOS)
SELECT TRIM(' xxxAlexande rxxx ') FROM dual;


--CON COLUMNAS 
SELECT TRIM(LEADING 'a' FROM FIRST_NAME )FROM HR.EMPLOYEES;    


--CON NUMEROS 
SELECT TRIM('5' from 12345 )from dual;

---------------------------------------------------------------------------------------------------


-------------------------------------------------------🔷 REPLACE 🔷---------------------------------------------------------------
--no usa indice negativo 
--parametros : 3  (cadena,texto a remplazar ,texto a insertar)
--devuelve : caracter 
--omitibles: 3 parametro texto a remplazar 

--remplaza el texto estudiante por ingeniero 
select replace ('alexander es estudiante','estudiante','ingeniero') from dual ;

--con una columna remplaza ar por xd 
select replace(FIRST_NAME,'ar','xd')from EMPLOYEES;

-- usando numeros 
select replace(1234,'2','507') from dual ; 

--con todos los parametros omitibles posibles : simplemente quita la cadena si la quita toda queda vacia 
select replace ('alex','ex')from dual ;

------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------🔷 ROUND 🔷--------------------------------------------------
--PUEDE USARSE PARA NUMEROS ,FECHAS 
--PARA NUMEROS USA 2 PARAMETROS 
--HACIA LA DERECHA REDONDEA LOS DECIMALES Y HACIA LA IZQUIERDA REDONDEA A LOS MILLARES (NEGATIVO)

--REDONDEO NORMAL CON NUMERO
SELECT ROUND(507.356722,2) FROM DUAL ;

--SE REDONDE A 6 PORQUE EL VALOR DE LA DERECHA ES MAYOR A 4 POR LO TANTO REDONDEA EL 5 A 6 
SELECT ROUND(507.356755,5) FROM DUAL ;

--no redonde ya que el ultimo numero es 5 
SELECT ROUND(507.35675,5) FROM DUAL ;

--round sin el segundo parametros  redondea a la parte positiva si el ultimo numero es 5 redonde la parte positiva   
SELECT ROUND(507.55675) FROM DUAL ;


--REDONDEA A LA PARTE DECIMAL  DEL NUMERO ENTERO DECENA XX
SELECT ROUND(507.55675,-1) FROM DUAL ;

--REDONDEA A LA PARTE DE LSD CENTENAS XXX
SELECT ROUND(507.55675,-2) FROM DUAL ;

--REDONDEA A LA PARTE DE LOS MILLARES XXXX
SELECT ROUND(5077.55675,-3) FROM DUAL ;

-------------------------------🔷  ROUND WITH DATES(REDONDEAR AL DIA ) 🔷-----------------------------

--antes de las 12 mediodia redondea al mismo dia despues de las 12 de la tarde redonde al siguiente dia 

SELECT 
 ROUND(SYSDATE) ,
 ROUND(TO_DATE('2024-01-15 10:30:00', 'YYYY-MM-DD HH24:MI:SS')) AS antes_12,
 ROUND(TO_DATE('2024-03-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) AS exacto_12,
 ROUND(TO_DATE('2024-01-15 13:30:00', 'YYYY-MM-DD HH24:MI:SS')) AS despues_12 
FROM DUAL ;


-------------------------------------------🔷 REDONDEA AL MES MAS CERCANO 🔷--------------------------------- 
SELECT ROUND(SYSDATE, 'MM')
FROM dual;


--Días 1-15  REDONDEA AL MISMO MES 16-31  REDONDEA AL MES SIGUIENTE


SELECT 
    SYSDATE AS fecha_actual,
    ROUND(SYSDATE, 'MM') AS redondeado_mes,
    ROUND(TO_DATE('2024-01-14', 'YYYY-MM-DD'), 'MM') AS MISMO_MES,      
    ROUND(TO_DATE('2024-01-15', 'YYYY-MM-DD'), 'MM') AS PUNTO_EXACTO,    
    ROUND(TO_DATE('2024-01-16', 'YYYY-MM-DD'), 'MM') AS NEXT_MES        
FROM DUAL;


SELECT ROUND(DATE '2025-11-15', 'MONTH') FROM dual;

--DIA 15 DESPUES DE LAS 12:00  REDONDEARA HACIA EL PRIMER DIA DEL SIGUIENTE MES 
SELECT ROUND(TO_DATE('2025-11-15 13:00','YYYY-MM-DD HH24:MI'), 'MONTH')
FROM dual;


-- SE PUEDE USAR CON LA PALABRA EXPLICITA MONTH O MM 
SELECT ROUND(SYSDATE, 'MM') AS redondeado_mes FROM DUAL ;
SELECT ROUND(SYSDATE, 'MONTH') AS redondeado_mes FROM DUAL ;



-----------------------------------------------------🔷 ROUND CON AÑO 🔷----------------------------------------------
--Redondea hacia abajo → 01-JAN del mismo año
--Redondea hacia arriba → 01-JAN del año siguiente
--El día 30 de junio a partir de las 12:00 puede elevar al año siguiente

--como va redondear 
--1-ENE → 30-JUN del mismo año --1-JUL → 31-DIC  del siguiente año

--redondea al mismo año 
SELECT ROUND(DATE '2025-03-10', 'YEAR') FROM dual;


--todavia al mismo año 
SELECT ROUND(DATE '2025-06-30', 'YEAR') FROM dual;

--ya redondea hacia arriva 
SELECT ROUND(DATE '2025-07-01', 'YEAR') FROM dual;

------------------------------------------------------------------------------------------------------------------------------------------


-------------------------------------------------------------🔷 TRUNC 🔷-----------------------------------------------------------------------
--LA FUNCION TRUNC TIENE DOS PARAMETROS (NUMERO_A_TRUNCAR,NUMERO_DE_DECIMALES_OPCIONAL)
--LA MEJOR PARA MANEJAR DATOS FINANCIEROS 
--FAMILIARISARSE CON UNIDADES DECENAS CENTENAS MILLARES CUANDO ES NEGATIVO 
--SIRVE PARA FECHAS :
--'DD' → día (00:00:00 del mismo día).
--'MM' → primer día del mes.
--'YYYY' → primer día del año.


--DEVUELVE EL NUMERO ENTERO (EL PARAMETRO NUMERO DE DECIMALES SE OMITIO) 
SELECT TRUNC(123.4567)
FROM dual;


-- 123.45 ( ESPECIFICA :dos decimales)
SELECT TRUNC(123.4567, 2)
FROM dual;


--TRUNCATE CON NUMERO NEGATIVO  (trunca en decenas 10 )
SELECT TRUNC(155.4567, -1)
FROM dual;  


--TRUNCA A LAS CENTENAS 
SELECT TRUNC(987.543, -2)
FROM dual;    


--(uso en una columna )trunca 8 numeros del salario 
SELECT TRUNC (SALARY,8)
FROM EMPLOYEES ;


--TRUNC(fecha) o TRUNC(fecha, 'DD').


--TRUNC CON FECHA
--8/29/2025, 00:00:00 AM FECHA FORMATEADA A HORAS 0 
SELECT TRUNC(SYSDATE) FROM dual;

--trunca la hora minuto segundos 
select TRUNC(TO_DATE('2025-03-18 15:45:10', 'YYYY-MM-DD HH24:MI:SS'));


--recorta la fecha al primer dia del mes 
select TRUNC(DATE '2025-11-21', 'MM');

--trunc con años 
select TRUNC(DATE '2025-11-21', 'YYYY');

-----------------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------🔷 ADD MONTHS 🔷--------------------------------------------------------

--A LA FECHA ACTUAL LE AGREGA 12 MESES SYNTAXIS
SELECT ADD_MONTHS (SYSDATE, 12)
AS "Next Year"
FROM dual;



-----------------------------------------------------------------------🔷 NEXT_DAY 🔷 ------------------------------------------------------------
--SYNTAXIS:(FECHA,'dia DE LA SEMANA')
--DEVUELVE UNA FECHA 


--ESTA CONSULTA DEVUELVE EL PROXIMO SABADO DE LA FECHA QUE SE LE HA PROPORCIONADO 
SELECT NEXT_DAY (SYSDATE,'Saturday')
AS "Next Saturday"
FROM dual;




-----------------------------------------------------------------------🔷 MONTHS_BETWEEN 🔷 ------------------------------------------------------------

--SYNTAXIS (FECHA1,FECHA2) R:(VALOR NUMERICO EN MESES) 
--SI EL PRIMER ARGUMENTO ES UNA FECHA ANTERIOR AL SEGUNDO DEVOLVERA UN NUMERO NEGATIVO 
--Entero: Si ambas fechas tienen el mismo día del mes 





--DEVUELVE EL APELLIDO Y FECHA DE CONTRATACION BASANDOSE EN LOS MESES QUE SEAN MAYOR A 100 ENTRA ESAS DOS FECHAS 
SELECT last_name, hire_date
FROM employees
WHERE MONTHS_BETWEEN(SYSDATE,hire_date)>100;


----------------------------------------------------------------------------🔷 MIN 🔷------------------------------------------------
--seleciona el valor minimo de una columna  valor numerico 
--funciona para : numeros ,fechas ,CADENAS 

--−MIN: SELECIONA EL VALOR MINIMO DE UNA COLUmna salario 
SELECT MIN(SALARY)
AS "Lowest Life Exp"
FROM EMPLOYEES;


--seleciona la fecha minima de hiredate;
SELECT MIN(hire_date)
from employees;


--SELECIONA EL NOMBRE QUE ESTE ALFABETICAMENTE EL PRIMERO  
SELECT MIN(first_name)
FROM EMPLOYEES;

--------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------🔷 MAX 🔷----------------------------------
--−max: SELECIONA EL VALOR MAXIMO DE UNA COLUmna salario 
SELECT MAX(SALARY)
AS "Lowest Life Exp"
FROM EMPLOYEES;


--seleciona la fecha MAXIMA de hiredate;
SELECT MAX(hire_date) from employees;



--SELECIONA EL ORDEN ALFABETICAMENTEEL ULTIMO 
SELECT MAX(first_name)
FROM EMPLOYEES;




---------------------------------------------------------------------------🔷 SUM 🔷-------------------------------------
-- SOLO SUMA VALORES NUMERICOS 

--SUMA TODA LA COLUMNA DE SALARIO 
SELECT SUM(salary)
FROM employees;




------------------------------------------------------------------------🔷 count 🔷------------------------------------------------
--sirve para contar registros de toda la tabla o una columna en especifico 


--CUENTA TODAS LAS FILAS INCLUYENDO NULOS 
SELECT COUNT(*)
FROM employees
WHERE hire_date < '01-Jan-1996';


--cuenta todas las filas que tiene la tabla 
SELECT COUNT(*)
FROM employees;


---------------------------------------------------------------------- 🔷 NVL 🔷-------------------------------------------------------------------------------
--NVL FUNTION SYNTAX: NVL (POSIBLE_NULL_VALUE,VALOR_REMPLAZAR_SI_ES_NULL)
--NVL PUEDE USARSE CON DISTINTOS TIPOS DE DATA SIEMPRE Y CUANDO LOS DOS VALORES SEAN DEL MISMO TIPO EJEMPLO CHAR,CHAR  NUM ,NUM 



--USANDO NVL LOS VALORES NULL SERAN REMPLAZADOS POR EL TEXTO NONE 
SELECT country_name, NVL(internet_extension, 'None') AS "Internet extn"
FROM wf_countries
WHERE location = 'Southern Africa'
ORDER BY internet_extension DESC;



-- EN ESTE CASO EL VALOR NULL ES UN NUMERO POR ESO EL OTRO PARAMETRO ES 0 AHORA 
SELECT last_name, NVL(commission_pct, 0)
FROM employees
WHERE department_id IN(80,90);



---------------------------------------------------------------------- 🔷   NVL2   🔷-------------------------------------------------------------------------------

--EVALUA UNA EXPRESION EN 3 VALORES 
--• Si el primer valor no es nulo, la función NVL2 devuelve la segunda expresión.
--• Si el primer valor es nulo, se devuelve la tercera expresión.


--usa NVL2
SELECT last_name, salary,NVL2(commission_pct, salary + (salary * commission_pct),salary) AS income
FROM employees
WHERE department_id IN(80,90);



---------------------------------------------------------------------- 🔷   NULLIF   🔷-------------------------------------------------------------------------------
--USADO PARA COMPARAR
--COMPARA DOS VALORES  SI SON IGUALES RETORNA NULL SI NO RETORNA EL VALOR 1 
--COMPARA SI LOS LENGTH DEL NOMBRE Y APELLIDO SON IDENTICOS DA NULL SI NO DEVUELVE LENGHT DEL PRIMERONOMBRE
--RETORNA UN NUMERO O UN VALOR O NULL 


--EXPRESIONES IGUALES ASI QUE DEVUELVE NULL 
SELECT NULLIF('XD','XD') 
FROM DUAL;


--EXPRESIONES DIFERENTES DEVUELVE LA PRIMERA
SELECT NULLIF('XD','Xd') 
FROM DUAL;


SELECT NULLIF(5,4) 
FROM DUAL;




--ESTA CONSLTA COMPARA DOS VALORES DE CADENA  NULLIF COMPARA SI LOS NUMEROS SON IGUALES DEVUELVE NULL SI NO DEVUELVE LA EXPRESION 1
SELECT first_name, LENGTH(first_name) AS "Length FN", last_name,
LENGTH(last_name) AS "Length LN", NULLIF(LENGTH(first_name),LENGTH(last_name)) AS "Compare Them"
FROM employees;



---------------------------------------------------------------------- 🔷  COALESCE  🔷-------------------------------------------------------------------------------
--DEVUELVE EL PRIMER VALOR QUE NO SEA NULL SI TODOS SON NULL DEVUELVE NULL  Y SI TODOS NO SON NULL DEVOLVERA EL PRIMERO DE LA LISTA 


--DEVUELVE EL PRIMER VALOR NO NULL 
SELECT last_name,COALESCE(commission_pct, salary, 10) AS "Comm"
FROM employees
ORDER BY commission_pct;

--devuelve el primer valor ya que no es null
select coalesce('xd','fd','jx') 
from dual ;


--devuelve el segundo valor porque el primero es null 
select coalesce(null,'fd','jx') 
from dual ;


------------------------------------------------------------------------🔷   🔷-------------------------------------------------------------------------------
