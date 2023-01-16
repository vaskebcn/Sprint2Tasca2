SELECT p.apellido1, p.apellido2, p.nombre FROM persona p WHERE p.tipo LIKE 'alumno' ORDER BY p.apellido1, p.apellido2, p.nombre;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo LIKE 'alumno' AND telefono IS NULL;
SELECT * FROM persona WHERE tipo LIKE 'alumno' AND fecha_nacimiento BETWEEN '1999/01/01' AND '1999/12/31';
SELECT * FROM persona WHERE tipo LIKE 'profesor' AND telefono IS NULL AND nif LIKE '%k';
SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS nombre_departamento FROM persona p JOIN profesor pr ON p.id=pr.id_profesor LEFT JOIN departamento d ON pr.id_profesor=d.id WHERE p.tipo LIKE 'profesor' ORDER BY p.apellido1, p.apellido2, p.nombre;
SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin FROM asignatura a JOIN alumno_se_matricula_asignatura asma ON a.id=asma.id_asignatura JOIN curso_escolar ce ON asma.id_curso_escolar=ce.id JOIN persona p ON asma.id_alumno=p.id WHERE p.nif LIKE '26902806M';
SELECT DISTINCT d.nombre FROM departamento d JOIN profesor pr ON pr.id_departamento=d.id JOIN asignatura a ON pr.id_profesor=a.id_profesor JOIN grado g ON a.id_grado=g.id WHERE g.nombre LIKE 'Grado en Ingeniería Informática (Plan 2015)';
SELECT DISTINCT p.* FROM persona p JOIN alumno_se_matricula_asignatura asma ON p.id=asma.id_alumno JOIN curso_escolar ce ON asma.id_curso_escolar=ce.id WHERE ce.anyo_inicio='2018' AND ce.anyo_fin='2019';
-- left join i right join
SELECT d.nombre, p.apellido1, p.apellido2, p.nombre FROM profesor pr LEFT JOIN departamento d ON pr.id_departamento=d.id LEFT JOIN persona p ON pr.id_profesor=p.id ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;
SELECT p.apellido1, p.apellido2, p.nombre FROM persona p LEFT JOIN profesor pr ON p.id=pr.id_profesor LEFT JOIN departamento d ON pr.id_departamento=d.id WHERE d.nombre IS NULL;
SELECT * FROM departamento d LEFT JOIN profesor pr ON d.id=pr.id_departamento WHERE pr.id_departamento IS NULL;
SELECT * FROM persona p LEFT JOIN profesor pr ON p.id=pr.id_profesor LEFT JOIN asignatura a ON pr.id_profesor=a.id_profesor WHERE a.id_profesor IS NULL AND p.tipo LIKE 'profesor';
SELECT a.* FROM persona p RIGHT JOIN asignatura a ON p.id=a.id_profesor WHERE a.id_profesor IS NULL;
SELECT DISTINCT d.nombre FROM departamento d LEFT JOIN profesor pr ON d.id=pr.id_departamento LEFT JOIN asignatura a ON pr.id_profesor=a.id_profesor LEFT JOIN alumno_se_matricula_asignatura asma ON a.id=asma.id_asignatura LEFT JOIN curso_escolar ce ON asma.id_curso_escolar=ce.id WHERE a.id IS NULL AND asma.id_curso_escolar IS NULL;
-- consultes resum
SELECT COUNT(persona.id)AS numero_alumnos FROM persona WHERE persona.tipo LIKE 'alumno';
SELECT COUNT(persona.id)AS numero_alumnos FROM persona WHERE persona.tipo LIKE 'alumno' AND persona.fecha_nacimiento BETWEEN '1999/01/01'AND'1999/12/31';
SELECT d.nombre AS departamento, COUNT(pr.id_profesor) AS profesores FROM departamento d LEFT JOIN profesor pr ON d.id=pr.id_departamento WHERE pr.id_profesor IS NOT NULL GROUP BY d.nombre ORDER BY profesores DESC;
SELECT d.nombre AS departamento, COUNT(pr.id_profesor) AS profesores FROM departamento d LEFT JOIN profesor pr ON d.id=pr.id_departamento GROUP BY d.nombre;
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS numero_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id=a.id_grado GROUP BY g.nombre ORDER BY numero_asignaturas DESC;
SELECT g.nombre AS nombre_grado, COUNT(a.id) AS numero_asignaturas FROM grado g LEFT JOIN asignatura a ON g.id=a.id_grado GROUP BY g.nombre HAVING numero_asignaturas>40 ORDER BY numero_asignaturas DESC;
SELECT g.nombre, a.tipo, a.creditos FROM asignatura a LEFT JOIN grado g ON g.id=a.id_grado; -- no resuelto
SELECT ce.anyo_inicio, COUNT(asma.id_alumno) AS numero_de_alumnos FROM curso_escolar ce LEFT JOIN alumno_se_matricula_asignatura asma ON ce.id=asma.id_curso_escolar GROUP BY ce.anyo_inicio;
SELECT p.id, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) FROM persona p LEFT JOIN profesor pr ON p.id=pr.id_profesor LEFT JOIN asignatura a ON pr.id_profesor=a.id_profesor GROUP BY p.id ORDER BY COUNT(a.id) DESC;
SELECT p.* FROM persona p WHERE p.tipo LIKE 'alumno' AND p.fecha_nacimiento = (SELECT MAX(pe.fecha_nacimiento)FROM persona pe);
SELECT * FROM persona p LEFT JOIN profesor pr ON p.id=pr.id_profesor LEFT JOIN departamento d ON pr.id_departamento=d.id LEFT JOIN asignatura a ON pr.id_profesor=a.id_profesor WHERE d.id IS NOT NULL AND a.id IS NULL;