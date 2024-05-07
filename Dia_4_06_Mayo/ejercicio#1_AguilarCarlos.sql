-- ################################
-- ########## EJERCICIO 1 ########
-- ###############################

-- Creación  de la base de datos de Pais

create database world_new;

use world_new;

create table pais(
	id int primary key,
	nombre varchar(20),
	continente varchar(50),
	poblacion int
);

create table ciudad (
	id int primary key,
	nombre varchar(20),
	id_pais int not null,
	foreign key (id_pais) references pais(id)
);

create table idioma (
	id int primary key,
	idioma varchar(50)
);

create table idioma_pais (
	id_idioma int,
	id_pais int,
	es_oficial tinyint(1),
	foreign key (id_pais) references pais(id),
	foreign key (id_idioma) references idioma(id)
);

show tables;

-- Inserciones en las tablas
insert into pais
values 	(1, "Colombia", "América", 50000000),
		(2, "Italia", "Europa", 60000000),
		(3, "Senegal", "África", 18000000),
		(4, "Corea del Sur", "Asia", 52000000),
		(5, "Argentina", "América", 47000000),
		(6, "Francia", "Europa", 68000000),
		(7, "Estados Unidos", "América", 334000000 ),
		(8, "Argelia", "África", 45000000),
		(9, "India", "Asia", 1418000000),
		(10, "Dinamarca", "Europa", 6000000);
	
insert into ciudad
values 	(1, "Bucaramanga", 1),
		(2, "Venezia", 2),
		(3, "Chicago", 7),
		(4, "Dakar", 3),
		(5, "Rosario", 5),
		(6, "Copenhague", 10),
		(7, "Benarés", 9),
		(8, "Lille", 6),
		(9, "Busan", 4),
		(10, "Orán", 8);
	
insert into idioma
values 	(1, "Español"),
		(2, "Creole"),
		(3, "Francés"),
		(4, "Inglés"),
		(5, "Italiano"),
		(6, "Danés"),
		(7, "Diola"),
		(8, "Árabe"),
		(9, "Tamazigh"),
		(10, "Coreano");

insert into idioma_pais 
values 	(1, 1, 1),
		(2, 1, 0),
		(7, 3, 0),
		(3, 6, 1),
		(3, 3, 1),
		(8, 8, 1),
		(9, 8, 0),
		(10, 4, 0),
		(1, 5, 1),
		(5, 2, 1),
		(4, 7, 1);
		
select * from pais as p, ciudad as c
where p.id = c.id_pais;

select count(distinct continente) from pais;

-- Indicar cada paìs y la cantidad de idiomas que habla dicho pais
select p.nombre as pais, count(*)as NumIdiomas
from pais as p, idioma as i, idioma_pais as ip
where p.id = ip.id_pais and ip.id_idioma = i.id
GROUP by pais;

/*
 Indicarme el nombre del continente y la poblaciòn total de los paìses de ese 
 */
select p.continente, sum(p.poblacion)
from pais as p
group by continente;

/* Sacar los paìses màs poblados de cada continente y 
ordernarlos los paises resultantes desde el mayor al menor poblacion*/

select * 
from (
	(select p.nombre as pais, p.poblacion
	from pais as p
	where continente = "América"
	order by poblacion DESC
	limit 1)
	
	union
	
	(select p.nombre as pais, p.poblacion
	from pais as p
	where continente = "Europa"
	order by poblacion DESC
	limit 1)
	
	union
	
	(select p.nombre as pais, p.poblacion
	from pais as p
	where continente = "África"
	order by poblacion DESC
	limit 1)

		union
	
	(select p.nombre as pais, p.poblacion
	from pais as p
	where continente = "Asia"
	order by poblacion DESC
	limit 1)) as paises_poblados
order by poblacion desc;
	
	

		
		
		
		
		
		
		
-- Desarrollado por Carlos Aguilar
