RAISERROR ('X - Creando tablas BI', 0, 1) WITH NOWAIT
GO

-- Creaci�n tabla Tiempo
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_Tiempo] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	A�o INT NULL,
	Mes INT NULL
)

-- Creaci�n tabla CategoriaAutoParte
CREATE TABLE [LOS_CUATRO_FANTASTICOS].[BI_CategoriaAutoParte] (
	Codigo INT PRIMARY KEY IDENTITY(1,1),
	Descripcion NVARCHAR(255) NULL
)

RAISERROR ('X - Fin Tablas', 0, 1) WITH NOWAIT
GO