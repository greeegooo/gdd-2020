USE [GD2C2020]
GO

------------------------------------------------------------
--                                                ESQUEMA --
------------------------------------------------------------

-- Creación de esquema 
CREATE SCHEMA [LOS_CUATRO_FANTASTICOS]
GO

------------------------------------------------------------
--                                            FIN ESQUEMA --
------------------------------------------------------------

------------------------------------------------------------
--                                                 TABLAS --
------------------------------------------------------------

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

-- Creación tabla Sucursal
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Sucursal] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Direccion NVARCHAR(255) NULL,
	Mail NVARCHAR(255) NULL,
	Telefono DECIMAL(18,0) NULL,
	Ciudad NVARCHAR(255) NULL
)
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

-- Creación tabla FacturaCliente
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[FacturaCliente] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nombre NVARCHAR(255) NULL,
	Apellido NVARCHAR(255) NULL,
	Direccion NVARCHAR(255) NULL,
	Dni DECIMAL(18,0) NULL,
	Fecha_Nacimiento DATETIME2(3) NULL,
	Mail NVARCHAR(255) NULL
)
GO

-- Creación tabla FacturaSucursal
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[FacturaSucursal] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Direccion NVARCHAR(255) NULL,
	Mail NVARCHAR(255) NULL,
	Telefono DECIMAL(18,0) NULL,
	Ciudad NVARCHAR(255) NULL
)
GO

-- Creación tabla Factura
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Factura] (
	Numero DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	Fecha DATETIME2(3) NOT NULL,
	Precio DECIMAL(18,2) NOT NULL,
	ClienteId INT NOT NULL REFERENCES [LOS_CUATRO_FANTASTICOS].[Cliente],
	FacturaClienteId INT NOT NULL REFERENCES [LOS_CUATRO_FANTASTICOS].[FacturaCliente],
	SucursalId INT NOT NULL REFERENCES [LOS_CUATRO_FANTASTICOS].[Sucursal],
	FacturaSucursalId INT NOT NULL REFERENCES [LOS_CUATRO_FANTASTICOS].[FacturaSucursal]
)
GO

--Creación tabla Auto
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Auto] (
	Id INT PRIMARY KEY,
	Chasis NVARCHAR(50) NULL,
	Motor  NVARCHAR(50) NULL,
	Patente NVARCHAR(50) NULL,
	Fecha_Alta DATETIME2(3) NULL,
	Cantidad_Kms DECIMAL(18,0) NULL,
	TipoAutoCodigo DECIMAL(18,0) NOT NULL,
	ModeloCodigo DECIMAL(18,0) NOT NULL,
)
GO

--Creación tabla Autoparte
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Autoparte] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255) NULL,
	ModeloId DECIMAL(18,0) NOT NULL,
	Categoria DECIMAL(18,0)
)
GO

-- Creación tabla CompraAuto
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[CompraAuto] (
	CompraNumero DECIMAL(18,0) REFERENCES [LOS_CUATRO_FANTASTICOS].[Compra],
	AutoId INT REFERENCES [LOS_CUATRO_FANTASTICOS].[Auto],
	Precio DECIMAL(18,2) NOT NULL,
	CONSTRAINT PK_CompraAuto PRIMARY KEY (CompraNumero, AutoId)
)
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

--Creación tabla TipoAuto
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[TipoAuto] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255) NULL,
)
GO

--Creación tabla Caja
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Caja] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255) NOT NULL,
)
GO


--Creación tabla Transmision
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Transmision] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255)  NOT NULL,
)
GO


--Creación tabla Motor
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Motor] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255)  NULL,
)
GO

--Creación tabla CategoriaAutoparte
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[CategoriaAutoparte] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255)  NULL,
)
GO

--Creación tabla Fabricante
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[Fabricante] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nombre NVARCHAR(255) NULL,
)
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

--Creación tabla FacturaAuto
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[FacturaAuto] (
	FacturaNumero DECIMAL(18,0) REFERENCES [LOS_CUATRO_FANTASTICOS].[Factura],
	AutoId  INT REFERENCES [LOS_CUATRO_FANTASTICOS].[Auto],
	Precio  DECIMAL(18,2) NOT NULL,
	CONSTRAINT PK_FacturaAuto PRIMARY KEY (FacturaNumero, AutoId)
)
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

-- Inserto datos de Fabricante
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Fabricante] (Nombre)
	SELECT 
		[FABRICANTE_NOMBRE]
	FROM gd_esquema.Maestra 
	GROUP BY [FABRICANTE_NOMBRE]
	ORDER BY [FABRICANTE_NOMBRE] 
GO


---Inserto datos de Tipo Transmision
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Transmision]([Codigo] ,[Descripcion])
	SELECT DISTINCT [TIPO_TRANSMISION_CODIGO], [TIPO_TRANSMISION_DESC]
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE [TIPO_TRANSMISION_CODIGO] IS NOT NULL

GO

---Inserto datos de Tipo Caja
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Caja]([Codigo] ,[Descripcion])
	SELECT DISTINCT TIPO_CAJA_CODIGO, TIPO_CAJA_DESC
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE TIPO_CAJA_CODIGO IS NOT NULL 

GO

---Inserto datos de Tipo Motor
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Motor]([Codigo] ,[Descripcion])
	SELECT DISTINCT TIPO_MOTOR_CODIGO, NULL
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE TIPO_MOTOR_CODIGO IS NOT NULL

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

---Inserto datos de TipoAuto
INSERT INTO [LOS_CUATRO_FANTASTICOS].[TipoAuto]([Codigo] ,[Descripcion])
	SELECT DISTINCT TIPO_AUTO_CODIGO, TIPO_AUTO_DESC
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE TIPO_AUTO_CODIGO is not null and TIPO_AUTO_DESC is not null

GO

---Inserto datos de Cliente
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Cliente]
           ([Nombre]
           ,[Apellido]
           ,[Direccion]
           ,[Dni]
           ,[Fecha_Nacimiento]
           ,[Mail])

	 SELECT CLIENTE_NOMBRE, CLIENTE_APELLIDO,CLIENTE_DIRECCION, CLIENTE_DNI, CLIENTE_FECHA_NAC, CLIENTE_MAIL 
	 FROM [GD2C2020].[gd_esquema].[Maestra]
	 WHERE CLIENTE_DNI IS NOT NULL 
		AND CLIENTE_FECHA_NAC IS NOT NULL
		AND CLIENTE_MAIL IS NOT NULL 
		AND  CLIENTE_NOMBRE IS NOT NULL
		AND CLIENTE_APELLIDO IS NOT NULL 
		AND CLIENTE_DIRECCION IS NOT NULL

GO

-- Inserto datos Sucursal
INSERT INTO [LOS_CUATRO_FANTASTICOS].[Sucursal] (Direccion, Mail, Telefono, Ciudad)
	SELECT DISTINCT [SUCURSAL_DIRECCION], [SUCURSAL_MAIL], [SUCURSAL_TELEFONO], [SUCURSAL_CIUDAD]
	FROM [gd_esquema].[Maestra]
	WHERE [SUCURSAL_CIUDAD] IS NOT NULL
	ORDER BY [SUCURSAL_CIUDAD]
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

--Inserto datos FacturaCliente
INSERT INTO [LOS_CUATRO_FANTASTICOS].[FacturaCliente] (Nombre, Apellido, Direccion, Dni, Fecha_Nacimiento, Mail)
SELECT 
	[FAC_CLIENTE_APELLIDO],
	[FAC_CLIENTE_NOMBRE],
	[FAC_CLIENTE_DIRECCION],
	[FAC_CLIENTE_DNI],
	[FAC_CLIENTE_FECHA_NAC],
	[FAC_CLIENTE_MAIL]
FROM [gd_esquema].[Maestra]
WHERE [FACTURA_NRO] IS NOT NULL AND [AUTO_PARTE_CODIGO] IS NULL
UNION 
SELECT DISTINCT
	[FAC_CLIENTE_APELLIDO],
	[FAC_CLIENTE_NOMBRE],
	[FAC_CLIENTE_DIRECCION],
	[FAC_CLIENTE_DNI],
	[FAC_CLIENTE_FECHA_NAC],
	[FAC_CLIENTE_MAIL]
FROM [gd_esquema].[Maestra]
WHERE [FACTURA_NRO] IS NOT NULL AND [AUTO_PARTE_CODIGO] IS NOT NULL 

-- Insert datos FacturaSucursal
INSERT INTO [LOS_CUATRO_FANTASTICOS].[FacturaSucursal] (Direccion, Mail, Telefono, Ciudad)
	SELECT 
		[FAC_SUCURSAL_DIRECCION],
		[FAC_SUCURSAL_MAIL],
		[FAC_SUCURSAL_TELEFONO],
		[FAC_SUCURSAL_CIUDAD]
	FROM [gd_esquema].[Maestra]
	WHERE [FACTURA_NRO] IS NOT NULL AND [AUTO_PARTE_CODIGO] IS NULL
GO

 INSERT INTO [LOS_CUATRO_FANTASTICOS].[FacturaSucursal] (Direccion, Mail, Telefono, Ciudad)
	(SELECT
		[FAC_SUCURSAL_DIRECCION],
		[FAC_SUCURSAL_MAIL],
		[FAC_SUCURSAL_TELEFONO],
		[FAC_SUCURSAL_CIUDAD]
	FROM [gd_esquema].[Maestra]
	WHERE [FACTURA_NRO] IS NOT NULL AND [AUTO_PARTE_CODIGO] IS NOT NULL 
	GROUP BY 
		[FAC_CLIENTE_APELLIDO],
		[FAC_CLIENTE_NOMBRE],
		[FAC_CLIENTE_DIRECCION],
		[FAC_CLIENTE_DNI],
		[FAC_CLIENTE_FECHA_NAC],
		[FAC_CLIENTE_MAIL],
		[FAC_SUCURSAL_DIRECCION],
		[FAC_SUCURSAL_MAIL],
		[FAC_SUCURSAL_TELEFONO],
		[FAC_SUCURSAL_CIUDAD])
GO

-- Insert datos Factura
--SET IDENTITY_INSERT [LOS_CUATRO_FANTASTICOS].[Factura] ON
--INSERT INTO [LOS_CUATRO_FANTASTICOS].[Factura] (Numero, Fecha, Precio, ClienteId, FacturaClienteId, SucursalId, FacturaSucursalId)
--	SELECT 
--		Numero = maestra.FACTURA_NRO
--		,Fecha = maestra.FACTURA_FECHA
--		,Precio = SUM(maestra.PRECIO_FACTURADO)
--		,1
--		,1
--		,1
--		,1
--	FROM gd_esquema.Maestra as maestra
--	WHERE FACTURA_NRO IS NOT NULL -- 57930 facturas
--	GROUP BY 
--		FACTURA_NRO,
--		FACTURA_FECHA
--SET IDENTITY_INSERT [LOS_CUATRO_FANTASTICOS].[Factura] OFF

------------------------------------------------------------
--                                              FIN DATOS --
------------------------------------------------------------
