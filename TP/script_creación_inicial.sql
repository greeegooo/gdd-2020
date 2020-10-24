USE [GD2C2020]
GO

RAISERROR ('Iniciando migración', 0, 1) WITH NOWAIT
GO
------------------------------------------------------------
--                                                ESQUEMA --
------------------------------------------------------------

RAISERROR ('0 - Creando schema', 0, 1) WITH NOWAIT
GO

-- Creación de esquema 
CREATE SCHEMA [LOS_CUATRO_FANTASTICOS]
GO
------------------------------------------------------------
--                                            FIN ESQUEMA --
------------------------------------------------------------

------------------------------------------------------------
--                                                 TABLAS --
------------------------------------------------------------

RAISERROR ('1 - Creando tablas', 0, 1) WITH NOWAIT
GO

RAISERROR ('1.1 - Creando Cliente', 0, 1) WITH NOWAIT
GO

-- Creación tabla Cliente
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Cliente] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nombre NVARCHAR(255) NULL,
	Apellido NVARCHAR(255) NULL,
	Direccion NVARCHAR(255) NULL,
	Dni DECIMAL(18,0) NULL,
	Fecha_Nacimiento DATETIME2(3) NULL,
	Mail NVARCHAR(255) NULL
)
GO

RAISERROR ('1.2 - Creando Sucursal', 0, 1) WITH NOWAIT
GO
-- Creación tabla Sucursal
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Sucursal] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Direccion NVARCHAR(255) NULL,
	Mail NVARCHAR(255) NULL,
	Telefono DECIMAL(18,0) NULL,
	Ciudad NVARCHAR(255) NULL
)
GO

RAISERROR ('1.3 - Creando Compra', 0, 1) WITH NOWAIT
GO
-- Creación tabla Compra
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Compra] (
	Numero DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	Fecha DATETIME2(3) NOT NULL,
	Precio DECIMAL(18,2) NOT NULL,
	SucursalId INT NOT NULL REFERENCES [LOS_CUATRO_FANTASTICOS].[Sucursal],
	ClienteId INT NOT NULL REFERENCES [LOS_CUATRO_FANTASTICOS].[Cliente]
) 
GO

RAISERROR ('1.4 - Creando Factura', 0, 1) WITH NOWAIT
GO
-- Creación tabla Factura
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Factura] (
	Numero DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	Fecha DATETIME2(3) NOT NULL,
	Precio DECIMAL(18,2) NOT NULL,
	ClienteId INT NOT NULL REFERENCES [LOS_CUATRO_FANTASTICOS].[Cliente],
	SucursalId INT NOT NULL REFERENCES [LOS_CUATRO_FANTASTICOS].[Sucursal],
)
GO

RAISERROR ('1.5 - Creando Cliente', 0, 1) WITH NOWAIT
GO
--Creación tabla Auto
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Auto] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Chasis NVARCHAR(50) NULL,
	Motor  NVARCHAR(50) NULL,
	Patente NVARCHAR(50) NULL,
	Fecha_Alta DATETIME2(3) NULL,
	Cantidad_Kms DECIMAL(18,0) NULL,
	TipoAutoCodigo DECIMAL(18,0) NOT NULL,
	ModeloCodigo DECIMAL(18,0) NOT NULL,
)
GO

RAISERROR ('1.6 - Creando Autoparte', 0, 1) WITH NOWAIT
GO
--Creación tabla Autoparte
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Autoparte] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255) NULL,
	ModeloId DECIMAL(18,0) NOT NULL,
	Categoria DECIMAL(18,0)
)
GO

RAISERROR ('1.7 - Creando CompraAuto', 0, 1) WITH NOWAIT
GO
-- Creación tabla CompraAuto
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[CompraAuto] (
	CompraNumero DECIMAL(18,0) REFERENCES [LOS_CUATRO_FANTASTICOS].[Compra],
	AutoId INT REFERENCES [LOS_CUATRO_FANTASTICOS].[Auto],
	Precio DECIMAL(18,2) NOT NULL,
	CONSTRAINT PK_CompraAuto PRIMARY KEY (CompraNumero, AutoId)
)
GO

RAISERROR ('1.8 - Creando CompraAutoparte', 0, 1) WITH NOWAIT
GO
-- Creación tabla CompraAutoparte
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[CompraAutoparte] (
	CompraNumero DECIMAL(18,0) REFERENCES [LOS_CUATRO_FANTASTICOS].[Compra],
	AutoparteId DECIMAL(18,0) REFERENCES [LOS_CUATRO_FANTASTICOS].[Autoparte],
	Cantidad DECIMAL(18,2) NOT NULL,
	Precio DECIMAL(18,2) NOT NULL,
	CONSTRAINT PK_CompraAutoparte PRIMARY KEY (CompraNumero, AutoparteId)
)
GO

RAISERROR ('1.9 - Creando TipoAuto', 0, 1) WITH NOWAIT
GO
--Creación tabla TipoAuto
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[TipoAuto] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255) NULL,
)
GO

RAISERROR ('1.10 - Creando Caja', 0, 1) WITH NOWAIT
GO
--Creación tabla Caja
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Caja] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255) NOT NULL,
)
GO

RAISERROR ('1.11 - Creando Transmision', 0, 1) WITH NOWAIT
GO
--Creación tabla Transmision
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Transmision] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255)  NOT NULL,
)
GO

RAISERROR ('1.12 - Creando Motor', 0, 1) WITH NOWAIT
GO
--Creación tabla Motor
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Motor] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255)  NULL,
)
GO

RAISERROR ('1.13 - Creando CatagoriaAutoparte', 0, 1) WITH NOWAIT
GO
--Creación tabla CategoriaAutoparte
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[CategoriaAutoparte] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255)  NULL,
)
GO

RAISERROR ('1.14 - Creando Fabricante', 0, 1) WITH NOWAIT
GO
--Creación tabla Fabricante
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Fabricante] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nombre NVARCHAR(255) NULL,
)
GO

RAISERROR ('1.15 - Creando Modelo', 0, 1) WITH NOWAIT
GO
--Creación tabla Modelo
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Modelo] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Nombre  NVARCHAR(50) NULL,
	Potencia  NVARCHAR(50) NULL,
	FabricanteId INT NOT NULL,
	TipoCajaId DECIMAL(18,0) NULL,
	TipoMotorId DECIMAL(18,0) NULL,
	TipoTransmisionId DECIMAL(18,0) NULL,
)
GO

RAISERROR ('1.16 - Creando FacturaAuto', 0, 1) WITH NOWAIT
GO
--Creación tabla FacturaAuto
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[FacturaAuto] (
	FacturaNumero DECIMAL(18,0) REFERENCES [LOS_CUATRO_FANTASTICOS].[Factura],
	AutoId  INT REFERENCES [LOS_CUATRO_FANTASTICOS].[Auto],
	Precio  DECIMAL(18,2) NOT NULL,
	CONSTRAINT PK_FacturaAuto PRIMARY KEY (FacturaNumero, AutoId)
)
GO

RAISERROR ('1.17 - Creando FacturaAutoparte', 0, 1) WITH NOWAIT
GO
--Creación tabla FacturaAutoparte
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[FacturaAutoparte] (
	FacturaNumero DECIMAL(18,0) REFERENCES [LOS_CUATRO_FANTASTICOS].[Factura],
	AutoparteId  DECIMAL(18,0) REFERENCES [LOS_CUATRO_FANTASTICOS].[Autoparte],
	Cantidad DECIMAL(18,2) NOT NULL,
	Precio  DECIMAL(18,2) NOT NULL,
	CONSTRAINT PK_FacturaAutoparte PRIMARY KEY(FacturaNumero, AutoparteId)
)
GO

RAISERROR ('1 - Fin Tablas', 0, 1) WITH NOWAIT
GO

RAISERROR ('2 - Creando de Constrains e Indices', 0, 1) WITH NOWAIT
GO

--Creación clave forania de la tabla Auto con  TIPOAUTO
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[Auto]  
ADD CONSTRAINT FK_Auto_TipoAuto FOREIGN KEY (TipoAutoCodigo)
REFERENCES [LOS_CUATRO_FANTASTICOS].[TipoAuto] (Codigo)
GO

--Creación clave forania de la tabla Auto con Modelo
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[Auto]
ADD CONSTRAINT FK_Auto_Modelo FOREIGN KEY (ModeloCodigo)
REFERENCES [LOS_CUATRO_FANTASTICOS].[Modelo] (Codigo)
GO

--Creación clave forania de la tabla Modelo con Fabricante
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[Modelo]
ADD CONSTRAINT FK_Modelo_Fabricante FOREIGN KEY (FabricanteId)
REFERENCES [LOS_CUATRO_FANTASTICOS].[Fabricante] (Id)
GO

--Creación clave forania de la tabla Modelo con tipo caja
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[Modelo]
ADD CONSTRAINT FK_Modelo_Caja FOREIGN KEY (TipoCajaId)
REFERENCES [LOS_CUATRO_FANTASTICOS].[Caja] (Codigo)
GO


--Creación clave forania de la tabla Modelo con tipo transmision
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[Modelo]
ADD CONSTRAINT FK_Modelo_Transmision FOREIGN KEY (TipoTransmisionId)
REFERENCES [LOS_CUATRO_FANTASTICOS].[Transmision] (Codigo)
GO

--Creación clave forania de la tabla Modelo con tipo motor
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[Modelo]
ADD CONSTRAINT FK_Modelo_Motor FOREIGN KEY (TipoMotorId)
REFERENCES [LOS_CUATRO_FANTASTICOS].[Motor] (Codigo)
GO

--Creación clave forania de la tabla AutoParte con  Modelo
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[Autoparte]
ADD CONSTRAINT FK_AutoParte_Modelo FOREIGN KEY (ModeloId)
REFERENCES [LOS_CUATRO_FANTASTICOS].[Modelo] (Codigo)
GO

--Creación clave forania de la tabla AutoParte con CategoriaAutoparte
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[Autoparte]
ADD CONSTRAINT FK_AutoParte_CategoriaAutoparte FOREIGN KEY (Categoria)
REFERENCES [LOS_CUATRO_FANTASTICOS].[CategoriaAutoparte] (Codigo)
GO

RAISERROR ('2 - Fin Constrains e Indices', 0, 1) WITH NOWAIT
GO
------------------------------------------------------------
--                                             FIN TABLAS --
------------------------------------------------------------

------------------------------------------------------------
--                                                INDICES --
------------------------------------------------------------

---- Creacion indice para tabla Cliente
--CREATE INDEX IDX_Cliente ON Cliente (Id) 
--GO

---- Creacion indice para tabla Sucursal
--CREATE INDEX IDX_Sucursal ON Sucursal (Id)
--GO

---- Creacion indice para tabla Compra
--CREATE INDEX IDX_Compra ON Compra (Numero)
--GO

---- Creacion indice para tabla Factura
--CREATE INDEX IDX_Factura ON Factura (Numero)
--GO

------------------------------------------------------------
--                                            FIN INDICES --
------------------------------------------------------------

------------------------------------------------------------
--                                                  DATOS --
------------------------------------------------------------

RAISERROR ('3 - Insertando Datos', 0, 1) WITH NOWAIT
GO

RAISERROR ('3.1 - Insertando Fabricante', 0, 1) WITH NOWAIT
GO
-- Inserto datos de Fabricante
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Fabricante] (Nombre)
	SELECT 
		[FABRICANTE_NOMBRE]
	FROM gd_esquema.Maestra 
	GROUP BY [FABRICANTE_NOMBRE]
	ORDER BY [FABRICANTE_NOMBRE] 
GO

RAISERROR ('3 - Insertando Transmision', 0, 1) WITH NOWAIT
GO
---Inserto datos de Tipo Transmision
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Transmision]([Codigo] ,[Descripcion])
	SELECT DISTINCT [TIPO_TRANSMISION_CODIGO], [TIPO_TRANSMISION_DESC]
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE [TIPO_TRANSMISION_CODIGO] IS NOT NULL

GO

RAISERROR ('3 - Insertando Caja', 0, 1) WITH NOWAIT
GO
---Inserto datos de Tipo Caja
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Caja]([Codigo] ,[Descripcion])
	SELECT DISTINCT TIPO_CAJA_CODIGO, TIPO_CAJA_DESC
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE TIPO_CAJA_CODIGO IS NOT NULL 

GO

RAISERROR ('3 - Insertando Motor', 0, 1) WITH NOWAIT
GO
---Inserto datos de Tipo Motor
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Motor]([Codigo] ,[Descripcion])
	SELECT DISTINCT TIPO_MOTOR_CODIGO, NULL
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE TIPO_MOTOR_CODIGO IS NOT NULL

GO

RAISERROR ('3 - Insertando Modelo', 0, 1) WITH NOWAIT
GO
-- Inserto datos de Modelo
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Modelo] (Codigo, Nombre, Potencia, FabricanteId, [TipoCajaId], [TipoMotorId], [TipoTransmisionId])
	 select m.MODELO_CODIGO, m.MODELO_NOMBRE, m.MODELO_POTENCIA, f.Id, m.TIPO_CAJA_CODIGO, m.TIPO_MOTOR_CODIGO, m.TIPO_TRANSMISION_CODIGO
  FROM [GD2C2020].[gd_esquema].[Maestra] m
  INNER JOIN [LOS_CUATRO_FANTASTICOS].[Fabricante] f on m.FABRICANTE_NOMBRE = f.[Nombre]
  INNER JOIN [LOS_CUATRO_FANTASTICOS].[Caja] c on m.TIPO_CAJA_CODIGO = c.[Codigo]
  INNER JOIN [LOS_CUATRO_FANTASTICOS].[Motor] mo on m.TIPO_MOTOR_CODIGO = mo.[Codigo]
  INNER JOIN [LOS_CUATRO_FANTASTICOS].[Transmision] t on m.TIPO_TRANSMISION_CODIGO = t.[Codigo]
  GROUP BY 
		m.[MODELO_CODIGO],
		m.[MODELO_NOMBRE],
		m.[MODELO_POTENCIA],
		f.Id,m.TIPO_CAJA_CODIGO, m.TIPO_MOTOR_CODIGO, m.TIPO_TRANSMISION_CODIGO

order by m.MODELO_CODIGO 
GO

RAISERROR ('3 - Insertando TipoAuto', 0, 1) WITH NOWAIT
GO
---Inserto datos de TipoAuto
INSERT INTO [LOS_CUATRO_FANTASTICOS].[TipoAuto]([Codigo] ,[Descripcion])
	SELECT DISTINCT TIPO_AUTO_CODIGO, TIPO_AUTO_DESC
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE TIPO_AUTO_CODIGO is not null and TIPO_AUTO_DESC is not null

GO

RAISERROR ('3 - Insertando Auto', 0, 1) WITH NOWAIT
GO
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Auto] ([Chasis], [Motor], [Patente], [Fecha_Alta], [Cantidad_Kms], [TipoAutoCodigo], [ModeloCodigo])
SELECT DISTINCT
	AUTO_NRO_CHASIS
	,AUTO_NRO_MOTOR
	,AUTO_PATENTE
	,AUTO_FECHA_ALTA
	,AUTO_CANT_KMS
	,TIPO_AUTO_CODIGO
	,MODELO_CODIGO
FROM [gd_esquema].[Maestra] as ma
JOIN [LOS_CUATRO_FANTASTICOS].[Modelo] as mo on ma.MODELO_CODIGO = mo.Codigo
JOIN [LOS_CUATRO_FANTASTICOS].TipoAuto as ta on ma.TIPO_AUTO_CODIGO = ta.Codigo



RAISERROR ('3 - Insertando Cliente', 0, 1) WITH NOWAIT
GO
---Inserto datos de Cliente
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Cliente]
           ([Apellido]
		   ,[Nombre]
           ,[Direccion]
           ,[Dni]
           ,[Fecha_Nacimiento]
           ,[Mail])

	 SELECT * FROM (
		SELECT Apellido = [FAC_CLIENTE_APELLIDO]
			  ,Nombre = [FAC_CLIENTE_NOMBRE]
			  ,Direccion = [FAC_CLIENTE_DIRECCION]
			  ,Dni = [FAC_CLIENTE_DNI]
			  ,Fecha_Nacimiento = [FAC_CLIENTE_FECHA_NAC]
			  ,Mail = [FAC_CLIENTE_MAIL]
		  FROM [GD2C2020].[gd_esquema].[Maestra]
		  WHERE FACTURA_NRO IS NOT NULL
		  GROUP BY [FAC_CLIENTE_APELLIDO]
			  ,[FAC_CLIENTE_NOMBRE]
			  ,[FAC_CLIENTE_DIRECCION]
			  ,[FAC_CLIENTE_DNI]
			  ,[FAC_CLIENTE_FECHA_NAC]
			  ,[FAC_CLIENTE_MAIL]
			UNION
		SELECT Apellido = [CLIENTE_APELLIDO]
			  ,Nombre = [CLIENTE_NOMBRE]
			  ,Direccion = [CLIENTE_DIRECCION]
			  ,Dni = [CLIENTE_DNI]
			  ,Fecha_Nacimiento = [CLIENTE_FECHA_NAC]
			  ,Mail = [CLIENTE_MAIL]
		  FROM [GD2C2020].[gd_esquema].[Maestra]
		  WHERE FACTURA_NRO IS NOT NULL 
		  GROUP BY 
			   [CLIENTE_APELLIDO]
			  ,[CLIENTE_NOMBRE]
			  ,[CLIENTE_DIRECCION]
			  ,[CLIENTE_DNI]
			  ,[CLIENTE_FECHA_NAC]
			  ,[CLIENTE_MAIL]) as clis
		WHERE Apellido IS NOT NULL

GO

RAISERROR ('3 - Insertando Sucursal', 0, 1) WITH NOWAIT
GO
-- Inserto datos Sucursal
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Sucursal] (Direccion, Mail, Telefono, Ciudad)
	SELECT DISTINCT [SUCURSAL_DIRECCION], [SUCURSAL_MAIL], [SUCURSAL_TELEFONO], [SUCURSAL_CIUDAD]
	FROM [gd_esquema].[Maestra]
	WHERE [SUCURSAL_CIUDAD] IS NOT NULL
	ORDER BY [SUCURSAL_CIUDAD]
GO

RAISERROR ('3 - Insertando Autoparte', 0, 1) WITH NOWAIT
GO
--Inserto datos de Autoparte
INSERT INTO [LOS_CUATRO_FANTASTICOS].Autoparte([Codigo], [Descripcion], [ModeloId], [Categoria])
SELECT DISTINCT 
	AUTO_PARTE_CODIGO,
	AUTO_PARTE_DESCRIPCION,
	MODELO_CODIGO,
	null AS AUTO_PARTE_CATEGORIA
FROM gd_esquema.Maestra
WHERE AUTO_PARTE_CODIGO IS NOT NULL
GO

RAISERROR ('3 - Insertando Factura', 0, 1) WITH NOWAIT
GO
-- Inserto datos Factura
SET IDENTITY_INSERT [LOS_CUATRO_FANTASTICOS].[Factura] ON
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Factura] (
	Numero, 
	Fecha, 
	Precio, 
	ClienteId,
	SucursalId
	)
	SELECT 
		Numero
		,Fecha
		,Precio
		,ClienteId = c.Id
		,SucursalId 
	FROM (
		SELECT 
			Numero = maestra.FACTURA_NRO
			,Fecha = maestra.FACTURA_FECHA
			,Precio = SUM(maestra.PRECIO_FACTURADO)
			,maestra.[FAC_CLIENTE_APELLIDO]
			,maestra.[FAC_CLIENTE_NOMBRE]
			,maestra.[FAC_CLIENTE_DIRECCION]
			,maestra.[FAC_CLIENTE_DNI]
			,maestra.[FAC_CLIENTE_FECHA_NAC]
			,maestra.[FAC_CLIENTE_MAIL]
			,SucursalId = (
				SELECT Id 
				FROM [LOS_CUATRO_FANTASTICOS].[Sucursal] as s
				WHERE FAC_SUCURSAL_CIUDAD = s.Ciudad
					AND FAC_SUCURSAL_DIRECCION = s.Direccion
					AND FAC_SUCURSAL_MAIL = s.Mail
					AND FAC_SUCURSAL_TELEFONO = s.Telefono
			)
		FROM gd_esquema.Maestra as maestra
		WHERE FACTURA_NRO IS NOT NULL -- 57930 facturas
		GROUP BY 
			[FACTURA_NRO]
			,[FACTURA_FECHA]
			,[FAC_CLIENTE_APELLIDO]
			,[FAC_CLIENTE_NOMBRE]
			,[FAC_CLIENTE_DIRECCION]
			,[FAC_CLIENTE_DNI]
			,[FAC_CLIENTE_FECHA_NAC]
			,[FAC_CLIENTE_MAIL]
			,[FAC_SUCURSAL_CIUDAD]
			,[FAC_SUCURSAL_DIRECCION]
			,[FAC_SUCURSAL_MAIL]
			,[FAC_SUCURSAL_TELEFONO]) as sarasa
	JOIN [LOS_CUATRO_FANTASTICOS].[Cliente] as c on sarasa.FAC_CLIENTE_DNI = c.Dni AND sarasa.FAC_CLIENTE_FECHA_NAC = c.Fecha_Nacimiento
SET IDENTITY_INSERT [LOS_CUATRO_FANTASTICOS].[Factura] OFF

RAISERROR ('3 - Insertando Compra', 0, 1) WITH NOWAIT
GO
SET IDENTITY_INSERT [LOS_CUATRO_FANTASTICOS].[Compra] ON
INSERT INTO LOS_CUATRO_FANTASTICOS.Compra(Numero, Fecha, Precio, ClienteId, SucursalId)
SELECT 
	Numero
	,Fecha
	,Precio
	,ClienteId = c.Id
	,SucursalId 
FROM (
	SELECT 
		Numero = maestra.COMPRA_NRO
		,Fecha = maestra.COMPRA_FECHA
		,Precio = SUM(maestra.COMPRA_PRECIO)
		,maestra.[CLIENTE_APELLIDO]
		,maestra.[CLIENTE_NOMBRE]
		,maestra.[CLIENTE_DIRECCION]
		,maestra.[CLIENTE_DNI]
		,maestra.[CLIENTE_FECHA_NAC]
		,maestra.[CLIENTE_MAIL]
		,SucursalId = (
			SELECT Id 
			FROM [LOS_CUATRO_FANTASTICOS].[Sucursal] as s
			WHERE SUCURSAL_CIUDAD = s.Ciudad
				AND SUCURSAL_DIRECCION = s.Direccion
				AND SUCURSAL_MAIL = s.Mail
				AND SUCURSAL_TELEFONO = s.Telefono
		)
	FROM gd_esquema.Maestra as maestra
	WHERE COMPRA_NRO IS NOT NULL -- 57930 facturas
	GROUP BY 
		[COMPRA_NRO]
		,[COMPRA_FECHA]
		,[CLIENTE_APELLIDO]
		,[CLIENTE_NOMBRE]
		,[CLIENTE_DIRECCION]
		,[CLIENTE_DNI]
		,[CLIENTE_FECHA_NAC]
		,[CLIENTE_MAIL]
		,[SUCURSAL_CIUDAD]
		,[SUCURSAL_DIRECCION]
		,[SUCURSAL_MAIL]
		,[SUCURSAL_TELEFONO]) as sarasa
JOIN [LOS_CUATRO_FANTASTICOS].[Cliente] as c on sarasa.CLIENTE_DNI = c.Dni AND sarasa.CLIENTE_FECHA_NAC = c.Fecha_Nacimiento
SET IDENTITY_INSERT [LOS_CUATRO_FANTASTICOS].[Compra] OFF

-- INSERT datos Compra Auto
INSERT INTO LOS_CUATRO_FANTASTICOS.CompraAuto(CompraNumero, AutoId, Precio)
SELECT DISTINCT
	compra.Numero, 
	autoTabla.Id,
	m.COMPRA_PRECIO
FROM [gd_esquema].[Maestra] as m
JOIN [LOS_CUATRO_FANTASTICOS].[Auto] as autoTabla on m.AUTO_NRO_CHASIS = autoTabla.Chasis AND m.AUTO_NRO_MOTOR = autoTabla.Motor AND m.AUTO_PATENTE = autoTabla.Patente
JOIN [LOS_CUATRO_FANTASTICOS].[Compra] as compra on m.COMPRA_NRO = compra.Numero

-- INSERT datos Compra AutoParte
INSERT INTO LOS_CUATRO_FANTASTICOS.CompraAutoparte(CompraNumero, AutoparteId, Precio, Cantidad)
SELECT 
	compraMaestra.COMPRA_NRO, 
	autoparteTb.Codigo,
	compraMaestra.COMPRA_PRECIO,
	compraMaestra.COMPRA_CANT
FROM (
	SELECT 
		gm.COMPRA_NRO,
		gm.COMPRA_PRECIO,
		gm.AUTO_PARTE_CODIGO,
		gm.COMPRA_CANT
	FROM gd_esquema.Maestra gm
	WHERE gm.AUTO_PARTE_CODIGO IS NOT NULL
) as compraMaestra
JOIN LOS_CUATRO_FANTASTICOS.Autoparte autoparteTb ON autoparteTb.Codigo = compraMaestra.AUTO_PARTE_CODIGO

-- INSERT datos FacturaAuto
INSERT INTO LOS_CUATRO_FANTASTICOS.FacturaAuto(FacturaNumero, AutoId, Precio)
SELECT
	autoFactura.FACTURA_NRO,
	autoTb.Id,
	autoFactura.PRECIO_FACTURADO
FROM (
	SELECT
		gm.FACTURA_NRO,
		gm.AUTO_PATENTE,
		gm.PRECIO_FACTURADO
	FROM gd_esquema.Maestra gm
	WHERE gm.FACTURA_FECHA IS NOT NULL AND gm.AUTO_PATENTE IS NOT NULL
) as autoFactura
JOIN LOS_CUATRO_FANTASTICOS.Auto autoTb ON autoTb.Patente = autoFactura.AUTO_PATENTE;

-- INSERT datos FacturaAutoparte
INSERT INTO LOS_CUATRO_FANTASTICOS.FacturaAutoparte(FacturaNumero, AutoparteId, Precio, Cantidad)
SELECT
	autoParteFactura.FACTURA_NRO,
	autoParteTb.Codigo,
	autoParteFactura.PRECIO_FACTURADO,
	autoParteFactura.CANT_FACTURADA
FROM (
	SELECT
		gm.FACTURA_NRO,
		gm.AUTO_PARTE_CODIGO,
		gm.PRECIO_FACTURADO,
		gm.CANT_FACTURADA
	FROM gd_esquema.Maestra gm
	WHERE gm.FACTURA_FECHA IS NOT NULL AND gm.AUTO_PARTE_CODIGO IS NOT NULL
) as autoParteFactura
JOIN LOS_CUATRO_FANTASTICOS.Autoparte autoParteTb ON autoParteTb.Codigo = autoParteFactura.AUTO_PARTE_CODIGO;

RAISERROR ('3 - Fin datos', 0, 1) WITH NOWAIT
GO

------------------------------------------------------------
--                                              FIN DATOS --
------------------------------------------------------------

RAISERROR ('3 - Fin migración', 0, 1) WITH NOWAIT
GO