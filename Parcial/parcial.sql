/*  1. SQL
	Se sabe que todo los productos que posee componentes tiene al menos 2 componentes distintos.
	
	Realizar una consulta que para todos los productos que poseen componentes y que no son componentes 
	de ningún otro producto devuelva:
	
	Requerimientos: 
	1)
	Codigo_Producto, Detalle_Producto, Detalle_Componente1, Detalle_Componente2, Detalle_Rubro (si hay).
	
	2)
	- Cada producto que cumpla las condiciones dadas debe figurar en la consulta una sola vez.
	- Los valores en las columnas componente 1 y 2 deben ser distintos sin importar su orden
	y sin importar cual dato se muestra en el caso de que tenga 3 o mas componentes.
	
	3)
	La consulta final debe ser ordenada (order by) con un criterio dado por el alumno.

	Ejemplo: 
	Si el producto "Control remoto porton" esta compuesto por una cantidad de "Control remoto marca ACME"
	y "Pila A23" se debe mostrar:
	Opción 1:
		Detalle del producto => Control remoto porton
		Componente 1 => Control remoto marca ACME 
		Componente 2 => Pila A23
	Opción 2:
		Detalle del producto => Control remoto porton
		Componente 1 => Pila A23    
		Componente 2 => Control remoto marca ACME
*/
-- Producto: 00001104
-- Componente 1: 00001109
-- Componente 2: 00001123

-- Producto: Codigo, Detalle, Precio, Familia, Rubro, Envase
-- Composicion: Cantidad, Producto, Componente

select * from Producto p where p.prod_codigo in ('00001104', '00001109', '00001123');
select * from Composicion;

-- Debe devolver 4 valores

SELECT 
	p.prod_codigo as [Codigo Producto],
	p.prod_detalle as [Detalle Producto],
	(SELECT prod_detalle FROM Producto WHERE prod_codigo = combinacion.comp_componente1) as [Detalle Componente 1],
	(SELECT prod_detalle FROM Producto WHERE prod_codigo = combinacion.comp_componente2) as [Detalle Componente 2],
	(SELECT TOP 1 ISNULL(r.rubr_detalle, 'Sin Rubro') FROM Rubro r WHERE r.rubr_id = p.prod_rubro) as [Detalle Rubro]
FROM Producto p
	JOIN (
		SELECT 
			c1.comp_producto as comp_producto, 
			c1.comp_componente as comp_componente1, 
			c2.comp_componente as comp_componente2
		FROM Composicion c1, Composicion c2 
		WHERE c1.comp_producto = C2.comp_producto AND c1.comp_componente <> c2.comp_componente
	) combinacion ON combinacion.comp_producto = p.prod_codigo
WHERE p.prod_codigo NOT IN (SELECT c.comp_componente FROM Composicion c) AND combinacion.comp_componente1 < combinacion.comp_componente2
ORDER BY [Detalle Producto] ASC
GO

/*
	Obtengo todos los productos que NO son compontentes => No estan en comp_componente en Componete
*/

/* 
2. T-SQL
	Realizar un stored procedure que calcule e informe la comisión de un vendedor para un determinado mes.
	
	Parametros Entrada: Código de vendedor (obligatorio), mes (null) y año (null).
	En caso de que se ingrese NULL para mes y año deberia tomarse el anterior al mes en curso.

	Si el periodo a calcular es el mes anterior al mes en curso:
	Ademas de informar lo pedido debe actualizar la comisión en la tabla de empleados.

	El criterio para el comisionamiento es:
	--------------------------------------------------------------------------------------------------------
	5% del total vendido tomando como importe base el valor de la factura sin los impuestos 
	del mes a comisionar,
	
	a esto se le debe sumar un plus en el caso de que haya aumentado en cantidad de unidades vendidas 
	(no valores monetarios) sus ventas durante los últimos 4 meses,

	para ello se le debe calcular un 2% de las ventas a cada uno de los 3 meses anteriores mencionados
	y sumarlo a la comisión.
	--------------------------------------------------------------------------------------------------------
	Minimizar la cantidad de accesos a las tablas de facturas.
*/

CREATE PROCEDURE sp_calcular_comision (
	@codigo_vendedor	NUMERIC(6,0),
	@mes				INT,
	@anio				INT,
	@comision			NUMERIC(6,2) OUTPUT
) AS 
BEGIN
	DECLARE @date_actual datetime = GETDATE();
	DECLARE @actualizar_comision bit = 0;

	DECLARE @comision_base NUMERIC(6,2) = 0;
	DECLARE @comision_plus NUMERIC(6,2) = 0;

	DECLARE @Ventas TABLE(
		Total DECIMAL (12,2),
		Cantidad_Vendida INT,
		Mes INT,
		Anio INT		
	)

	-- Código Defensivo
	IF (@mes IS NULL AND @anio IS NOT NULL) OR (@anio IS NULL AND @mes IS NOT NULL) OR (@codigo_vendedor IS NULL)
		RETURN

	IF @mes IS NULL AND @anio IS NULL
	BEGIN
		SET @mes = MONTH(DATEADD(MONTH, -1, @date_actual));
		SET @anio = YEAR(DATEADD(MONTH, -1, @date_actual)); 
		SET @actualizar_comision = 1;
	END

	-- Guardamos todos los registros de ventas de los ultimos 4 meses, no necesitamos volver a acceder a Factura
	INSERT INTO @Ventas
	SELECT 
		SUM(ifa.item_precio * ifa.item_cantidad) as facturado,
		SUM(ifa.item_cantidad) as cantidad,
		MONTH(f.fact_fecha) as mes, 
		YEAR(f.fact_fecha) as anio
	FROM Factura f
	JOIN Item_Factura ifa ON f.fact_tipo = ifa.item_tipo AND f.fact_sucursal = ifa.item_sucursal AND f.fact_numero = ifa.item_numero
	WHERE 
		f.fact_vendedor = 4 
		AND f.fact_fecha BETWEEN DATEADD(MONTH, -4, @date_actual) AND @date_actual
	GROUP BY YEAR(f.fact_fecha), MONTH(f.fact_fecha)
	ORDER BY anio, mes DESC

	-- Calculamos la comisión Base
	SET @comision_base = ISNULL((
		SELECT v.Total 
		FROM @Ventas v
		WHERE v.Anio = @anio AND v.Mes = @mes
	), 0) * 0.05;


	DECLARE @total1 DECIMAL(12, 2), @cantidad1 DECIMAL(12,2), @mes1 INT, @anio1 INT;
	DECLARE @cantidad2 DECIMAL(12,2);
	DECLARE @hay_plus bit = 1;

	-- Calculamos la comisión Plus
	DECLARE c_ventas CURSOR FOR 
	SELECT v.Total, Cantidad_Vendida, v.Mes, v.Anio FROM @Ventas v
	OPEN c_ventas

	FETCH NEXT FROM c_ventas INTO @total1, @cantidad1, @mes1, @anio1
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @cantidad2 = ISNULL((
			SELECT v.Cantidad_Vendida 
			FROM @Ventas v 
			WHERE v.Mes = CASE v.Mes WHEN 1 then 12 else V.Mes - 1 END 
			AND v.Anio = CASE v.Mes WHEN 1 then @anio1 - 1 else @anio1 END 
		), 0);

		IF @cantidad2 > @cantidad1
			SET @hay_plus = 0

		FETCH NEXT FROM c_ventas INTO @cantidad1
	END
	CLOSE c_ventas
	DEALLOCATE c_ventas

	IF (@hay_plus = 1)
		SET @comision_plus = ISNULL((SELECT 0.02 * SUM(V.Total) FROM @Ventas V WHERE V.Anio != @Anio AND  v.Mes != @Mes), 0) 


	SET @comision = @comision_base + @comision_plus;
	
	PRINT(@comision)

	IF @actualizar_comision = 1
	BEGIN
		UPDATE Empleado
		SET empl_comision = @comision
		WHERE empl_codigo = @codigo_vendedor
	END

END
GO

DECLARE @retorno NUMERIC(6,2)
EXECUTE sp_calcular_comision 4, 10, 2011, @retorno OUTPUT
SELECT @retorno

SELECT * FROM Empleado e where e.empl_codigo = 4;
SELECT * FROM Factura f where f.fact_vendedor = 4;







--------

DECLARE @codigo_vendedor NUMERIC(6,0) = 4, @mes	INT = 10, @anio INT = 2011;
DECLARE @date_actual datetime = GETDATE();
DECLARE @actualizar_comision bit = 0;
DECLARE @comision_base NUMERIC(6,2) = 0;
DECLARE @comision_plus NUMERIC(6,2) = 0;
DECLARE @comision NUMERIC(6,2) = 0;
DECLARE @Ventas TABLE(
	Total DECIMAL (12,2),
	Cantidad_Vendida INT,
	Mes INT,
	Anio INT		
)
DECLARE @FechaIngresada DATETIME2

-- Código Defensivo
IF (@mes IS NULL AND @anio IS NOT NULL) OR (@anio IS NULL AND @mes IS NOT NULL) OR (@codigo_vendedor IS NULL)
	RETURN

IF @mes IS NULL AND @anio IS NULL
BEGIN
	SET @mes = MONTH(DATEADD(MONTH, -1, @date_actual));
	SET @anio = YEAR(DATEADD(MONTH, -1, @date_actual)); 
	SET @actualizar_comision = 1;
END

SET @FechaIngresada = CAST(CAST(@Anio AS varchar) + '-' + CAST(@Mes AS varchar) + '-1' AS DATETIME)

-- Guardamos todos los registros de ventas de los ultimos 4 meses, no necesitamos volver a acceder a Factura
INSERT INTO @Ventas
SELECT 
	SUM(ifa.item_precio * ifa.item_cantidad) as facturado,
	SUM(ifa.item_cantidad) as cantidad,
	MONTH(f.fact_fecha) as mes, 
	YEAR(f.fact_fecha) as anio
FROM Factura f
JOIN Item_Factura ifa ON f.fact_tipo = ifa.item_tipo AND f.fact_sucursal = ifa.item_sucursal AND f.fact_numero = ifa.item_numero
WHERE 
	f.fact_vendedor = 4 
	AND YEAR(f.fact_fecha) BETWEEN YEAR(DATEADD(MONTH, -4, @FechaIngresada)) AND @Anio
	AND MONTH(f.fact_fecha) BETWEEN MONTH(DATEADD(MONTH, -4, @FechaIngresada)) AND @Mes
GROUP BY YEAR(f.fact_fecha), MONTH(f.fact_fecha)
ORDER BY anio, mes DESC

-- Calculamos la comisión Base
SET @comision_base = ISNULL((
	SELECT v.Total 
	FROM @Ventas v
	WHERE v.Anio = @anio AND v.Mes = @mes
), 0) * 0.05;

DECLARE @total1 DECIMAL(12, 2), @cantidad1 DECIMAL(12,2), @mes1 INT, @anio1 INT;
DECLARE @cantidad2 DECIMAL(12,2);
DECLARE @hay_plus bit = 1;

-- Calculamos la comisión Plus
DECLARE c_ventas CURSOR FOR 
SELECT v.Total, v.Cantidad_Vendida, v.Mes, v.Anio FROM @Ventas v
OPEN c_ventas

FETCH NEXT FROM c_ventas INTO @total1, @cantidad1, @mes1, @anio1
WHILE (@@FETCH_STATUS = 0)
BEGIN
	SET @cantidad2 = ISNULL((
		SELECT v.Cantidad_Vendida 
		FROM @Ventas v 
		WHERE v.Mes = CASE v.Mes WHEN 1 then 12 else V.Mes - 1 END 
		AND v.Anio = CASE v.Mes WHEN 1 then @anio1 - 1 else @anio1 END 
	), 0);

	IF @cantidad2 > @cantidad1
		SET @hay_plus = 0

	FETCH NEXT FROM c_ventas INTO @total1, @cantidad1, @mes1, @anio1
END
CLOSE c_ventas
DEALLOCATE c_ventas

PRINT(CONCAT('Hay PLus ', @hay_plus))
PRINT(CONCAT('MES ', @Mes))	-- 10
PRINT(CONCAT('AÑO ', @Anio)) -- 2011

IF (@hay_plus = 1)
BEGIN
	SET @comision_plus = ISNULL((SELECT 0.02 * SUM(V.Total) FROM @Ventas V WHERE NOT(v.Anio = @Anio AND  v.Mes = @Mes)), 0) 
END

PRINT(@comision_plus)

SET @comision = @comision_base + @comision_plus;
	
IF @actualizar_comision = 1
BEGIN
	UPDATE Empleado
	SET empl_comision = @comision
	WHERE empl_codigo = @codigo_vendedor
END

PRINT(@comision)
