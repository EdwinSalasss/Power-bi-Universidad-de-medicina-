create database UNMN_AMPLIADO
go
use UNMN_AMPLIADO
go

-- Tabla Recinto
Create table Recinto(
    ID_Recinto int identity(1,1) primary key not null,
    Nombre_Recinto nvarchar(50) not null,
    DireccionRecinto nvarchar(150) not null,
    TelefonoRecinto char(11) not null,
    EmailRecinto nvarchar(100) not null,
    Ciudad nvarchar(50) not null,
    Estado nvarchar(50) not null,
    CodigoPostal nvarchar(10) not null,
    Pais nvarchar(50) not null,
    FechaFundacion date not null
)
go

Create table Decano(
	ID_Decano int identity(1,1) primary key not null,
	Primer_Nombre nvarchar(30) not null,
    Segundo_Nombre nvarchar(30) not null,
    Primer_Apellido nvarchar(30) not null,
    Segundo_Apellido nvarchar(30) not null,
	Estado bit,
    Email nvarchar(100) not null,
    Telefono char(10) not null,
    Direccion nvarchar(150) not null,
)

-- Tabla Facultad
Create table Facultad(
    ID_Facultad int identity(1,1) primary key not null,
    Nombre nvarchar(70) not null,
	ID_Decano int foreign key references Decano(ID_Decano),
    ID_Recinto int foreign key references Recinto(ID_Recinto),
    FechaCreacion date not null
)
go

Create table AreaDeEstudio(
	ID_AreaDeEstudio int identity(1,1) primary key not null,
	NombreAreaDeEstudio nvarchar(50) not null,
	ID_Facultad int foreign key references Facultad(ID_Facultad)
)

-- Tabla Carrera
Create table Carrera(
    ID_Carrera int identity(1,1) primary key not null,
    Nombre_Carrera nvarchar(30) not null,
    ID_Facultad int foreign key references Facultad(ID_Facultad),
    Duracion nvarchar(20) not null,
    Modalidad nvarchar(20) not null
)
go

-- Tabla Estudiante
Create table Estudiante(
    ID_Estudiante int identity(1,1) primary key,
    Primer_Nombre nvarchar(30) not null,
    Segundo_Nombre nvarchar(30) not null,
    Primer_Apellido nvarchar(30) not null,
    Segundo_Apellido nvarchar(30) not null,
    Fecha_Nacimiento Date not null,
    Estado bit,
    Email nvarchar(100) not null,
    Telefono char(10) not null,
    Direccion nvarchar(150) not null,
    Ciudad nvarchar(50) not null,
    EstadoResidencia nvarchar(50) not null,
    CodigoPostal nvarchar(10) not null
)
go

-- Tabla Matricula
Create table Matricula(
    ID_Matricula int identity(1,1) primary key,
    Año_Matricula date not null,
    Periodo nvarchar(20) not null,
)
go

-- Tabla Estudiante_Matricula
Create table Estudiante_Matricula(
    ID_Estudiante_Matricula int identity(1,1) primary key,
    ID_Estudiante int foreign key references Estudiante(ID_Estudiante) not null,
    ID_Matricula int foreign key references Matricula(ID_Matricula) not null,
    Fecha_Ingreso date default getdate(),
    Estado nvarchar(20) not null
)
go

-- Tabla Asignatura
Create table Asignatura(
    ID_Asignatura int identity(1,1) primary key,
    Nombre nvarchar(25) not null,
    Numero_creditos int not null,
    Semestre char(1) Check(Semestre like '[1|2]') not null,
    Clasificacion NVARCHAR(50) CHECK (Clasificacion IN ('Basico', 'Basico_Especifico', 'Ejercicio_Profesional')) not null,
    ID_Carrera int foreign key references Carrera(ID_Carrera),
    Descripcion nvarchar(500) not null,
    Requisitos nvarchar(100) not null
)
go

-- Tabla Inscripcion
Create table Inscripcion(
    ID_Inscripcion int identity(1,1) primary key,
    ID_Asignatura int foreign key references Asignatura(ID_Asignatura) not null,
    ID_Estudiante_Matricula int foreign key references Estudiante_Matricula(ID_Estudiante_Matricula) not null,
    Fecha_Inscripcion Date default getdate(),
    Estado nvarchar(20) not null
)
go

-- Tabla Profesor
Create table Profesor(
    ID_Profesor int identity(1,1) primary key,
    Primer_Nombre nvarchar(30) not null,
    Segundo_Nombre nvarchar(30) not null,
    Primer_Apellido nvarchar(30) not null,
    Segundo_Apellido nvarchar(30) not null,
    Direccion nvarchar(120) not null,
    Telefono char(11) not null,
    Email nvarchar(100) not null,
    Titulo nvarchar(100) not null,
	ID_Matricula int foreign key references Matricula(ID_Matricula) not null,
	ID_AreaDeEstudio int foreign key references AreaDeEstudio(ID_AreaDeEstudio) not null
)
go

-- Tabla TelefonosProfesor
Create table TelefonosProfesor(
    ID_Telefono int identity(1,1) primary key,
    Telefono char(11) not null,
    ID_Profesor int foreign key references Profesor(ID_Profesor) not null,
    Tipo nvarchar(20) not null
)
go

-- Tabla Grupo
Create table Grupo(
    ID_Grupo nvarchar(20) primary key,
    Numero_Estudiantes int check (Numero_Estudiantes < 40),
    Nombre_Grupo nvarchar(50) not null,
    ID_Profesor int foreign key references Profesor(ID_Profesor) not null,
    Horario nvarchar(50) not null
)
go

-- Tabla Inscripcion_Grupo
Create table Inscripcion_Grupo(
    ID_Inscripcion_Grupo int identity(1,1) primary key,
    ID_Inscripcion int foreign key references Inscripcion(ID_Inscripcion) not null,
    ID_Grupo nvarchar(20) foreign key references Grupo(ID_Grupo) not null,
    Fecha_Ingreso date default getdate(),
    Estado nvarchar(20) not null
)
go

-- Tabla Edificio
Create table Edificio(
    ID_Edificio int identity(1,1) primary key,
    Nombre_Edificio nvarchar(30) not null,
    Direccion nvarchar(150) not null,
    Numero_Pisos int not null,
    Codigo_Edificio nvarchar(10) not null
)
go

-- Tabla Aula
Create table Aula(
    ID_Aula int identity(1,1) primary key,
    Nombre_Aula nvarchar(50) not null,
    ID_Edificio int foreign key references Edificio(ID_Edificio) not null,
    Capacidad int not null,
    Tipo_Aula nvarchar(50) not null
)
go

-- Tabla Planificacion
Create table Planificacion(
    ID_Planificacion int identity(1,1) primary key,
    ID_Aula int foreign key references Aula(ID_Aula) not null,
    ID_Grupo nvarchar(20) foreign key references Grupo(ID_Grupo) not null,
    ID_Profesor int foreign key references Profesor(ID_Profesor) not null,
    ID_Asignatura int foreign key references Asignatura(ID_Asignatura) not null,
    ID_Carrera int foreign key references Carrera(ID_Carrera) not null,
    Fecha_Inicio date not null,
    Fecha_Fin date not null,
    Horario nvarchar(50) not null
)
go
