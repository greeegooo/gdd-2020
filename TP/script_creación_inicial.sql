------------------------------------------------------------
--                                                 TABLAS --
------------------------------------------------------------

-- Creación tabla Cliente
CREATE TABLE [Cliente] (
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
CREATE TABLE [Sucursal] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Direccion NVARCHAR(255) NULL,
	Mail NVARCHAR(255) NULL,
	Telefono DECIMAL(18,0) NULL,
	Ciudad NVARCHAR(255) NULL
)
GO

-- Creación tabla Compra
CREATE TABLE [Compra] (
	Numero DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	Fecha DATETIME2(3) NOT NULL,
	Precio DECIMAL(18,2) NOT NULL,
	SucursalId INT NOT NULL REFERENCES Sucursal,
	ClienteId INT NOT NULL REFERENCES Cliente
) 
GO

-- Creación tabla FacturaCliente
CREATE TABLE [FacturaCliente] (
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
CREATE TABLE [FacturaSucursal] (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Direccion NVARCHAR(255) NULL,
	Mail NVARCHAR(255) NULL,
	Telefono DECIMAL(18,0) NULL,
	Ciudad NVARCHAR(255) NULL
)
GO

-- Creación tabla Factura
CREATE TABLE [Factura] (
	Numero DECIMAL(18,0) PRIMARY KEY IDENTITY(1,1),
	Fecha DATETIME2(3) NOT NULL,
	Precio DECIMAL(18,2) NOT NULL,
	ClienteId INT NOT NULL REFERENCES Cliente,
	FacturaClienteId INT NOT NULL REFERENCES FacturaCliente,
	SucursalId INT NOT NULL REFERENCES Sucursal,
	FacturaSucursalId INT NOT NULL REFERENCES FacturaSucursal
)
GO

--CREO LA TABLA AUTO
CREATE TABLE [Auto] (
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

--CREO LA TABLA AUTOPARTE
CREATE TABLE [Autoparte] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255) NULL,
	ModeloId DECIMAL(18,0) NOT NULL,
	Categoria DECIMAL(18,0) NOT NULL,
	TipoAutoparteCodigo DECIMAL(18,0) NOT NULL,
)
GO

-- Creación tabla CompraAuto
CREATE TABLE [CompraAuto] (
	CompraNumero DECIMAL(18,0) REFERENCES [Compra],
	AutoId INT REFERENCES [Auto],
	Precio DECIMAL(18,2) NOT NULL,
	CONSTRAINT CONSTRAINT_CompraAuto_PK PRIMARY KEY (CompraNumero, AutoId)
)
GO

-- Creación tabla CompraAutoparte
CREATE TABLE [CompraAutoparte] (
	CompraNumero DECIMAL(18,0) REFERENCES [Compra],
	AutoparteId DECIMAL(18,0) REFERENCES [Autoparte],
	Cantidad DECIMAL(18,2) NOT NULL,
	Precio DECIMAL(18,2) NOT NULL,
	CONSTRAINT CONSTRAINT_CompraAutoparte_PK PRIMARY KEY (CompraNumero, AutoparteId)
)
GO

--CREO LA TABLA TIPOAUTO
CREATE TABLE [TipoAuto] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255) NULL,
)
GO

--CREO LA TABLA TIPOAUTOPARTE
CREATE TABLE [TipoAutoparte] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255)  NULL,
)
GO

--CREO LA TABLA CATEGORIAAUTOPARTE
CREATE TABLE [CategoriaAutoparte] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Descripcion NVARCHAR(255)  NULL,
)
GO

--CREO LA TABLA FABRICANTE
CREATE TABLE [Fabricante] (
	Id INT PRIMARY KEY,
	Nombre NVARCHAR(255) NULL,
)
GO

--CREO LA TABLA MODELO
CREATE TABLE [Modelo] (
	Codigo DECIMAL(18,0) PRIMARY KEY,
	Nombre  NVARCHAR(50) NULL,
	Potencia  NVARCHAR(50) NULL,
	FabricanteId INT NOT NULL,
)
GO

--CREO LA TABLA FACTURACIONAUTO
CREATE TABLE [FacturaAuto] (
	FacturaNumero DECIMAL(18,0),
	AutoId  INT,
	Precio  DECIMAL(18,2) NOT NULL,
	PRIMARY KEY(FacturaNumero, AutoId)
)
GO

--CREO LA TABLA FACTURACIONAUTOPARTE
CREATE TABLE [FacturaAutoparte] (
	FacturaNumero DECIMAL(18,0),
	AutoparteId  INT,
	Cantidad DECIMAL(18,2) NOT NULL,
	Precio  DECIMAL(18,2) NOT NULL,
	PRIMARY KEY(FacturaNumero, AutoparteId)
)
GO

--CREO CLAVE FORANIA DE LA TABLA AUTO CON  TIPOAUTO
ALTER TABLE Auto  
ADD CONSTRAINT fk_auto_tipoAuto FOREIGN KEY
(TipoAutoCodigo)
REFERENCES TipoAuto (Codigo)
GO

--CREO CLAVE FORANIA DE LA TABLA AUTO CON MODELO
ALTER TABLE Auto  
ADD CONSTRAINT fk_auto_modelo FOREIGN KEY
(ModeloCodigo)
REFERENCES Modelo (Codigo)
GO

--CREO CLAVE FORANIAS DE LA TABLA MODELO CON FABRICANTE
ALTER TABLE Modelo  
ADD CONSTRAINT fk_modelo_fabricante FOREIGN KEY
(FabricanteId)
REFERENCES Fabricante (Id)
GO

--CREO CLAVE FORANIAS DE LA TABLA AUTOPARTE CON TIPOAUTOPARTE
ALTER TABLE Autoparte  
ADD CONSTRAINT fk_autoParte_tipoAutoparte FOREIGN KEY
(TipoAutoparteCodigo)
REFERENCES TipoAutoparte (Codigo)
GO

--CREO CLAVE FORANIAS DE LA TABLA AUTOPARTE CON  MODELO
ALTER TABLE Autoparte  
ADD CONSTRAINT fk_autoParte_modelo FOREIGN KEY
(ModeloId)
REFERENCES Modelo (Codigo)
GO

--CREO CLAVE FORANIAS DE LA TABLA AUTOPARTE CON CATEGORIAAUTOPARTE
ALTER TABLE Autoparte  
ADD CONSTRAINT fk_autoParte_categoriaAutoparte FOREIGN KEY
(Categoria)
REFERENCES CategoriaAutoparte (Codigo)
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