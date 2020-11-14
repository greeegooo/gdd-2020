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

)
GO

RAISERROR ('1.5 - Creando [BI_Transmision]', 0, 1) WITH NOWAIT
GO
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Transmision] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255)  NOT NULL,
	Cantidad_Cambios INT NULL
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
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Caja]([Codigo] ,[Descripcion])
	SELECT [Codigo],[Descripcion]
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