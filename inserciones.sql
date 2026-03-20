INSERT INTO Recinto (Nombre_Recinto) VALUES ('Recinto A'), ('Recinto B'), ('Recinto C'), ('Recinto D'), ('Recinto E');

INSERT INTO Facultad (Nombre, ID_Recinto) 
VALUES 
('Facultad de Ingeniería', 1), 
('Facultad de Ciencias', 2), 
('Facultad de Letras', 3), 
('Facultad de Medicina', 4), 
('Facultad de Derecho', 5);

select *from Carrera
INSERT INTO Carrera (Nombre_Carrera, ID_Facultad) 
VALUES 
('Ingeniería Civil', 1), 
('Ingeniería de Sistemas', 1), 
('Biología', 2), 
('Química', 2), 
('Literatura', 3), 
('Historia', 3), 
('Medicina General', 4), 
('Odontología', 4), 
('Derecho Penal', 5), 
('Derecho Civil', 5);

INSERT INTO Estudiante (PNombre, SNombre, PApellido, SApellido, Fecha_Nacimiento, Estado) 
VALUES 
('Juan', 'Carlos', 'Perez', 'Gomez', '1990-01-01', 1),
('Ana', 'Maria', 'Lopez', 'Martinez', '1991-02-02', 1),
('Luis', 'Miguel', 'Rodriguez', 'Hernandez', '1992-03-03', 1),
-- Continue this for 100 students
('Estudiante98', 'Nombre98', 'Apellido98', 'Apellido98', '2000-04-01', 1),
('Estudiante99', 'Nombre99', 'Apellido99', 'Apellido99', '2000-05-01', 1),
('Estudiante100', 'Nombre100', 'Apellido100', 'Apellido100', '2000-06-01', 1);

INSERT INTO Profesor (PNombre, SNombre, PApellido, SApellido, Direccion) 
VALUES 
('Profesor1', 'Nombre1', 'Apellido1', 'Apellido1', 'Direccion 1'),
('Profesor2', 'Nombre2', 'Apellido2', 'Apellido2', 'Direccion 2'),
-- Continue this for 20 professors
('Profesor19', 'Nombre19', 'Apellido19', 'Apellido19', 'Direccion 19'),
('Profesor20', 'Nombre20', 'Apellido20', 'Apellido20', 'Direccion 20');



INSERT INTO Asignatura (Nombre, Numero_creditos, Semestre, Clasificacion, ID_Carrera) 
VALUES 
('Matemáticas Básicas', 3, '1', 'Basico', 1),
('Física General', 3, '1', 'Basico', 2),
('Química Orgánica', 3, '1', 'Basico_Especifico', 3),
('Asignatura29', 3, '2', 'Basico_Especifico', 4),
('Asignatura30', 3, '2', 'Ejercicio_Profesional', 5);

select * from Asignatura
INSERT INTO Matricula (Año_Matricula) 
VALUES 
('2024-01-01'),
('2024-02-01'),
('2024-03-01'),
-- Continue this for the number of required enrollment records
('2024-04-01'),
('2024-05-01');

INSERT INTO Estudiante_Matricula (ID_Estudiante, ID_Matricula)
SELECT ID_Estudiante, (ABS(CHECKSUM(NEWID())) % 5) + 1
FROM Estudiante;

INSERT INTO Aula (Nombe_Aula, ID_Edificio) 
VALUES 
('Aula 101', 1), 
('Aula 102', 2), 
('Aula 103', 3), 
('Aula 104', 4), 
('Aula 105', 5);
select * from Grupo

INSERT INTO Grupo (Numero_Estudiantes, ID_Profesor) 
VALUES 
(25, 1), 
(30, 2),
-- Continue this for the number of required groups
(20, 19), 
(22, 20);

INSERT INTO Edificio (Nombe_Edificio) 
VALUES 
('Edificio A'), 
('Edificio B'), 
('Edificio C'), 
('Edificio D'), 
('Edificio E');

-- Insertar una nueva matrícula
INSERT INTO Matricula (Año_Matricula)
VALUES ('2024-06-01');
GO

-- Insertar un nuevo estudiante matrícula
INSERT INTO Estudiante_Matricula (ID_Estudiante, ID_Matricula,Fecha_Ingreso)
VALUES (1, 1,'2024-06-01');
GO

select * from Estudiante_Matricula