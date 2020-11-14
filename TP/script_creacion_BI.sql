RAISERROR ('1 - Creando tablas BI', 0, 1) WITH NOWAIT
GO

RAISERROR ('1.1 - Creando [BI_Tiempo]', 0, 1) WITH NOWAIT
GO
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Tiempo] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Año INT NULL,
	Mes INT NULL
)

RAISERROR ('1.2 - Creando [BI_CategoriaAutoParte]', 0, 1) WITH NOWAIT
GO
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_CategoriaAutoParte] (
	Codigo INT PRIMARY KEY IDENTITY(1,1),
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
-- Creación tabla Modelo
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Modelo] (
	Codigo DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
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
	Codigo DECIMAL(18, 0) IDENTITY PRIMARY KEY,
	Descripcion NVARCHAR(255)
)
GO


RAISERROR ('1.11 - Creando [BI_Compra_Venta_Auto_Autoparte]', 0, 1) WITH NOWAIT
GO
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Compra_Venta_Auto_Autoparte] (
	Tipo_Compra_Venta CHAR(1) NOT NULL,
	Tipo_Auto_Autoparte NVARCHAR(10) NOT NULL,
	Precio DECIMAL(18,2) NOT NULL,
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

--Creación clave forania de la tabla BI_Modelo con BI_Fabricante
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[BI_Modelo]  
ADD CONSTRAINT FK_FabricanteId FOREIGN KEY (FabricanteId)
REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Fabricante] (Id)
GO

--Creación clave forania de la tabla BI_Modelo con BI_Caja
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[BI_Modelo]  
ADD CONSTRAINT FK_CanjeId FOREIGN KEY (CanjeId)
REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Caja] (Codigo)
GO

--Creación clave forania de la tabla BI_Modelo con BI_Transmision
ALTER TABLE [LOS_CUATRO_FANTASTICOS].[BI_Modelo]  
ADD CONSTRAINT FK_TransmisionId FOREIGN KEY (TransmisionId)
REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Transmision] (Codigo)
GO

--Creación clave forania de la tabla BI_Modelo con BI_Motor
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
	SELECT [Codigo],[Descripcion], NULL
	FROM [LOS_CUATRO_FANTASTICOS].[Caja]
GO

RAISERROR ('2.4 - Insertando [BI_Motor]', 0, 1) WITH NOWAIT
GO
---Inserto datos de Tipo Motor
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Motor]([Codigo] ,[Descripcion])
	SELECT [Codigo],[Descripcion]
	FROM [LOS_CUATRO_FANTASTICOS].[Motor]
GO

RAISERROR ('2.4 - Insertando [BI_Sucursal]', 0, 1) WITH NOWAIT
GO
---Inserto datos de Sucursal
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Sucursal](Direccion, Mail, Telefono, Ciudad)
	SELECT [Direccion], [Mail], [Telefono], [Ciudad]
	FROM [LOS_CUATRO_FANTASTICOS].[Sucursal]
GO

RAISERROR ('2.4 - Insertando [BI_Cliente]', 0, 1) WITH NOWAIT
GO
---Inserto datos de Cliente
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Cliente](Id, Sexo, Edad)
	SELECT [Id], null, 
	CASE 
		WHEN DATEDIFF(YEAR, [Fecha_Nacimiento], GETDATE()) <= 30 THEN '18 - 30 años'
		WHEN DATEDIFF(YEAR, [Fecha_Nacimiento], GETDATE()) > 50 THEN '> 50 años'
		ELSE '31 - 50 años'
	END
	FROM [LOS_CUATRO_FANTASTICOS].[Cliente] as a
GO

RAISERROR ('2.4 - Insertando [BI_TipoAuto]', 0, 1) WITH NOWAIT
GO
---Inserto datos de TipoAuto
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_TipoAuto](Codigo, Descripcion)
	SELECT [Codigo], [Descripcion]
	FROM [LOS_CUATRO_FANTASTICOS].[TipoAuto]
GO

RAISERROR ('2 - Fin insertando datos', 0, 1) WITH NOWAIT
GO


---------------------------------------------------------

---------------------------------------------------------

RAISERROR ('3 - Creando Vistas', 0, 1) WITH NOWAIT
GO