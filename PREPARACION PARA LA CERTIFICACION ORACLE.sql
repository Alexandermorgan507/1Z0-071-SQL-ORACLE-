-- ==========================================
-- 📝 ESTUDIO PARA CERTIFICACIÓN ORACLE 1Z0-071   ALEXANDER MORGAN 
-- ==========================================

--IDENTIFICADORES :📌(TEMAS PRINCIPALES ),✳️(SUBTEMAS PRINCIPALES),🔷(SUBTEMAS DE SUBTEMAS PRINCIPALES)📝(TEORIA EXPLICATIVA O A RECORDAR )
--🔑(PRIMARY KEY)
--🛅(FOREIGN KEY)
--🔐(UNIQUE)
--
--



---------------------------------------------------------------------------👨‍💻👨‍💻👨‍💻 INDICE 👨‍💻👨‍💻👨‍💻-------------------------------------------------------------------------------
-- 0.📌ADMINISTRACION/CREACION DE USUARIOS PRIVILEGIOS ETC 
-- 1.📌TIPOS DE DATOS 
-- 2.📌OPERADORES DE COMPARACION
-- 3.📌DDL (CREACION DE TABLAS Y CONSTRAINTS )
-- 4.DDL(MODIFY,ALTER,DROP,ADD,DEFINE) 
-- 4.VIEWS
-- 5.SUBQUERRYS
-- 5.SELECT BASICOS: WHERE,LIKE,ALIAS,concatenacion,operaciones aritmeticas.
-- 6.JOINS: NATURAL,INNER,OUTER,ON,SELFT
-- 7.ORDER BY / GROUP BY / ROLLUP / CUBE / HAVING / GROUPING SET
-- 8.VIEWS
-- ADM PRIVILEGIOS(USER,ETC)
-- TCL:TRANSACTION  LANGUAGUE



----------------- 📌ADMINISTRACION CREACION DE USUARIOS📌 ----------------------------------------------------------------
--verifica los usuarios de la bd 
SELECT username 
FROM dba_users; 


--Crea un usuario y una contraseña
CREATE USER practica_bd 
IDENTIFIED BY Alex507; 


--CAMBIA LA CONTRASEÑA DEL USUARIO 
ALTER USER practica_bd 
IDENTIFIED BY alexx5077;  


--SYNTAXIS PARA DAR PRIVILEGIOS A USUARIOS :
--GRANT privilege [privilege]
--TO user [user| role, PUBLIC];

--ESTA DANDO PRIVILEGIOS AL USUARIO SCOTT
GRANT create session, create table, create sequence, create
view
TO scott;

--------------------------------------------------------------------------------------------------------------------------------










--🎧-------------------------------------------------------------------📌📌📌1. TIPOS DE DATOS📌📌📌-------------------------------------------------------------🎧


CREATE TABLE tipos_datos (
dt1 INTEGER,                              -- Almacena números enteros como 123
valor FLOAT,                              -- Almacena números como 123.456
dt2 NUMBER,                               -- Almacena números como 123.45
nombre1 VARCHAR2(50),                     -- Almacena "alfanumericos" sin relleno
caracter CHAR(1),                         -- Almacena 'A' caracteres
nombre2 NCHAR(10),                        -- Almacena "日本語" UNICODES PARA TEXTOS EN VARIOS IDIOMAS 
nombre3 NVARCHAR2(50),                    -- Almacena "こんにちは"
fecha DATE,                               -- Almacena '2025-10-05 14:30:00' una fecha normal 
marca_tiempo TIMESTAMP(6),                -- Almacena '2025-10-05 14:30:00.123456' una fecha con fracciones de segundos 
marca_tiempo TIMESTAMP(6) WITH TIME ZONE, -- Almacena '2025-10-05 14:30:00.123456 -05:00' con una zona horaria
duracion INTERVAL YEAR(2) TO MONTH,       -- Almacena '02-06' (2 años y 6 meses)
tiempo INTERVAL DAY TO SECOND ,           --Permite almacenar la hora como un intervalo de días, horas, minutos y SEGUNDOS USADO PARA DIFERENCIAS ENTRE 2 TIEMPOS 
create_date DATE DEFAULT SYSDATE,         --USA LA HORA DEL SISTEMA como fecha
datos RAW(16),                            -- Almacena datos binarios 1 y 0 para ser interpretados por otro programa.
datoss LONG RAW,                          -- Almacena datos binarios hasta 2gb
archivo BLOB,                             -- Almacena imágenes, videos, etc.
descripcion CLOB ,                        -- Almacena texto largo
descripcion NCLOB,                        -- Almacena texto largo en Unicode
id ROWID,                                 -- Almacena direcciones de filas
datos XMLType,                            -- Almacena documentos XML
datos JSON ,                              -- Almacena datos JSON
persona Persona,                          -- Almacena objetos de tipo Persona
telefonos Telefonos ,                     -- Almacena un array de teléfonos
geometria SDO_GEOMETRY,                   -- Almacena datos espaciales cordenadas 
datos ANYDATA ,                           -- Almacena cualquier tipo de dato
INFROMACION LONG,                         -- Numeros Almacena hasta 2GB 
caracter CLOB,                            --Almacena caracteres hasta 4GB
CARACTERES  NCLOB ,                       --Almacena caracteres unicodes
filee  BFILE                              --Datos binarios Almacenados en archivo externo.
);


-- CREAR TIPO DE DATO OBJECTO            
CREATE TYPE Persona AS OBJECT (
nombre VARCHAR2(50),                     --almacena nombre de una persona
edad NUMBER                              --almacena edad de una persona
);

--CREA 5 ARRAYS DE 15 ESPACIOS 
CREATE TYPE Telefonos AS VARRAY(5) OF VARCHAR2(15);
---------------------------------------------------------------------------------------------------------------



-------------------------------------------------------------------📌📌📌OPERADORES DE COMPARACION📌📌📌--------------------------------------------------------------------------------

-- =              -Equal to
-- >             -Greater than
-- >=             -Greater than or equal to
-- <              -Less than
-- <=             -Less than or equal to
-- <>             -Not equal to 
-- ^=             -Not equal to 
-- !=             -Not equal to 
-- BETWEEN…AND…   -Between two values (inclusive)
-- IN (set)       -Match any of a list of values
-- LIKE           -Match a character pattern
-- IS NULL        -Is a null value
--AND             -CONDICIONES ANIDADAS 
--OR              -SE CUMPLE UNA CONDICION O OTRA   SOLO NECESITA UNA 
--NOT             -NIEGA UNA OPERACION O LISTA 

--AND OR NOT TIENEN ORDER JERARQUICO PERO AL COLOCAR ()ROMPES ESO  SU ORDEN DE EJECUCION ES PRIMERO AND OR NOT
--el or se evalua por cada fila no es una opcion o otra  si se cumple la primera la segunda y la tercera devuelve valores correspondientes a eso 
---------------------------------------------------------aritmetica suma multiplicacion--------------------------------------------------------
--Resultado: 20 (2*5 = 10, luego +10)
SELECT 10 + 2 * 5
FROM dual;

--Resultado: 60 (12 * 5)
SELECT (10 + 2) * 5 FROM dual;

----------------------------------------------------------logica: (AND-OR-NOT )--------------------------------------------------------


--OR Y AND :el and y or se ejecuta primero luego se compara con lo del lado izquierdo 
SELECT *
FROM employees
WHERE department_id = 10 OR department_id = 20 AND salary > 3000;


--OR PARENTESIS:el parentesis tiene prioridad
SELECT *
FROM employees
WHERE (department_id = 10 OR department_id = 20)
AND salary > 3000;

--NOT: SELECIONA TODOS LAS COLUMNAS EXCEPTO LOS DEL DEPARTAMENTO 10 CON SALARIO MENOR A 3MIL 
SELECT *
FROM employees
WHERE NOT (department_id = 10 AND salary < 3000);


--CAMBINACION TODO: ESTO AND ESTO 
SELECT *
FROM employees
WHERE NOT job_id = 'SA_REP' AND (salary > 5000 OR commission_pct IS NOT NULL);



--TODA LA OPERACION NEGADA 
SELECT *
FROM employees
WHERE(NOT job_id = 'SA_REP') AND (salary > 5000 OR commission_pct IS NOT NULL);

--------------------------------------------------------------------------------------------------------------------------------------------------------------




--------------------------------------------------📌📌📌2. DDL CREATE TABLES,DEFAULT,(CONSTRAINTS > PK, FK,UQ,NN,ETC) 📌📌📌--------------------------------------------------




------------------------------------------------------------------✳️ CREACION DE TABLAS ✳️--------------------------------------------------




RENAME old_name to new_name;

RENAME my_cd_collection TO my_music;


--comentar una tabla 
COMMENT ON TABLE employees
IS 'Western Region only';

--ver comentarios de una tabla 
SELECT table_name, comments
FROM user_tab_comments;

--borrar los comentarios 
COMMENT ON TABLE employees IS ' ' ;

--flashback querry sirve para ver lo que se guarda en flashback tras una operacion insert update o delete 
SELECT employee_id,first_name ||' '|| last_name AS "NAME",
versions_operation AS "OPERATION",
versions_starttime AS "START_DATE",
versions_endtime AS "END_DATE", salary
FROM employees
VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE employee_id = 1;


--creacion de tabla con identity 
CREATE TABLE EMPLOYEES (
  Employee_ID NUMBER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
  First_Name VARCHAR2(50),
  Last_Name VARCHAR2(50),
  Hire_Date DATE NOT NULL
);


--CREACION DE UNA TABLA EXTERNA 
--parametros opcionales: acces,oracle loaderm,REJECT LIMIT,TYPE

CREATE TABLE emp_load
(employee_number CHAR(5),
employee_dob CHAR(20),
employee_last_name CHAR(20),
employee_first_name CHAR(15),
employee_middle_name CHAR(15),
employee_hire_date DATE)
ORGANIZATION EXTERNAL
(TYPE ORACLE_LOADER
DEFAULT DIRECTORY def_dir1
ACCESS PARAMETERS
(RECORDS DELIMITED BY NEWLINE
FIELDS (employee_number CHAR(2),
employee_dob CHAR(20),
employee_last_name CHAR(18),
employee_first_name CHAR(11),
employee_middle_name CHAR(11),
employee_hire_date CHAR(10) date_format DATE mask
"mm/dd/yyyy"))
LOCATION ('info.dat'));


--ACCEDER A OTRAS TABLAS DE OTROS USUARIOS 
SELECT *
FROM mary.students;


--USER TYPE
SELECT table_name, status
FROM ALL_TABLES;

--DATA DICTIONARY 
SELECT *
FROM user_indexes;

SELECT *
FROM user_objects
WHERE object_type = 'SEQUENCE';

--crea una tabla temporal 
CREATE GLOBAL TEMPORARY TABLE temp_employees (
   employee_id NUMBER,
   name VARCHAR2(50)
)
ON COMMIT DELETE ROWS;




--CREACION DE TABLA NORMAL (SIN RESTRICIONES )
CREATE TABLE my_friends
(first_name VARCHAR2(20),
last_name VARCHAR2(30),
email VARCHAR2(30),
phone_num VARCHAR2(12),
birth_date DATE);

--CREA UNA TABLA E INTENTA LLENARLA CON DATOS DE OTRA TABLA PERO AL NO CUMPLIRSE LA CONDICION NO SE LLENARA 
CREATE TABLE sales1 (prod_id, cust_id, quantity_sold, price)
AS
SELECT product_id, customer_id, quantity_sold, price
FROM sales
WHERE 1 = 2;  --esta condicion no se cumple 


--🔑🔐 CREA UNA TABLA CON UNA PK Y UQ 
CREATE TABLE Usuarios (
    id INT PRIMARY KEY,         
    correo VARCHAR(255) UNIQUE, 
    nombre VARCHAR(100)
);

--🔑🛅CREA UNA TABLA CON PK Y FK 
CREATE TABLE Pedidos (
    id_pedido INT  PRIMARY KEY, 
    id_usuario INT, 
    producto VARCHAR(255),
    cantidad INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id)
);

--CREACION DE LA TABLA CON INTERVALOS DAY TO SECOND EL 3 AL LADO ES LA CANTIDAD DE DIAS 999
CREATE TABLE time_ex5
(day_duration1 INTERVAL DAY(3) TO SECOND,
day_duration2 INTERVAL DAY(3) TO SECOND);


--INSERTANDO EN LA TABLA DAY TO SECOND INTERVAL 25:25 DIAS  Y EL 2 INDICAMOS QUE TAMOS USANDO 2 DIGITOS DE LOS 3 QUE FUERON DECLARADOS 
--en el caso de day duration 2  el intervalo es mas completo indicando : 4 dias  10 horas  30 minutos y 10 segundos 
INSERT INTO time_ex5 (day_duration1, day_duration2)
VALUES (INTERVAL '25' DAY(2), INTERVAL '4 10:30:10' DAY TO
SECOND);




--CREA TABLA CON DATOS DAY TO SECOND 
--ALMACENAN EL INTERVALO DE TIEMPO ENNTRE DOS FECHAS Y HORAS 
CREATE TABLE time_ex5
(day_duration1 INTERVAL DAY(3) TO SECOND,
day_duration2 INTERVAL DAY(3) TO SECOND);

--CREAR TABLAS CON DATOS YEAR TO MONTH 
CREATE TABLE time_ex4
(loan_duration1 INTERVAL YEAR(3) TO MONTH,
loan_duration2 INTERVAL YEAR(2) TO MONTH);


SELECT SYSDATE + loan_duration1 AS "120 months from now",
SYSDATE + loan_duration2 AS "3 years 6 months from
now"
FROM time_ex4;

--TIMESTAMP WITH TIME ZONE   AND    TIMESTAMP WITH LOCAL TIME ZONE 
--LA DIFERENCIA ES QUE EL WITH TIME ZONE  GUARDA LA SONA SIN CAMBIO    MIENTRAS QUE   WITH LOCAL TIME ZONE   AL CONSULTAR LA HORA DESDE OTRA ZONA HORARIA ESTA SE AJUSTARA A LA LOCAL.
CREATE TABLE time_ex3
( first_column TIMESTAMP WITH TIME ZONE,
second_column TIMESTAMP WITH LOCAL TIME ZONE);





CREATE TABLE time_ex1
(exact_time TIMESTAMP);


CREATE TABLE time_ex2
(time_with_offset TIMESTAMP WITH TIME ZONE);

INSERT INTO time_ex2
VALUES (SYSTIMESTAMP);

INSERT INTO time_ex2
VALUES ('10-Jun-2017 10:52:29.123456 AM +2:00');

-----------------------------------------------------------------🔷DEFAULT🔷--------------------------------------------------

--CREA UNA TABLA CON LA CARACTERISTICA DE UN VALOR POR DEFAULT LA FECHA ACTUAL DEL SISTEMA 
CREATE TABLE my_employees (
hire_date DATE DEFAULT SYSDATE,
first_name VARCHAR2(15),
last_name VARCHAR2(15));
--------------------------------------------------------------------------------------------------------------


-- Esta tabla se creo con constraint el cual su nombre es fk_departamento
CREATE TABLE empleados (
    id_empleado NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    id_depto NUMBER,
    CONSTRAINT fk_departamento FOREIGN KEY (id_depto) REFERENCES departamentos(id_depto)
);

-- Forma 1 de establecer una constraint en un valor simple no FK nivel de columna
CREATE TABLE empleados (
    id_empleado NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    id_depto NUMBER,
    email VARCHAR(8) CONSTRAINT emp_email UNIQUE --especifica espacio 
);

--FORMA 2 DE ESTABLECER UNA UQ  a nivel de tabla  se recomienda mas esta 
CREATE TABLE empleados (
    id_empleado NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    id_depto NUMBER,
   CONSTRAINT  emp_email UNIQUE(email)
);
--Creacion de tablas con llave foranea a nivel de tabla 
CREATE TABLE Departments(
id_deparment varchar(8)PRIMARY key 
);

CREATE TABLE employees(
employee_id NUMBER(6),
last_name VARCHAR2(25),
email VARCHAR2(25),
salary NUMBER(8,2),
commission_pct NUMBER(2,2),
hire_date DATE,
department_id NUMBER(4),
CONSTRAINT EM_DEPT_FK FOREIGN KEY  (department_id) REFERENCES Departments (id_deparment) 
);





--CREA TABLA CON DATOS DAY TO SECOND 
CREATE TABLE time_ex5
(day_duration1 INTERVAL DAY(3) TO SECOND,
day_duration2 INTERVAL DAY(3) TO SECOND);

--CREAR TABLAS CON DATOS YEAT TO MONTH 
CREATE TABLE time_ex4
(loan_duration1 INTERVAL YEAR(3) TO MONTH,
loan_duration2 INTERVAL YEAR(2) TO MONTH);


SELECT SYSDATE + loan_duration1 AS "120 months from now",
SYSDATE + loan_duration2 AS "3 years 6 months from
now"
FROM time_ex4;


----------------------------------------------------✳️CONSTRAINT✳️-------------------------------------------------------

-------------------------------------------========📝RESTRICIONES 📝--------------------------------------
--TIPOS DE CONSTRAINTS:
--A NIVEL DE COLUMNA >  SE DECLARAN AL MOMENTO DE ESTABLECER LA COLUMNA Y EL TIPO DE DATO 
--A NIVEL DE TABLA   >  AL FINAL DE LA TABLA 
--UNIQUE, PRIMARY KEY, FOREIGN KEY , CHECK
--foreigt key, primary key,check ,unique can be defined at table or column level 
--a composite key only at the table level
--a not null only a column level 
--CK NO PUEDE USAR FUNCIONES COMO SYSDATE YA QUE ES DETERMINISTICO 

-------------------------------------------------------------------------------------------
--NOT NULL    NO PUEDE CONTENER VALORES VACIOS 
--UNIQUE      EL VALOR DEBE SER UNICO YA SEA DE 1 O COMPUESTO DEBE SER UNICO PARA TODAS LAS FILAS 
--PRIMARY KEY  DEBE CONTENER NOT NULL Y UN VALOR UNICO 1 O PUEDE ESTAR COMPUESTA 
--FOREING KEY  DEBE HACER REFERENCIA A OTRA TABLA PARA SU RELACION O A LA MISMA TABLA PUEDE SER CONVINACION DE COLUMNAS 
--CHECK        UNA CONDICION QUE DEBE SER CIERTA 
-----------------------------------------------------------------------------------------------------------------------------

--VERIFICA TODOS LOS CONSTRAINTS (LOS NULL CONSTRAINT SALEN COMO CHECK )
SELECT constraint_name, table_name, constraint_type, status
FROM USER_CONSTRAINTS
WHERE table_name ='COPY_EMPLOYEES';

------------------------------------🔷COLUMN LEVEL🔷----------------------------------------
--NOT NULL SE ESPECIFICA SOLO A NIVEL DE COLUMNA 

--🔑PK A NIVEL DE COLUMNA 
CREATE TABLE clients
(client_number NUMBER(4) CONSTRAINT clients_client_num_pk PRIMARY KEY,
first_name VARCHAR2(14),
last_name VARCHAR2(13));


--Definicion DE FK A NIVEL DE COLUMNA
CREATE TABLE employees(
employee_id NUMBER(6),
last_name VARCHAR2(25),
email VARCHAR2(25),
salary NUMBER(8,2),
commission_pct NUMBER(2,2),
hire_date DATE,
department_id NUMBER(4) CONSTRAINT emp_dept_fk REFERENCES departments(department_id)
);

--Definicion DE FK A NIVEL DE COLUMNA
CREATE TABLE copy_employees
(employee_id NUMBER(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
department_id NUMBER(4,0) CONSTRAINT c_emps_dept_id_fk REFERENCES departments(department_id),
email VARCHAR2(25));

CREATE TABLE clients
(client_number NUMBER(4) CONSTRAINT clients_cient_num_pk PRIMARY KEY,
last_name VARCHAR2(13) CONSTRAINT clients_last_name_nn NOT NULL,
email VARCHAR2(80) CONSTRAINT clients_emil_uk UNIQUE);


CREATE TABLE clients
(client_number NUMBER(4) CONSTRAINT clients_client_num_pk
PRIMARY KEY,
first_name VARCHAR2(14),
last_name VARCHAR2(13));



CREATE TABLE clients
(client_number NUMBER(4) CONSTRAINT clients_cient_num_pk PRIMARY KEY,
last_name VARCHAR2(13) CONSTRAINT clients_last_name_nn NOT NULL,
email VARCHAR2(80) CONSTRAINT clients_emil_uk UNIQUE);
--------------------------------------------------------------------------------------------------

-------------------------------------------🔷TABLE LEVEL🔷---------------------------------------------------
--LAS LLAVES COMPUESTAS DEBEN SER DEFINIDAS A NIVEL DE TABLA 



--🔑PRIMARY KEY TABLE LEVEL 
CREATE TABLE clients
(client_number NUMBER(4),
first_name VARCHAR2(14),
last_name VARCHAR2(13),
CONSTRAINT clients_client_num_pk PRIMARY KEY
(client_number));

--🔑PRIMARY KEY COMPOSITE (ONLY A TABLE LEVEL )
CREATE TABLE copy_job_history
(employee_id NUMBER(6,0),
start_date DATE,
job_id VARCHAR2(10),
department_id NUMBER(4,0),
CONSTRAINT copy_jhist_id_st_date_pk PRIMARY KEY(employee_id,start_date));




--🔐UNIQUE(COMPUESTA) A NIVEL DE TABLA 
CREATE TABLE clients (
client_number NUMBER(6) NOT NULL,
first_name VARCHAR2(20),
last_name VARCHAR2(20),
phone VARCHAR2(20),
email VARCHAR2(10) NOT NULL,
CONSTRAINT clients_phone_email_uk UNIQUE (email,phone));


-------------------------------------------------------------------------------------------------

---------------------------------------------🔷 AT COLUM Y TABLE LEVEL 🔷-----------------------------------
CREATE TABLE copy_employees
(employee_id  NUMBER(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
department_id NUMBER(4,0),
email VARCHAR2(25),
CONSTRAINT c_emps_dept_id_fk FOREIGN KEY (department_id)
REFERENCES departments(department_id));

-------------------------------------------------------------------------------------------------------


------------------------------------------------------✳️CONSTRAINT CHECK✳️---------------------------------------------
-- EL COMANDO CHECK SE USA A NIVEL DE TABLA O NIVEL DE COLUMNA 
--NO PERMITIDO CURRVAL, NEXTVAL, LEVEL, or ROWNUM


--CHECK > SE ASEGURA QUE LA FECHA FINAL SEA MAYOR A LA FECHA INICIAL (A NIVEL DE TABLA)
CREATE TABLE copy_job_history
(employee_id NUMBER(6,0),
start_date DATE,
end_date DATE,
job_id VARCHAR2(10),
department_id NUMBER(4,0),
CONSTRAINT cjhist_emp_id_st_date_pk
PRIMARY KEY(employee_id, start_date),
CONSTRAINT cjhist_end_ck CHECK (end_date > start_date));

--CHECK A NIVEL DE COLUMNA 
CREATE TABLE TESTING ( salary NUMBER(8,2) CONSTRAINT employees_min_sal_ck CHECK(salary > 0));


--CHECK A NIVEL DE TABLA 
CREATE TABLE XD ( CONSTRAINT employees_min_sal_ck CHECK (salary > 0));

--CHECK EJEMPLO
CREATE TABLE employees(
salary NUMBER(8,2) CONSTRAINT emp_salary_min CHECK (salary > 0), --PONE COMO RESTRICION QUE SALARY SEA MAYOR A 0 
hire_date DATE, CONSTRAINT hire_date_min CHECK (hire_date >'01-JAN-2018')

);
------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------🔷 DROPING CONSTRAINTS 🔷 -------------------------------------------------------
--NECESITAS SABER EL NOMBRE DE LOS CONSTRAINTS 
--LOS NOMBRES DE LOS CONSTRAINTS ESTAN EL EL DATA DICTIONARY



ALTER TABLE copy_departments
DROP CONSTRAINT c_dept_dept_id_pk CASCADE;


--ALTER TABLE tablename DROP
--(pk_column_name(s));

----------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------🔷ON DELETE: CASCADE / SET NULL🔷---------------------------------------------
--SI EN LA CREACION DE LA TABLA NO SE DEFINE HABRA PROBLEMAS EN LA ELIMINACION 


--CON ON DELETE CASCADE 
CREATE TABLE copy_employees
(employee_id NUMBER(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
department_id NUMBER(4,0),
email VARCHAR2(25),
CONSTRAINT cdept_dept_id_fk FOREIGN KEY (department_id)
REFERENCES copy_departments(department_id) ON DELETE CASCADE);

--ON DELETE SET NULL
CREATE TABLE copy_employees
(employee_id NUMBER(6,0) CONSTRAINT copy_emp_pk PRIMARY KEY,
first_name VARCHAR2(20),
last_name VARCHAR2(25),
department_id NUMBER(4,0),
email VARCHAR2(25),
CONSTRAINT cdept_dept_id_fk FOREIGN KEY (department_id)
REFERENCES copy_departments(department_id) ON DELETE SET NULL);


ALTER TABLE employees
ADD CONSTRAINT emp_dept_fk FOREIGN KEY (department_id)
REFERENCES departments (department_id) ON DELETE CASCADE;
----------------------------------------------------------------------------------------------------

-----------------------------------------------------🔷DISABLE CONSTRAINTS /CASCADE🔷----------------------------------------------
--DESABILITA EL CONTRAINT Y SUS DEPENDIENTES SI LUEGO ES HABILITADO SU DEPENDENCIAS NO LO HARAN

--SYNTAX DISABLE CASCADE 
ALTER TABLE table_name
DISABLE CONSTRAINT constraint_name CASCADE;

--DISABLE CONSTRAINT CASCADE
ALTER TABLE copy_departments
DISABLE CONSTRAINT c_dept_dept_id_pk CASCADE;

ALTER TABLE table_name
DROP(column_name) CASCADE CONSTRAINTS;


CREATE TABLE copy_employees
( employee_id NUMBER(6,0) PRIMARY KEY DISABLE);


ALTER TABLE copy_employees
DISABLE CONSTRAINT c_emp_dept_id_fk;
-----------------------------------------------------------------------------------



------------------------------------------------------🔷ENABLE CONSTRAINTS🔷---------------------------------------------------
--SE HABILITA A TODA LA DATA EN LA TABLA 
--TODOS LOS DATOS SE ADJUNTAN A LA RESTRICION 
--AL HABILITAR LOS CONSTRAINTS PK O UK  LOS INDEX SE CREAN AUTOMATICAMENTE 
--HABILITAR UNA PK QUE FUE DESHABILITADA POR CASCADE NO HABILITARA LA FK 

--SYNTAX
ALTER TABLE table_name
ENABLE CONSTRAINT constraint_name;

--HABILITA UN CONSTRAINT DESEBILITADO 
ALTER TABLE copy_departments
ENABLE CONSTRAINT c_dept_dept_id_pk;

--COPIA UNA (RECOMENDABLE ANTES DE MANIPULARLA) NO SE COPIAN TODAS LAS RESTRICIONES SOLO LO QUE SEA NOT NULL 
CREATE TABLE copy_departments AS (SELECT * FROM departments);

-----------------------------------------------------------------------------------------------------------------




-----------------------------------------------------------------📌📌📌 3.VIEWS 📌📌📌--------------------------------------------------------------------


--REPRESENTACIONES VIRTUALES DE TABLA PARA PERZONALIZAR
--ES UN OBJETO(NO SON TABLAS REALES)
--FACILITAN LOS QUERRYS 
--POR DEFECTO SE CREA VIEW SOLO SI LA TABLA BASE EXISTE 
--LAS VISTAS PUEDEN CAMBIAR LAS TABLAS BASES 
--SON COMO FILTROS PERMANENTES  SI LA VISTA ESTA HECHA DEL DEPT 10  MOSTRATA ESOS REGISTROS Y SI CAMBIAS UNO DE ESOS REGISTROS  DEL 10 AL 20 LA VISTA DEJA DE MOSTRAR ESE REGISTRO 
--LA VISTAS TIENE DML RESTRICTIONS : NO PUEDES USAR ORDER BY  NO PUEDES USAR FUNCIONES O GRUPOS ,DISTINCT ,ROWNUM 
--AL BORRAR UNA VISTA LOS CAMBIOS HECHOS A LAS TABLAS BASE PERMANECEN 

--create view syntax 

--CREATE [OR REPLACE] [FORCE| NOFORCE] VIEW view [(alias [,
--alias]...)] AS subquery
--[WITH CHECK OPTION [CONSTRAINT constraint]]
--[WITH READ ONLY [CONSTRAINT constraint]];

--OR REPLACE : Re-creates the view if it already exists.
--FORCE: Creates the view whether or not the base tables exist.
--NOFORCE: Creates the view only if the base table exists (default).
--view_name Specifies the name of the view
--alias: Specifies a name for each expression selected by the view's query.
--subquery:Is a complete SELECT statement. You can use aliases for the columns in the SELECT list. The subquery can contain complex SELECT syntax.
--WITH CHECK OPTION:Specifies that rows remain accessible to the view after insert or update operations
--CONSTRAINT: Is the name assigned to the CHECK OPTION constraint.
--WITH READ ONLY: Ensures that no DML operations can be performed on this view.


--CREA UNA VISTA DE LA TABLA EMPLOYEES 
CREATE VIEW view_employees
AS SELECT employee_id,first_name, last_name, email
FROM employees
WHERE employee_id BETWEEN 100 and 124;


--SE CONSULTA LA VISTA CREADA 
SELECT *
FROM view_employees;

--ELIMINA UNA VISTA 
DROP VIEW viewname;


---------------------------------------------------------------------CLASIFICATION OF VIEWS:SIMPLES----------------------------------------------------------
--NO SUBQUERRY 
--ONE TABLE 
--NO FUNTIONS 
--NO GROUPS
--YES :DML OPERTIONS 



--crea o remplaza la vista existente 
CREATE OR REPLACE VIEW view_euro_countries
AS SELECT country_id, region_id, country_name, capitol
FROM wf_countries
WHERE location LIKE '%Europe';

SELECT * FROM view_euro_countries
ORDER BY country_name;

--CREA LOS ALIAS DESPUES EN LA SUBCONSULTA 
CREATE OR REPLACE VIEW view_euro_countries
AS SELECT country_id AS "ID", country_name AS "Country",capitol AS "Capitol City"
FROM wf_countries
WHERE location LIKE '%Europe';


--CREA LOS ALIAS ANTES DE LA SUBCONSULTA
CREATE OR REPLACE VIEW view_euro_countries("ID", "Country","Capitol City")
AS SELECT country_id, country_name, capitol
FROM wf_countries
WHERE location LIKE '%Europe';

--PERMITE A LOS EMPLEADOS DEL VER LA VISTA PARA LOS MANGERS DEL DEPARTAMENTO 50 
CREATE VIEW view_dept50
AS SELECT department_id, employee_id,first_name, last_name,salary
FROM copy_employees
WHERE department_id = 50;

SELECT * FROM view_dept50;


--CREA UN TOP ANLYZE USA ROWNUM PARA TOP N RECORDS 
--AQUI SON LAS 5 PRIMERAS FILAS CUALQUIERA DE HIRE DATE 
--EL ROWNUM SE ASIGNA ANTES DE ORDENAR
SELECT ROWNUM AS "Longest employed", last_name, hire_date
FROM employees
WHERE ROWNUM <=5
ORDER BY hire_date;


-- USA INLINE VIEW 
--EL ROW NUM SE ASIGNA DESPUES DE ORDENAR ESTA ES LA FORMA CORRECTA PARA RANKEAR COSAS 
--DEBE USAR MENOR O MENOR IGUAL EN ROWNUM 
SELECT ROWNUM AS "Longest employed", last_name, hire_date
FROM (SELECT last_name, hire_date
FROM employees
ORDER BY hire_date)
WHERE ROWNUM <=5;

---------------------------------------------------------------------CLASIFICATION OF VIEWS:COMPLEX----------------------------------------------------------
--SUBQUERRY 
--ONE OR MORE TABLE 
--FUNTIONS ,JOINS
--GROUPS
--ALWAYS :DML OPERTIONS 

--USA DOS TABLAS CON JOIN USING 
CREATE OR REPLACE VIEW view_euro_countries("ID", "Country", "Capitol City", "Region")
AS SELECT c.country_id, c.country_name, c.capitol,r.region_name
FROM wf_countries c JOIN wf_world_regions r
USING (region_id)
WHERE location LIKE '%Europe';

SELECT *
FROM view_euro_countries;

--VIEW CON FUNCIONES 
CREATE OR REPLACE VIEW view_high_pop
("Region ID", "Highest
population")
AS SELECT region_id, MAX(population)
FROM wf_countries
GROUP BY region_id;

SELECT * FROM view_high_pop;

--VIEWS IN LINE  SE LE DA UN ALIAS A LA SUBCONSULTA ACTUA COMO VISTA DURANTE UNA CONSULTA SELECT 
SELECT e.last_name, e.salary, e.department_id, d.maxsal
FROM employees e,
(SELECT department_id, max(salary) maxsal
FROM employees
GROUP BY department_id) d
WHERE e.department_id = d.department_id
AND e.salary = d.maxsal;

------------------------------------------------------------------------------  DML AND view with check options  --------------------------------------------------------
--CON ESTO ACTIVO SI SE INTENTA MODIFICAR UNA FILA DE LA VISTA QUE PODRIA LLEVARLA FUERA DE ESTE DOMINIO DEVUELVE ERROR 
--se permite actualizar siempre y cuando el registro aun se mantega dentro del dominio de la lista 



--
CREATE OR REPLACE VIEW view_dept50
AS SELECT department_id, employee_id, first_name, last_name,salary
FROM employees
WHERE department_id = 50
WITH CHECK OPTION CONSTRAINT view_dept50_check;

--ERROR TO TRY UPDATE 
UPDATE view_dept50
SET department_id = 90
WHERE employee_id = 124;

--operacion permitida 
UPDATE view_dept50
SET salary = salary + 1000
WHERE employee_id = 120;


--insert permitido 
INSERT INTO view_dept50 (employee_id, first_name, last_name, department_id, salary)
VALUES (103, 'Ana', 'Lopez', 50, 4500);

--insert no permitido si esta with chek options 
INSERT INTO view_dept50 (employee_id, first_name, last_name, department_id, salary)
VALUES (104, 'Carlos', 'Diaz', 60, 4000);




----------------------------------------------------------------------------- WITH READ ONLY -------------------------------------------------------------------------------


--CREA UNA VISTA PARA SOLO LECTURA 
CREATE OR REPLACE VIEW view_dept50
AS SELECT department_id, employee_id, first_name, last_name,
salary
FROM employees
WHERE department_id = 50
WITH READ ONLY;














------------------------------------------MODIFICAR VISTA------------------------------------------------------

--RECREA LA VISTA SIN TENER QUE DROPEARLA 
CREATE OR REPLACE VIEW view_euro_countries
AS SELECT country_id, region_id, country_name, capitol
FROM wf_countries
WHERE location LIKE '%Europe';



----------------------------------------------------📌📌📌SUBQUERY📌📌📌--------------------------------------------
--SIRVE PARA FILTRAR DATOS BASADOS EN EL RESULTADO DE OTRA CONSULTA QUE SIRVAN PARA LA CONSULTA PRINCIPAL
--2 TIPOS DE SUBQUERYS : 1 SOLA FILA (>,<,<= ETC) Y MULTIPLES FILAS (IN,ANY,ALL,EXISTS,NOT IN,NOT EXISTS)
--DEBE IR ENCERRADA CON PARENTESIS , VAN DEL LADO DERECHO DE COMPARACION , EL SELECT INTERNO Y EXTERNO PUEDEN OBTENER DATA DE DIFERENTES TABLAS 
--UNA SUBCONSULTA NO PUEDE TENER SU PROPIO ORDER BY(SELECT EXTERNO), EL LIMITE DE LAS SUBCONSULTAS ES SOLO EL BUFFER 
--LA SUBCONSULTAS SE EJECUTAN PRIMERO
--EL RESULTADO DE UNA SUBQUERY ES UTILIZADA PARA LA QUERY PRINCIPAL 
--NO USAR EN SUBCONSULTAS QUE INSERTA ACTUALIZA O ELIMINA DATOS EN LA MISMA TABLA QUE LA CONSULTA PRINCIPAL
--SYNTATICAMENTE VAN EN  :  WHERE / JOIN / EN EL MISMO SELECT / HAVING / FROM 
--LOS 3 RESULTADOS DE LAS SUBQUERYS SON :TRUE, FALSE, and UNKNOWN
--LAS SUBCONSULTAS CORRELACIONADAS: SON CUANDO LA SUBCONSULTA DEPENDE DE UNA FILA  DEL SELECT PRINCIPAL(POR LO GENERAL USAN ALIAS COMO EN LOS JOIN)



--------------------------------------------🔷SINGLE ROW SUBQUERIES🔷-------------------------------------------------------
--RETORNAN UNA SOLA FILA
--SE USAN EN SELECT WHERE HAVING 
--OEPRADORES USADOS =, !=, <, >, <=, >=

--SUBCONSULTA ESCALAR DEVUELVE 1 SOLA FILA Y COLUMNA 
SELECT employee_id, salary,
(SELECT MAX(salary) FROM employees) AS max_salary
FROM employees;



--DEVUELVEN UNA SOLA FILA PERO VARIAS COLUMNAS 
SELECT first_name
FROM employees
WHERE department_id =
(SELECT department_id 
FROM departments 
WHERE department_name = 'IT');

-- VERIFICA QUE EXISTA 
SELECT nombre 
FROM clientes c 
WHERE EXISTS (SELECT 1 FROM pedidos p WHERE p.cliente_id = c.id);

--SUBCONSULTA CON ALIAS 
SELECT p.prod_name, I.item_cnt
FROM 
    (SELECT prod_id, COUNT(*) item_cnt 
     FROM sales 
     GROUP BY prod_id) I   -- <-- 'I' es el alias de toda esta subconsulta
RIGHT OUTER JOIN products p 
    ON I.prod_id = p.prod_id;




SELECT nombre FROM employees 
WHERE salario > ALL (SELECT salario FROM employees WHERE departamento = 'Ventas');


SELECT nombre FROM productos 
WHERE precio > ANY (SELECT precio FROM productos WHERE categoria = 'Electrónicos');


--------------------------------------------🔷MULTIPLES ROWS SUBQUERIES🔷--------------------------------------------------
--RETORNA MAS DE UNA FILA 
--IN,ANY,ALL,EXISTS,NOT IN,NOT EXISTS
--PUEDEN USARSE CON GROUP BY Y HAVING 
--IN: SELECIONA LAS FILAS QUE CORRESPONDAN CON LA LISTA DE IN(ITEM1,ITEM2,ETC) (NO CONSIDERA NULLS)
--ANY : DEVUELVE LAS FILAS QUE CORRESPONDAN A ALMENOS A UNO DE LOS VALORES DE ANY (NO CONSIDERA NULLS )
--ALL :


SELECT first_name,LAST_NAME
FROM employees
WHERE department_id IN 
(SELECT department_id 
FROM departments 
WHERE location_id = 1700);

--USO DE IN
SELECT last_name,employee_id
FROM employees
WHERE employee_id IN
(SELECT manager_id
FROM employees);

--USO DE IN
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) IN
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);


--USO DE ANY 
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ANY
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);

--USO DE ALL 
SELECT last_name, employee_id
FROM employees
WHERE employee_id <= ALL
(SELECT manager_id
FROM employees);


--multiple filas 
SELECT first_name, last_name,
job_id
FROM employees
WHERE job_id IN
(SELECT job_id
FROM employees
WHERE last_name = 'Ernst');



-------------------------------------------------------------🔷GROUP BY AND HAVINEG WITH SUBQUERRYS🔷 -------------------------------------------------------------

--EL MIN SALARIO DEBE SER MENOR QUE ALMENOS 1 DE LOS SALARIOS QUE APARECEN EN LA LISTA ANY 
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) < ANY
(SELECT salary
FROM employees
WHERE department_id IN (10,20))
ORDER BY department_id;







----------------------------------------------------------🔷MULTIPLE COLUMNS SUBQUERRYS🔷---------------------------------------------------------------------------

SELECT employee_id, manager_id, department_id
FROM employees
WHERE(manager_id,department_id) IN
(SELECT manager_id,department_id
FROM employees
WHERE employee_id IN (149,174))
AND employee_id NOT IN (149,174);


--comparacion por pares, La consulta enumera los empleados cuyo gerente y departamento son los mismos que los de los empleados 149 o 174.
SELECT employee_id, manager_id, department_id
FROM employees
WHERE(manager_id,department_id) IN
(SELECT manager_id,department_id
FROM employees
WHERE employee_id IN (149,174))
AND employee_id NOT IN (149,174);


--comparacion sin pares aqui separo las subconsultas 
SELECT employee_id,
manager_id,
department_id
FROM employees
WHERE manager_id IN
(SELECT manager_id
FROM employees
WHERE employee_id IN
(149,174))
AND department_id IN
(SELECT department_id
FROM employees
WHERE employee_id IN
(149,174))
AND employee_id NOT IN(149,174);





-------------------------------------------🔷SUBCONSULTAS CORRELACIONADAS🔷---------------------------------------------------------

--SYNTAXIS BASICA 
SELECT select_listhire_date
from tabla 
where user =(select select_list from tabla); 

SELECT e1.first_name
FROM employees e1
WHERE e1.salary > (
  SELECT AVG(e2.salary)
  FROM employees e2
  WHERE e1.department_id = e2.department_id  -- << REFERENCIA A "e1"
);



--SUBCONSULTA EN LA MISMA CONSULTA (USAR , PARA SEPARAR)
SELECT nombre, (SELECT COUNT(*) FROM pedidos WHERE pedidos.cliente_id = clientes.id) AS total_pedidos
FROM clientes;

--SUBCONSULTA EN EL WHERE
SELECT * FROM productos 
WHERE precio > (SELECT AVG(precio) 
FROM productos);



SELECT first_name, last_name,
hire_date
FROM employees
WHERE hire_date >
(SELECT hire_date
FROM employees
WHERE last_name = 'Vargas');


--CON UN NULL
SELECT last_name
FROM employees
WHERE department_id =
(SELECT department_id
FROM employees
WHERE last_name = 'Grant');


--SUBQUERYS DE DIFERENTES TABLAS 
SELECT last_name, job_id, department_id
FROM employees
WHERE department_id =
(SELECT department_id
FROM departments
WHERE department_name = 'Marketing')
ORDER BY job_id;



--MAS DE 1 SUBQUERY 
SELECT last_name, job_id, salary, department_id
FROM employees
WHERE job_id =
(SELECT job_id
FROM employees
WHERE employee_id = 141)
AND department_id =
(SELECT department_id
FROM departments
WHERE location_id = 1500);



--SUBQUERYS CON HAVING HAVING ES COMO WHERE SOLO QUE PARA AGRUPACIONES 
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) >
(SELECT MIN(salary)
FROM employees
WHERE department_id = 50);


--IN : TRAE MULTIPLES VALORES DE UNA FILA 
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) IN
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);


--ANY : para cuando coincide almenos un valor  tiene match con >,=,< etc QUERRY EXTERNA
SELECT last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ANY
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);



--ALL : PARA QUE COINCIDA CON TODOS LOS VALORES 
SELECT last_name, hire_date FROM employees
WHERE EXTRACT(YEAR FROM hire_date) < ALL
(SELECT EXTRACT(YEAR FROM hire_date)
FROM employees
WHERE department_id=90);

--not :

--MANEJANDO NULOS SI IN Y ANY SON USADOS RETORNARA LOS VALORES NO NULOS
SELECT last_name,
employee_id
FROM employees
WHERE employee_id IN
(SELECT manager_id
FROM employees);


--MANEJANDO NULOS CON SI SE USA ALL
--RETORNARA NULL PORQUE EL COMPARA EL SELECT EXTERNO CON CADA ELEMENTO DEL SELECT INTERNO Y AL TENER NULL POR ALGO ES NULL
SELECT last_name, employee_id
FROM employees
WHERE employee_id <= ALL
(SELECT manager_id
FROM employees);


--GROUP BY AND HAVING 
SELECT department_id, MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) < ANY
(SELECT salary
FROM employees
WHERE department_id IN (10,20))
ORDER BY department_id;

--SUBCONSULTAS CON MULTIPLES COLUMNAS  MULTIPLE COLUMNS SUBQUERYS COMPARACIONES POR PARES O NO 

SELECT employee_id, manager_id, department_id
FROM employees
WHERE(manager_id,department_id) IN
(SELECT manager_id,department_id
FROM employees
WHERE employee_id IN (149,174))
AND employee_id NOT IN (149,174);

--subconsulta con multiples columnas sin pares ordenados los separa escribiendo 1 subconsulta por columna 
SELECT employee_id,
manager_id,
department_id
FROM employees
WHERE manager_id IN
(SELECT manager_id
FROM employees
WHERE employee_id IN
(149,174))
AND department_id IN
(SELECT department_id
FROM employees
WHERE employee_id IN
(149,174))
AND employee_id NOT IN(149,174);


--PARA RETORNAR UNA SOLA FILA 
SELECT first_name, last_name,job_id
FROM employees
WHERE job_id =
(SELECT job_id
FROM employees
WHERE last_name = 'Ernst');


--PARA RETORNAR MUCHAS FILAS 
SELECT first_name, last_name,job_id
FROM employees
WHERE job_id IN
(SELECT job_id
FROM employees
WHERE last_name ='King');

--SUBCONSULTAS CORRELACIONADAS 
--Las subconsultas correlacionadas se utilizan para el procesamiento fila por fila.
--Se ejecuta una vez por cada fila de la tabla 
--LA SUBCOSULTA HACE REFERENCIA A UNA COLUMNA DE LA SUBCONSULTA EXTERIOR 

--CALCULA EL PROMEDIO DE SALARIOS POR DEPARTAMENTO ID LUEGO VE SI EL SALARIO DEL EMPLEADO ES MAYOR A ESE PROMEDIO LO INCLUYE
SELECT o.first_name,o.last_name,
o.salary
FROM employees o
WHERE o.salary >
(SELECT AVG(i.salary)
FROM employees i
WHERE i.department_id =  o.department_id);

-------------------------------------------------✳️SUBQUERYS :EXISTS & NOT EXISTS in Subqueries✳️----------------------------------------------------------
--2 CLAUSULAS QUE PUEDEN USARSE EN SUBCONSULTAS 


--SELECIONA TODO DONDE NO EXISTAN LOS MANAGERS
SELECT last_name AS "Not a Manager"
FROM employees emp
WHERE NOT EXISTS
(SELECT *
FROM employees mgr
WHERE mgr.manager_id = emp.employee_id);

--NOT IN DICE QUE NO HAY MANAGERS PORQUE AL HALLAR UN NULL HACE Q TODO EL RESULTADO SALGA MAL 
SELECT last_name AS "Not a Manager"
FROM employees emp
WHERE emp.employee_id NOT IN
(SELECT mgr.manager_id
FROM employees mgr);

---------------------------------------------✳️SUBQUERYS : WITH CLAUSE ✳️--------------------------------------------------------------
--hacen que las querys sean facil de leer 
--mejoran el rendimiento 

--syntaxys:
--WITH subquery-name AS (subquery),
--subquery-name AS (subquery)
--SELECT column-list
--FROM {table | subquery-name | view}
--WHERE condition is true;

--
WITH managers AS
(SELECT DISTINCT manager_id
FROM employees
WHERE manager_id IS NOT NULL)

SELECT last_name AS "Not a manager"
FROM employees
WHERE employee_id NOT IN
(SELECT *
FROM managers);











--------------------------------------------------------------------------------------------------------------



-----------------------------📌📌📌SELECT BÁSICOS Y NULL : WHERE / DISTINCT / SELECT ARITMETIC / ALIAS / VARIABLES DE SUSTITUCION📌📌📌-------------------

-----------------------------------------------------✳️SELECT BASICOS Y NULL EN SELECT✳️---------------------------------------------------------
--CUALQUIER COSA POR NULL DARA NULL 
--LA TABLA DUAL ES UNA TABLA VIRTUAL QUE SE USA PARA CALCULAR EXPRESIONES LLAMAR FUNCIONES O SELECIONAR VALORES CONSTANTES 
--LA TABLA DUAL TIENE UNA FILA Y UNA COLUMNA : puede usar funciones ,literales,texto no columnas 




--“ANSI Date Literal”, y es el único formato estándar que Oracle acepta directamente con el prefijo DATE.
--👉 Siempre debe ir en orden: Año-Mes-Día (YYYY-MM-DD)
--En resumen: devuelve los días entre hoy y 1/1/2019, menos 1.
SELECT SYSDATE-DATE'2019-01-01'-1 
FROM DUAL;

--mismo resultado que el de arriva 
SELECT SYSDATE-1-DATE'2019-01-01'
FROM DUAL;

-- igual al de arriva al dividir por 1 no cambia nada 
SELECT (SYSDATE-DATE'2019-01-01')/1
FROM DUAL; 

--Muestra el conteo total por departamento en cada fila individual.
--en vez de agruparlos los pone en filas individuales 
SELECT EMPLOYEE_ID,SALARY,
COUNT(*) OVER(PARTITION BY DEPARTMENT_ID) AS TOTAL_EMPLOYEES
FROM EMPLOYEES;


SELECT SYSDATE
FROM dual;

SELECT 'Hola desde la tabla dual',2+2
from dual ;

SELECT CASE 
WHEN 1=1 
THEN 'Sí' 
ELSE 'No' 
END 
FROM dual;


--Muestra todo lo referente a una tabla
DESCRIBE CUSTOMERS;                                                    

--Selecciona todos los registros de la tabla empleados
SELECT * 
FROM EMPLOYEES;                                              


--Seleciona  columnas especificas de tabla EMPLOYEES
SELECT first_name,last_name 
FROM EMPLOYEES;                         


SELECT DATE '2017-06-13'
FROM employees;

--DA NULL 
SELECT commission_pct 
FROM employees;

--DARA NULL
SELECT salary + commission_pct AS total_pay
FROM employees;



--------------------------------------------------------✳️ USO DE WHERE : limitin rows ✳️----------------------------------------------------------

--USA IS NULL PARA SABER CUAL NO TIENE MANAGER_ID
SELECT last_name, manager_id
FROM employees
WHERE manager_id IS NULL;

--MUESTRA LOS EMPLEADOS DONDE LA COMISION NO ES NULA
SELECT last_name, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;


--SELECT :TOP-N-ANALYSIS  RPWNUM ENUMERA LAS FILAS
SELECT ROWNUM AS "Longest employed", last_name, hire_date
FROM employees
WHERE ROWNUM <=5
ORDER BY hire_date;

--SELECIONA TODAS ESAS COLUMNAS DONDE EL DEPARTAMENTO ID SEA = 90
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = 90;

-- SELECIONA TODOS LOS DATOS QUE TENGAN COMO APELLIDO Whalen  
SELECT last_name, job_id, department_id
FROM employees
WHERE last_name = 'Whalen';

--BUSCA POR LA FECHA PUESTA EN EL WHERE 
SELECT FIRST_NAME,last_name
FROM employees
WHERE hire_date = '03-Jan-2016';

--SELECT CON RANGOS DE DATOS BETWEEN
SELECT last_name, salary
FROM employees
WHERE salary BETWEEN 2500 AND 3500 ;

--EL IN ES UNA LISTA COMO SI FUERA OR  PUEDE TRAER TODOS LOS DATOS DE LA LISTA O SOLO LOS QUE ENCUENTRE EN LA TABLA.
SELECT employee_id, last_name, salary, manager_id
FROM employees
WHERE manager_id IN (100, 103, 201)
ORDER BY first_name asc;

-- verifica que el dato pais en uno de los paises listados 
SELECT * 
FROM clientes 
WHERE pais IN ('México', 'España', 'Argentina');

--verifica que el id no este en la columna id 
SELECT * 
FROM productos
WHERE id NOT IN (SELECT producto_id FROM descuentos);



--ENCUENTRA VALORES CON NULL (NO USAR =)
SELECT last_name, manager_id
FROM employees
WHERE manager_id IS NULL;

--EN ESTE SELECT EL AND TIENE PRECEDENCE SE EVALUA EL OR Y EL AND PRIMERO LUEGO LO DE WHERE 
SELECT last_name, job_id, salary
FROM employees
WHERE job_id = 'SA_REP'
OR job_id = 'AD_PRES'AND salary > 15000;


--AQUI CAMBIA EL ORDEN POR EL PARENTESIS SE EVALUA LO QUE ESTA CON LOS OR LUEGO EL AND SI UNO ES FALSE EL RESULTADO SERA FALSO 
SELECT last_name, job_id, salary
FROM employees
WHERE (job_id = 'SA_REP'OR job_id = 'AD_PRES')AND salary > 15000; 


--FILTRA LOS REGISTROS DONDE LOS NUMEROS 60 90 100 NO ESTAN 
SELECT employee_id, last_name, salary, manager_id
FROM employees
WHERE department_id NOT IN (60, 90, 100) ;

--SELECIONA TODO DONDE NO ESTE ('IT_PROG', 'ST_CLERK', 'SA_REP')
SELECT last_name, job_id
FROM employees
WHERE job_id NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP') ;

--ANY Y SOME SON SYNONIMOS 
SELECT nombre FROM productos 
WHERE precio > ANY
(SELECT precio FROM productos WHERE categoria = 'Electrónicos');

--------------------------------------------------✳️DISTINCT✳️----------------------------------------------
--ELIMINA DUPLICADOS (FILAS QUE SE REPITEN)
--ESTO SE APLICA AL CONJUNTO DE COLUMNAS NO A ESTAS POR SEPARADO

SELECT DISTINCT department_id
FROM employees;

SELECT DISTINCT FIRST_NAME
FROM employees;

-----------------------------------------✳️SELECT CON OPERACIONES ARITMETICAS✳️-------------------------------------------------------
-- (+ suma)(- resta)(* multiplicación)(/ división)
-- los parentesis tienen prioridad ante cualquier operacion aritmetica 
--cualquier operacion con null da null 
--PUEDES REALIZAR ESTAS OPERACIONES CON OTRAS COLUMNAS TAMBIEN 


--OPERACION ARITMETICA USADA : (SUMA)
SELECT last_name, salary, salary + 300
FROM employees;

--MISMA CONSULTA EL PARENTESIS HACE QUE SE EJECUTE ESO PRIMERO LUEGO LO DEMAS.
SELECT last_name, salary, 12*(salary+100)
FROM employees;

--prioridad de parentesis 
SELECT (salary + 500) * 1.05 AS adjusted_salary
FROM employees;

--multiplicacion y resta 
SELECT salary* 1.05-5 as test_calculo
FROM EMPLOYEES;

--suma de dos columnas 
SELECT first_name ,salary + commission_pct as "suma de dos columnas"
FROM  employees
WHERE commission_pct is not null ;


------------------------------------------------✳️AS(ALIAS)-CONCATENACIONES-LITERALES✳️----------------------------------------------

--El AS ES OPCIONAL 
--PUEDEN USARSE EL ALIAS COMO: AS, SIN EL AS,ENTRE COMILLAS PARA PALABRAS SEPARADAS

--Cuenta los productos con id y da el nombre a la columna como numero de productos
SELECT  COUNT(PRODUCT_ID) AS N_productos
FROM PRODUCTS ; 

--MISMA CONSULTA PERO SIN EL AS 
SELECT  COUNT(PRODUCT_ID)  N_productos
FROM PRODUCTS ; 


--SE USO LAS COMILLAS DOBLES EN VEZ DEL AS 
--SITUACION DE USO CUANDO EL NOMBRE LLEVA ESPACIOS 
SELECT last_name "Name XD" ,
salary*12 "Annual Salary"
FROM employees;

--USANDO CONLUMNAS CON AS Y SIN AS 
SELECT STORE_NAME AS NOMBRE_TIENDA,STORE_ID  IDENTIFICACION_TIENDA 
FROM STORES
GROUP BY (STORE_NAME,STORE_ID)
ORDER BY STORE_ID  DESC;-- USA DOS ALIAS PARA CADA SELECION 


---------------------------------------------🔷CONCATENACIONES-LITERALES🔷------------------------------------------------
--LAS CONCATENACIONES UNEN DOS COLUMNAS Y MAS O LITERALES 
--LOS LITERALES SON PALABRAS QUE VAN DENTRO DE 'LITERAL' NO ES UN DATO COMO TAL 


--UNE DOS LITERALES 
SELECT 'Hola ' || 'Mundo' AS saludo 
FROM dual;

--CONCATENACION 2 COLUMNAS 
SELECT first_name ||' '|| last_name AS full_name
FROM employees;


--CONCATENACION 3 COLUMNAS 
SELECT first_name ||' '|| last_name ||' '||EMPLOYEE_ID AS full_name
FROM employees;

--LITERALES ENTRE COLUMNAS
SELECT first_name ||' '|| 'Morgan' ||' '||EMPLOYEE_ID AS full_name
FROM employees
WHERE first_name='Alexander' and employee_id=103;


--Alternative Quote OEPRATOR
--q'{ }', q'! !', q'< >'  SE PUEDE USAR CUALQUIER DELIMITADOR 
SELECT first_name ||' '|| 'APELLIDO'  AS full_name , q'[texto 'entre comillas']' AS QUOTE_OPERATOR ,SALARY ||''||'$' AS SALARIO_LITERAL
FROM employees;


------------------------------------------------------🔷LITERAL🔷---------------------------------------------------

--MUESTRA UN TEXTO LITERAL 
SELECT 'Oracle SQL es potente'
AS mensaje FROM dual;

--MUESTRA UN TEXTO LITERAL 
SELECT 'ONE PIECE IS  GOOD'
AS mensaje FROM dual;

------------------------------- ----------------------✳️ VARIABLES DE SUSTITUCION ✳️----------------------------------------
--COMO SU PALABRA INDICAN ESTAN VARIAN SUS VALORES PARA NO TENER QUE ESTAR ESCRIBIENDO UNA QUERRY COMPLETA NUEVAMENTE PARA UN NUEVO VALOR 
--

-- VARIABLES DE SUSTITUCION  EL : INDICA QUE SE ESPERA QUE SE INTRODUZCA UN VALOR 
SELECT employee_id, last_name, salary, department_id
FROM employees
WHERE employee_id = :employee_num ;

--VARIABLES DE SUSTITUCION DEBES INSERTAR UNA CADENA
SELECT last_name, department_id, salary*12
FROM employees
WHERE job_id = :job_title ;



SELECT employee_id, first_name, salary
FROM employees
WHERE hire_date > '&fecha_contratacion';


--define la variable y luego la puedes usar en multiples consultas 
DEFINE fecha_contratacion = '01-JAN-2020';

SELECT employee_id, first_name, salary
FROM employees
WHERE hire_date > '&fecha_contratacion';






---------------------------------------📌📌📌SELECT CON LIKE /REGULAR EXPRESIONS📌📌📌--------------------------------------------

SELECT STORE_NAME
FROM STORES 
WHERE STORE_NAME LIKE 'S%';   

SELECT STORE_NAME
FROM STORES
WHERE STORE_NAME LIKE '%o';   


SELECT STORE_NAME
FROM STORES
WHERE STORE_NAME LIKE '%os%';            


SELECT salary
FROM employees
WHERE last_name LIKE
'Smith';


--DENOTA UN CARACTER CUALQUIERA QUE EMPIEZA  Y LE SIGUE CON LA o  
SELECT last_name
FROM employees
WHERE last_name LIKE '_o%' ;

--BUSCA VALORES QUE CONTENGAN EN CUALQUIER POSICION SA_  se usa \ para indicar que es un caracter literario y no uno cualquiera. 
SELECT employee_id, last_name, job_id
FROM employees
WHERE job_id LIKE '%SA\_%' ESCAPE '\';  

--AND OPERATOR SELECIONA DE EMPLEADOS LOS QUE CUMPLAN AMBAS CONDICIONES SALIOR MAYOR Y PATRON BUSQUEDA MAN
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 10000
AND job_id LIKE '%MAN%' ;

--OR REQUIERE QUE CUALQUIERA DE LAS PARTES DE LA CONDICION SEA CIERTA 
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >= 10000
OR job_id LIKE '%MAN%' ;

----------------------------------------------------------------------REGULAR EXPRESION--------------------------------------------------------------------------
SELECT first_name, last_name
FROM employees
WHERE REGEXP_LIKE(first_name, '^Ste(v|ph)en$');


--"^" specifies the start of the string that is being searched
--Uppercase "S", followed by
--lowercase "t", followed by
--lowercase "e", followed by
--"(" starts a sub-expression
--lowercase "v"
--"|" specifies an OR
--lowercase "p" followed by Lowercase "h"
--")" finishes the group of choices,
--lowercase "e"
--lowercase "n"
--"$" specifies the end of the string that is being searched


--REMPLAZA UN PATRON DE STRING CON OTRO POR **
SELECT last_name, REGEXP_REPLACE(last_name, '^H(a|e|i|o|u)','**')
AS "Name changed"
FROM employees;


--CUENTA LA CANTIDAD DE ab  QUE HAY EN CONTRY_NAME  >0 ES IMPORTANTE 
SELECT country_name, REGEXP_COUNT(country_name, '(ab)') AS
"Count of 'ab'"
FROM wf_countries
WHERE REGEXP_COUNT(country_name, '(ab)')>0;


--VERIFICA CON UNA EXPRESION REGULAR QUE ESTE EL @ EN EL EMAIL
ALTER TABLE employees
ADD CONSTRAINT email_addr_chk
CHECK(REGEXP_LIKE(email,'@'));

--VERIFICA QUE EL CORREO SEA INTRODUCIDO CON MAS DE SUS CARACTERISTICAS  XXXX@XXX.XXX
CREATE TABLE my_contacts
(first_name VARCHAR2(15),
last_name VARCHAR2(15),
email VARCHAR2(30) CHECK(REGEXP_LIKE(email, '.+@.+\..+')));


--.+ means one or more characters
--@ an @ symbol
--\. a . (a dot) (here the backslash is an escape character)
-----------------------------------------------------------------------------------------------------------------------------------------------------------





---------------------------------------📌 3. ORDER BY / GROUP BY / ROLLUP / CUBE / HAVING / GROUPING SET / SET OPERATORS 📌-------------------------------------

----------------------------------------✳️ORDER BY✳️ --------------------------------------------
--EL ORDER BY CON NUMEROS SE REFERIRSE A LA POSICION DEL SELECT NO DE LA TABLA (ORDER BY 1 ) 1=PRIMERA COLUMNA DE TU SELECT
--PUEDES USAR ALIAS EN TU ORDER BY (ALIAS DE COLUMNAS O FUNCIOENS PERMITIDAS EN ORDER BY )
--PUEDES ORDENAR POR CUALQUIER COLUMNA DE LA TABLA PERO ESPECIFICA SU NOMBRE
--DEBEN ESTAR A LO ULTIMO DE UNA CLAUSULA
--AL COMBINAR CON UNION PARA ORDENAR ESTAS UNIONES LA COLUMNA POR LA QUE ORDENAMOS DEBE ESTAR EN AMBAS TABLAS SI NO DA ERROR 
--EL ORDER BY SOLO FUNCIONA CON FUNCIONES DE AGREGACION single row COMO:
--UPPER,LOWER,LENGTH,SUBSTR,ROUND,TRUNC,SYSTDATE Y EXPRESIONES
--en subconsultas el order by va siempre en la columna de la consulta exterior 

--ORDENA POR LA COLUMNA DEPARTMENT NAME 
SELECT DEPARTMENT_NAME,MANAGER_ID 
FROM DEPARTMENTS
ORDER BY 2 NULLS FIRST ;

--ORDENA POR LOS MANAGER ID DE FORMA ACENDENTE DEJANDO LOS NULLS DE ULTIMO
SELECT DEPARTMENT_NAME,MANAGER_ID FROM DEPARTMENTS
ORDER BY 2 NULLS LAST ;


--
SELECT JOB_ID, COUNT(*) AS TOTAL
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY TOTAL DESC;

--ORDENA POR EXPRESION 
SELECT EMPLOYEE_ID,FIRST_NAME
FROM EMPLOYEES
ORDER BY SALARY * 0.15 DESC;


--Seleciona nombre de producto, el precio unico de latabla productos y lo ordena por su precio acendente
SELECT PRODUCT_NAME,UNIT_PRICE 
FROM PRODUCTS 
ORDER BY UNIT_PRICE ASC;                         

--Realiza lo de arriva pero de forma decendente en los  unit_price
SELECT PRODUCT_NAME,UNIT_PRICE 
FROM PRODUCTS 
ORDER BY UNIT_PRICE DESC;                        

--ORDENA POR UN ALIAS EN EL SELECT
SELECT last_name, hire_date
AS "Date Started"
FROM employees
ORDER BY "Date Started";

--ORDENA POR VARIAS COLUMNNAS DE EMPLOYEES
SELECT department_id,
last_name
FROM employees
WHERE department_id <= 50
ORDER BY department_id,last_name;


--ORDENA POR DEPARMENT_ID PORQUE ES LA 3RA COLUMNA
SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY 3;


--ORDENA POR VARIAS COLUMNAS Y EL SALARIO DECENDENTE
SELECT last_name, department_id, salary
FROM employees
ORDER BY department_id, salary DESC;


--ordenar por una columna que no esta en el select 
SELECT FIRST_NAME,LAST_NAME
FROM EMPLOYEES 
ORDER BY SALARY;

----------------------------------------------------------------✳️GROUP BY✳️----------------------------------------------------------------
-- TODAS LAS COLUMNAS LISTADAS EN EL SELECT DEBEN SER PARTE DEL GROUP BY. SI NO DEBEN SER FUNCIONES DE AGREGACION
--solo puedes anidar 2 funciones de grupo cuando se usa una clausura group by :    max(avg(colum))
-- LOS ALIAS NO PUEDEN USARSE EN EL GROUP BY
-- LAS FUNCIONES DE AGREGACION NO PUEDEN IR EN LA CLAUSURA WHERE 
-- PERMITE AGRUPAR POR UNA COLUMNA QUE NO ESTA EN EL SELECT 
-- va siempre despues de where y antes de having 
-- puedes agrupar por expresiones
--PUEDES USAR ALIAS DADOS EN UNA SUBCONSULTA EN LA CLAUSULA GROUP BY 
--AL USAR ORDER BY LA COLUMNA POR LA QUE SE ORDENA DEBE ESTAR EN EL GROUP BY 


--nesting two funtions 
SELECT max(avg(salary))
FROM employees
GROUP by department_id;

--USA ALIAS DADOS POR UNA SUBCONSULTA INDICANDO EL ALIAS EN EL SELECT  PARA LUEGO USARLO EN EL GROUP BY 
SELECT minsal, maxsal 
FROM (
     SELECT MIN(salary) minsal, MAX(salary) maxsal 
     FROM hr.employees 
     WHERE hire_date < SYSDATE-365) 
GROUP BY maxsal, minsal;


--uso con rollup importante 
SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY CUBE(department_id, job_id);

-- agrupar por mas de una columna 
SELECT department_id, job_id, AVG(salary)
FROM employees
GROUP BY department_id, job_id;

--agrupa por funciones , contratados por año
SELECT TO_CHAR(hire_date, 'YYYY') AS hire_year, COUNT(*)
FROM employees
GROUP BY TO_CHAR(hire_date, 'YYYY');


--promedio de salario por departamento
SELECT AVG(salary)
FROM employees
GROUP BY department_id;

--SIN EL SELECT EN LA COLUMNA 
SELECT MAX(salary)
FROM employees
GROUP BY department_id;

SELECT region_id, ROUND(AVG(population)) AS population
FROM wf_countries
GROUP BY region_id
ORDER BY region_id;


SELECT country_id, COUNT(language_id) AS "Number of languages"
FROM wf_spoken_languages
GROUP BY country_id;


SELECT department_id, MAX(salary)
FROM employees
GROUP BY department_id;

SELECT COUNT(country_name), region_id
FROM wf_countries
GROUP BY region_id
ORDER BY region_id;


--puede agrupar por dos columnas dptid40,id50
SELECT department_id, sum(salary) as salary
FROM employees
GROUP BY department_id,EMPLOYEE_ID
ORDER BY department_id;

--puedes agrupar por una columna que no sale en el group by 
SELECT MAX(salary)
FROM employees
GROUP BY department_id;


SELECT job_id, last_name, AVG(salary)
FROM employees
GROUP BY job_id;

-- agrupa el nombre e id de la tienda y las ordena de manera descendente
SELECT STORE_NAME,STORE_ID
 FROM STORES 
 GROUP BY (STORE_NAME,STORE_ID)
 ORDER BY STORE_ID  DESC; 




---------------------------------------------✳️ROLLUP(COMPLEMENTO DEL GROUP BY )✳️--------------------------------------------------------------------
-- hace subtotales jerarquicos quitando columnas de derecha a izquierda, hasta llegar al total general como una escalera decendente cada escalon es un 
-- subtotal 
-- sigue la regla de la formula ncolumnas a la -1  (column1,column2)=column1=()
--HACE TOTALES SUBTOTALES  GERARQUICOS SEGUN LA AGRUPACION Y LUEGO UN TOTAL GENERAL 
--TODAS LAS FILAS SELECIONADAS EN EL SELECT DEBEN ESTAR EN EL ROLLUP o dentro del group by
--EL ROLLUP IDENTIFICA LAS COLUMNAS A LAS CUALES HACER SUBTOTALES Y TOTAL MEDIANTE UNA FUNCION DE AGREGACION COMO AVG,COUNT,PROM ETC  
--ROLLUP ES UNA EXTENSION DE LA CLAUSURA GRUP BY
--ROLLUP DETECTA LA FUNCION DE AGREGACION 


--MUESTRA EL SALARIO PARA CADA EMPLEADO Y LO SUMA SEGUN EL PRIMER NOMBRE ,APELLIDO Y DA UN TOTAL GENERAL  DE TODOS
SELECT FIRST_NAME,LAST_NAME,SUM(SALARY) AS CALCULO_ROLLUP 
FROM EMPLOYEES
GROUP BY ROLLUP(FIRST_NAME,LAST_NAME)
order by 1;


-- tambien es valido de esta forma 
SELECT FIRST_NAME,LAST_NAME,SUM(SALARY) AS CALCULO_ROLLUP 
FROM EMPLOYEES
GROUP BY FIRST_NAME,ROLLUP(LAST_NAME)
order by 1;



--SUMA EL SALARIO POR DEPARTAMENTO ID Y DA UN TOTAL GENERAL POR LA SUMA DE TODOS 
SELECT department_id, SUM(salary)
FROM EMPLOYEES
GROUP BY ROLLUP (department_id)
order by department_id;


--AGRUPAMIENTO POR 2 COLUMNAS calcula el maximo salario por departamento y nombre y da un total general 
SELECT department_id,FIRST_NAME,MAX(salary)
FROM EMPLOYEES
where salary >6000
GROUP BY ROLLUP (department_id,FIRST_NAME)
order by department_id;


SELECT department_id, job_id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY ROLLUP (department_id, job_id);



--------------------------------------------------------✳️CUBE(COMPLEMENTO DEL GROUP BY )✳️ ----------------------------------------------------------
--USA LA FORMULA 2 ELEVADO A LA CANTIDAD DE COLUMNAS = CANTIDA DE COMBINACIONES CUBE
--GENERA TODAS LAS COMBINACIONES POSIBLES POR LAS COLUMNAS SELECIONADAS 
--SIGUE LAS COLUMNAS DE IZ A DERECHA HASTA MEZCLAR TODAS CON TODAS 
--FUNCIONA CON TODAS LAS FUNCIONES DE AGREGACION 


--GENERA TODAS LAS COMBINACIONES POSIBLES MATRICIALMENTE HABLANDO 
SELECT FIRST_NAME,LAST_NAME,SUM(SALARY) AS CALCULO_CUBE 
FROM EMPLOYEES
WHERE SALARY>15000
GROUP BY CUBE(FIRST_NAME,LAST_NAME)
order by FIRST_NAME;


----------------------------------------------------------------✳️HAVING✳️----------------------------------------------------------------
--el HAVING puede y DEBE usar funciones de agregación en la subconsulta, incluso cuando esas funciones no están en la consulta principal. De hecho, esa es la función principal de HAVING.
--SIEMPRE VA DESPUES DE GROUP BY 
--NO PUEDE USARSE SIN GROUP BY 
--Filtra grupos completos, no filas individuales (a diferencia de WHERE)
--PUEDE USAR FUNCIONES DE AGREGACION 
--NO PUEDE HACER REFERENCIA A COLUMNAS INDIVIDUALES AMENOS QUE ESTEN EN EL GROUP BY 

--GROUP BY USANDO HAVING CUENTA TODO LO QUE SEA MAYOR A 1 QUE ESTA EN EL GROUP BY 
SELECT department_id,MAX(salary)
FROM employees
GROUP BY department_id
HAVING COUNT(*)>1
ORDER BY department_id;

--USANDO HAVING SELECIONA LA POBLACION MINIMA QUE SEA MAYOR A LO INDICADO EN EL HAVING 
SELECT region_id,
ROUND(AVG(population))
FROM wf_countries
GROUP BY region_id
HAVING MIN(population)>300000
ORDER BY region_id;




----------------------------------------------------------✳️GROUPING SETS✳️ -------------------------------------------------
--GROUPING SETS CREA CONJUNTOS DE COMBINACIONES. SE MUESTRAN TODAS LAS COLUMNAS Y LUEGO EN LAS FILAS APARECEN LAS DISTINTAS COMBINACIONES
--COMO SI FUERA UNION ALL PERO MAS EFICIENTE 
--SE PUEDEN MEZCLAR COLUMNAS ,UZAR CON FUNCIONES DE AGREGACION , CONVINAR CON CUBE Y ROLLUP 
--SE PUEDE USAR EL GROUPING SETS EN EL SELECT DANDOLE COMO PARAMETRO UNA COLUMNA ESTE NOS DARA 1 O 0 PARA IDENTIFICAR SI ES UN RESULTADO 
-- 0 PARA FILA NO AGREGADA 1 PARA FILA AGREGADA 



SELECT department_id, job_id, manager_id, SUM(salary)
FROM employees
WHERE department_id < 50
GROUP BY GROUPING SETS
((job_id, manager_id),(department_id, job_id),(department_id, manager_id));



--GROUPING USADO EN EL SELECT (DETERMINA QUE FILA CON NULL ES DE AGREGACION POR CUBE Y CUAL ES NULL REAL   0 Y 1 )
SELECT department_id, job_id, SUM(salary),
GROUPING(department_id) AS "Dept sub total",GROUPING(job_id) AS "Job sub total"
FROM employees
WHERE department_id < 50
GROUP BY CUBE (department_id, job_id);



----------------------------------------------------------------✳️SETS OPERATORS✳️----------------------------------------------------------------
--
--
--UNION:SELECIONA TODOS LOS DATOS DE AMBAS TABLAS EXCLUYENDO NULLS 
--UNION ALL: SELECIONA TODOS LOS DATOS DE AMBAS TABLAS IINCLUYENDO NULLS 
--INTERSECT : RETORNA TODA LA INFORMACION COMUN PARA AMBAS TABLAS 
--MINUS:LE RESTO LO QUE TENGO EN UNA PARTE A LA OTRA  EJEMPLO A:123 MINUS B(456) = 123  Y VICEVERSA SERIA 456 
--PUEDES MATCHEAR POR COLUMNAS QUE NO TENGA LA TABLA USNADO FUNCIONES DE CONVERSION EJEMPLO TO_DATE(NULL)
--LOS ORDER BY VAN AL FINAL 

--UNION
SELECT a_id
FROM a
UNION
SELECT b_id
FROM b; 

--UNION ALL 
SELECT a_id
FROM a
UNION ALL
SELECT b_id
FROM b; 

--INTERSECT 
SELECT a_id
FROM a
INTERSECT
SELECT b_id
FROM b; 

--MINUS
SELECT a_id
FROM a
MINUS
SELECT b_id
FROM b; 


--USANDO TO_DATE PARA MATCHEAR UNA COLUMNA QUE NO TIENE LA TABLA 
SELECT hire_date, employee_id, job_id
FROM employees
UNION
SELECT TO_DATE(NULL),employee_id,job_id
FROM job_history;


--ORDER BY IN SET OPERATORS 
SELECT hire_date, employee_id, job_id
FROM employees
UNION
SELECT TO_DATE(NULL),employee_id, job_id
FROM job_history
ORDER BY employee_id;


SELECT hire_date, employee_id, job_id
FROM employees
UNION
SELECT TO_DATE(NULL),employee_id, job_id
FROM job_history
ORDER BY employee_id;
-----------------------------------------------------------------------------------------------------------------




---------------------------------------📌 4. FUNCIONES SQL / CONVERTIONS/ SUSTITUCION DE VARIABLES📌-------------------------------------

--------------------------------------------------📝SOBRE FUNCIONE📝------------------------------------- 
--TIENEN DOS TIPOS DE FUNCIONES (SIMPLE FILA)(MULTIPLES FILAS)
--LAS FUNCIONES SIMPLES ACEPTAN 1 O MAS ARGUMENTOS 
--PUEDEN SER ANIDADAS
--PUEDEN USARSE EN CLAUSULAS COMO (SELECT,WHERE,ORDER BY,)
--2 CASOS DE FUNCIONES DE SIMPLE FILA QUE SON (Case-Manipulation Functions) Y (Character-Manipulation Functions)

SELECT FLOOR(15.7) FROM dual;        -- Resultado: 15
SELECT FLOOR(15.2) FROM dual;        -- Resultado: 15
SELECT FLOOR(-15.7) FROM dual;       -- Resultado: -16
SELECT FLOOR(-15.2) FROM dual;       -- Resultado: -16



--🔵Case-Manipulation Functions:

--HACE EN MAYUSCULA LA COLUMNA SELECIONADA 
SELECT UPPER(FIRST_NAME)
FROM EMPLOYEES;  

--HACE MAYUSCULA UN TEXTO QUE NOSOTROS LE PASEMOS 
SELECT UPPER('texto a HACER Mayuscula')
FROM EMPLOYEES;

--HACE MINISCULA LA COLUMNA SELECIONADA
SELECT LOWER(FIRST_NAME)
FROM EMPLOYEES;  

--HACE MINUSCULA UN TEXTO QUE LE PASEMOS 
SELECT LOWER('HOLA ESTO VA EN MINUSCULA')
FROM EMPLOYEES;

--PONE EN MAYUSCULA LA PRIMERA LETRA DE CADA PALABRA 
SELECT INITCAP(FIRST_NAME)
from EMPLOYEES;

--HACE MAYUSCULA LA PRIMERA LETRA DE CADA PALABRA 
SELECT INITCAP ('mayuscula en la primera letra de cada palabra')
from employees ;

SELECT last_name
FROM employees
WHERE LOWER(last_name) = 'abel';

--🔵Character-Manipulation Functions:  

--UNE  DOS COLUMNAS O LITERALES  CONCAT TIENE (2 PARAMETROS) SOLAMENTE NO PUEDES UNIR MAS DE 2 COSAS ALMENOS QUE LA ANIDES
--NO ACEPTA PARAMETROS NEGATIVOS 
--NO DEJA ESPACIO EN MEDIO A LA HORA DE LA UNION       
SELECT CONCAT(first_name, last_name)
FROM employees;  

--UNE 2 LITERALES CON '',''  
SELECT CONCAT ('Hola ','Mundo')
FROM EMPLOYEES;

--SUBSTR(cadena, inicio_C,longitud)INICIO_C Y LONGITUD DEBEN SER VALORES NUMERICOS / la longitud es opcional si no se usa saldra LA CADENA COMPLETA
SELECT SUBSTR (FIRST_NAME,2,3)
FROM EMPLOYEES
ORDER BY FIRST_NAME; 

--SELECIONA LA CADENA QUE LE DIMOS ONEPIECE Y EMPEZAMOS DESDE LA LETRA 1 Y OMITIMOS EL 3 PARAMETRO 
SELECT SUBSTR('ONEPIECE',4)
FROM EMPLOYEES;

--ESTA VEZ USAMOS EL 3 PARAMETRO 
SELECT SUBSTR('ONEPIECEEXISTE',9,6)
FROM EMPLOYEES;

--CON INDICE NEGATIVO (VA DESDE EL FINAL DERECHA A IQUIERDA)
--EL -5 QUEDA EN LA POSICION B Y DESDE ALLI CUENTAN LOS 12 PERO DESDE B SOLO HAY 5 DISPONIBLES HACIA LA DERECHA POR LO CUAL EL RESULTADO USA 5
--DE LOS 12 CARACTERES SOLICITADOS 
SELECT SUBSTR('DRAGONBALLZ',-5,12)
FROM EMPLOYEES;

--Muestra la Cantidad De Letras DE UNA COLUMNA O LITERAL
--NO ACEPTA PARAMETROS NEGATIVOS 
SELECT LENGTH(last_name)
FROM employees; 
--MUESTRA LA CANTIDAD DE LETRAS EN LA PALABRA LUFFY
SELECT LENGTH('LUFFY')
FROM EMPLOYEES;

--INSTR ES CASE SENSITIVE 
--BUSCA LA POSICION NUMERICA DE UNA LETRA EN UNA CADENA 
--TIENE 4 PARAMETROS 2 OPCIONALES(op): INSTR(cadena_origen,subcadena,posicion_busqueda(op),numero_ocurrencia)
--ES CASE SENSITIVE ,DEVUELVE UN NUMERO 
--EL NUMERO DE OCURRENCIA POR DEFECTO ES 0  DISTINGUE MAYUSCULAS Y MINUSCULAS Y  1 PARA COMPARACION POR TEXTO NO DISTINGUE MAYUS MINUS
--el numeero de ocurrencia es como por ejemplo si @ aparece 2 veces  la ocurrencia en 0 buscara el primero pero si ta en uno buscara el segundo 

--se omitio el primer parametro comenzara desde el caracter 1
SELECT last_name, INSTR(last_name, 'A')
FROM employees; 


--USO CON LITERAL,CADENA_BUSCAR,PUNTO_INICIO
--PIECE APARECE APARTIR DEL CARACTER 4 ES POR ESO EL RESULTADO 4  PERO EMPIEZA A BUSCAR DESDE EL 3 
SELECT 'LUFFY',INSTR('ONEPIECE','PIECE',3)
FROM employees;

--AQUI AL BUSCAR DESDE EL CARACTER 5 ES DECIR DESDE I NO ENCUENTRA LA CADENA POR ESO 0
SELECT 'LUFFY',INSTR('ONEPIECE','PIECE',5)
FROM employees;


--CON LA 3 RA OCURRENCIA:(VECES QUE SE REPITE LA SUBCADENA) 
--ES DECIR LA 3 VEZ QUE SALGA LA CADENA QUE ESTAMOS BUSCANDO 
SELECT INSTR('abracadabra', 'a', 1, 3) AS posicion
FROM dual;


--EMPIEZA DE DERECHA A IZ BUSCANDO ST posicion 6 
SELECT INSTR('TEST', 'ST', -1,1) AS posicion
FROM dual;



--AGREGA CARACTERES A LA IZ PARAMETROS 3(columna/LITERAL,tot_caracteres_CONAGREGADO,'letra_agregar')
--SI AGREGAS MENOS CARACTERES DE LA CADENA SERA TRUNCADA DE IZ A DERECHA 
--NO ACEPTA PARAMETROS NEGATIVOS 

SELECT LPAD(last_name, 8, '*')
FROM employees;             

--AGREGA LA PALABRA NARUTO A LA IZQUIERDA 
SELECT LPAD(' EL HOKAGE',15,'NARUTO ')
FROM EMPLOYEES;


--AGREGA CARACTERES A la DR PARAMETROS 3(columna,tot de caracteres de la cadena,'letra_agregar')
SELECT RPAD(last_name, 10, '*')
FROM employees;           
--AGREGA MAMA A AL LITERAL TE AMO 
SELECT RPAD('TE AMO',11,' MAMA')
FROM EMPLOYEES;




--Borra solo un caracter  especifico  de una cadena. Syntaxis: TRIM([ [LEADING|TRAILING|BOTH] [carácter_a_eliminar] FROM ] cadena)
--LEADING → Elimina el carácter solo al inicio (izquierda).
--TRAILING → Elimina el carácter solo al final (derecha).
--BOTH → Elimina el carácter en ambos lados (valor por defecto si no se especifica).
--carácter_a_eliminar → Opcional. Si no se especifica, elimina espacios en blanco ('').
--cadena → La cadena de texto a la que se aplicará el recorte.
--NO ACEPTA PARAMETROS NEGATIVOS 
SELECT TRIM(LEADING 'a' FROM 'abcba')
FROM DUAL;    

--ELIMINA EL CARACTER 7 UE ESTA AL FINAL 
SELECT TRIM (TRAILING '7' FROM 'JETMOTION507')
FROM DUAL;

--ELIMINA LAS X DE AMBOS LADOS (PARAMETRO POR DEFECTO) BOTH
SELECT TRIM('x' from 'xxxAlexanderxxx')
from dual ;

--🔵FUNTION: REPLACE
--Remplaza Una Cadena de texto por otra Syntaxis(columna,cadena_de_remplazo,texto_insertar)
--SE PUEDE OMITIR EL 3 PARAMETRO 
--NO USA INDICE NEGATIVO 
--SI NO ENCUENTRA CADENA DE REMPLAZO ARROJA LO MISMO 

SELECT REPLACE('JACK and JUE', 'J', 'BL')
FROM DUAL;   

--SI SE OMITE EL 3R PARAMETRO SOLO SE QUITARA LA J no remplaza nada en su lugar 
SELECT REPLACE('JACK and JUE', 'J')
FROM DUAL;   
--EJEMPLO CON COLUMNA REAL
SELECT REPLACE(First_name,'S','XD')
FROM EMPLOYEES;        

--EJEMPLO COLUMNA REAL CON DOS CARACTERES A REMPLAZAR 
SELECT REPLACE(First_name,'Sa','XD')
FROM EMPLOYEES; 

-------------------------------------------------------🔵NUMBER FUNCTIONS-------------------------------:

--Syntaxis TRUNC(column|expression, decimal places)
--MOD SI EL RESULTADO ES 1 ES PAR SI ES 0 ES IMPAR  SYNTAXIS DE MOD : MOD(NUM A DIVIDIR NUMERADOR, divisor DENOMINADOR)
--FAMILIARISARTE CON CONCEPTOS DE UNIDA(X), DECENA (XX) , CENTENA(XXX),MILLARES(XXXX) DECENAS DE MILLARES (10,000) ETC (CASOS NEGATIVOS)

--ROUND PUEDE SER USADO CON NUMEROS Y FECHAS 2 PARAMETROS  SYNTAXIS(column|expression, decimal places) 
--ROUND :A PARTIR DE DECIMAL .5 SE REDONDE EL NUMERO HACIA ARRIVA 
--ROUND CUANDO EL NUMERO ES - SE REDONDE A LA IZQUIERDA PERO CON MULTIPLOS DE 10 ES DECIR 45.977 ESTA 40/50 5.977 es >5 asi que es 50
--SI SE DEJA EL PARAMETRO 0 SE REDONDEA AL ENTERO MAS CERCANO Y SI NO SE ESCRIBE 0 TAMBIEN 



--REDONDEA AL ENTERO MAS CERCANO BASANDOSE EN SI EL DECIMAL ES MAYOR A 5  
SELECT ROUND (UNIT_PRICE,0) 
FROM PRODUCTS;

--REDONDEA AL ENTERO MAS CERCANO TAMBIEN 
SELECT ROUND (UNIT_PRICE) 
FROM PRODUCTS;
    
--REDONDEA A 2 DECIMALES  
SELECT ROUND (UNIT_PRICE,2)
FROM PRODUCTS;

--REDONDEA UN NUMERO PROPORCIONADO 
SELECT ROUND (23555.78910,4)
FROM PRODUCTS;

--redondea a la decena 120-130 (decena xx)
SELECT ROUND (45.926,-1)
FROM PRODUCTS;

--REDONDE A LA DECENA  55 ESTA MAS CERCA DE 60 QUE DE 50  POR ESO ES 460
SELECT ROUND (455.76,-1)
FROM PRODUCTS ;






--REDONDEA A LA CENTENA(XXX) MAS CERCA ES DECIR 345 ESTA MAS CERCA DE 300 QUE DE 400 
select round (2345.67, -2)
from products;

--REDONDEA AL MILLAR(XXXX) MAS CERCA EN ESTE CASO TA MAS CERCA DE 2000 QUE DE 1000 
SELECT ROUND (1578.678,-3)
FROM dual;

--ROUND CON FECHAS :
--si el mes es del 1 al 6 redondea  redondea a inicio del mismo año si no al otro año 
--SI EL Día 1–15 → REDONDEA  al primer día de ese mismo mes. SI NO Día 16–31 → al primer día del siguiente mes.
--'DD' (default) → redondea la hora:
--antes de mediodía → regresa el mismo día 00:00:00
--después de mediodía → siguiente día 00:00:00
--'MM' → redondea al mes más cercano.
--'YYYY' → redondea al año más cercano.
--'Q' → redondea al trimestre más cercano.
--'HH', 'MI', etc. → redondean horas, minutos, etc.
--ROUND(fecha) → redondea al día más cercano (si la hora ≥ 12:00 va al día siguiente).
--TRUNC(fecha) → quita horas, minutos, segundos → deja solo la fecha sin tiempo.


--SELECT employee_id ,LAST_NAME
--FROM EMPLOYEES
--WHERE SUBSTR(first_name, INSTR(first_name,'')+1) LIKE 'St%';
--WHERE INITCAP(SUBSTR(FIRST_NAME, INSTR(FIRST_NAME,'')+1)) LIKE 'St%';
--WHERE INITCAP(SUBSTR(FIRST_NAME, INSTR(FIRST_NAME,'')+1)) LIKE 'St%';



--REDODNEA AL DIA MAS CERCANO ANTES DE LAS 12 EL MISMO DIA DESPUES DE LAS 12 o a las 12 exactamente  EL DIA SIGUIENTE 
SELECT ROUND(SYSDATE)
FROM dual;

--antes del corte    (00:00:00.000 - 11:59:59.999)
--corte exacto       (12:00:00.000)
--despues del corte  (12:00:00.001 - 23:59:59.999)


select ROUND(TO_DATE('2024-01-15 10:30:00', 'YYYY-MM-DD HH24:MI:SS')) AS antes_12 from dual;
select ROUND(TO_DATE('2024-03-15 12:00:00', 'YYYY-MM-DD HH24:MI:SS')) AS exacto_12 from dual;
select ROUND(TO_DATE('2024-01-15 13:30:00', 'YYYY-MM-DD HH24:MI:SS')) AS despues_12 from dual;


--REDONDEA AL MES MAS CERCANO 
SELECT ROUND(SYSDATE, 'MM')
FROM dual;


--antes del corte : Días 1-14
--corte exacto : dia 16 
--despues del corte:16-31

SELECT TO_DATE('2024-03-14', 'YYYY-MM-DD') AS fecha, '14' AS dia_del_mes FROM dual;
SELECT TO_DATE('2024-03-15', 'YYYY-MM-DD') AS fecha, '15' AS dia_del_mes FROM dual;
SELECT TO_DATE('2024-03-16', 'YYYY-MM-DD') AS fecha, '16' AS dia_del_mes FROM dual;








--REDONDEA AL AÑO MAS CERCANO 
SELECT ROUND(SYSDATE, 'YYYY') FROM dual;



--REDONDE LA FECHA A UN UN MES dependiendo de los dias 1-15  el mismo mes del 16 31 el mes siguiente 
SELECT hire_date,
ROUND(hire_date,'Month')
FROM employees
WHERE department_id = 50;


--redondea segun los meses 1 al 12   del 1 al 6 el mismo 1ro del mismo año  del 7 al 12 siguiente primero del siguiente año 
SELECT hire_date,
ROUND(hire_date,'year')
FROM employees
WHERE department_id = 50;


--La fecha se redondea al domingo más cercano: (necesitas saber el dia de la semana )
--Si la fecha está entre lunes y miércoles, se redondea hacia el domingo anterior.
--Si está entre jueves y sábado, se redondea hacia el domingo siguiente.
--utiliza los dias de la semana
SELECT hire_date,
ROUND(hire_date,'day')
FROM employees
WHERE department_id = 50;



----------------------------------------------------------------------------------------------------------------------------------------------
--🔷TRUNC 
--LA FUNCION TRUNC TIENE DOS PARAMETROS (NUMERO_A_TRUNCAR,NUMERO_DE_DECIMALES_OPCIONAL)
--LA MEJOR PARA MANEJAR DATOS FINANCIEROS 
--FAMILIARISARSE CON UNIDADES DECENAS CENTENAS MILLARES CUANDO ES NEGATIVO 
--EL PARAMETRO NUMERO DECIMALES  DEJARA LA CANTIDAD DE DECIMALES QUE PONGAS EN ESTE PARAMETRO 
--cuando hay un negativo la cantidad del numero negativo son los ceros que pondremos 
--SIRVE PARA FECHAS :
--'DD' → día (00:00:00 del mismo día).
--'MM' → primer día del mes.
--'YYYY' → primer día del año.
--'Q' → primer día del trimestre.
--'D' → primer día de la semana (según configuración NLS).
--'IW' → primer día de la semana ISO (lunes).
--TRUNC(fecha) → quita horas, minutos, segundos → deja solo la fecha sin tiempo.
--TRUNC(FECHA'DAY'):LLEVA LA FECHA AL DOMINGO ANTERIOR 
--TRUNC(FECHA'MONTH'):LELVA LA FECHA AL MES INICIAL 
--TRUNC (FECHA,'YEAR'): LLEVA LA FECHA AL PRIMER DIA DE ESE AÑO 


--DEVUELVE EL NUMERO ENTERO (EL PARAMETRO NUMERO DE DECIMALES SE OMITIO) 
SELECT TRUNC(123.4567)
FROM dual;

--TRUNCA LA TABLA Y LIBERA EL ESPACIO 
TRUNCATE TABLE sales
DROP STORAGE;

-- 123.45 ( ESPECIFICA :dos decimales)
SELECT TRUNC(123.4567, 2)
FROM dual;

--TRUNCATE CON NUMERO NEGATIVO  (trunca en decenas 10 )
SELECT TRUNC(155.4567, -1)
FROM dual;  


-- 9000 (trunca en millares) es decir quita las unidades decenas centenas 
SELECT TRUNC(9876.543, -3)
FROM dual;    

--(uso en una columna )trunca 8 numeros del salario 
SELECT TRUNC (SALARY,8)
FROM EMPLOYEES ;

--TRUNC CON FECHA
--8/29/2025, 00:00:00 AM FECHA FORMATEADA A HORAS 0 
SELECT TRUNC(SYSDATE) FROM dual;

--8/1/2025, 00:00:00 AM PRIMER DIA DEL MES 
SELECT TRUNC(SYSDATE, 'MM') FROM dual;

--1/1/2025, 00:00:00 AM primer dia del año 
SELECT TRUNC(SYSDATE, 'YYYY') FROM dual;

--7/1/2025, 00:00:00 AM  PRIMER DIA DEL TRIMESTRE DONDE CAE AGOSTO ES DECIR 
SELECT TRUNC(SYSDATE, 'Q') FROM dual;

--8/25/2025, 00:00:00 AM primer dia de la semana 
SELECT TRUNC(SYSDATE, 'IW') FROM dual;
-----------------------------------------------------------------------------------------------------------------------------

--🔷MOD
--DEVUELVE el residuo de la división entre 2 numeros ,determina si es par(odd) o impar(even).
--PARAMETROS 2 (dividendo ,divisor)
--MOD SI EL RESULTADO ES 0 ES PAR SI ES 1 ES IMPAR  SYNTAXIS DE MOD : MOD(NUM_A_DIVIDIR NUMERADOR, divisor DENOMINADOR)
--ejemplo 10/3  3x3=9   10-9=1  
--EL SIGNO DEL DIVIDENDO ES EL SIGNO QUE ESTARA COMO RESULTADO 
--SI EL DIVIDENDO ES MAYOR QUE EL DIVISOR = RESIDUO +SIGNO DEL DIVIDENDO 
--SI EL DIVIDENDO ES MENOR QUE EL DIVISOR = DIVIDENDO + SIGNO DEL DIVIDENDO 
SELECT MOD((UNIT_PRICE),2) AS CALCULOS
FROM PRODUCTS;      
--EL NUMERO ES PAR  2X10=20 POR ESO ES 0 (PAR)
SELECT MOD (20,2)
FROM PRODUCTS ;
--EL NUMERO ES IMPAR 
SELECT MOD (25.3,4)
FROM PRODUCTS ;

--resultado 3
SELECT MOD(15, 4) FROM dual;

--
SELECT MOD(20, 5) FROM dual;    

SELECT 
    MOD(10, 3) as ej1,      -- 1 (divisor positivo → positivo)
    MOD(-10, 3) as ej2,     -- 2 (divisor positivo → positivo)  
    MOD(10, -3) as ej3,     -- -2 (divisor negativo → negativo)
    MOD(-10, -3) as ej4,    -- -1 (divisor negativo → negativo)
    MOD(5, -10) as ej5      -- -5 (divisor negativo → negativo)
FROM dual;




---------------------------------🔵DATE FUNCTIONS--------------------------------------------:
--FORMATO POR DEFECTO  DD-Mon-YYYY
--FECHAS VALIDAS :January 1, 4712 a.C.,and December 31, 9999 D.C
-- SOLO HAY UNA FUNCION QUE RETORNA UNA NUMERO COMO TIPO DE DATO LA CUAL ES MONTHS_BETWEEN QUE RETORNA UN DATO NUMERICO
--SYSDATE,MONTHS_BETWEEN,ADD_MONTHS,NEXT_DAY,LAST_DAY,ROUND,TRUNCATE

--MUESTRA LA HORA ACTUAL DEL SYSTEMA DONDE SE EJECUTA EL COMANDO
SELECT SYSDATE FROM dual;       

--PARAMETROS 2 (COLUMNA | EXPRESION,FORMATO_FECHA) 
SELECT ROUND ('04-JUL-25','DD')
FROM DUAL;

--AGREGA 60 DIAS A LA FECHA DE CONTRATACION 
SELECT last_name, hire_date + 60
FROM employees;

--DESPLIEGA EL NUMERO DE SEMANAS DESDE QUE EL EMPLEADO FUE CONTRATADO 
SELECT last_name, (SYSDATE-hire_date)/7
FROM employees; 

--NUMERO DE DIAS QUE EL EMPLEADO ESTUVO EN UN TRABAJO / AÑOS = NUEMRO DE AÑOS EN ESE TRABAJO  
SELECT employee_id, (end_date -start_date)/365 AS "Tenure in last job"
FROM job_history;


--🔷MONTHS_BETWEEN
--SYNTAXIS (FECHA1,FECHA2) R:(VALOR NUMERICO EN MESES) 
--SI LAS DOS FECHAS CAEN EL MISMO DIA 
--DICE LOS DIAS ENTRE DOS FECHAS 
--SI EL PRIMER ARGUMENTO ES UNA FECHA ANTERIOR AL SEGUNDO DEVOLVERA UN NUMERO NEGATIVO 
--EL VALOR PUEDE SER DECIMAL EQUIVALE A 2 MESES Y 

--DEVUELVE EL APELLIDO Y FECHA DE CONTRATACION BASANDOSE EN LOS MESES QUE SEAN MAYOR A 100 ENTRA ESAS DOS FECHAS 
SELECT last_name, hire_date
FROM employees
WHERE MONTHS_BETWEEN(SYSDATE,hire_date)>100;




--🔷ADD_MONTHS
--AGREGA MESES A LA FECHA ACTUAL 
--DOS PARAMETROS fecha y un numero 
--n puede ser negativo o positivo para sumar o restar meses 

--A LA FECHA ACTUAL LE AGREGA 12 MESES SYNTAXIS
SELECT ADD_MONTHS (SYSDATE, 12)
AS "Next Year"
FROM dual;




--🔷NEXT_DAY
--SYNTAXIS:(FECHA,'dia DE LA SEMANA')

--ESTA CONSULTA DEVUELVE EL PROXIMO SABADO DE LA FECHA QUE SE LE HA PROPORCIONADO 
SELECT NEXT_DAY (SYSDATE,'Saturday')
AS "Next Saturday"
FROM dual;



--🔷LAST_DAY 
--SYNTAXIS (FECHA)  DEVUELVE EL ULTIMO DIA DE LA FECHA INTRODUCIDA 

--DEVUELVE EL ULTIMO DIA DE LA FECHA QUE LE PROPORCIONEMOS SYNTAXIS(SOLO LA FECHA )
SELECT LAST_DAY (SYSDATE)
AS "End of the Month"
FROM dual;



--SELECIONA MUCHAS FILAS Y USA COMBINACION DE FUNCIONES DE FECHAS PARA CALCULAR 
SELECT employee_id, hire_date,
ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) AS TENURE,
ADD_MONTHS (hire_date, 6) AS REVIEW,
NEXT_DAY(hire_date, 'FRIDAY'), LAST_DAY(hire_date)
FROM employees
WHERE MONTHS_BETWEEN (SYSDATE, hire_date) > 36;




-------------------------------------------------------------✳️FUNCIONES DE AGRUPACION--✳️---------------------------------------------
--•✳️Group Functions: IGNORAN LOS VALORES NULOS 
--TRABAJAN EN TODA UNA COLUMNA 
-- IGNORAN LOS VALORES NULOS 
--PUEDEN ANIDARSE 
--NO PUEDEN USARSE EN CLAUSURA WHERE
--•MIN, MAX and COUNT PUEDEN SER USADO POR CUALQUIER TIPO DE DATO ;
--SUM, AVG, STDDEV, SOLO PUEDEN SER USADAS CON DATOS NUMERICOS 


--−AVG : SELECIONA UNA COLUMNA NUMERICA (PROMEDIO)

SELECT ROUND(AVG(salary), 2)
FROM employees
WHERE department_id = 90;

--−COUNT
--−MIN: SELECIONA EL VALOR MINIMO DE UNA COLUMNA YA SEA FECHA NUMERO CADENA

SELECT MIN(SALARY)
AS "Lowest Life Exp"
FROM EMPLOYEES;
 
SELECT MIN(country_name)
FROM COUNTRIES;

SELECT MIN(hire_date)
FROM employees;

--−MAX:SELECIONA EL VALOR NUMERICO,CADENA,FECHA MAXIMO DE LA COLUMNA SELECIONADA 

SELECT MAX(SALARY)
AS "Lowest Life Exp"
FROM EMPLOYEES;

 
SELECT MAX(country_name)
FROM COUNTRIES;


SELECT MAX(hire_date)
FROM employees;

--−SUM : SUM SUMA UNA COLUMNA QUE CONTENGA VALORES NUMERICOS 

SELECT SUM (salary)
FROM employees
WHERE department_id = 90;


--−VARIANCE : Se utiliza con columnas que almacenan datos numéricos para calcular la dispersión de los datos en torno a la media.

SELECT ROUND(VARIANCE(SALARY),2)
FROM EMPLOYEES
WHERE department_id = 90;


--STDDEV :
SELECT ROUND(STDDEV(SALARY), 4)
FROM EMPLOYEES;

-------------------------------- MAS DE 1 GRUPO DE FUNCIONES -----------------------
SELECT MAX(salary), MIN(salary), MIN(employee_id)
FROM employees
WHERE department_id = 60;


------------------------------✳️COUNT, DISTINC , NVL✳️ --------------------------------


--COUNT: RETORNA EL NUMERO DE VALORES NO NULOS DE UNA COLUMNA (LOS CUENTA)
SELECT COUNT(job_id)
FROM employees;


--CUENTA CUANTOS EMPLEADOS FUERON CONTRATADOS ANTES DE LA FECHA INDICADA EN EL WHERE 
SELECT COUNT(*)
FROM employees
WHERE hire_date < '01-Jan-1996';


--DISTINCT : DEVUELVE TODOS LOS VALORES NO DUPLICADOS DE UNA TABLA 
--PUEDE SER USADA CON TODAS LAS FUNCIONES DE GRUPO 

SELECT DISTINCT job_id
FROM employees;

SELECT SUM(DISTINCT salary)
FROM employees
WHERE department_id = 90;

SELECT COUNT (DISTINCT job_id)
FROM employees;

SELECT COUNT (DISTINCT
job_id)
FROM employees;

--CUENTA TODAS LAS FILAS INCLUYENDO NULOS 
SELECT COUNT(*)
FROM employees
WHERE hire_date < '01-Jan-1996';

SELECT COUNT(country_name), region_id
FROM wf_countries
GROUP BY region_id
ORDER BY region_id;

SELECT COUNT(*), region_id
FROM wf_countries
GROUP BY region_id
ORDER BY region_id;

-------NVL-------

SELECT AVG(NVL(commission_pct, 0))
FROM employees;

SELECT COUNT(*), region_id
FROM wf_countries
GROUP BY region_id
ORDER BY region_id;

--CALCULA LA RAIZ CUADRADA DE LA VARIANZA 
SELECT STDDEV(UNIT_PRICE)
FROM PRODUCTS; 



-- MAS DE UNA FUNCION EN LA MISMA COLUMNA O DISTINTAS 
SELECT MAX(salary), MIN(salary), MIN(employee_id)
FROM employees
WHERE department_id = 60;

---------------------------------------------------------Aliases en Funciones ------------------------------------------------------

--CONCATENA EL APELLIDO EN MINUSCULA CON LA PRIMERA LETRA DEL PRIMER NOMBRE
SELECT LOWER(last_name)||LOWER(SUBSTR(first_name,1,1))
AS "User Name"
FROM employees;
-------------------------------------------------------------------------------------


SELECT COUNT(PRODUCT_ID)FROM PRODUCTS;                     --Funcion COUNT cuenta lo que halla en la columna PRODUCT_ID omitiendo nulos. 
SELECT COUNT(*)FROM PRODUCTS ;                             --Cuenta todos los registros de la tabla products incluso los nulos.
SELECT SUM(UNIT_PRICE) FROM PRODUCTS;                      --Suma todo lo que esta en la columna UNIT_PRICE
SELECT AVG(UNIT_PRICE) FROM PRODUCTS;                      --Calcula el promedio de los precios en UNIT_PRICE
SELECT MIN(UNIT_PRICE) FROM PRODUCTS;                      --Busca el valor minimo de la columna UNIT_PRICE
SELECT MAX(UNIT_PRICE) FROM PRODUCTS;                      --Busca el valor maximo de la columna UNIT_PRICE
SELECT MEDIAN(UNIT_PRICE)FROM PRODUCTS;                    --Busca la mediana de la columna UNIT_PRICE     
SELECT STDDEV(UNIT_PRICE) FROM PRODUCTS;                   --Calcula la desviacion estandar 
SELECT VARIANCE(UNIT_PRICE) FROM PRODUCTS;                 --Calcula la varianza.
SELECT -LENGTH(FIRST_NAME) FROM EMPLOYEES;                 --CUENTA LOS CARACTERES DE LOS PRIMEROS NOMBRES CON UN SIGNO NEGATIVO DELANTE



-----------------------------------------------------------CONVERTION FUNCTIONS----------------------------------------------------
--🔵DATA TYPE CONVERSIONS FUNCTIONS:
--CONVIERTTE IMPLICITAMENTE :VARCHAR2,CHAR EN NUMBER AND DATE AND VICEVERSE NUMBER AND DATE TO CHARECTER DATA TYPE 
--VARCHAR2 or CHAR TO NUMBER 
--VARCHAR2 or CHAR  TO DATE
--NUMBER TO VARCHAR2
--DATE TO VARCHAR2
--Implicit data type conversions
--FROM TO
--VARCHAR2 or CHAR NUMBER
--VARCHAR2 or CHAR DATE
--NUMBER VARCHAR2
--DATE VARCHAR2

--🔵TO_CHAR
--TO_CHAR (date column name, 'format model you specify')
--Use sp para que el numero salga como caracter ejmplo: veintidos de abril del dosmil dieciocho 
--th sirve para ordinal  como : 1st, 2nd, 3rd, and so on
-- fm  fill mode : quita los espacios en blanco y los ceros 
--YYYY Full year in numbers
--YEAR Year spelled out
--MM Two-digit value for month
--MONTH Full name of the month
--MON Three-letter abbreviation of the month
--DY Three-letter abbreviation of the day of the week
--DAY Full name of the day of the week
--DD Numeric day of the month
--DDspth FOURTEENTH
--Ddspth Fourteenth
--ddspth fourteenth
--DDD or DD or D Day of year, month or week   :  DDD → Día del año (de 001 a 366), DD → Día del mes (de 01 a 31),  D → Día de la semana (1 = domingo, 2 = lunes, ... hasta 7).
--HH24:MI:SS AM 15:45:32 PM             HH(HOUR)24(formato 24 horas 00-23),MI(MINUTES),SS(SECONDS)
--DD "of" MONTH 12 of October
--hh(horas formato de 12 )
--HH(FORMATO 24 HORAS )
--mm(minutos)
-- ss(segundos) 
--pm(pm)(ORACLE LO INTERPRETA DINAMICAMENTE) 


SELECT 
   SYSDATE AS FECHA,
   TO_CHAR(SYSDATE, 'DDD') AS DIA_DEL_ANO,
   TO_CHAR(SYSDATE, 'DD')  AS DIA_DEL_MES,
   TO_CHAR(SYSDATE, 'D')   AS DIA_DE_SEMANA
FROM dual;

SELECT TO_CHAR(hire_date, 'fmDay ddth Mon,
YYYY')
FROM employees;

SELECT 
   TO_CHAR(TO_DATE('15:45:32', 'HH24:MI:SS'), 'HH24:MI:SS AM') AS FORMATO_HORA
FROM dual;


--CONVIERTE LA FECHA DEL PARAMETRO A UN FORMATO DE FECHA DADO SYNTAXIS: TO_CHAR (date column name, 'format model you specify')
SELECT TO_CHAR(hire_date, 'Month dd, YYYY')
FROM employees;

--CONVIERTE LA FECHA A EL FORMATO DADO FM ES DE FILL MODE QUITA LOS ESPACIOS Y CEROS 
SELECT TO_CHAR(hire_date, 'FMMonth dd, YYYY')
FROM employees;

--CONVIERTE LA FECHA AL FORMATO DADO  th= numeros solo funciona con elementos numericos no afecta ponerlo en el mes se puede quitar 
SELECT TO_CHAR(hire_date, 'fmMonth ddth, YYYY')
FROM employees;


--OTROS FORMATOS 
SELECT TO_CHAR(hire_date, 'fmDay ddth Mon,YYYY')
FROM employees;

--OTRO FORMATO SP = DELETREAR   DELETREA EL DIA EN EL FORMATO 
SELECT TO_CHAR(hire_date, 'fmDay ddthsp
Mon, YYYY')
FROM employees;

--OTRO FORMATO  
SELECT TO_CHAR(SYSDATE, 'hh:mm:ss pm')
FROM dual;

----------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------🔵Number Conversion to Character Data:SYNTAXIS :TO_CHAR(number, 'format model')-------------------------------------------
-- LOS 9999 SON REMPLAZADOS POR EL NUMERO ESTOS SE ACOMODAN DEACUERDO AL FORMATO 
--table examples:

--9 Numeric position (# of 9's determine width) 999999 = 1234  (el formato son seis 9 pero se añaden espacios en blanco a la izquierda de 1234 para rellenar el formato)
--pero si usamos length veremos que nos da como resultado 7  esto porque son los 6 del formato mas 1 del signo positivo 
--resumen : tus numeros no pueden ser mas alto que el formato  no importa si en el formato hay mas numeros de los que tienes se rellena con espacios a la iz
SELECT LENGTH(TO_CHAR(1234,'999999'))
FROM dual;

--en este formato como son 6 los que no usemos se transformaran en 0 a la izquierda 
SELECT TO_CHAR(1234, '099999')
FROM dual;  -- '001234'

--symbolo de dolar agregado al formato resultante 
SELECT TO_CHAR(1234, '$999999')
FROM dual;  -- '$   1234'

--symbolo de moneda local 
SELECT TO_CHAR(1234, 'L999999')
FROM dual;  -- 'B/.  1234'

--uso del punto decimal 
SELECT TO_CHAR(1234, '999999.99')
FROM dual;  -- '1234.00'

-- separador de miles agrega las comas 
SELECT TO_CHAR(1234, '9,999')
FROM dual;  -- '1,234'

-- signo menos a la derecha 
SELECT TO_CHAR(-1234, '999999MI')
FROM dual;  -- '1234-'

--NEGATIVOS ENTREPARENTESIS 
SELECT TO_CHAR(-1234, '999999PR')
FROM dual;  -- '<1234>'


--NOTACION CIENTIFICA 
SELECT TO_CHAR(1234, '9.9999EEEE')
FROM dual;  -- '1.2340E+03'

-- MULTIPLICADO PRO 10(ELEVADO)N 
SELECT TO_CHAR(1234, '9999V99')
FROM dual;  -- '123400'

--MUESTRA CEROS COMO BLANCO 
SELECT TO_CHAR(0, 'B9999.99')
FROM dual;  -- '     '

SELECT TO_CHAR(1234, 'B9999.99')
FROM dual;  -- '1234.00'



--SALARIO SE AJUSTA AL FORMATO DADO 
SELECT TO_CHAR(salary,
'$99,999') AS "Salary"
FROM employees;

SELECT TO_CHAR(3000, '$99999.99')
FROM dual;


SELECT TO_CHAR(4500, '99,999')
FROM dual;

SELECT TO_CHAR(4422, '0009999')
FROM dual;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--🔵Character Conversion to Number Syntaxis : TO_NUMBER(character string, 'format model') FORMAT MODEL IS OPTIONAL 
--A DIFERENCIA DE LAS OTRAS CONVERSIONES TO NUMBER  NO TOMA LA COMA EN CUENTA ES DECIR EL RESULTADO NO TENDRA LA COMA. 
-- PIENSA LO DE LA FORMA DE QUE EXTRAE LOS NUMEROS DE UN STRING 
--LOS NUMEROS DEBEN COINCIDIR CON EL FORMATO
--EL PRIMER PARAMETRO SI SOLO ES UN NUMERO LO CONVERTIRA SIN NECESIDAD DEL SEGUNDO PERO SI INCLUYE UNA , O ALGO DEBE USAR FORMATO 

-- CONVIERTE UN STRING EN UN NUMERO 
SELECT TO_NUMBER('5,320', '9,999') AS "Number"
FROM dual;

--NO SALE LA COLUMNA NUMBER NO EXISTE
SELECT last_name, TO_NUMBER(bonus,'9999') AS "Bonus"
FROM employees
WHERE department_id = 80;



-----------------------------------------------------🔵Character Conversion to Date SYNTAXIS: TO_DATE('character string', 'format model')------------------------------------------------------

--CONVIERTE UN VALOR QUE NO ES FECHA (CADENA STRING ) A UN VALOR QUE ES UNA FECHA
--FX = FORMAT EXACT  HACE COINCIDIR EL FORMATO EXACTAMENTE 
--SIN FX ORACLE IGNORA LOS ESPACIOS EN BLANCO
--SIN FX LOS NUMEROS EN EL ARGUMENTO CARACTER PUEDE SER OMITIDOS LOS CEROS INICIALES 
--REGLAS DE FX:
--1 La puntuación y el texto entre '' en el argumento de carácter deben coincidir exactamente con las partes correspondientes del modelo de formato
--2 NO ESPACIOS EN BLANCOS ADICIONALES EN EL ARGUMENTO STRING
--3 EL ARGUMENTO CARACTER DEBE TENER LOS MISMOS DIGITOS QUE EL FORMATO
--EN RESUMEN FX DEBE COINCIDIR EXACTAMENTE
-- el formato rr cuando la fecha es 0-49  del año actual se entiende que te refieres a una fecha proxima 
-- formato rr : cuanto la fecha es 50-99 del año actual se entiende que te refieres a una fecha del año anterior  
-- las multiplicaciones en fechas por lo general no devuelve una fecha 

--PASA LA FECHA DE TEXTO A FORMATO FECHA 
SELECT TO_DATE('November 3, 2001', 'Month dd, yyyy') AS "calculo"
from dual;

-- USO DE FX PARA INDICAR QUE EL MESS Y EL DIA ESTAN SIN ESPACIOS 
--el formato de fx debe coicidir exactamente excepto por mayusculas y minusculas 
--no debe tener espacios en blanco  
--sin fx oracle ignora los espacios en blanco extra 
--EL NUMERO DEBE TENER EL LOS MISMOS DIGITOS 
-- SIN FX SE PUEDEN OMITIR LOS CEROS A LA IZQUIERDA 
SELECT TO_DATE('May10,1989', 'fxMonDD,YYYY') AS "Convert"
FROM DUAL;

--two digit interpreted as a 2095 yy=siglo actual 
SELECT TO_DATE('27-Oct-95','DD-Mon-YY') AS "Date"
FROM dual;

--RR DATA FORMAT  interpreted as 1995
SELECT TO_DATE('27-Oct-95','DD-Mon-RR') AS "Date"
FROM dual;


--rr del 0-49  actual siglo 2000  si es 50-99 el siglo pasado 
SELECT TO_DATE('27-Oct-49','DD-Mon-RR')
AS "Date"
FROM dual;




--USO DE FX
SELECT TO_DATE('July312004', 'fxMonthDDYYYY') AS "Date"
FROM DUAL;

--USO DE FX
SELECT TO_DATE('June 19, 1990','fxMonth dd, YYYY') AS "Date"
FROM DUAL;

--USO DE FX
SELECT TO_DATE('May10,1989', 'fxMonDD,YYYY') AS "Convert"
FROM DUAL;

--CONVIERTE EL VALOR STRING A UN VALOR DE TIPO FECHA
SELECT TO_DATE('November 3, 2001', 'Month dd, yyyy') AS STRING_TO_DATE 
FROM DUAL ;

--RR DATE FORMAT AND YY DATE FORMAT     RR:SE REFIERE AL SIGLO PASADO EJEMPLO 1959   MIENTRAS QUE YY SE REFIERE AL SIGLO ACTUAL EJEMPLO 2095

-- EL AÑO ATENER 2 PUEDE Q SE INTERPRETE COMO 2095 POR EL YY 
SELECT TO_DATE('27-Oct-95','DD-Mon-YY')
AS "Date"
FROM dual;

--RR FORMAT
SELECT TO_DATE('27-Oct-95','DD-Mon-RR')
AS "Date"
FROM dual;

--CONVIERTE UNA FECHA DE CARACTER A DATO FECHA SIGUIENDO UN FORMATO  
SELECT last_name, TO_CHAR(hire_date, 'DD-Mon-YY')
FROM employees
WHERE hire_date < TO_DATE('01-Jan-90','DD-Mon-YY');


SELECT TO_DATE('2019-01-01','YYYY-MM-DD') FROM EMPLOYEES;  --convierte una cadena de texto (string) en un valor de tipo date 


SELECT INITCAP(first_name ||' '||  
UPPER(SUBSTR(first_name,-LENGTH(last_name),2)))as practica  
FROM employees
WHERE first_name = 'Alexander';

------------------------------------------------------🔵NVL FUNTION---------------------------------------------------
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

--WITH DATE VALUE 
SELECT NVL(date_of_independence,'No date')
FROM wf_countries;



--NVL VUELVE LOS NULLOS EN 0  SI commission_pct NO ES 0 ESE VALOR SE MULTIPLICA POR 250
SELECT last_name,
NVL(commission_pct, 0)*250
AS "Commission"
FROM employees
WHERE department_id IN(80,90);

------------------------------------------------------------------------------------------------------------------



------------------------------------🔵NVL2 : SYNTAXIS  NVL2 (dato1 value null/or not , dato2 value return if dato1 is not null, dato3 value replace if dato1 is null)
--EVALUA UNA EXPRESION EN 3 VALORES 
--• Si el primer valor no es nulo, la función NVL2 devuelve la segunda expresión.
--• Si el primer valor es nulo, se devuelve la tercera expresión.
--• Los valores de la expresión 1 pueden tener cualquier tipo de dato.
--• Las expresiones 2 y 3 pueden tener cualquier tipo de dato EXCEPTO LONG 
--The data type of the returned value is always the same as the
--data type of expression 2, unless expression 2 is character
--data, in which case the returned type is VARCHAR2





-----------------------------------------------------🔵NULLIF Function SYNTAXIS:NULLIF(expression 1, expression 2)------------------------------------
--USADO PARA COMPARAR
-- COMPARA DOS VALORES  SI SON IGUALES RETORNA NULL SI NO RETORNA EL VALOR 1 

--COMPARA SI LOS LENGTH DEL NOMBRE Y APELLIDO SON IDENTICOS DA NULL SI NO DEVUELVE LENGHT DEL PRIMERONOMBRE
SELECT first_name, LENGTH(first_name) AS "Length FN", last_name,
LENGTH(last_name) AS "Length LN", NULLIF(LENGTH(first_name),
LENGTH(last_name)) AS "Compare Them"
FROM employees;


------------------------------------------------🔵COALESCE Function :SYNTAXIS:COALESCE (expression 1, expression 2, ...expression n)-------------------------------- 
--DEVUELVE EL PRIMER VALOR QUE NO SEA NULL SI TODOS SON NULL DEVUELVE NULL  Y SI TODOS NO SON NULL DEVOLVERA EL PRIMERO DE LA LISTA 


--DEVUELVE EL PRIMER VALOR NO NULL 
SELECT last_name,COALESCE(commission_pct, salary, 10) AS "Comm"
FROM employees
ORDER BY commission_pct;


--------------------------------------------------🔵CONDITIONALS EXPRESION CASE Y DECODE  -----------------------------------------------------------------------
--CASE  y DECODE EXPRESSION 
--LOS TIPOS DE DATOS DE LAS EXPRESIONES  CASE, WHEN, and ELSE  DEBEN SER LAS MISMAS NUMBER NUMBER  CHAR CHAR ETC 
--DECODE ES PROPIETARIO DE ORACLE ISO99  Y CASE DE ANSI 
--si no hay else y no hay coincidencia devuelve null 


--SYNTAXIS PARA CASE : 
--CASE expr WHEN comparison_expr1 THEN return_expr1
--[WHEN comparison_expr2 THEN return_expr2
--WHEN comparison_exprn THEN return_exprn
--ELSE else_expr]
--END

--CONDICIONALES 
SELECT last_name,
CASE department_id
WHEN 90 THEN 'Management'
WHEN 80 THEN 'Sales'
WHEN 60 THEN 'It'
ELSE 'Other dept.'
END AS "Department"
FROM employees;

--SYNTAXIS PARA DECODE 
--DECODE(columnl|expression, search1, result1
--[, search2, result2,...,]
--[, default])

SELECT last_name,
DECODE(department_id,
90, 'Management',
80, 'Sales',
60, 'It',
'Other dept.')
AS "Department"
FROM employees;



--con una funcion donde convierte un numero en char para compatibilidad 
SELECT last_name,
DECODE(department_id,
90, 'Management',
80, 'Sales',
60, 'It',
20,to_char(100),
'Other dept.')
AS "Department"
FROM HR.employees;



---------------------------------------------------📌📌📌📌📌SUSTITUCION DE VARIABLES📌📌📌📌📌---------------------------------------------------
-- LAS VARIABLES PERMITEN CAMBIAR EL VALOR ESTATICO ES UTIL PARA NO ESCRIBIR NUEVO CODIGO Y PODER REUTILIZAR EL YA ESCRITO PERO CON OTROS VALORES
--:named_variable   NOMBRE DE LA VARIABLE  EL DBMS TE PEDIRA UN VALOR. 
-- NO ES NECESARIO LAS COMILLAS EN LA CLAUSURA WHERE 

--UTILIZA UNA VARIABLE :enter_dept_id  
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id=:enter_dept_id;


--DEFINE UN NOMBRE DE UNA VARIABLE ANTES DE USARLA EN UNA CONSULTA 
DEFINE &1 = '01-JAN-2020';

--SI SE EJECUTA ESTO SIN DEFINE PEDIRA UN VALOR SI SE DEFINE ANTES LA CONSULTA SE EJECUTARA 
SELECT employee_id, first_name, salary
FROM employees
WHERE hire_date > '&1';


-- consultar_empleados.sql
SELECT employee_id, first_name, salary
FROM employees
WHERE hire_date > '&1';


@consultar_empleados.sql '01-JAN-2020'
--------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------📌📌📌📌📌 SEQUENCES / Indexes Y Synonyms📌📌📌📌📌----------------------------------------------


---------------------------------------------------------------✳️Sequences✳️---------------------------------------------------------------------
--AL CREAR UNA SECUENCIA POR DEFECTO : START WITH 1 , INCREMENT BY 1,(MINVALUE 1 SI START WITH ES > A 0), NO CYCLE , MAX VALUE :10^27 ,CACHE 20 ,NOORDER 
--ES UN OBJECTO
--A SEQUENCE is a shareable object used to automatically generate unique numbers
--Typically, sequences are used to create a primary-key value
--NO USAR PARA PK ALMENOS QUE HAIGA UN MECANISMO PARA BORRAR FILAS RAPIDO 
--NEXTVAL: se utiliza para extraer números de secuencia sucesivos de una secuencia específica.
--CURRVAL: se usa luego de usar nextval para ver el valor actual asignado currval guarda el ultimo numero de la sesion nextval 
--NO SE PUEDE USAR EN SUBCONSULTA  A MENOS QUE SEA PARTE DE UN INSERT , EN UN CK CONSTRAINT ,DEFAULT,WHERE,HAVING,SELECT DENTRO DE UN VIEW 
--PUEDE SER USADO EN UN UPDATE.
--SI SE USA ROLLBACK EN INSERT ,UPDATE  EL NUMERO UTILIZADO YA NO SE PUEDE VOLVER A USAR 
--PUEDEN SER ALTERADAS CON ALTER TABLE SOLO SI SE AUMENTARA MAS ESPACIO NO MENOS DEL ANTES DEFINIDO Y NO SE CAMBIA START WITH 
--

--no pueden usarse: 
--con select list de una view 
--A SELECT statement with the DISTINCT keyword
--A SELECT statement with GROUP BY, HAVING, or ORDER BY clauses
--A subquery in a SELECT, DELETE, or UPDATE statement
--The DEFAULT expression in a CREATE TABLE or ALTER TABLEstatement




--SYNTAX:

--CREATE SEQUENCE sequence
--[INCREMENT BY n]
--[START WITH n]
--[{MAXVALUE n | NOMAXVALUE}]
--[{MINVALUE n | NOMINVALUE}]
--[{CYCLE | NOCYCLE}]
--[{CACHE n | NOCACHE}];

--sequence:          ES EL NOMBRE DEL OBJECTO DE SECUENCIA GENERADA
--INCREMENT BY n:    ESPECIFICA EL INTERVALO ENTRE LOS NUMEROS DE SECUENCIA / N ES NUMERICO ENTERO / SI ES OMITIDA POR DEFECTO ES 1 
--START WITH n:      ESPECIFICA EL PRIMER NUMERO DE SECUENCIA A SER GENERADO / POR DEFECTO ES 1 
--MAXVALUE n         ESPECIFICA EL MAXIMO VALOR QUE LA SECUENCIA PUEDE GENERAR
--NOMAXVALUE         ESPECIFICA EL MAXIMO VALOR 10^27 PARA SEQUENCIA ACENDENTE Y -1 PARA SECUENCIA DECENDENTE  
--MINVALUE n:        ESPECIFICA EL MINIMO VALOR DE SECUENCIA 
--NOMINVALUE:        Especifica un valor mínimo de 1 para una secuencia ascendente y –(10^26) para una secuencia descendente (predeterminado).
--CYCLE | NOCYCLE:   Especifica si la secuencia continúa generando valores después de alcanzar su valor máximo o mínimo./NOCYCLE(POR DEFECTO)
--CACHE n | NOCACHE: Especifica cuántos valores preasigna y guarda el servidor Oracle en memoria / POR DEFECTO:20 / SE PIERDEN SI CRASHEA SISTEMA


--You can use NEXTVAL and CURRVAL in the following contexts:
--The SELECT list of a SELECT statement that is not part of a subquery
--The SELECT list of a subquery in an INSERT statement
--The VALUES clause of an INSERT statement
--The SET clause of an UPDATE statement


--You cannot use NEXTVAL and CURRVAL in the following contexts:
--The SELECT list of a view
--A SELECT statement with the DISTINCT keyword
--A SELECT statement with GROUP BY, HAVING, or ORDER BY clauses
--A subquery in a SELECT, DELETE, or UPDATE statement
--The DEFAULT expression in a CREATE TABLE or ALTER TABLE statement

--📝📝📝📝📝📝📝📝📝📝📝📝📝📝📝📝📝📝📝

---------------------------------------------------------CREANDO SEQUENCE---------------------------------------------------------------------

--tabla de la secuencia a crear 
CREATE TABLE runners
(runner_id NUMBER(6,0) CONSTRAINT runners_id_pk PRIMARY KEY,
first_name VARCHAR2(30),
last_name VARCHAR2(30));



--CREA UNA SECUENCIA PARA UNA MARATON EMPEZANDO DESDE 1 
CREATE SEQUENCE runner_id_seq
INCREMENT BY 1
START WITH 1
MAXVALUE 50000
NOCACHE
NOCYCLE;




--PARA VER LAS SECUENCIAS 
--LAST NUMBER CON NO CACHE MUESTRA EL VALOR SIGUIENTE DE LA SEQUENCIA
--LAST NUMBER CON CACHE MUESTRA EL VALOR MAXIMO DESPUS DEL CACHE DEFINIDO EJEMPLO CACHE 20 MUESTRA 21 
SELECT sequence_name, min_value, max_value, increment_by,last_number
FROM user_sequences;

--VERIFICAR SECUENCIA DE LA TABLA USER_SEQUENCES (SOLO SI ESTA FUE CREADA CON NO CACHE )
SELECT sequence_name, min_value, max_value, last_number AS "Next number"
FROM USER_SEQUENCES
WHERE sequence_name = 'RUNNER_ID_SEQ';


--PARA VERIFICAR LA SECUENCIA 
SELECT runner_id, first_name, last_name
FROM runners;

--MUESTRA LA ULTIMASECUENCIA 
SELECT runner_id_seq.CURRVAL
FROM dual;

--GENERA UN NUEVO DEPARTAMENTO 
INSERT INTO departments
(department_id, department_name, location_id)
VALUES (departments_seq.NEXTVAL, 'Support', 2500);


--PARA INSERTAR TODOS LOS NUEVOS EMPLEADOS
INSERT INTO employees
(employee_id, department_id)
VALUES (employees_seq.NEXTVAL, dept_deptid_seq .CURRVAL);
-------------------------------------------------------------------------currval use -------------------------------------------------
-- 1️⃣ Crear un nuevo departamento
INSERT INTO departments (department_id, department_name)
VALUES (dept_deptid_seq.NEXTVAL, 'Recursos Humanos');

-- 2️⃣ Insertar un empleado en ese mismo departamento
INSERT INTO employees (employee_id, department_id)
VALUES (employees_seq.NEXTVAL, dept_deptid_seq.CURRVAL);
-----------------------------------------------------------------------------------------------------------------------------------

--INSERTA UN NUEVO CORREDOR A LA SECUENCIA 
INSERT INTO runners
(runner_id, first_name, last_name)
VALUES (runner_id_seq.NEXTVAL, 'Joanne', 'Everely');

--INSERTA NUEVO CORREDOR 
INSERT INTO runners
(runner_id, first_name, last_name)
VALUES (runner_id_seq.NEXTVAL, 'Adam', 'Curtis');

--VERIFICA LA INSERCION 
SELECT runner_id, first_name, last_name
FROM runners;

SELECT runner_id_seq.CURRVAL
FROM dual;

--SI FUE CREADA CON NOCACHE SE PUEDE VER EL  SIGUIENTE VALOR DE UNA SECUENCIA 
SELECT sequence_name, min_value, max_value, last_number AS
"Next number"
FROM USER_SEQUENCES
WHERE sequence_name = 'RUNNER_ID_SEQ';


--CAMBIAR UNA SECUENCIA (NO SE PUEDE CAMBIAR SI EL MAX VALUE ES MENOR DEL QUE SE CREO)
--START WITH OPTION NO SE PUEDE CAMBIAR 
ALTER SEQUENCE runner_id_seq
INCREMENT BY 1
MAXVALUE 999999
NOCACHE
NOCYCLE;

--BORRA UNA SECUENCIA
DROP SEQUENCE runner_id_seq;


---------------------------------------------------------------------------- ✳️ INDEXES ✳️ --------------------------------------------------

--ES UN OBJECTO DE ESQUEMA QUE ACELERA LA FORMA DE OBTENER INFORMACION DE TABLAS CONO PUNTERO 
--SE PUEDEN CREAR EXPLICITAMENTE O AUTOMATICAMENTE al crear una pk o uk 
--REDUCE LA NECESIDAD DE DISCO AL LEER INFORMACION AL HAVER INDEXES VA DIRECTO A LA INFORMACION 
--USAN ROWSID
--USER_INDEXES data dictionary view   PARA VER LOS INDICES  USER_IND_COLUMNS view
--ORACLE TRATA LOS INDICES COMO :CREATE INDEX emp_idx4 ON employees (salary DESC); (COMO INDICE BASADO EN FUNCION POR EL DESC) SIN ESO LO TRATA COMO NORMAL ACENDENTE DEFAULT

--DOS TIPOS DE INDICES : UNIQUE INDEX - NOUNIQUE INDEX 
--UNIQUE INDEX : SE CREA SOLA AL DEFINIR UNA COLUMNA EN LA TABLA PK (EL NAME DEL INDEX ES EL DE LA CONSTRAINT)
--NO UNIQUE : ES EL INDEX  QUE CREA UN USUARIO 

---💡​CONDICIONES PARA CREAR UN  INDEX EN TU SCHEMA: 
--The table must be in your own schema
--You must have the INDEX object privilege on the table to be indexed.
--You must have the CREATE ANY INDEX system privilege.
--para crear cualquier index debes tener create any index privilege 


--💡CUANDO CREAR UN INDEX ?
--The column contains a wide range of values
--A column contains a large number of null values
--One or more columns are frequently used together in a  WHERE clause or a join condition
--The table is large and most queries are expected to retrieve less than 2-4% of the rows(osea la tabla tiene muchos registros pero no usas todos )


--💡CUANDO NO CREAR UN INDEX ?
--•When deciding whether or not to create an index,
--more is not always better

--•Each DML operation (INSERT, UPDATE, DELETE) that is
--performed on a table with indexes means that the
--indexes must be updated

--•The more indexes you have associated with a table, the
--more effort it takes to update all the indexes after the
--DML operation

--•The table is small
--•The columns are not often used as a condition in the query
--•Most queries are expected to retrieve more than 2-4 % of the rows in the table
--•The table is updated frequently
--•The indexed columns are referenced as part of an expression

--💡UQ INDEX 
--Los índices compuestos pueden acelerar la recuperación de datos para las instrucciones SELECT en las que la cláusula 
--WHERE hace referencia a todas o a la parte inicial de las columnas del índice compuesto.

--•Null values are not included in the composite index
--•To optimize joins, you can create an index on the
--FOREIGN KEY column, which speeds up the search to
--match rows to the PRIMARY KEY column
--•The optimizer does not use an index if the WHERE
--clause contains the IS NULL expression


--CREANDO UN INDEX 
CREATE INDEX index_name
ON table_name( column,column);

--CREANDO INDEX 
CREATE INDEX wf_cont_reg_id_idx
ON wf_countries(region_id);

--COMPOSITE INDEX 
CREATE INDEX emps_name_idx
ON employees(first_name, last_name);

--VER LOS INDEXES 
SELECT DISTINCT ic.index_name, ic.column_name,ic.column_position, id.uniqueness
FROM user_indexes id, user_ind_columns ic
WHERE id.table_name = ic.table_name
AND ic.table_name = 'EMPLOYEES';

---------------------------------------------------------------------------------------- INDEX BASED FUNCTION -----------------------------------------------------------
--The index expression is built from table columns,
--constants, SQL functions, and user-defined functions
--EL INDICE CREADO PARA UNA FUNCION DEBE MATCHEAR 
--be sure that the value of the function is not null in subsequent queries 
--SI HACEMOS UNA CONSULTA USANDO UNA FUNCION Y USAMOS UNA UNA COLUMNA INDEXADA  ORACLE NO LA USARA YA QUE DEBE CREARSE (BASED FUNTION INDEX)   
--NO SE PUEDEN USAR FUNCIONES MULTIROW 



--crea un índice basado en una función en Oracle SQL (indexa el resultado )
CREATE INDEX upper_last_name_idx
ON employees (UPPER(last_name));


--SE HACE LA CONSULTA Y RESULTA MAS RAPIDA GRACIAS AL INDICE DE FUNCION  
SELECT *
FROM employees
WHERE UPPER(last_name) = 'KING';


--
SELECT *
FROM employees
WHERE UPPER(last_name) LIKE 'KIN%';


--SE ASEGURA QUE LA BUSQUEDA NO SEA NULL PORQUE SI NO HARA FULL TABLE SCAN
SELECT *
FROM employees
WHERE UPPER (last_name) IS NOT NULL
ORDER BY UPPER (last_name);



--FULL TABLE SCAN 
SELECT first_name, last_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'yyyy') = '1987';

--CREANDO INDEX EN FUNCION TO CHAR PARA QUE PERMITA EL COMANDO DE ARRIVA SIN REALIZAR BUSQUEDA COMPLETA 
CREATE INDEX emp_hire_year_idx
ON employees (TO_CHAR(hire_date, 'yyyy'));



----------------------------------------------------------------BORRAR UN INDICE----------------------------------------------
--AL REMOVER UN INDEX LAS VISTAS Y LAS SECUENCIAS PERMANECEN 
--DEBES SER EL DUEÑO DEL INDICE 
--O TENER PRIVILEGIOS 
--•If you drop a table, indexes and constraints are
--automatically dropped, but views and sequences
--remain

DROP INDEX upper_last_name_idx;

DROP INDEX emps_name_idx;

DROP INDEX emp_hire_year_idx;

----------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------✳️SYNONYM✳️---------------------------------------------------------------------
--En SQL, como en el lenguaje, un sinónimo es una palabra o expresión que es un sustituto aceptado de otra palabra.
--FACILITA ACCESO A OBJETOS DANDOLE OTRO NOMBRE 
--PUEDE HACER REFERENCIA A TABLAS PERTENECIENTE A OTROS USUARIOS 
--SE PUEDE USAR CON OBJECTOS COMO : table, view, sequence,procedure, or other object
--PUENDEN SER PUBLICOS , EL OBJECTO NO DEBE ESTAR CONTENIDO EN PACKETE 
--A private synonym name must be distinct from all other objects owned by the same user

--USMA_SBHS_SQL01_S04.amy_copy_employees

--CREA UN SYNONYM PUBLICO 
CREATE PUBLIC SYNONYM synonym_table_view_test_certification
FOR object;


--CREA UN SYNONYM PUBLICO 
CREATE SYNONYM synonymSXD
FOR object;

--EJEMPLO SYNONIMO PARA EL OBJECTO amy_copy_employees
CREATE SYNONYM amy_emps
FOR amy_copy_employees;


--BORRA UN SYNONYM PUBLICO
DROP PUBLIC SYNONYM name_of_synonym

--BORRA UN SYNONIM PRIVADO
DROP SYNONYM amy_emps;

--SE PUEDEN VER EN EL DICCIONARIO DE USO DE DATOS 
SELECT Synonym_name,Table_name,Table_owner,Db_link
FROM USER_SYNONYMS;


--Synonym_name Name of the synonym.
--Table_name Owner of the object referenced by the synonym.
--Table_owner Name of the object referenced by the synonym.
--Db_link Database link referenced in a remote synonym.


-------------------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------------------------------------------------------------------




----------------------------------------------------------📌📌📌 JOINS / UNION📌📌📌📌📌----------------------------------------------

-- EL WHERE VA LUEGO DE TODAS LAS CLAUSURAS JOIN 
--HAY DOS FORMAS DE JOIN : ORACLE PROPIETARY JOINS(OLD)  Y ANSI ISO SQL99 (NEW)
-- SERIAN NECESARIAS 2 CLAUSURAS JOIN PARA UNIR 3 TABLAS 
--LA UNION DE 2 TABLAS QUE DEVUELVEN FILAS COINCIDENTES SE LE CONOCE COMO (INNER JOIN ) INNER join. (NATURAL JOIN,USING, ON clauses)

--🔵TIPOS DE JOIN  : inner join ,selft join,right join ,left join ,full join,cross join,natural join,join using 

---------------✳️INNER JOIN o JOIN  (INNER ES OPCIONAL ):  (UNION INTERNA)
--TRAE LOS SOLO LOS DATOS QUE COINCIDAN (IGNORA NULLS)

--SYNTAXIS CON INNER JOIN
SELECT e.first_name,e.last_name
FROM employees e  inner join departments d 
on e.department_id=d.department_id;
--SYNTAXIS CON JOIN Y CONDICION AND 
SELECT e.employee_id, e.last_name, e.department_id,
d.department_id, d.location_id
FROM employees e JOIN departments d
ON (e.department_id = d.department_id)
AND e.manager_id = 149 ;


--SYNTAXIS CON JOIN Y FILTRADO WHERE CON LIKE
SELECT last_name, job_title
FROM employees e JOIN jobs j
ON (e.job_id = j.job_id)
WHERE last_name LIKE 'H%';

--JOIN SIN UNA CONDICION JOIN NORMAL 
SELECT DISTINCT  FIRST_NAME,SALARY,MIN_SALARY, MAX_SALARY
FROM employees JOIN JOBS
ON SALARY BETWEEN MIN_SALARY AND MAX_SALARY; 

-------------------------------------✳️NATURAL JOIN :(UNION NATURAL)  -----------------------------------------------------------
--ENTRA DENTRO DE LA SYNTAXIS ANSI ISO SQL99                
--UNE TODAS LAS COLUMNAS COINCIDENTES DE UNA TABLA  CON LA OTRA (NO ES NECESARIO ALIAS)
--LOS NOMBRES Y TIPOS DE DATOS DE CADA COLUMNA DEBEN SER LA MISMA o compatibles
--LA UNION SE DA POR LAS COLUMNAS QUE TENGAN EL MISMO TIPO DE DATO Y NOMBRE 
--LA CLAUSURA WHERE DEBE IR DEPUES DEL USO DE NATURAL JOIN 
 
--UNE POR COLUMNA NATURAL FILTRA ID MAYORES A 80
SELECT first_name, last_name, job_id, job_title
FROM employees NATURAL JOIN jobs
WHERE department_id > 80;

--UNE POR COLUMNA NATURAL ENTRE AMBAS TABLAS 
SELECT FIRST_NAME,LAST_NAME,DEPARTMENT_NAME
FROM EMPLOYEES NATURAL JOIN DEPARTMENTS;

--NATURAL JOIN : ESTA VEZ NO SALE EN EL SELECT LA COLUMNA EN COMUN POR LA CUAL SE UNEN LAS TABLAS 
SELECT department_name, city
FROM departments NATURAL JOIN locations;



---------------------------------------------------✳️JOIN USING:✳️--------------------------------------------------------------------------
--SE USA PARA ESPECIFICAR LA COLUMNA POR LA CUAL SE UNIRAN LAS TABLAS 
--USING PERMITE COLOCAR UN CALIFICADOR ES DECIR TABLA.COLUMNA A LA COLUMNA QUE APARECE EN LA CLAUSULA USING 
--SE PUEDEN ESPECIFICAR VARIAS COLUMNAS ,SE PUEDE UNIR POR TIPOS DE DATOS DIFERENTES (NO DESEABLE)

--JOIN USING : UNION POR LA COLUMNA DEPARTMENT_ID
SELECT first_name, last_name, department_id, department_name
FROM employees JOIN departments  USING (department_id);

--JOIN USING : CON CLAUSURA WHERE
SELECT first_name, last_name, department_id, department_name
FROM employees JOIN departments USING (department_id)
WHERE last_name = 'Higgins';

--USANDO ALIAS EN LAS COLUMNAS (SIN CALIFICADORES)
SELECT FIRST_NAME AS NOMBRE, LAST_NAME AS APELLIDO ,DEPARTMENT_ID AS ID_DEP 
FROM EMPLOYEES JOIN DEPARTMENTS USING (department_id);

--USANDO CUALIFICADORES (NO EN LA COLUMNA QUE USA USING XQ SERIA ERROR )
SELECT E.FIRST_NAME AS NOMBRE, E.LAST_NAME AS APELLIDO  
FROM EMPLOYEES E JOIN DEPARTMENTS D USING (department_id);


-------------------------------------------------------✳️CROSS JOIN : ✳️ --------------------------------------------------------------     
--PERTENECE A SQL ANSI ISO SQL 99             
--UNE LAS TABLAS CON UN PRODUCTO CRUSADO DE LAS COLUMNAS DE AMBAS TABLAS EJEMPLO 10 DE UNA Y 20 DE OTRA SERIAN 20X10 = 200 COMBINACIONES  
--SE COMBINAN LAS FILAS 
--NO REQUIERE ESPECIFICAR LAS COLUMNAS POR LAS CUALES SE UNIRAN YA QUE TODAS SE COMBINARAN 

-- CROSS JOIN : UNE 20X8 FILAS = 160 FILAS 
SELECT last_name, department_name
FROM employees CROSS JOIN
departments;


-----------------------------------------------------✳️FULL OUTER JOIN ✳️--------------------------------------------------------------------------
--MUESTRA TODOS LOS DATOS DE LA TABLA IZQUIERDA Y DERECHA QUE COINCIDEN Y LOS QUE NO SERAN NULL 
--UNION DE AMBAS TABLAS SIN DUPLICACION 
--CON EL OUTER 
SELECT e.last_name, d.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id);
--SIN EL OUTER HACE EXATAMENTO LO MISMO
SELECT e.last_name, d.department_id, d.department_name
FROM employees e FULL JOIN departments d
ON (e.department_id = d.department_id);




--------------------------------------------------✳️UNION DE 3 TABLAS ✳️-----------------------------------------------------------
--PARA UNIR 3 TABLAS PUEDES USAR (USING,JOIN)
--USING PUEDE SERVIR AL IGUAL QUE ON .
SELECT last_name, department_name AS "Department", city
FROM employees JOIN departments USING (department_id)
JOIN locations USING (location_id);

--UNION DE 3 TABLAS CON ON
SELECT b.title as "BOOK TITLE",
a.name as "AUTHOR",
t.id as "BOOK TRANSACTION"
FROM authors a JOIN books b
ON a.id = b.author_id
JOIN book_transactions t
ON b.id = t.book_id;



--UNE 3 TABLAS CON LEFT JOIN Y INNER JOIN 
SELECT e.last_name, d.department_name, l.city
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
INNER JOIN locations l ON d.location_id = l.location_id;



--------------------------------------------------------✳️LEFT OUTER JOIN o LEFT JOIN ✳️: ---------------------------------------
--ansi sql99 retorna filas de valores que matchean y no matchean 
--DEVUELVE TODOS LOS REGISTROS DE LA TABLA IZQUIERDA  
--Y TODOS LOS REGISTROS COINCIDENTES DE LA TABLA DERECHA SI NO HAY DEJA NULL
--LA PALABRA OUTER PUEDE OMITIRSE  

--LEFT OUTER JOIN 
SELECT e.last_name, d.department_id,
d.department_name
FROM employees e LEFT OUTER  JOIN
departments d
ON (e.department_id =d.department_id);


------------------------------------------------------✳️RIGHT OUTER JOIN O RIGHT JOIN✳️----------------------------------------- 
--DEVUELVE TODOS LOS REGISTROS DE LA TABLA DERECHA Y LOS QUE COINCIDAN CON LA TABLA IZQUIERDA
--EL OUTER TAMBIEN ES OPCIONAL 

--RIGHT OUTER JOIN
SELECT e.last_name, d.department_id,d.department_name
FROM employees e RIGHT OUTER JOIN
departments d
ON (e.department_id =d.department_id);


--RIGHT OUTER JOIN : VER TODOS LOS DEPARTAMENTOS AUN ASI NO TENGAN ASIGNADO UN EMPLEADO
SELECT *
FROM empleados e
RIGHT OUTER JOIN departamentos d
ON e.departamento_id = d.departamento_id;


-----------------------------------------------------------------✳️SELF JOIN CLAUSE✳️-------------------------------------------------------
-- ESTE TIPO DE JOIN UNE UNA TABLA CON ELLA MISMA USANDO DOS ALIAS DIFERENTES PARA LA MISMA TABLA  

--SELF JOIN UNE DOS COLUMNAS DE LA MISMA TABLA O DIFERENTES TABLAS 
SELECT worker.last_name emp, manager.last_name mgr
FROM employees worker JOIN employees manager
ON worker.manager_id = manager.employee_id;



SELECT worker.last_name ||'work for' || manager.last_name
AS "Works for"
FROM employees worker JOIN employees manager
ON (worker.manager_id = manager.employee_id);

--------------------------------------------------------------------------------------------------------------------------



------------------------------------------------------------✳️Hierarchical✳️---------------------------------------------------
--la poda de ramas se puede hacer con clausura where o Pruning branches from the tree can be done using CONNECT BY PRIOR (poda la rama entera )

--emieza con employe id 100 luego los conecta buscando sus hijos y asi va ordenandolos  ejemplo busca los empleados con manager id 100  
SELECT employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id;


SELECT last_name ||' reports to ' || PRIOR last_name AS "Walk
Top Down"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id;


SELECT LEVEL, last_name ||
' reports to ' ||
PRIOR last_name
AS "Walk Top Down"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR
employee_id = manager_id;


-- el level numera una columna  luego la colummna se multiplica por 2  y se restan 2 porque si no el primero tendria sangria y no deberia porque es el mas alto de la herarquia 
SELECT LPAD(last_name, LENGTH(last_name)+(LEVEL*2)-2,'_')
AS "Org Chart"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id;


--forma de exclusion de clausura where (no ideal )
SELECT last_name
FROM employees
WHERE last_name != 'Higgins'
START WITH last_name = 'Kochhar'
CONNECT BY PRIOR employee_id = manager_id;

-- en este caso se poda la rama completa 
SELECT last_name
FROM employees
START WITH last_name = 'Kochhar'
CONNECT BY PRIOR employee_id = manager_id
AND last_name != 'Higgins';


-----------------------------------------------------✳️EQUIJOIN✳️-----------------------------------------------
--EQUIVALENTE A −NATURAL JOIN
--JOIN USING
--JOIN ON (when the join condition uses "=")
-- si no existe join condition devuelve un producto cartesiano equivalente a cross join 

--SYNTAXIS EQUIJOIN 
SELECT employees.last_name, employees.job_id, jobs.job_title
FROM employees, jobs
WHERE employees.job_id = jobs.job_id;

--UNION DE 3 TABLAS CON AND 
SELECT last_name, city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;

-- con aliases 
SELECT last_name, e.job_id, job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id
AND department_id = 80;

--no se especifico la join condition 
SELECT employees.last_name, departments.department_name
FROM employees, departments;



--unir tres tablas con la syntaxis oracle legacy 
SELECT last_name, city
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id
AND d.location_id = l.location_id;

-----------------------------------------------------------------✳️NONEEQUIJOIN✳️---------------------------------------------------- 
--UNE TABLAS QUE NO TIENEN RELACIONES (COLUMNAS EN COMUN)<= and >= can be used, BETWEEN...AND
--SIMILAR A JOIN ON


--ORACLE PROPIETARI JOINS  SYNTAX 
SELECT table1.column, table2.column
FROM table1, table2
WHERE table1.column1 = table2.column2;


SELECT last_name, salary, grade_level, lowest_sal,highest_sal
FROM employees, job_grades
WHERE (salary BETWEEN lowest_sal AND highest_sal);





-------------------------------------------------✳️OUTER JOIN (Oracle Syntax)✳️ ----------------------------------------------------------
--UNE 2 TABLAS PERO USA MAS CALUSURAS COMO GROUP BY HAVING Y ORDER BY 
SELECT d.department_name, COUNT(e.employee_id) AS total_empleados
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 3
ORDER BY total_empleados DESC;



-------------------------------------------------✳️LEFT OUTER JOIN - RIGHT OUTER JOIN (Oracle Syntax)✳️ --------------------------------------------------------
--EQUIVALENTE AL LEFT JOIN 

--EL + AL IR A LA DERECHA INDICA QUE PRESERVA LA TABLA EMPLEADOS 
--SI VA AL LADO IZQUIERDO QUIERE DECIR RIGHT JOIN 


--LEFT OUTER JOIN ORACLE SYNTAX 
SELECT e.last_name,d.department_id,d.department_name
FROM employees e, departments d
WHERE e.department_id =d.department_id(+);



--PRESERVA LA TABLA EMPLOYEES ES UN RIGHT JOIN 
SELECT e.last_name,d.department_id,d.department_name
FROM employees e, departments d
WHERE e.department_id(+)=d.department_id;

--------------------------------------------
--full outer join no existe en oracle syntax 
--------------------------------------------


-----------------------------------------------✳️JOINS CON OTRAS CLAUSURAS-✳️------------------------------------------------ 
--JOIN CON GROUP BY,HAVING,ORDER BY 
SELECT d.department_name, COUNT(e.employee_id) AS total_empleados
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 3
ORDER BY total_empleados DESC;

-----------------------------------------------✳️✳️------------------------------------------------ 






-------------------------------------------------------------------RESUMEN-----------------------------------------------------------------
--| Tipo de JOIN     |                    Qué hace  ?                              |                 
--| ---------------- | ----------------------------------------------------------- |
--| INNER JOIN       | Solo filas coincidentes                                     |
--| LEFT OUTER JOIN  | Todo de la izquierda + coincidentes de la derecha           |
--| RIGHT OUTER JOIN | Todo de la derecha + coincidentes de la izquierda           |
--| FULL OUTER JOIN  | Todos los registros de ambas tablas                         |
--| CROSS JOIN       | Producto cartesiano                                         |
--| NATURAL JOIN     | Une automáticamente por columnas con el mismo nombre y tipo |
--| JOIN USING       | Une por columnas comunes especificadas                      |
--| SELF JOIN        | Une una tabla consigo misma                                 |


--------------------------JOINS TABLAS SIN RELACION---------------------------------
--CROSS JOIN
--POR CONDICIONES COMO BETWEEN 
-- 1=1 (ES COMO CROSS JOIN)



--| Cláusula   | ¿Se puede combinar? | Comentario                    |
--| ---------- | ------------------- | ----------------------------- |
--| `WHERE`    | ✅ Sí                | Para filtrar después del JOIN |
--| `GROUP BY` | ✅ Sí                | Para agrupar resultados       |
--| `HAVING`   | ✅ Sí                | Para filtrar sobre grupos     |
--| `ORDER BY` | ✅ Sí                | Para ordenar el resultado     |
--| `DISTINCT` | ✅ Sí                | Para eliminar duplicados      |



--------------------------------------------------✳️CLAUSULA UNION(UNION /INTERSECT / MINUS / UNION ALL )✳️---------------------------------------------------------------------------
--UNION CLAUSURA UNE LAS CONSULTAS EN UNA SOLA COLUMNA ES DECIR UNA DEBAJO DE OTRA TOMA EN CUENTA EL NOBMRE DEL PRIMER SELECT 
--UNION : RETORNA TODAS LAS FILAS DESPUES DE ELIMINAR DUPLICADOS 
SELECT JOB_ID AS UNIDOS FROM JOBS 
UNION 

SELECT JOB_TITLE FROM JOBS 
ORDER BY UNIDOS;


--RETORNA TODAS LAS FILAS INCLUSO REPETIDAS 
SELECT JOB_ID AS UNIDOS FROM JOBS 
UNION ALL 
SELECT JOB_TITLE FROM JOBS 
ORDER BY UNIDOS;



--UNION ORDENANDO LOS VALORES POR VALOR, TIPO
SELECT JOB_ID AS valor, 'ID' AS tipo FROM JOBS
UNION
SELECT JOB_TITLE, 'TITLE' FROM JOBS
ORDER BY tipo, valor;


SELECT 3 from JOBS 
UNION 
SELECT 4  FROM JOBS
ORDER BY 1;  


--INTERSECT : SOLO UNE LAS FILAS COMUNES PARA AMBAS TABLAS 
SELECT 3 from JOBS 
INTERSECT
SELECT 4  FROM JOBS
ORDER BY 1;  


--MINUS : DEVUELVE TODAS LAS FILAS ENCONTRADAS EN UNA TABLA PERO NO EN LA OTRA 
SELECT 3 from JOBS 
MINUS
SELECT 4  FROM JOBS
ORDER BY 1;  


--UNION DE 2 TABLAS DONDE UNA TABLA NO TIENE COLUMNA EN COMUN 
SELECT hire_date, employee_id, job_id FROM employees
UNION
SELECT TO_DATE(NULL),employee_id,job_id
FROM job_history;





--✳️Hierarchical Queries

--EMPIEZA POR EL EMPLEADO CON ID 100 Y BUSCA LOS SUBORDINADOS DIRECTOS Y LUEGO LOS SUBORDINADOS DE LOS SUBORDINADOS HASTA LLEGAR AL LVL BAJO 
SELECT employee_id, last_name, job_id, manager_id
FROM employees
START WITH employee_id = 100
CONNECT BY PRIOR employee_id = manager_id;



--MUESTRA LA GERARQUIA A QUIEN DEBEN REPORTARSE 
SELECT last_name ||' reports to ' || PRIOR last_name AS "Walk Top Down"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id;


--CUENTA EL NIVEL DE CADA EMPLEADO SEGUN LA GERARQUIA ES DECIR LOS PONE EN SUS NIVELES 1 2 3 ETC 
SELECT LEVEL, last_name ||
' reports to ' ||
PRIOR last_name
AS "Walk Top Down"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR
employee_id = manager_id;


--AGREGA UNA _  A LA IQUIERDA SEGUN SU NIVEL DE ERARQUIA 
SELECT LPAD(last_name, LENGTH(last_name)+
(LEVEL*2)-2,'_') AS "Org_Chart"
FROM employees
START WITH last_name = 'King'
CONNECT BY PRIOR employee_id = manager_id;


--MUESTRA DE EMPLEADO A GERENTE 
SELECT LPAD(last_name, LENGTH(last_name) +
(LEVEL*2)-2, '_') AS ORG_CHART
FROM employees
START WITH last_name = 'Grant'
CONNECT BY employee_id = PRIOR manager_id;


--ELIMINA UNA RAMA DE LA HERARQUIA DONDE ESTE  Higgins AFECTARA UN REGISTRO DE LA FILA 
SELECT last_name
FROM employees
WHERE last_name != 'Higgins'
START WITH last_name = 'Kochhar'
CONNECT BY PRIOR employee_id = manager_id;

--ELIMINA TODA LA RAMA 
SELECT last_name
FROM employees
START WITH last_name = 'Kochhar'
CONNECT BY PRIOR employee_id = manager_id
AND last_name != 'Higgins';



 


----------------------------------------------------------📌 7. ALTER TABLE 📌-----------------------------------------------------------------
-- los constrains pueden ser agregados al crear la tabla o despues mediante el alter table.


---------------------------------------------✳️ALTER TABLE ADD COLUMN✳️-------------------------------------------------------

ALTER TABLE my_cd_collection
ADD (release_date DATE DEFAULT SYSDATE);


ALTER TABLE my_friends
ADD (favorite_game VARCHAR2(30));





---------------------------------------------✳️ALTER TABLE MODIFY✳️-------------------------------------------------------
--REGLAS
--You can increase the width or precision of a numeric column
--You can increase the width of a character column
--You can decrease the width of a NUMBER column if the
--column contains only null values, or if the table has no rows
--For VARCHAR types, you can decrease the width down to the
--largest value contained in the column

--You can change the data type only if the column
--contains null values
--• You can convert a CHAR column to VARCHAR2 or
--convert a VARCHAR2 COLUMN to CHAR only if the
--column contains null values, or if you do not change
--the size to something smaller than any value in the column
--A change to the DEFAULT value of a column affects only later insertions to the table




ALTER TABLE mod_emp
MODIFY (last_name VARCHAR2(30));

ALTER TABLE mod_emp
MODIFY (last_name VARCHAR2(10));

ALTER TABLE mod_emp
MODIFY (salary NUMBER(10,2));

ALTER TABLE mod_emp
MODIFY (salary NUMBER(8,2) DEFAULT 50);



--------------------------------------------------✳️ALTERTABLE DORP✳️-----------------------------------------------

ALTER TABLE tablename
DROP COLUMN column_name;


ALTER TABLE my_cd_collection
DROP COLUMN release_date;

ALTER TABLE my_friends
DROP COLUMN favorite_game;



----------------------------------------------✳️DROP TABLE✳️-----------------------------------------------
--PUEDE RECUPERARSE PERO NO HAY GARANTIA 
--POR RAZONES DE SEGURIDAD SE DEBE ELIMINAR UNA TABLA SIN PASAR POR LA PAPELERA 

DROP TABLE tablename;


DROP TABLE copy_employees;

--RECUPERAR TABLA 
FLASHBACK TABLE tablename TO BEFORE DROP;

SELECT original_name, operation, droptime
FROM user_recyclebin;

--LA ELIMINA PERMANENTEMENTE SIN QUEDAR EN PAPELERA 
DROP TABLE copy_employees PURGE;


----------------------------------------------------------✳️SET UNUSED COLUMNS✳️ ---------------------------------------------

ALTER TABLE tablename SET UNUSED (column_name);

ALTER TABLE copy_employees
SET UNUSED (email);

ALTER TABLE copy_employees
DROP UNUSED COLUMNS;



-------------------------------------------------------------✳️TRUCATE✳️-------------------------------------------------------------------------------------------
--You cannot roll back row removal
--You must be the owner of the table or have been given DROP
--ANY TABLE system privileges
--DELETE NO LIBERA EL ESPACIO 

TRUNCATE TABLE tablename;


-----------------------------------------------------------------------✳️ ALTER SEQUENCE ✳️-------------------------------------------------------------------------

--CUANDO UNA SECUENCIA LLEGUE A SU LIMITE SE PUEDE ALTERAR PARA AGREGAR MAS ESPACIOS (DE SER MAYOR AL VALOR DEFINIDO ANTES ) Y NO MODIFICAR START WITH 
ALTER SEQUENCE runner_id_seq
INCREMENT BY 1
MAXVALUE 999999
NOCACHE
NOCYCLE;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------✳️RENAME✳️------------------------------------------------------------------

RENAME old_name to new_name;

RENAME my_cd_collection TO my_music;

--------------------------------------------------------------✳️ALTER TABLE CONSTRAINTS✳️-------------------------------------------------------------------------------------



--AGREGA UNA NUEVA COLUMNA 
ALTER TABLE my_cd_collection
ADD (release_date DATE DEFAULT SYSDATE);


-- AGREGA UNA COLUMNA 
ALTER TABLE my_friends
ADD (favorite_game VARCHAR2(30));


--se usa modify porque es a nivel de columna el not null 
ALTER TABLE table_name
MODIFY (column_name CONSTRAINT constraint_name NOT NULL);


--agrega una llave primaria 
ALTER TABLE empleados 
ADD CONSTRAINT pk_empleado PRIMARY KEY (id_empleado);   


--agrega restricion de que el salario debe ser mayor a 0
ALTER TABLE empleados
ADD CONSTRAINT chk_salario CHECK (salario > 0);        


--agrega una restricion que el correo debe ser unico (no repetirse)
ALTER TABLE empleados
ADD CONSTRAINT uq_correo UNIQUE (correo);               


--SE MODIFICA: VALOR POR DEFECTO,TIPO DE DATO,TAMAÑO,CONSTRAINT                 
ALTER TABLE employees 
MODIFY first_name VARCHAR2(30);                         


--SE QUITA UNA COLUMNA DE LA TABLA
ALTER TABLE employees
DROP (termination_date);  



ALTER TABLE dept SET UNUSED (dname);                                          --MARCA EN DESHUSO UNA COLUMNA NO ADMITE CONSULTAS
ALTER TABLE dept DROP UNUSED COLUMNS;                                         --ELIMINA TODAS LAS COLUMNAS QUE FUERON MARCADAS COMO DESHUSO
ALTER TABLE dept READ ONLY;                                                   --PONE UNA TABLA EN MODO LECTURA
ALTER TABLE dept READ WRITE;                                                  --CAMBIA DE MODO LECTURA A ESCRITURA 




---------------------------------------------------------✳️ DROP, DISABLE,ENABLE CONSTRAINTS✳️-------------------------------------------------------------
--NO HAY DATOS AFECTADOS 
--DESABILITAR UN UK O PK  REMUEVE EL UQ INDEX 
--SI HABILITAS UN CONSTRAINT PK  EL INDEX SE CREA AUTOMATICAMENTE 

--ELIMINA UN CONSTRAINT
ALTER TABLE copy_departments
DROP CONSTRAINT c_dept_dept_id_pk CASCADE;


-- DESABILITACION DE CONSTRAINT DURANTE LA CREACION DE TABLA 
--CREATE TABLE copy_employees
--( employee_id NUMBER(6,0) PRIMARY KEY DISABLE,
--...
--...);

--DESABILITA UN CONSTRAINT 
ALTER TABLE copy_employees
DISABLE CONSTRAINT c_emp_dept_id_fk;



--SE USA PARA CUANDO EN LA TABLA PADRE TIENE UNA TABLA HIJO  OSEA DEPENDEN DE EL 
--ALTER TABLE table_name
--DROP column_name CASCADE CONSTRAINTS;


--SE USA EN EL CASO DE COMO YA NO HAY TABLAS HIJAS QUE DEPENDAN DE LA PADRE ENTONCES NO ES NECESARIO EL CASCADE 
--ALTER TABLE tablename DROP
--pk_column_name(s);


--SIRVE PARA VER LAS CONSTRAINTS 
SELECT constraint_name, table_name, constraint_type, status
FROM USER_CONSTRAINTS
WHERE table_name ='COPY_EMPLOYEES';




---------------------------------------📌 9. DROP_TABLE,DELETE_TABLE,TRUNCATE_TABLE 📌----------------------------------------------

-- DROP Y DELETE DIFERENCIAS  
--DELETE TRABAJA A NIVEL DENTRO DE LA TABLA  MIENTRAS QUE DROP TRABAJA A NIVEL DE OBJETO

--POR LO GENERAL SUS DEPENDENCIAS Y REFERENCIAS QUEDAN INABILITADAS 

--ELIMINA UNA TABLA(NO POR COMPLETO VA A PAPAELERA)
DROP TABLE dept;   

--ELIMINA LA TABLA POR DEFINITIVO                                                            
--DROP TABLE PURGE dept;                                                      



TRUNCATE TABLE copy_employees;                                                 --ELIMINA TODAS LAS FILAS DE UNA TABLA.



---------------------------------------📌📌📌 10.DML INSERT / UPDATE / DELETE / ALTER /MERGE / DROP 📌📌📌----------------------------------------------


-------------------------------------------------------✳️ INSERT ✳️---------------------------------------------------

--CREAR COPIA DE UNA TABLA ANTES DE REALIZAR OPERACIONES DE DML 
--PARA LA FORMA EXPLICITA DEBEN COLOCARSE LOS NOMBRES DE COLUMNA Y SUS VALORES 
--PARA LA FORMA IMPLICITA DEBEN COLOCARSE LOS VALORES SEGUN EL ORDEN DE LA COLUMNA 
--Regla 1: Si NO especificas columnas, debes insertar TODAS las columnas.
--Regla 2: No puedes omitir columnas NOT NULL.
--Regla 3: Puedes omitir columnas NULL si no se exige su valor.
--si quiero omitir columnas nulleables de manera explicita  debo especificar  las columnas omitiendo las que no quiero 
--si quiero omitir columnas implicitamente (ir directo al value sin especificar columnas ) debo escribir explicitamente null en el value    

--SYNTAXYS
CREATE TABLE copy_tablename
AS (SELECT * FROM tablename);

--EJEMPLO
CREATE TABLE copy_employees
AS (SELECT * FROM employees);

--PASOS
DESCRIBE copy_employees;

SELECT * FROM copy_employees;

DESCRIBE copy_departments;

SELECT * FROM copy_departments;


--FORMA EXPLICITA
INSERT INTO copy_departments (department_id, department_name, manager_id, location_id)
VALUES (200,'Human Resources', 205, 1500);


--To specify empty strings and / or missing dates   phone_number es de tipo : varchar2
INSERT INTO copy_employees
(employee_id, first_name, last_name, email, phone_number,hire_date, job_id, salary)
VALUES(302,'Grigorz','Polanski', 'gpolanski', '', '15-Jun-2017','IT_PROG',4200);

--inserta valores de fecha que no usan el formato pro defecto 
INSERT INTO copy_employees (employee_id, first_name, last_name, email, phone_number,hire_date, job_id, salary)
VALUES(303,'Angelina','Wright', 'awright','4159982010',TO_DATE('July 10, 2017 17:20', 'Month fmdd, yyyy HH24:MI'),'MK_REP', 3600);


--FORMA IMPLICITA
INSERT INTO copy_departments
VALUES(210,'Estate Management', 102, 1700);

--FORMA EXPLICITA CON NULLS
INSERT INTO copy_employees (employee_id, first_name, last_name, email, phone_number,hire_date, job_id, salary)
VALUES (302,'Grigorz','Polanski', 'gpolanski','', '15-Jun-2017','IT_PROG',4200);


--INSERTANDO VALORES ESPECIALES (EXPLICITA): SYSDATE
INSERT INTO copy_employees (employee_id, first_name, last_name, email, phone_number,hire_date,job_id, salary)
VALUES(304,'Test',USER, 't_user', 4159982010, SYSDATE,'ST_CLERK',2500);


--INSERTANDO FECHA ESPECIFICA CON : TO_CHAR()
INSERT INTO copy_employees (employee_id, first_name, last_name, email, phone_number,hire_date,job_id, salary)
VALUES(301,'Katie','Hernandez', 'khernandez','8586667641',TO_DATE('July 8, 2017', 'Month fmdd, yyyy'),'MK_REP',4200);


--OTRO EJEMPLO DE FECHA 
INSERT INTO copy_employees
(employee_id, first_name, last_name, email, phone_number,hire_date, job_id, salary)
VALUES(303,'Angelina','Wright', 'awright','4159982010',TO_DATE('July 10, 2017 17:20', 'Month fmdd, yyyy HH24:MI'),'MK_REP', 3600);


INSERT INTO copy_departments VALUES (40, 'Advertising', 201, 1800);                     --INSERTA 4 DATOS A LA TABLA

 --OTRA MANERA ESPECIFICANDO COLUMNAS
INSERT INTO copy_departments(department_id,department_name, manager_id, location_id)   
VALUES (70, 'Public Relations', 100, 1700);

--METODO EXPLICITO CON INDICANDO COLUMNAS  (VALORES NULL) 
INSERT INTO copy_departments(department_id,department_name)
VALUES(30,'Purchasing');

--METODO IMPLICITO INSERTANDO (VALORES NULL)
INSERT INTO copy_departments
VALUES (100, 'Finance', NULL, NULL);

--INSERTA USANDO VALORES ESPECIALES COMO FECHA PERO USANDO UNA FUNCION PARA OBTENERLA DEL SYSTEMA
INSERT INTO copy_employees (employee_id, first_name,last_name, email, phone_number,hire_date, job_id, salary,commission_pct, manager_id,department_id)
VALUES( 113, 'Louis','Popp', 'LPOPP', '515.124.4567',SYSDATE, 'AC_ACCOUNT', 6900,NULL, 205,110); 

-- INSERTA VALORES CON UNA FECHA Y FORMATO EN ESPECIFICO 
INSERT INTO copy_employees VALUES(114, 'Den', 'Raphealy', 'DRAPHEAL','515.127.4561',
TO_DATE('Dec 7, 2002', 'MON DD, YYYY'),'SA_REP', 11000, 0.2, 100, 60, NULL);


---SUBQUERY PARA COPIAR FILAS EN UNA TABLA 
--NO VA EN PARENTESIS
--DEBEN SER MISMOS TIPOS DE DATOS
--AMBAS TABLAS DEBEN TENER EL MISMO NUMERO DE COLUMNAS 
INSERT INTO sales_reps(id, name, salary, commission_pct)
SELECT employee_id, last_name, salary, commission_pct
FROM employees
WHERE job_id LIKE '%REP%';


--PARA INSERTAR TODAS LAS COLUMNAS en la tabla sales_res desde employees deben coicidir ambas tablas    
INSERT INTO sales_reps
SELECT *
FROM employees;


--INSERTA UN VALOR POR DEFAULT FORMA EXPLICITA 
INSERT INTO my_employees(hire_date, first_name, last_name)
VALUES(DEFAULT, 'Angelina','Wright');

--INSERTA UN DEFAULT FORMA IMPLICITA 
INSERT INTO my_employees
(first_name, last_name)
VALUES
('Angelina','Wright');

INSERT INTO time_ex4 (loan_duration1, loan_duration2)
VALUES (INTERVAL '120' MONTH(3),
INTERVAL '3-6' YEAR TO MONTH);

INSERT INTO time_ex5 (day_duration1, day_duration2)
VALUES (INTERVAL '25' DAY(2), INTERVAL '4 10:30:10' DAY TO
SECOND);


--DE UNA TABLA SE SELECIONA FILAS Y ESTAS SE INSERTAN EN OTRAS TABLAS SI CUMPLEN CON CONDICIONES 
INSERT ALL
  -- Cuando el salario es mayor a 10000, va a la tabla ejecutivos
WHEN salario > 10000 THEN
INTO ejecutivos (id, nombre, salario) VALUES (id_emp, nombre_emp, salario)
  
-- La misma condición aplica a dos tablas (ejemplo para opción B)
WHEN salario > 10000 THEN
INTO altos_salarios (id, salario) VALUES (id_emp, salario)

-- Cuando el departamento es IT, va a la tabla it_empleados
WHEN departamento = 'IT' THEN
INTO it_empleados (id, nombre, habilidad) VALUES (id_emp, nombre_emp, 'Tecnología')

-- Todos los demás van a la tabla empleados_regulares
WHEN 1=1 THEN  -- Esto actúa como ELSE
INTO empleados_regulares (id, nombre) VALUES (id_emp, nombre_emp)

SELECT id_emp, nombre_emp, salario, departamento   
FROM empleados_origen;


--SE PUEDE ESCRIBIR DEFAULT PARA USAR EL VALOR POR DEFECTO DE LA TABLA EXPLICIT
INSERT INTO my_employees
(hire_date, first_name, last_name)
VALUES
(DEFAULT, 'Angelina','Wright');


--IMPLICIT
INSERT INTO my_employees
(first_name, last_name)
VALUES
('Angelina','Wright');


-------------------------------------------------------✳️UPDATE✳️---------------------------------------------------
--SE PUEDEN CAMBIAR MULTIPLES COLUMNAS A LA VEZ 


--SYNTAXYS :
UPDATE TABLA 
SET FILA_COLUMNA_A_CAMBIAR='XD'
WHERE EMPLOYEE_ID='123';


--UPDATE : MULTIPLES COLUMNAS EN UN VALOR ESPECIFICO 
UPDATE copy_employees
SET phone_number = '654321', last_name = 'Jones'
WHERE employee_id >= 303;


--UPDATE :SIN CLAUSURA WHERE ACTUALIZA TODOS LOS DATOS DE LA TABLA 
UPDATE copy_employees
SET phone_number = '654321', last_name = 'Jones';


--UPDATE USANDO SUBCONSULTA PARA CAMBIAR UN VALOR 
UPDATE copy_employees
SET salary = (SELECT salary
FROM copy_employees
WHERE employee_id = 100)
WHERE employee_id = 101;


--UPDATE : USANDO DOS SUBCONSULTAS UNA PARA CADA COLUMNA DEL SET 
UPDATE copy_employees
SET salary = (SELECT salary
FROM copy_employees
WHERE employee_id = 205),
job_id = (SELECT job_id
FROM copy_employees
WHERE employee_id = 205)
WHERE employee_id = 206;

--UPDATE : USANDO 2 TABLAS DIFERENTES 
UPDATE copy_employees
SET salary = (SELECT salary
FROM employees
WHERE employee_id = 205)
WHERE employee_id = 202;


ALTER TABLE copy_employees
ADD (department_name varchar2(30) NOT NULL);


--UPDATE: CON TABLAS CORRELACIONADAS (USAN LA MISMA TABLA )
UPDATE copy_employees e
SET e.department_name = (SELECT d.department_name
FROM departments d
WHERE e.department_id =
d.department_id);





--BLOCKEA LAS FILAS DE LAS TABBLAS HASTA QUE SE EMITA UN COMMIT O ROLLBACK 
SELECT e.employee_id, e.salary, d.department_name
FROM employees e JOIN departments d USING (department_id)
WHERE job_id = 'ST_CLERK' AND location_id = 1500
FOR UPDATE
ORDER BY e.employee_id;


--ACTUALIZA TODOS LOS VALORES DE LA TABLA  SI NO SE USA WHERE
UPDATE copy_employees
SET department_id = 110;



--NO SE PUEDEN VIOLAR LAS RESTRICIONES EJEMPLO :
UPDATE employees
SET department_id = 55
WHERE department_id = 110;

--ACTUALIZA USANDO UN VALOR POR DEFECTO 
UPDATE my_employees
SET hire_date = DEFAULT
WHERE last_name = 'Wright';


--EXPLICIT DEFAULT UPDATE 
UPDATE my_employees
SET hire_date = DEFAULT
WHERE last_name = 'Wright';




-------------------------------------------------------✳️DELETE✳️---------------------------------------------------
--NECESITA : NOMBRE DE TABLA , CONDICION 
--PODRIAN TENER PROBLEMAS SI SE ROMPEN LAS REGLAS DE INTEGRIDAD 
--ES MAS LENTO QUE TRUNCATE PORQUE GENERA ROLLBACK INFROMATION 

--BORRA TODA UNA FILA 
DELETE from copy_employees
WHERE employee_id = 303;

--BORRA TODAS LAS FILAS DE LA TABLA 
DELETE from copy_employees;


--DELETE CON SUBQUERYS
DELETE FROM copy_employees
WHERE department_id =
(SELECT department_id
FROM departments
WHERE department_name = 'Shipping');


DELETE FROM copy_employees e
WHERE e.manager_id IN
(SELECT d.manager_id
FROM employees d
HAVING count (d.department_id) < 2
GROUP BY d.manager_id);



--DELETE FOR  : BLOCKEA LAS TABLAS  LAS MARCA PARA ACTUALIZAR HASTA QUE SE USE COMMIT O ROLLBACK 
SELECT e.employee_id, e.salary, d.department_name
FROM employees e JOIN departments d USING (department_id)
WHERE job_id = 'ST_CLERK' AND location_id = 1500
FOR UPDATE
ORDER BY e.employee_id;






-------------------------------------------------------✳️MERGE✳️---------------------------------------------------
--La sentencia MERGE combina operaciones de INSERT y UPDATE (e incluso DELETE) en una sola instrucción
--puedes usar subquerrys , vistas : para proporcionar datos
--el delete siempre actua sobre la tabla destino 

--MERGE INTO destination-tableE USING source-table
--ON matching-condition
--WHEN MATCHED THEN UPDATE
--SET......... 
--WHEN NOT MATCHED THEN INSERT
--VALUES (……);


--ACTUALIZA CUNADO MATCHEAN , INSERTA CUANDO NO MATCHEAN  TABLA DESTINO COPY_EMP   ORIGEN:EMPLOYEES 
MERGE INTO copy_emp c USING employees e
ON (c.employee_id = e.employee_id)
WHEN MATCHED THEN UPDATE
SET
c.last_name = e.last_name,
c.department_id = e.department_id
WHEN NOT MATCHED THEN INSERT
VALUES (e.employee_id, e.last_name, e.department_id);








----------------------------------------MULTITABLA INSERT---------------------------------------------------
--INSERT ALL INTO clause VALUES clause SUBQUERY
--ALL INSERTA EN TODAS LAS WHEN CLAUSULAS DE LAS TABLAS EN EL ORDEN EN EL QUE ESTAN 
--FIRST INSERTA EN LA PRIMERA WHEN CONDITION QUE CUMPLA CON LA CONDICION  E IGNORA LAS DEMAS 


--INSERTANDO EN MULTIPLES TABLAS 
INSERT ALL
INTO my_employees
VALUES (hire_date, first_name, last_name)
INTO copy_my_employees
VALUES (hire_date, first_name, last_name)
SELECT hire_date, first_name, last_name
FROM employees;


INSERT ALL
WHEN call_format IN ('tlk','txt','pic') THEN
INTO all_calls
VALUES (caller_id, call_timestamp, call_duration, call_format)
WHEN call_format IN ('tlk','txt') THEN
INTO police_record_calls
VALUES (caller_id, call_timestamp, recipient_caller)
WHEN call_duration < 50 AND call_type = 'tlk' THEN
INTO short_calls
VALUES (caller_id, call_timestamp, call_duration)
WHEN call_duration > = 50 AND call_type = 'tlk' THEN
INTO long_calls
VALUES (caller_id, call_timestamp, call_duration)
SELECT caller_id, call_timestamp, call_duration, call_format,
recipient_caller
FROM calls
WHERE TRUNC(call_timestamp ) = TRUNC(SYSDATE);


INSERT INTO time_ex4 (loan_duration1, loan_duration2)
VALUES (INTERVAL '120' MONTH(3),
INTERVAL '3-6' YEAR TO MONTH);

INSERT INTO time_ex5 (day_duration1, day_duration2)
VALUES (INTERVAL '25' DAY(2), INTERVAL '4 10:30:10' DAY TO
SECOND);

---------------------------------------------✳️ALTER✳️----------------------------------------------------------


--AGREGA UNA NUEVA COLUMNA 
ALTER TABLE my_cd_collection
ADD (release_date DATE DEFAULT SYSDATE);

-- AGREGA UNA COLUMNA 
ALTER TABLE my_friends
ADD (favorite_game VARCHAR2(30));

--
CREATE TABLE mod_emp
(last_name VARCHAR2(20),
salary NUMBER(8,2));


--AGREGA UNA NUEVA COLUMNA 
ALTER TABLE my_cd_collection
ADD (release_date DATE DEFAULT SYSDATE);

-- AGREGA UNA COLUMNA 
ALTER TABLE my_friends
ADD (favorite_game VARCHAR2(30));

--
CREATE TABLE mod_emp
(last_name VARCHAR2(20),
salary NUMBER(8,2));

---------------------------------------------ALTER TABLE MODIFY-------------------------------------------------------
ALTER TABLE mod_emp
MODIFY (last_name VARCHAR2(30));

ALTER TABLE mod_emp
MODIFY (last_name VARCHAR2(10));

ALTER TABLE mod_emp
MODIFY (salary NUMBER(10,2));

ALTER TABLE mod_emp
MODIFY (salary NUMBER(8,2) DEFAULT 50);

--------------------------------------------------ALTER TABLE DORP-----------------------------------------------

ALTER TABLE tablename
DROP COLUMN column_name;


ALTER TABLE my_cd_collection
DROP COLUMN release_date;

ALTER TABLE my_friends
DROP COLUMN favorite_game;


----------------------------------------------------------ALTER SET UNUSED COLUMNS ---------------------------------------------

ALTER TABLE tablename SET UNUSED (column_name);

ALTER TABLE copy_employees
SET UNUSED (email);

ALTER TABLE copy_employees
DROP UNUSED COLUMNS;


----------------------------------------------------------ALTER CONSTAINTS-----------------------------------------------------------------

--AGREGA UN CONSTRAINT PRIMARY KEY 
ALTER TABLE employees
ADD CONSTRAINT emp_id_pk PRIMARY KEY (employee_id);

--CONSTRAINT FOREIGN KEY
ALTER TABLE tablename
ADD CONSTRAINT constraint_name FOREIGN KEY(column_name)
REFERENCES tablename(column_name);



------------------------------------------------------------------------------------------------------------------------
SELECT employee_id,first_name ||' '|| last_name AS "NAME",
versions_operation AS "OPERATION",
versions_starttime AS "START_DATE",
versions_endtime AS "END_DATE", salary
FROM employees
VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE employee_id = 1;

---------------------------------------------ALTER TABLE MODIFY-------------------------------------------------------
ALTER TABLE mod_emp
MODIFY (last_name VARCHAR2(30));

ALTER TABLE mod_emp
MODIFY (last_name VARCHAR2(10));

ALTER TABLE mod_emp
MODIFY (salary NUMBER(10,2));

ALTER TABLE mod_emp
MODIFY (salary NUMBER(8,2) DEFAULT 50);

--------------------------------------------------ALTER TABLE DROP-----------------------------------------------

ALTER TABLE tablename
DROP COLUMN column_name;


ALTER TABLE my_cd_collection
DROP COLUMN release_date;

ALTER TABLE my_friends
DROP COLUMN favorite_game;


----------------------------------------------------------SET UNUSED COLUMNS ---------------------------------------------

--syntax:  ALTER TABLE tablename SET UNUSED (column name);

ALTER TABLE copy_employees
SET UNUSED (email);

ALTER TABLE copy_employees
DROP UNUSED COLUMNS;


---------------------------------------------------------✳️DROP TABLE✳️ -----------------------------------------------------------
--SYNTAXIS
DROP TABLE tablename;

--BORRA UNA TABLA 
DROP TABLE copy_employees;

--ELIMINA POR DEFINITIVO DEL RECICLEBYN
DROP TABLE copy_employees PURGE;
----------------------------------------------RECOVERED-------------------------------------------------
FLASHBACK TABLE copy_employees TO BEFORE DROP;

SELECT original_name, operation, droptime
FROM user_recyclebin;


SELECT employee_id,first_name ||' '|| last_name AS "NAME",
versions_operation AS "OPERATION",
versions_starttime AS "START_DATE",
versions_endtime AS "END_DATE", salary
FROM employees
VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE employee_id = 1;


SELECT employee_id,first_name ||' '|| last_name AS "NAME",
versions_operation AS "OPERATION",
versions_starttime AS "START_DATE",
versions_endtime AS "END_DATE", salary
FROM employees
VERSIONS BETWEEN SCN MINVALUE AND MAXVALUE
WHERE employee_id = 1;




-----------------------------------------------RENAME ------------------------------------------------


----------------------------------------------------TRUNCATED---------------------------------------------------
--TRUNCATE ES MAS RAPIDO QUE DELETE 


TRUNCATE TABLE tablename;

-----------------------------------------------------COMMENT-------------------------------------------------

COMMENT ON TABLE employees
IS 'Western Region only';

--PARA VER LOS COMENTARIOS 
SELECT table_name, comments
FROM user_tab_comments;

--PARA REMPLAZAR UN COMENTARIO QUE YA EXISTA 
COMMENT ON TABLE employees IS ' ' ;

------------------------------------------------------📌📌📌CONTROLING USER ACCESS / regular expresions 📌📌📌----------------------------------------

--DAR PERMISOS EN UN SYNONIMO ES COMO DAR PERMISO EN LA TABLA BASE 
--UN USUARIO POR DEFECTO TIENE TODOS LOS PRIVILEGIOS DE OBJECTOS EN SU SCHEMA 
--UN USUARIO CON  WITH GRANT OPTION PUEDE PASAR SUS PRIVILEGIOS A OTRO USUARIO 
--OTORGAMIENTOS WITH GRANT OPTIONS NO SON CIRCULARES 
--security is clasified in 2 : system security:(creating users, usernames,and passwords) - data security(object privileges which covers access to and use of thedatabase objects) 
--se puede restringir el privilegio select creando una vista y dandole permisos de select a esa vista
--Un privilegio otorgado sobre un sinónimo se convierte en un privilegio sobre la tabla base a la que hace referencia el sinónimo.
--Usar un synonimo : este nombre para otorgar un privilegio es lo mismo que otorgar el privilegio en la propia tabla.
--To grant privileges on an object, the object must be in your own schema, or you must have been granted the privilege using the WITH GRANT OPTION
--The owner of an object automatically acquires all object privileges on that object
--un rol puede ser otorgado a otro rol 

--privilegios de sistema que usualmente un DBA no daria 
--System Privilege------------ Operations Authorized

--CREATE USER -------------------Grantee can create other Oracle users (a privilege required for a DBA role)
--DROP USER--------------------- Grantee can drop another user
--DROP ANY TABLE-----------------Grantee can drop a table in any schema
--BACKUP ANY TABLE---------------Grantee can backup any table in any schema with the export utility
--SELECT ANY TABLE---------------Grantee can query tables, views, or snapshots in any schema
--CREATE ANY TABLE-------------- Grantee can create tables in any schema

------------------------------------------------------------------------------------------------------------------


--System Privilege---------- Operations Authorized
--CREATE SESSION------------ Connect to the database
--CREATE TABLE-------------- Create tables in the user's schema
--CREATE SEQUENCE------------Create a sequence in the user's schema
--CREATE VIEW ---------------Create a view in the user's schema
--CREATE PROCEDURE---------- Create a procedure, function, or package in the user's schema


--object privilegies 
--Object Privilege ---------Table ---------View ---------Sequence --------Procedure
--ALTER                       X                             X
--DELETE                      X             X
--EXECUTE                                                                     X
--INDEX                       X             X
--INSERT                      X             X
--REFERENCES                  X
--SELECT                      X             X               X
--UPDATE                      X             X


--mira todos los privilegios que hay para otorgar 
SELECT * FROM session_privs;      

--LE ESTA DANDO PERMISOS DE ACTUALIZAR LA COLUMNA SALARY DE LA TABLA EMPLOYEES AL USUARIO STEVEN_KING
--no se puede otorgar select en columnas individuales  
GRANT UPDATE (salary)
ON employees TO steven_king

--PONE PUBLICA LA TABLA DENTRO DEL SCHEMA DE UN USUARIO         
GRANT select
ON alice.departments
TO PUBLIC;

-------------------------------------------------- VIEW PRIVILEGES ----------------------------------------
--You can access the data dictionary to view the privileges that you have

--Data Dictionary             View Description
--OLE_SYS_PRIVS System        privileges granted to roles
--ROLE_TAB_PRIVS              Table privileges granted to roles
--USER_ROLE_PRIVS Roles       accessible by the user
--USER_TAB_PRIVS_MADE         Object privileges granted on the user's objects
--USER_TAB_PRIVS_RECD         Object privileges granted to the user
--USER_COL_PRIVS_MADE         Object privileges granted on the columns of the user's objects
--USER_COL_PRIVS_RECD         Object privileges granted to the user on specific columns
--USER_SYS_PRIVS              Lists system privileges granted to the user






------------------------------------------------CREACION DE ROLES ----------------------------------------------
--SE LE PUEDEN ASIGNAR MULTIPLES ROLES A UN USUARIO 

--CREA UN ROL 
CREATE ROLE manager;

--OTORGA PRIVILEGIOS A ESE ROL 
GRANT create table, create view TO manager;

--ASIGNA EL ROL AL USUARIO 
GRANT manager TO jennifer_cho;

---------------------------------------------------------------------------------------------------------------------------------------------





---------------------------------------------OTORGAMIENTO DE PRIVILEGIOS A LOS OBJECTOS------------------------------------------------- 
--NO PUEDES DAR PRIVILEGIOS EN OBJECTOS REMOTOS 

--SYNTAXIS:
--GRANT object_priv [(column_list)]
--ON object_name
--TO {user|role|PUBLIC}
--[WITH GRANT OPTION];

--Syntax                 Defined
--object_priv            is an object privilege to be granted
--column_list            specifies a column from a table or view on which privileges are granted
--ON object_name         is the object on which the privileges are granted
--TO user|role           identifies the user or role to whom the privilege is granted
--PUBLIC                 grants object privileges to all users
--WITH GRANT OPTION      Allows the grantee to grant the object privileges to other users and roles








-------------------------------------------EJEMPLO DE USO HABITUAL-----------------------------------------------------------


--TODOS LOS USUARIOS TIENEN PERMISO PARA HACER SELECTS EN LA TABLA CLIENTES de scot QUE AHORA ES PUBLICA 
GRANT SELECT
ON clients
TO PUBLIC;

--PERMITE ACTUALIZAR DOS COLUMNAS DE LA TABLA CLIENTES A jennifer_cho y al rol manager
GRANT UPDATE(first_name,last_name)
ON clients
TO jennifer_cho, manager;

--PARA QUE JENIFER PUEDA ACCEDER A LA DATA DEBE USAR LA SYNTAXIS DEL USUARIO SCOTT almenos que tenga un synonimo publico o privado 
SELECT *
FROM scott_king.clients;

--SE PUEDE CREAR UN SYNONYM CLIENTS PARA NO TENER QUE USAR scott_king.clients
CREATE SYNONYM clients
FOR scott_king.clients;


--AHORA CON EL SYNONIM CREADO ELLA SIMPLEMENTE PUEDE ESCRIBIRLO MAS SIMPLE 
SELECT *
FROM clients;
-------------------------------------------------------------------------------------------------------

--OTORGA PRIVILEGIOS PARA SELECT Y INSERTAR DATOS A SCOTT PERO AL TENER OPCION GRANT ESTE PUEDE PASAR EL PRIVILEGIO A OTROS 
GRANT SELECT, INSERT
ON clients
TO scott_king
WITH GRANT OPTION;

--permite select a todos los usuarios en jason_tsang.clients
GRANT SELECT
ON jason_tsang.clients
TO PUBLIC;

--CREA UN SYNONIMO PARA UNA BASE DE DATOS REMOTA 
CREATE PUBLIC SYNONYM HQ_EMP
FOR emp@HQ.ACME.COM;


SELECT *
FROM HQ_EMP;

-------------------------------------------------------- REVOKE PRIVILEGES OBJECTS ----------------------------------------------
--SI SE REVOKA PRIVILEGIOS A UN USUARIO QUE DIO PRIVILEGIOS A OTROS CON SU OPCION DE WITH GRAND OPTIONS CON CASCADE SE QUITAN TODOS 
--SYNTAXIS : 
--cascade constraint se usa para eliminar cualquier restricion de integridad que se aplica sobre el objeto y la cadena de with grand option que se le otorgo a otros 
--si el usuario a da privelegios a user b  y user b da privilegios a user c  al hacer revoke sobre usar a se pierden los privilegios del b y c 

--REVOKE {privilege [, privilege]|ALL}
--ON object
--FROM {user[,user]|role|PUBLIC}
--[CASCADE CONSTRAINTS];

--REVOCA PRIVILEGIOS select y insert a scott_king 
REVOKE SELECT, INSERT
ON clients
FROM scott_king;

------------------------------------------------------------------------ DATA BASE LINKS (COMUNICACION DE UNA BASE DE DATOS CON OTRA BASE DE DATOS ) ---------------------------------------------------------------
-- UN USUARIO EN LA BD A LOCAL  SE CONECTA A LA BD B  PERO NO VICEVERSA 
--DEBE TENER UN NOMBRE UNICO DE BD 
--PUEDE OCURRIR SIN TENER UN USUARIO EN LA BD REMOTA 
--USER_DB_LINKS CONTIENE LA INFORMACION DEL VINCULO 
--


--CREA UN SYNONIMO PUBLICO PARA UNA BD REMOTA 
CREATE PUBLIC SYNONYM HQ_EMP
FOR emp@HQ.ACME.COM;

--PARA ACCEDER A UNA BASE DE DATOS REMOTA 
SELECT * FROM
emp@HQ_ACME.COM;
--------------------------------------------------
-- Crear roles individuales
CREATE ROLE rol_lectura;
CREATE ROLE rol_escritura;
CREATE ROLE rol_administracion;

-- Otorgar privilegios a roles base
GRANT SELECT ON empleados TO rol_lectura;
GRANT INSERT, UPDATE ON empleados TO rol_escritura;
GRANT ALL ON empleados TO rol_administracion;

-- Crear rol que contiene otros roles
CREATE ROLE rol_supervisor;
GRANT rol_lectura, rol_escritura TO rol_supervisor;

CREATE ROLE rol_gerente;
GRANT rol_supervisor, rol_administracion TO rol_gerente;
----------------------------------------------------------------------------













------------------------------------------------------------------------------ Regular Expressions --------------------------------------------------------------------------
--Symbol       Description
--. (dot)  Matches any character in the supported character set, except NULL  (matchea todos los caracteres (letra, número, símbolo, espacio) menos null )
--?        Matches zero or one occurrence
--*        Matches zero or more occurrences
--+        Matches one or more occurrences
--()       Grouping expression, treated as a single sub-expression
--\        Escape character
--|        Alternation operator for specifying alternative matches
--^/$      Matches the start-of-line/end-of-line
--[ ]      Bracket expression for a matching list matching any one of the expressions represented in the list





--------------------------------------------------------------------------📌 11.TCL:TRANSACTION  LANGUAGUE📌----------------------------------------------------------------
--salirse de la sesion emite implicitamente  un commit o un rollback :
--se emitira commit implicito  cuando la sesion cierre normalmente  
--cuando la bd crashea o se cierra la cesion de forma anormal se emite un (rollback implicito) 
--no puede cambiar la data mas de 1 user a la vez 
--Read Consistency:
--Readers do not view data that is in the process of being changed
--A partial copy of the database is kept in undo
--segments. When User A issues an insert, update, or
--delete operation to the database, the Oracle server
--takes a snapshot (copy) of the data before it is changed
--and writes it to an undo (rollback) segment
--Changes made by one writer do not destroy or conflictb nwith changes another writer is making
--Changes made by one writer do not destroy or conflict with changes another writer is making 


--CUANDO EMPIEZA O TRANSACION : 
--A transaction begins with the first DML (INSERT, UPDATE, DELETE or MERGE) statement
--Writers are ensured that the changes to the database are done in a consistent way
--Changes made by one writer do not destroy or conflict with changes another writer is making


--CUANDO TERMINA UNA TRANSACION : 

--−A transaction ends when one of the following occurs:
--−A COMMIT or ROLLBACK statement is issued
--−A DDL(CREATE, ALTER, DROP, RENAME or TRUNCATE) statement is issued
--−A DCL(GRANT or REVOKE) statement is issued
--−A user exits normally from the Oracle Database utility,causing the current transaction to be implicitly committed

--HACE UNA OPERACION DML 
UPDATE copy_departments
SET manager_id= 101
WHERE department_id = 60;

--CREA UN PUNTO DE GUARDADO 
SAVEPOINT one;

--INSERTA DATOS A LA TABLA 
INSERT INTO copy_departments(department_id, department_name,
manager_id, location_id)
VALUES(130, 'Estate Management', 102, 1500);

--ACTUALIA LA TABLA PERO OLVIDA LA CLAUSURA WHERE 
UPDATE copy_departments
SET department_id = 140;

-- VUELVE AL PUNTO DE GUARDADO 
ROLLBACK TO SAVEPOINT one;

--CONFIRMA LA TRANSACION 
COMMIT;

--EXPLICIT LOCKING
SAVEPOINT update_done;                          --CREA UN PURTO DE GUARDADO A PARTIR DE UN RESULTADO.

--INSERT
ROLLBACK TO update_done;

--REALIZA OPERACIONES DE DML (INSERTAR,DELETE)
COMMIT;                                         --GUARDA LOS CAMBIOS PERMANENTE A LA BASE DE DATOS (YA QUE POR LO GENERAL ESTAN EN LOG)

DELETE FROM copy_employees;
ROLLBACK ;                                      --VUELVE A UN ESTADO GUARDADO 

--ojo si un comando falla se revierte esa sentencia automaticamente las demas permanecen en log para ser guardadas o hechar todo atras roll

--How the Oracle Database Locks Data
--•Oracle locking is performed automatically and requires no user action
--•Implicit locking occurs for SQL statements as necessary, depending on the action requested
--•Implicit locking occurs for all SQL statements except SELECT
--•The users can also lock data manually, which is called explicit locking
--•When a COMMIT or ROLLBACK statement is issued,locks on the affected rows are released

















-------------------------------------------📝PRACTICA DE LOS MODULOS 📝--------------------------------------
--📌 PRACTICA MODULO 1 SESION 6 
CREATE TABLE dept(
deptno NUMBER(2),
dname VARCHAR2(14),
loc VARCHAR2(13),
create_date DATE DEFAULT SYSDATE  --USA LA HORA DEL SISTEMA EN EL MOMENTO
);



DESCRIBE dept;                    --Confirma si una tabla fue creada 

---------------------------------------📌12. CONJUNTOS (INTERSEC,)📌----------------------------------------------
--CONJUNTO VACIO(NO HAY COINCIDENCIAS)
SELECT 1 AS id, 'John' AS name FROM DUAL
INTERSECT
SELECT 2 AS id, 'Mary' AS name FROM DUAL;

--1 COINCIDENCIA DEVUELVE ESA FILA
SELECT 'Apple' AS fruit FROM DUAL
UNION ALL
SELECT 'Orange' AS fruit FROM DUAL
INTERSECT
SELECT 'Apple' AS fruit FROM DUAL
UNION ALL
SELECT 'Banana' AS fruit FROM DUAL;



--COINCIDENCIA CON UN NULL
SELECT 1 AS id, NULL AS value FROM DUAL
INTERSECT
SELECT 1 AS id, NULL AS value FROM DUAL;


--MULTIPLES FILAS COINCIDENTES
SELECT department_id FROM employees WHERE salary > 10000
INTERSECT
SELECT department_id FROM departments WHERE location_id = 1700;
