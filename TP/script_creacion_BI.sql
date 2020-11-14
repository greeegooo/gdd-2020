RAISERROR ('1 - Creando tablas BI', 0, 1) WITH NOWAIT
GO

RAISERROR ('1. - Creando [BI_Tiempo]', 0, 1) WITH NOWAIT
GO
-- Creación tabla Tiempo
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Tiempo] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Año INT NULL,
	Mes INT NULL
)

RAISERROR ('1. - Creando [BI_CategoriaAutoParte]', 0, 1) WITH NOWAIT
GO
-- Creación tabla CategoriaAutoParte
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_CategoriaAutoParte] (
	Codigo INT PRIMARY KEY IDENTITY(1,1),
	Descripcion NVARCHAR(255) NULL
)


RAISERROR ('1. - Creando [BI_Fabricante]', 0, 1) WITH NOWAIT
GO
--Creación tabla Fabricante
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Fabricante] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Nombre NVARCHAR(255) NULL,
)
GO

RAISERROR ('1. - Creando [BI_Caja]', 0, 1) WITH NOWAIT
GO
--Creación tabla Caja
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Caja] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255) NOT NULL,

)
GO

RAISERROR ('1. - Creando [BI_Transmision]', 0, 1) WITH NOWAIT
GO
--Creación tabla Transmision
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Transmision] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255)  NOT NULL,
	Cantidad_Cambios INT NULL
)
GO

RAISERROR ('1. - Creando [BI_Motor]', 0, 1) WITH NOWAIT
GO
--Creación tabla Motor
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Motor] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255)  NULL,
)
GO

RAISERROR ('1. - Creando [BI_Compra_Venta_Auto_Autoparte]', 0, 1) WITH NOWAIT
GO
-- Creación tabla BI_Compra_Venta_Auto_Autoparte
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Compra_Venta_Auto_Autoparte] (
	Tipo_Compra_Venta CHAR(1) NOT NULL,
	Tipo_Auto_Autoparte NVARCHAR(10) NOT NULL,
	Precio DECIMAL(18,2) NOT NULL,
	IdCliente INT REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Cliente],
	IdSucursal INT REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Sucursal],
	IdTiempo INT REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Tiempo],
	IdModelo INT REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_Modelo],
	IdTipoAuto INT NULL REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_TipoAuto],
	IdCategoria INT NULL REFERENCES [LOS_CUATRO_FANTASTICOS].[BI_CategoriaAutoparte]
)

GO

RAISERROR ('X - Fin Tablas', 0, 1) WITH NOWAIT
GO



---------------------------------------------------------

---------------------------------------------------------


RAISERROR ('2.1 - Insertando Fabricante', 0, 1) WITH NOWAIT
GO
-- Inserto datos de Fabricante
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Fabricante] (Nombre)
	SELECT 
		[FABRICANTE_NOMBRE]
	FROM gd_esquema.Maestra 
	GROUP BY [FABRICANTE_NOMBRE]
	ORDER BY [FABRICANTE_NOMBRE] 
GO

RAISERROR ('2.2 - Insertando Transmision', 0, 1) WITH NOWAIT
GO
---Inserto datos de Tipo Transmision
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Transmision]([Codigo] ,[Descripcion])
	SELECT DISTINCT [TIPO_TRANSMISION_CODIGO], [TIPO_TRANSMISION_DESC]
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE [TIPO_TRANSMISION_CODIGO] IS NOT NULL

GO

RAISERROR ('2.3 - Insertando Caja', 0, 1) WITH NOWAIT
GO
---Inserto datos de Tipo Caja
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Caja]([Codigo] ,[Descripcion])
	SELECT DISTINCT TIPO_CAJA_CODIGO, TIPO_CAJA_DESC, NULL
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE TIPO_CAJA_CODIGO IS NOT NULL 

GO

RAISERROR ('2.4 - Insertando Motor', 0, 1) WITH NOWAIT
GO
---Inserto datos de Tipo Motor
INSERT INTO [LOS_CUATRO_FANTASTICOS].[BI_Motor]([Codigo] ,[Descripcion])
	SELECT DISTINCT TIPO_MOTOR_CODIGO, NULL
	FROM [GD2C2020].[gd_esquema].[Maestra]
	WHERE TIPO_MOTOR_CODIGO IS NOT NULL

GO