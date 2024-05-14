/*
	Este script se hace exclusivamente para reliazar las consultas requeridad
	sobre la Base de Datos "jardineria"
*/

/*
	tener presente el orden en que MYSQL ejecuta la consulta:
	FROM/JOIN
	WHERE
	GROUP BY
	HAVING
	SELECT
	ORDER BY
	LIMIT/OFFSET
*/

USE jardineria;

/*
	1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
*/

SELECT codigo_oficina AS CodOficina, ciudad
FROM oficina;

/*
	2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España
*/
SHOW COLUMNS FROM oficina;

SELECT ciudad, telefono
FROM oficina
WHERE pais = "España";

/*
	3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
*/

SELECT nombre, CONCAT(apellido1, ' ', apellido2) AS Aepllidos, email
FROM empleado
WHERE codigo_jefe = 7;

/*
	4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
*/

SELECT puesto as Cargo, nombre AS Nombre, CONCAT(apellido1, ' ', apellido2) AS Aepllidos, email AS Email 
FROM empleado
WHERE codigo_jefe IS NULL;

/*
	5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
*/

SELECT nombre AS Nombre, CONCAT(apellido1, ' ', apellido2) AS Aepllidos, puesto AS Cargo
FROM empleado
WHERE puesto <> "Representante Ventas";

/*
	6. Devuelve un listado con el nombre de los todos los clientes españoles.
*/
SHOW COLUMNS FROM cliente;

SELECT * FROM cliente;

SELECT nombre_cliente
FROM cliente
WHERE pais = "Spain";


/*
	7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
*/

SELECT DISTINCT estado
FROM pedido;

/*
	8. Devuelve un listado con el código de cliente de aquellos clientes que realizaron algún pago en 2008. Tenga en cuenta 
	que deberá eliminar aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
*/

-- Utilizando la función YEAR de MySQL.

SHOW COLUMNS FROM pago;

SELECT codigo_cliente AS codCliente
FROM pago
WHERE YEAR(fecha_pago) = "2008"
GROUP BY codigo_cliente;

-- Utilizando la función DATE_FORMAT de MySQL.
SELECT DATE_FORMAT(CURRENT_DATE(), "%Y"); -- Verifico el funcionamiento de la función Date_format()

SELECT codigo_cliente AS codCliente
FROM pago
WHERE DATE_FORMAT(fecha_pago, "%Y") = "2008"
GROUP BY codigo_cliente;

-- Sin utilizar ninguna de las funciones anteriores.
SELECT LOCATE("o", "Hola"); -- funcionamiento de locate

SELECT codigo_cliente AS codCliente
FROM pago
WHERE SUBSTRING(fecha_pago, 1, LOCATE("-", fecha_pago) - 1) = "2008"
GROUP BY codigo_cliente;

/*
	9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de 
	los pedidos que no han sido entregados a tiempo.
*/

SHOW COLUMNS FROM pedido;
SELECT (fecha_esperada - fecha_entrega) AS difFecha, fecha_esperada, fecha_entrega
FROM pedido; -- consulta para verificar si puedo restar fechas

SELECT codigo_pedido AS codPedido, codigo_cliente AS codCliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE (fecha_esperada - fecha_entrega) < 0;

/*
	10. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega 
	de los pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada. 
*/


-- Utilizando la función ADDDATE de MySQL
SELECT fecha_entrega, ADDDATE(fecha_entrega, INTERVAL 1 month)
FROM pedido; -- verificando funcionamiento de la fucnión ADDDATE

SELECT codigo_pedido AS codPedido, codigo_cliente AS codCliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega <= ADDDATE(fecha_esperada, -2);

-- Utilizando la función DATEDIFF de MySQL.
SELECT codigo_pedido AS codPedido, codigo_cliente AS codCliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;

/*
	17. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
*/


SELECT 	cl.nombre_cliente AS nombreCliente,
			e.nombre AS nombreReprVentas,
			CONCAT(e.apellido1, ' ', e.apellido2) AS AepllidosReprVentas,
			e.puesto AS Cargo
FROM		cliente AS cl,
			empleado AS e
WHERE cl.codigo_empleado_rep_ventas = e.codigo_empleado AND
		e.puesto = "Representante Ventas";