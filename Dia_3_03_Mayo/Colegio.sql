CREATE DATABASE Colegio;
USE Colegio;

CREATE TABLE departamento(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL
);

CREATE TABLE grado (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL
);

CREATE TABLE persona (
	id INT PRIMARY KEY AUTO_INCREMENT,
	nif VARCHAR(9) DEFAULT NULL,
	nombre VARCHAR(25) NOT NULL,
	apellido1 VARCHAR(50) NOT NULL,
	apellido2 VARCHAR(50) DEFAULT NULL,
	ciudad VARCHAR(25) NOT NULL,
	direccion VARCHAR(50) NOT NULL,
	telefono VARCHAR(9) DEFAULT NULL,
	fecha_nacim DATE NOT NULL,
	sexo ENUM('H', 'M'),
	tipo ENUM('tipo1', 'tipo2', '...')	
);

CREATE TABLE profesor(
	id_profesor INT NOT NULL,
	PRIMARY KEY (id_profesor),
	id_depto INT NOT NULL,
	FOREIGN KEY (id_profesor) REFERENCES persona(id),
	FOREIGN KEY (id_depto) REFERENCES departamento(id)
);

CREATE TABLE asignatura(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(100) NOT NULL,
	creditos FLOAT NOT NULL,
	tipo ENUM('tipo1', 'tipo2', '...'),
	curso TINYINT(3) NOT NULL,
	cuatrimestre TINYINT(3) NOT NULL,
	id_profesor  INT,
	id_grado INT NOT NULL,
	FOREIGN KEY (id_profesor) REFERENCES persona(id),
	FOREIGN KEY (id_grado) REFERENCES grado(id)
);

CREATE TABLE curso_escolar(
	id INT PRIMARY KEY AUTO_INCREMENT,
	anyo_inicio YEAR NOT NULL,
	anyo_fin YEAR NOT NULL
);

CREATE TABLE alumno_asignatura(
	id_alumno INT NOT NULL,
	id_asignatura INT NOT NULL,
	id_curso_escolar INT NOT NULL,
	FOREIGN KEY (id_alumno) REFERENCES persona(id),
	FOREIGN KEY (id_asignatura) REFERENCES asignatura(id),
	FOREIGN KEY (id_curso_escolar) REFERENCES curso_escolar(id)
);

SHOW TABLES;