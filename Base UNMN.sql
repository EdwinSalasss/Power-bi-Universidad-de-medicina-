use master 
create database UNMN 
go
use UNMN 
go 
Create table Recinto(
ID_Recinto int identity(1,1) primary key not null,
 Nombre_Recinto nvarchar(50) not null, 
 DireccionRecinto nvarchar(150) not null,
 TelefonoRecinto char(8) check(TelefonoRecinto like '[2|5|7|8][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' ) not null,
 EmailRecinto nvarchar(100) not null
 )
 go
Create table Facultad(
 ID_Facultad int identity(1,1) primary key not null,
 Nombre nvarchar(70) not null,
ID_Recinto int foreign key references Recinto(ID_Recinto)
 )
 go
Create table  Carrera(
 ID_Carrera int identity(1,1) primary key not null,
 Nombre_Carrera nvarchar(30)not null,
 ID_Facultad int foreign key references Facultad(ID_Facultad)
)
--ALTER TABLE Carrera
--ALTER COLUMN Nombre_Carrera nvarchar(30);
go
Create table Estudiante
(
ID_Estudiante int identity(1,1) primary key ,
Primer_Nombre nvarchar(30) not null,
Segundo_Nombre nvarchar(30) not null,
Primer_Apellido nvarchar(30) not null,
Segundo_Apellido nvarchar(30) not null,
Fecha_Nacimiento Date not null,
Estado bit 
)
--ALTER TABLE Estudiante
--ALTER COLUMN  SApellido nvarchar(30) not null;

go
Create table Matricula (
ID_Matricula int identity(1,1) primary key ,
Año_Matricula date not null
)
go
Create table Estudiante_Matricula(
ID_Estudiante_Matricula int identity(1,1) primary key ,
ID_Estudiante int foreign key references Estudiante(ID_Estudiante) not null,
 ID_Matricula int foreign key references Matricula(ID_Matricula) not null,
Fecha_Ingreso date default getdate(),
)
go
Create table Asignatura (
ID_Asignatura int identity(1,1) primary key ,
Nombre nvarchar(25) not null,
Numero_creditos int not null,
Semestre char(1) Check(Semestre like '[1|2]') not null,
Clasificacion NVARCHAR(50) CHECK (Clasificacion IN ('Basico', 'Basico_Especifico', 'Ejercicio_Profesional'))not null,
 ID_Carrera int foreign key references Carrera(ID_Carrera)
)
go
Create table Inscripcion (
ID_Inscripcion int identity(1,1) primary key,
ID_Asignatura int foreign key references Asignatura(ID_Asignatura) not null,
ID_Estudiante_Matricula int foreign key references Estudiante_Matricula(ID_Estudiante_Matricula) not null,
Fecha_Inscripcion Date default getdate()
)
go
Create table Profesor 
( ID_Profesor int identity(1,1) primary key ,
Primer_Nombre nvarchar(30) not null,
Segundo_Nombre nvarchar(30) not null,
Primer_Apellido nvarchar(30) not null,
Segundo_Apellido nvarchar(30) not null,
Direccion nvarchar(120) not null
)
go
Create table TelefonosProfesor(
ID_Telefono int identity(1,1) primary key ,
Telefono char(11) not null,
ID_Profesor int foreign key references Profesor(ID_Profesor) not null,
)
go
Create table Grupo
(ID_Grupo nvarchar(20) primary key ,
Numero_EStudiantes int, constraint Numero_Estudiantes CHECK (Numero_Estudiantes < 40) 
)
go
Create table Inscripcion_Grupo
(ID_Inscripcion_Grupo int identity(1,1) primary key,
ID_Inscripcion int foreign key references Inscripcion(ID_Inscripcion) not null,
ID_Grupo nvarchar(20) foreign key references Grupo(ID_Grupo) not null,
)
go
Create table Edificio
(ID_Edificio int identity(1,1) primary key,
Nombre_Edificio nvarchar(30) not null,
)
go
Create table Aula
(ID_Aula int identity(1,1) primary key,
Nombre_Aula nvarchar(50) not null,
ID_Edificio int foreign key references Edificio(ID_Edificio) not null
)

go
Create table Planificacion
(ID_Planificacion int identity(1,1) primary key,
ID_Aula int foreign key references Aula(ID_Aula) not null,
ID_Grupo nvarchar(20) foreign key references Grupo(ID_Grupo) not null,
ID_Profesor int foreign key references Profesor(ID_Profesor) not null,
ID_Asignatura  int foreign key references Asignatura(ID_Asignatura) not null,
ID_Carrera  int foreign key references Carrera(ID_Carrera) not null,
)
 drop table Planificacion

---------------------------Propuesta cubo waos 

--Inscripciones por carrera y semestre 
SELECT c.Nombre_Carrera AS Carrera, a.Semestre, COUNT(*) AS Numero_Inscripciones
FROM Inscripcion fi
JOIN Asignatura a ON fi.ID_Inscripcion = a.ID_Asignatura
JOIN Carrera c ON a.ID_Carrera = c.ID_Carrera
GROUP BY c.Nombre_Carrera, a.Semestre
ORDER BY c.Nombre_Carrera, a.Semestre;

select * from Carrera
select * from Facultad
select * from Decano
--Dimenciones 
--------Dimecion Estudiante---------------
create view Dim_Estudiante as
select
    ID_Estudiante,
    Primer_Nombre + ' ' + Segundo_Nombre + ' ' + Primer_Apellido + ' ' + Segundo_Apellido AS Nombre_Completo ,
    Estado
from
    Estudiante;
----------Dimecion Profesor--------------
create view Dim_Profesor
as
select * from Profesor
----------Dimencion Carrera-------------
create view Dim_Carrera as
select
    ID_Carrera,
    Nombre_Carrera,
    ID_Facultad
from
   Carrera;
-------------Dimencion Grupo-------------
   create view Dim_Grupo as
select
    ID_Grupo,
    Numero_Estudiantes,
from
    Grupo;
--------------Dimencion Aula-------------
	create view Dim_Aula as
Select
    ID_Aula,
    Nombre_Aula,
    ID_Edificio
from
   Aula;

--  Dimencion Matricula con el nombre del estudiante------------
create view  DimMatricula 
as
select
	EM.ID_Estudiante_Matricula,
    M.ID_Matricula,
    E.ID_Estudiante,
    E.Primer_Nombre + ' ' + E.Segundo_Nombre + ' ' + E.Primer_Apellido + ' ' + E.Segundo_Apellido AS Nombre_Completo,
    E.Estado,
    M.Año_Matricula
from
Matricula M
	inner join
Estudiante_Matricula EM ON M.ID_Matricula = EM.ID_Matricula
    inner join
Estudiante E ON EM.ID_Estudiante = E.ID_Estudiante;


  --------Dimencion fecha----------------
   create view DimDate
as 
select distinct Fecha_Inscripcion, 
year(Fecha_Inscripcion)as Año,
month(Fecha_Inscripcion)as NoMes,
datename(month, Fecha_Inscripcion) as NombreMes,
day(Fecha_Inscripcion) as NoDia
from Inscripcion s


	-- Crear la vista PlanificacionDetalles
--CREATE VIEW PlanificacionDetalles 
--as
--select
--    P.ID_Planificacion,
--    C.Nombre_Carrera,
--    A.Nombre as Nombre_Asignatura,
--    Pr.Primer_Nombre + Pr.Segundo_Apellido as Nombre_Profesor,
--    G.ID_Grupo,
--    AU.Nombre_Aula,
--    E.Nombe_Edificio,
--	EM.ID_Estudiante_Matricula,
--    Es.Primer_Nombre,
--	I.Fecha_Inscripcion,
--	I.ID_Inscripcion
--from
--    Planificacion P
--inner join
--    Carrera C on P.ID_Carrera = C.ID_Carrera
--inner join
--    Asignatura A on P.ID_Asignatura = A.ID_Asignatura
--inner join
--    Profesor Pr on P.ID_Profesor = Pr.ID_Profesor
--inner join
--    Grupo G on P.ID_Grupo = G.ID_Grupo
--inner join
--    Aula AU on P.ID_Aula = AU.ID_Aula
--inner join
--    Edificio E on AU.ID_Edificio = E.ID_Edificio
--Inner join 
--     Estudiante_Matricula EM on Em.ID_Estudiante = EM.ID_Estudiante
--Inner join 
--     Inscripcion I On I.ID_Estudiante_Matricula = EM.ID_Estudiante_Matricula
--Inner join 
--     Inscripcion_Grupo IG On IG.ID_Inscripcion = I.ID_Inscripcion
--Inner join
--Estudiante Es on Em.ID_Estudiante_Matricula=Es.ID_Estudiante;


-- Tabla hechos planeacion-------------
Create view FactPlanificacion as
select
    P.ID_Planificacion,
    P.ID_Aula,
    P.ID_Grupo,
    P.ID_Profesor,
    P.ID_Asignatura,
    P.ID_Carrera,
    A.Semestre,
   -- SUM(G.Numero_Estudiantes) as Estudiantes_Inscritos_Por_Semestre
   SUM(G.Numero_Estudiantes) as Estudiantes_Inscritos_Por_Semestre,
    --COUNT(I.ID_Inscripcion) as Inscripciones_Por_Carrera_Semestre,
   -- SUM(A.Numero_creditos) as Total_Creditos_Por_Semestre,
    COUNT(Distinct P.ID_Profesor) as Profesores_Por_Carrera_Semestre
    /*COUNT(DISTINCT P.ID_Grupo) as Grupos_Por_Carrera_Semestre,
    AVG(G.Numero_Estudiantes) as Promedio_Estudiantes_Por_Grupo*/
from
Planificacion P
inner join
Grupo G on P.ID_Grupo = G.ID_Grupo
inner join
Asignatura A on P.ID_Asignatura = A.ID_Asignatura
group by
    P.ID_Planificacion,
    P.ID_Aula,
    P.ID_Grupo,
    P.ID_Profesor,
    P.ID_Asignatura,
    P.ID_Carrera,
    A.Semestre;

