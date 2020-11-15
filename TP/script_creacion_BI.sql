RAISERROR ('1 - Creando tablas BI', 0, 1) WITH NOWAIT
GO

RAISERROR ('1.1 - Creando [BI_Tiempo]', 0, 1) WITH NOWAIT
GO
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Tiempo] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	A�o INT NULL,
	Mes INT NULL
)

RAISERROR ('1.2 - Creando [BI_CategoriaAutoParte]', 0, 1) WITH NOWAIT
GO
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_CategoriaAutoParte] (
	Codigo INT PRIMARY KEY,
	Descripcion NVARCHAR(255) NULL
)


RAISERROR ('1.3 - Creando [BI_Fabricante]', 0, 1) WITH NOWAIT
GO
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Fabricante] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nombre NVARCHAR(255) NULL,
)
GO

RAISERROR ('1.4 - Creando [BI_Caja]', 0, 1) WITH NOWAIT
GO
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Caja] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255) NOT NULL,
	Cantidad_Cambios INT NULL
)
GO

RAISERROR ('1.5 - Creando [BI_Transmision]', 0, 1) WITH NOWAIT
GO
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Transmision] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255)  NOT NULL
)
GO

RAISERROR ('1.6 - Creando [BI_Motor]', 0, 1) WITH NOWAIT
GO
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Motor] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255)  NULL,
)
GO

RAISERROR ('1.7 - Creando [BI_Modelo]', 0, 1) WITH NOWAIT
GO
-- Creaci�n tabla Modelo
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Modelo] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Nombre NVARCHAR(50) NULL,
	Potencia NVARCHAR(50) NULL,
	FabricanteId INT NOT NULL,
	CajaId DECIMAL(18,0) NULL,
	TransmisionId DECIMAL(18,0) NULL,
	MotorId DECIMAL(18,0) NULL
)
GO

RAISERROR ('1.8 - Creando [BI_Sucursal]', 0, 1) WITH NOWAIT
GO
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Sucursal] (
	Id INT IDENTITY PRIMARY KEY,
	Direccion NVARCHAR(255) NOT NULL,
	Mail NVARCHAR(255) NOT NULL,
	Telefono DECIMAL(18, 0) NOT NULL,
	Ciudad NVARCHAR(255) NOT NULL
)
GO

RAISERROR ('1.9 - Creando [BI_Cliente]', 0, 1) WITH NOWAIT
GO
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Cliente] (
	Id INT PRIMARY KEY,
	Edad NVARCHAR(11) NOT NULL,
	Sexo CHAR(1)
)
GO

RAISERROR ('1.10 - Creando Tipo Auto', 0, 1) WITH NOWAIT
GO
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_TipoAuto] (
	Codigo DECIMAL(18, 0) PRIMARY KEY,
	Descripcion NVARCHAR(255)
)
GO


RAISERROR ('1.11 - Creando [BI_Compra_Venta_Auto_Autoparte]', 0, 1) WITH NOWAIT
GO
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Compra_Venta_Auto_Autoparte] (
	Tipo_Compra_Venta CHAR(1) NOT NULL,
	Tipo_Auto_Autoparte NVARCHAR(10) NOT NULL,
	Precio DECIMAL(18,2) NOT NULL,
	Cantidad DECIMAL(18,2) NULL,
	IdCliente INT REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Cliente],
	IdSucursal INT REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Sucursal],
	IdTiempo INT REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Tiempo],
	IdModelo DECIMAL(18, 0) REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Modelo],
	IdTipoAuto DECIMAL(18, 0) NULL REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_TipoAuto],
	IdCategoria INT NULL REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_CategoriaAutoparte]
)

GO

RAISERROR ('1.12 - Creando de Constrains e Indices', 0, 1) WITH NOWAIT
GO

--Creaci�n clave forania de la tabla BI_Modelo con BI_Fabricante
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[BI_Modelo]  
ADD CONSTRAINT FK_FabricanteId FOREIGN KEY (FabricanteId)
REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Fabricante] (Id)
GO

--Creaci�n clave forania de la tabla BI_Modelo con BI_Caja
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[BI_Modelo]  
ADD CONSTRAINT FK_CajaId FOREIGN KEY (CajaId)
REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Caja] (Codigo)
GO

--Creaci�n clave forania de la tabla BI_Modelo con BI_Transmision
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[BI_Modelo]  
ADD CONSTRAINT FK_TransmisionId FOREIGN KEY (TransmisionId)
REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Transmision] (Codigo)
GO

--Creaci�n clave forania de la tabla BI_Modelo con BI_Motor
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[BI_Modelo]  
ADD CONSTRAINT FK_MotorId FOREIGN KEY (MotorId)
REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Motor] (Codigo)
GO

RAISERROR ('1 - Fin Tablas', 0, 1) WITH NOWAIT
GO



---------------------------------------------------------

---------------------------------------------------------

RAISERROR ('2 - Insertando datos', 0, 1) WITH NOWAIT
GO

RAISERROR ('2.1 - Insertando [BI_Fabricante]', 0, 1) WITH NOWAIT
GO
-- Inserto datos de Fabricante
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Fabricante] (Nombre)
	SELECT 
		[Nombre]
	FROM [LOS_CUATRO_FANTASTICOS].[Fabricante]
GO

RAISERROR ('2.2 - Insertando [BI_Transmision]', 0, 1) WITH NOWAIT
GO
---Inserto datos de Tipo Transmision
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Transmision]([Codigo] ,[Descripcion])
	SELECT[Codigo],[Descripcion]
	FROM [LOS_CUATRO_FANTASTICOS].[Transmision]
GO

RAISERROR ('2.3 - Insertando [BI_Caja]', 0, 1) WITH NOWAIT
GO
---Inserto datos de Tipo Caja
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Caja]([Codigo] ,[Descripcion], [Cantidad_Cambios])
	SELECT [Codigo],[Descripcion], null
	FROM [LOS_CUATRO_FANTASTICOS].[Caja]
GO

RAISERROR ('2.4 - Insertando [BI_Motor]', 0, 1) WITH NOWAIT
GO
---Inserto datos de Tipo Motor
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Motor]([Codigo] ,[Descripcion])
	SELECT [Codigo],[Descripcion]
	FROM [LOS_CUATRO_FANTASTICOS].[Motor]
GO

RAISERROR ('2.5 - Insertando [BI_Sucursal]', 0, 1) WITH NOWAIT
GO
---Inserto datos de Sucursal
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Sucursal](Direccion, Mail, Telefono, Ciudad)
	SELECT [Direccion], [Mail], [Telefono], [Ciudad]
	FROM [LOS_CUATRO_FANTASTICOS].[Sucursal]
GO

RAISERROR ('2.6 Insertando [BI_Cliente]', 0, 1) WITH NOWAIT
GO
---Inserto datos de Cliente
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Cliente](Id, Sexo, Edad)
	SELECT [Id], null, 
	CASE 
		WHEN DATEDIFF(YEAR, [Fecha_Nacimiento], GETDATE()) <= 30 THEN '18-30 a�os'
		WHEN DATEDIFF(YEAR, [Fecha_Nacimiento], GETDATE()) > 50 THEN '> 50 a�os'
		ELSE '31-50 a�os'
	END
	FROM [LOS_CUATRO_FANTASTICOS].[Cliente] as a
GO

RAISERROR ('2.7 - Insertando [BI_TipoAuto]', 0, 1) WITH NOWAIT
GO
---Inserto datos de TipoAuto
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_TipoAuto](Codigo, Descripcion)
	SELECT [Codigo], [Descripcion]
	FROM [LOS_CUATRO_FANTASTICOS].[TipoAuto]
GO

RAISERROR ('2.8 - Insertando BI_CategoriaAutoParte', 0, 1) WITH NOWAIT
GO
---Inserto datos de BI_CategoriaAutoParte
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_CategoriaAutoParte]([Codigo] ,[Descripcion])
SELECT DISTINCT [Codigo],[Descripcion]
  FROM [LOS_CUATRO_FANTASTICOS].[CategoriaAutoparte]

GO

RAISERROR ('2.9 - Insertando BI_Modelo', 0, 1) WITH NOWAIT
GO
---Inserto datos de BI_Modelo
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Modelo](
	   [Codigo]
      ,[Nombre]
      ,[Potencia]
      ,[FabricanteId]
      ,[CajaId]
      ,[MotorId]
      ,[TransmisionId])
SELECT DISTINCT 
	   [Codigo]
      ,[Nombre]
      ,[Potencia]
      ,[FabricanteId]
      ,[TipoCajaId]
      ,[TipoMotorId]
      ,[TipoTransmisionId]
  FROM [LOS_CUATRO_FANTASTICOS].[Modelo]

GO

RAISERROR ('2.10 - Insertando BI_Tiempo', 0, 1) WITH NOWAIT
GO
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Tiempo] (A�o, Mes)
SELECT * FROM (
SELECT DISTINCT
	Anio = YEAR(Fecha), 
	Mes = MONTH(Fecha)
FROM [LOS_CUATRO_FANTASTICOS].[Compra]
--ORDER BY Anio, Mes
UNION
SELECT DISTINCT
	Anio = YEAR(Fecha), 
	Mes = MONTH(Fecha)
FROM [LOS_CUATRO_FANTASTICOS].[Factura]) as tiempo
ORDER BY Anio, Mes

RAISERROR ('2.11 - Insertando BI_Compra_Venta_Auto_Autoparte', 0, 1) WITH NOWAIT
GO
-- COMPRA AUTO
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Compra_Venta_Auto_Autoparte] 
([IdCliente], [IdSucursal], [IdTiempo], [IdModelo], [IdTipoAuto], [IdCategoria], [Tipo_Compra_Venta], [Tipo_Auto_Autoparte], [Precio], [Cantidad])
SELECT 
	[IdCliente] = bicliente.Id, 
	[IdSucursal] = compra.SucursalId, 
	[IdTiempo] = (
		SELECT Id 
		FROM [LOS_CUATRO_FANTASTICOS].[BI_Tiempo] as bitiempo 
		WHERE bitiempo.A�o = YEAR(compra.Fecha) 
			and bitiempo.Mes = MONTH(compra.Fecha)), 
	[IdModelo] = modelo.Codigo, 
	[IdTipoAuto] = tipoauto.Codigo, 
	[IdCategoria] = null, 
	[Tipo_Compra_Venta] = 'C', 
	[Tipo_Auto_Autoparte] = 'AUTO', 
	[Precio] = compraauto.Precio,
	[Cantidad] = null
FROM [LOS_CUATRO_FANTASTICOS].[Compra] as compra
INNER JOIN [LOS_CUATRO_FANTASTICOS].[CompraAuto] as compraauto on compra.Numero = compraauto.CompraNumero
INNER JOIN [LOS_CUATRO_FANTASTICOS].[Auto] as autoo on compraauto.AutoId = autoo.Id
INNER JOIN [LOS_CUATRO_FANTASTICOS].[TipoAuto] as tipoauto on autoo.TipoAutoCodigo = tipoauto.Codigo
INNER JOIN [LOS_CUATRO_FANTASTICOS].[Modelo] as modelo on autoo.ModeloCodigo = modelo.Codigo
INNER JOIN [LOS_CUATRO_FANTASTICOS].[BI_Cliente] as bicliente on bicliente.Id = compra.ClienteId
GO

-- COMPRA AUTOPARTE
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Compra_Venta_Auto_Autoparte] 
([IdCliente], [IdSucursal], [IdTiempo], [IdModelo], [IdTipoAuto], [IdCategoria], [Tipo_Compra_Venta], [Tipo_Auto_Autoparte], [Precio], [Cantidad])
SELECT 
	[IdCliente] = bicliente.Id, 
	[IdSucursal] = compra.SucursalId, 
	[IdTiempo] = (
		SELECT Id 
		FROM [LOS_CUATRO_FANTASTICOS].[BI_Tiempo] as bitiempo 
		WHERE bitiempo.A�o = YEAR(compra.Fecha) 
			and bitiempo.Mes = MONTH(compra.Fecha)), 
	[IdModelo] = modelo.Codigo, 
	[IdTipoAuto] = null, 
	[IdCategoria] = categoria.Codigo, 
	[Tipo_Compra_Venta] = 'C', 
	[Tipo_Auto_Autoparte] = 'AUTOPARTE', 
	[Precio] = compraautoparte.Precio,
	[Cantidad] = compraautoparte.Cantidad
FROM [LOS_CUATRO_FANTASTICOS].[Compra] as compra
INNER JOIN [LOS_CUATRO_FANTASTICOS].[CompraAutoparte] as compraautoparte on compra.Numero = compraautoparte.CompraNumero
INNER JOIN [LOS_CUATRO_FANTASTICOS].[Autoparte] as autoparte on compraautoparte.AutoparteId = autoparte.Codigo
LEFT JOIN [LOS_CUATRO_FANTASTICOS].[CategoriaAutoparte] as categoria on categoria.Codigo = autoparte.Categoria
INNER JOIN [LOS_CUATRO_FANTASTICOS].[Modelo] as modelo on modelo.Codigo = autoparte.ModeloId
INNER JOIN [LOS_CUATRO_FANTASTICOS].[BI_Cliente] as bicliente on bicliente.Id = compra.ClienteId
GO

-- VENTA AUTO
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Compra_Venta_Auto_Autoparte] 
([IdCliente], [IdSucursal], [IdTiempo], [IdModelo], [IdTipoAuto], [IdCategoria], [Tipo_Compra_Venta], [Tipo_Auto_Autoparte], [Precio], [Cantidad])
SELECT 
	[IdCliente] = bicliente.Id, 
	[IdSucursal] = factura.SucursalId, 
	[IdTiempo] = (
		SELECT Id 
		FROM [LOS_CUATRO_FANTASTICOS].[BI_Tiempo] as bitiempo 
		WHERE bitiempo.A�o = YEAR(factura.Fecha) 
			and bitiempo.Mes = MONTH(factura.Fecha)), 
	[IdModelo] = modelo.Codigo, 
	[IdTipoAuto] = tipoauto.Codigo, 
	[IdCategoria] = null, 
	[Tipo_Compra_Venta] = 'V', 
	[Tipo_Auto_Autoparte] = 'AUTO', 
	[Precio] = facturaauto.Precio,
	[Cantidad] = null
FROM [LOS_CUATRO_FANTASTICOS].[Factura] as factura
INNER JOIN [LOS_CUATRO_FANTASTICOS].[FacturaAuto] as facturaauto on factura.Numero = facturaauto.FacturaNumero
INNER JOIN [LOS_CUATRO_FANTASTICOS].[Auto] as autoo on facturaauto.AutoId = autoo.Id
INNER JOIN [LOS_CUATRO_FANTASTICOS].[TipoAuto] as tipoauto on autoo.TipoAutoCodigo = tipoauto.Codigo
INNER JOIN [LOS_CUATRO_FANTASTICOS].[Modelo] as modelo on autoo.ModeloCodigo = modelo.Codigo
INNER JOIN [LOS_CUATRO_FANTASTICOS].[BI_Cliente] as bicliente on bicliente.Id = factura.ClienteId
GO

-- VENTA AUTOPARTE
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Compra_Venta_Auto_Autoparte] 
([IdCliente], [IdSucursal], [IdTiempo], [IdModelo], [IdTipoAuto], [IdCategoria], [Tipo_Compra_Venta], [Tipo_Auto_Autoparte], [Precio], [Cantidad])
SELECT 
	[IdCliente] = bicliente.Id, 
	[IdSucursal] = factura.SucursalId, 
	[IdTiempo] = (
		SELECT Id 
		FROM [LOS_CUATRO_FANTASTICOS].[BI_Tiempo] as bitiempo 
		WHERE bitiempo.A�o = YEAR(factura.Fecha) 
			and bitiempo.Mes = MONTH(factura.Fecha)), 
	[IdModelo] = modelo.Codigo, 
	[IdTipoAuto] = null, 
	[IdCategoria] = categoria.Codigo, 
	[Tipo_Compra_Venta] = 'V', 
	[Tipo_Auto_Autoparte] = 'AUTOPARTE', 
	[Precio] = facturaautoparte.Precio,
	[Cantidad] = facturaautoparte.Cantidad
FROM [LOS_CUATRO_FANTASTICOS].[Factura] as factura
INNER JOIN [LOS_CUATRO_FANTASTICOS].[FacturaAutoparte] as facturaautoparte on factura.Numero = facturaautoparte.FacturaNumero
INNER JOIN [LOS_CUATRO_FANTASTICOS].[Autoparte] as autoparte on facturaautoparte.AutoparteId = autoparte.Codigo
LEFT JOIN [LOS_CUATRO_FANTASTICOS].[CategoriaAutoparte] as categoria on categoria.Codigo = autoparte.Categoria
INNER JOIN [LOS_CUATRO_FANTASTICOS].[Modelo] as modelo on modelo.Codigo = autoparte.ModeloId
INNER JOIN [LOS_CUATRO_FANTASTICOS].[BI_Cliente] as bicliente on bicliente.Id = factura.ClienteId

RAISERROR ('2 - Fin insertando datos', 0, 1) WITH NOWAIT
GO


---------------------------------------------------------

---------------------------------------------------------

RAISERROR ('3 - Creando Vistas', 0, 1) WITH NOWAIT
GO

CREATE VIEW view_automoviles_vendidos_comprados_surcursal_mes AS (
	SELECT 
		sucursal.Id AS [Sucursal_ID],
		tiempo.A�o AS [A�o],
		tiempo.Mes AS [Mes],
		COUNT(1) AS [Cantidad],
		compra_venta.Tipo_Compra_Venta AS [Tipo_Compra_Venta]
	FROM [LOS_CUATRO_FANTASTICOS].[BI_Compra_Venta_Auto_Autoparte] AS compra_venta
		INNER JOIN [LOS_CUATRO_FANTASTICOS].[BI_Tiempo] AS tiempo ON (tiempo.Id = compra_venta.IdTiempo)
		INNER JOIN [LOS_CUATRO_FANTASTICOS].[BI_Sucursal] AS sucursal ON (sucursal.Id = compra_venta.IdSucursal)
	WHERE compra_venta.Tipo_Auto_Autoparte = 'AUTO'
	GROUP BY compra_venta.Tipo_Compra_Venta, tiempo.A�o, tiempo.Mes, sucursal.Id
)
GO

CREATE VIEW view_precio_promedio_automoviles_vendidos_comprados AS (
	SELECT 
		modelo.Nombre AS [Modelo],
		compra_venta.Tipo_Compra_Venta AS [Tipo_Compra_Venta],
		FLOOR(AVG(compra_venta.Precio)) AS [Precio_Promedio]
	FROM [LOS_CUATRO_FANTASTICOS].[BI_Compra_Venta_Auto_Autoparte] AS compra_venta
		INNER JOIN [LOS_CUATRO_FANTASTICOS].[BI_Modelo] AS modelo ON (modelo.Codigo = compra_venta.IdModelo)
	WHERE compra_venta.Tipo_Auto_Autoparte = 'AUTO'
	GROUP BY compra_venta.Tipo_Compra_Venta, modelo.Nombre
)
GO

CREATE VIEW view_precio_promedio_autoparte_vendidos_comprados AS (
	SELECT 
		modelo.Nombre AS [Modelo],
		compra_venta.Tipo_Compra_Venta AS [Tipo_Compra_Venta],
		FLOOR(AVG(compra_venta.Precio)) AS [Precio_Promedio]
	FROM [LOS_CUATRO_FANTASTICOS].[BI_Compra_Venta_Auto_Autoparte] AS compra_venta
		INNER JOIN [LOS_CUATRO_FANTASTICOS].[BI_Modelo] AS modelo ON (modelo.Codigo = compra_venta.IdModelo)
	WHERE compra_venta.Tipo_Auto_Autoparte = 'AUTOPARTE'
	GROUP BY compra_venta.Tipo_Compra_Venta, modelo.Nombre
)
GO

CREATE VIEW view_auto_ganancias_sucursal_mes AS
	WITH compra_venta_precio AS(
		SELECT 
			sucursal.Id AS [Sucursal_ID],
			tiempo.Mes AS [Mes],
			compraVenta.Tipo_Compra_Venta AS [Tipo],
			compraVenta.IdModelo AS [Modelo],
			CASE
				WHEN compraVenta.Tipo_Compra_Venta = 'c' THEN (-1) * SUM(compraVenta.Precio)
				ELSE SUM(compraVenta.Precio)
			END AS [Precio]		
		FROM [LOS_CUATRO_FANTASTICOS].[BI_Compra_Venta_Auto_Autoparte] as compraVenta
			INNER JOIN [LOS_CUATRO_FANTASTICOS].[BI_Tiempo] AS tiempo ON (tiempo.Id = compraVenta.IdTiempo)
			INNER JOIN [LOS_CUATRO_FANTASTICOS].[BI_Sucursal] AS sucursal ON (sucursal.Id = compraVenta.IdSucursal)
		WHERE compraVenta.Tipo_Auto_Autoparte = 'AUTO'
		GROUP BY sucursal.Id, tiempo.Mes, compraVenta.IdModelo, compraVenta.Tipo_Compra_Venta
	) 
(
	SELECT 
		q1.Sucursal_ID,
		q1.Mes,
		CASE
			WHEN SUM(q2.Precio + q1.Precio) IS NULL THEN SUM(isnull(q2.Precio, 0) + isnull(q1.Precio, 0))
			ELSE SUM(q2.Precio + q1.Precio)
		END AS Ganancia_Perdida
	FROM compra_venta_precio q1
		FULL OUTER JOIN compra_venta_precio q2 on (
			q1.Sucursal_ID = q2.Sucursal_ID 
			AND q1.Mes = q2.Mes 
			AND q1.Modelo = q2.Modelo
			AND q1.Tipo = 'c' AND q2.Tipo = 'v'
		)
	GROUP BY q1.Sucursal_ID, q1.Mes
	HAVING q1.Sucursal_ID IS NOT NULL
)
GO

CREATE VIEW view_autoparte_ganancias_sucursal_mes AS
	WITH compra_venta_precio AS(
		SELECT 
			sucursal.Id AS [Sucursal_ID],
			tiempo.Mes AS [Mes],
			compraVenta.Tipo_Compra_Venta AS [Tipo],
			compraVenta.IdModelo AS [Modelo],
			CASE
				WHEN compraVenta.Tipo_Compra_Venta = 'c' THEN (-1) * SUM(compraVenta.Precio)
				ELSE SUM(compraVenta.Precio)
			END AS [Precio]		
		FROM [LOS_CUATRO_FANTASTICOS].[BI_Compra_Venta_Auto_Autoparte] as compraVenta
			INNER JOIN [LOS_CUATRO_FANTASTICOS].[BI_Tiempo] AS tiempo ON (tiempo.Id = compraVenta.IdTiempo)
			INNER JOIN [LOS_CUATRO_FANTASTICOS].[BI_Sucursal] AS sucursal ON (sucursal.Id = compraVenta.IdSucursal)
		WHERE compraVenta.Tipo_Auto_Autoparte = 'AUTOPARTE'
		GROUP BY sucursal.Id, tiempo.Mes, compraVenta.IdModelo, compraVenta.Tipo_Compra_Venta
	) 
(
	SELECT 
		q1.Sucursal_ID,
		q1.Mes,
		CASE
			WHEN SUM(q2.Precio + q1.Precio) IS NULL THEN SUM(isnull(q2.Precio, 0) + isnull(q1.Precio, 0))
			ELSE SUM(q2.Precio + q1.Precio)
		END AS Ganancia_Perdida
	FROM compra_venta_precio q1
		FULL OUTER JOIN compra_venta_precio q2 on (
			q1.Sucursal_ID = q2.Sucursal_ID 
			AND q1.Mes = q2.Mes 
			AND q1.Modelo = q2.Modelo
			AND q1.Tipo = 'c' AND q2.Tipo = 'v'
		)
	GROUP BY q1.Sucursal_ID, q1.Mes
	HAVING q1.Sucursal_ID IS NOT NULL
)
GO

-- Autom�viles:
--- Cantidad de autom�viles, vendidos y comprados x sucursal y mes. (view_automoviles_vendidos_comprados_surcursal_mes)
--- Precio promedio de autom�viles, vendidos y comprados. (view_precio_promedio_automoviles_vendidos_comprados)
--- Ganancias (precio de venta � precio de compra) x Sucursal x mes. (view_ganancias_sucursal_mes)
--- Promedio de tiempo en stock de cada modelo de autom�vil.

-- Autopartes
--- Precio promedio de cada autoparte, vendida y comprada. (view_precio_promedio_autoparte_vendidos_comprados)
--- Ganancias (precio de venta � precio de compra) x Sucursal x mes. (view_autoparte_ganancias_sucursal_mes)
--- Promedio de tiempo en stock de cada autoparte.
--- M�xima cantidad de stock por cada sucursal (anual).





-- Si hay columna compra_y_venta usar ese, sino compra_o_venta

-- Mes 1  -22.359.513
-- Mes 2  -20.604.194 + 18.544.272 = -2.059.921
-- Mes 3  -36434665 + 12082820 = -24.351.845
-- Mes 5  -17265794 
-- Mes 7  +11929541
-- Mes 10 +9750278
-- Mes 11 -8756971
-- Mes 12 +9099542
