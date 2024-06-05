drop database if exists instituto;

create database instituto;

use instituto;

create table cursos (
	ano year not null primary key,
	finalizado boolean not null
);

create table profesores (
	nrp varchar(10) not null primary key,
	nombre_p varchar(20) not null
);

create table alumnos (
	dni varchar(9) not null primary key,
	nombre_a varchar(20) not null,
	fecha_nac date not null,
	tlf int not null unique
);

create table ciclos (
	cod_c varchar(15) not null primary key,
	nombre_c varchar(20) not null unique,
	familia varchar(40) not null,
	grado varchar(10) not null,
	tutor varchar(20)not null,
	constraint fk_tutor1 foreign key (tutor) references profesores(nrp) on delete no action on update cascade
);

create table modulos (
	cod_m varchar(15) not null primary key,
	nombre_m varchar(255) not null unique,
	curso varchar(10) not null,
	sesiones int not null,
	horas int not null,
	ciclo varchar(15) not null,
	profesor varchar(10) not null,
	constraint fk_ciclo1 foreign key (ciclo) references ciclos(cod_c) on delete no action on update cascade,
	constraint fk_profesor1 foreign key (profesor) references profesores(nrp) on delete no action on update cascade
);

create table curso_alumno (
	alumno varchar(9) not null,
	curso_a year not null,
	modulo varchar(15) not null,
	nota int null,
	faltas int not null default "0",
	enviado_ap boolean not null,
	fecha_ap date null,
	perdida_ec boolean not null default false,
	fecha_pec date null,
	constraint pk_alumno_curso_modulo primary key (alumno, curso_a, modulo),
	constraint fk_alumno1 foreign key (alumno) references alumnos(dni) on delete no action on update cascade,
	constraint fk_curso_a1 foreign key (curso_a) references cursos(ano) on delete no action on update cascade,
	constraint fk_modulo1 foreign key (modulo) references modulos(cod_m) on delete no action on update cascade
);

create table matricula (
	alumno varchar(9) not null,
	curso_a year not null,
	ciclo varchar(15) not null,
	fecha_alta date not null,
	fecha_baja date null,
	constraint pk_alumno_curso_ciclo primary key (alumno, curso_a, ciclo),
	constraint fk_alumno2 foreign key (alumno) references alumnos(dni) on delete no action on update cascade,
	constraint fk_curso_a2 foreign key (curso_a) references cursos(ano) on delete no action on update cascade,
	constraint fk_ciclo2 foreign key (ciclo) references ciclos(cod_c) on delete no action on update cascade
);

############################################# Inserci�n de datos ##############################################
###############################################################################################################
###############################################################################################################

insert into cursos (ano, finalizado)
values ("2021", true),("2022", false);


insert into profesores (nrp, nombre_p)
values ("48cfd64714","remy owens"),("b09bd71d86","gwenyth matthews"),("1b22874fc4","cherish blackwall"),("886e0067f4","nick cavanagh"),
("defc97343e","melanie hobson"),("ec1fb85b9f","enoch bradley"),("754336ab8f","gil ebbs"),("226265df03","william noon");


insert into alumnos (dni, nombre_a, fecha_nac, tlf)
values ("20394751d","alma page" ,"2001-02-22","623523635"),
("39450125f","manuel holt","1984-05-29","664424814"),
("59736219c","analise rose","2003-01-03","650146605"),
("97047391g","hank kidd","1981-11-21","647422784"),
("44483772x","isabella london","1990-04-27","608685123"),
("44478233k","chuck bradshaw","1982-11-15","603437810"),
("44498265v","evie stone","1993-02-15","628154267"),
("44469723z","brooklyn yarlett","1985-02-20","646701448"),
("44672095x","beatrice woods","1984-05-18","642683071"),
("46628499l","ethan cattell","1998-06-22","660420618"),
("44927734j","juliette yates","1997-10-03","677858735"),
("44758692h","rae ross","2002-01-09","676026280"),
("45782314t","chester brett","1999-08-25","622844735"),
("46792351s","chris morris","1999-12-14","627827446"),
("44669234f","irene shea","1988-01-09","632324670");


insert into ciclos (cod_c,nombre_c,familia,grado,tutor)
values ("273849502728asd","dam","inform�tica","superior","ec1fb85b9f"),
("283947165038zrx","daw","inform�tica","superior","1b22874fc4"),
("183408524466lps","rpae","comunicaci�n imagen y sonido","medio","defc97343e");


insert into ciclos (cod_c,nombre_c,familia,grado,tutor)
values ("183429004466pru","aaa","inform�tica","superior","ec1fb85b9f");


insert into modulos (cod_m,nombre_m,profesor,curso,sesiones,horas,ciclo)
values ("rpae56734","planificaci�n de la realizaci�n en cine y v�deo","226265df03","primero","2","6","183408524466lps"),
("rpae34521","planificaci�n de la realizaci�n en televisi�n","b09bd71d86","primero","3","8","183408524466lps"),
("rpae12803","planificaci�n del montaje y postproducci�n de audiovisuales","1b22874fc4","primero","2","4","183408524466lps"),
("rpae29041","planificaci�n de la regidur�a de espect�culos y eventos","886e0067f4","primero","3","6","183408524466lps"),
("rpae89444","medios t�cnicos audiovisuales y esc�nicos","defc97343e","primero","4","9","183408524466lps"),
("rpae11146","formaci�n y orientaci�n laboral rpae","ec1fb85b9f","primero","1","1","183408524466lps"),
("rpae57234","procesos de realizaci�n en cine y v�deo","1b22874fc4","segundo","3","7","183408524466lps"),
("rpae12376","procesos de realizaci�n en televisi�n","886e0067f4","segundo","2","5","183408524466lps"),
("rpae03481","procesos de regidur�a de espect�culos y eventos","defc97343e","segundo","3","5","183408524466lps"),
("rpae12984","realizaci�n del montaje y postproducci�n de audiovisuales","ec1fb85b9f","segundo","4","6","183408524466lps"),
("rpae36109","proyecto de realizaci�n de proyectos de audiovisuales y espect�culos","754336ab8f","segundo","2","3","183408524466lps"),
("rpae44471","empresa e iniciativa emprendedora rpae","226265df03","segundo","2","4","183408524466lps");


insert into modulos (cod_m,nombre_m,profesor,curso,sesiones,horas,ciclo)
values ("dam56734","lenguajes de marcas y sistemas de gesti�n de informaci�n dam","48cfd64714","primero","2","6","273849502728asd"),
("dam34521","sistemas inform�ticos dam","b09bd71d86","primero","3","7","273849502728asd"),
("dam12803","bases de datos dam","1b22874fc4","primero","2","3","273849502728asd"),
("dam29041","programaci�n dam","886e0067f4","primero","3","6","273849502728asd"),
("dam89444","entornos de desarrollo dam","defc97343e","primero","4","8","273849502728asd"),
("dam11146","formaci�n y orientaci�n laboral dam","ec1fb85b9f","primero","1","1","273849502728asd"),
("dam57234","acceso a datos","1b22874fc4","segundo","3","6","273849502728asd"),
("dam12376","desarrollo de interfaces","886e0067f4","segundo","3","3","273849502728asd"),
("dam03481","programaci�n multimedia y dispositivos m�viles","defc97343e","segundo","3","5","273849502728asd"),
("dam12984","programaci�n de servicios y procesos","ec1fb85b9f","segundo","4","7","273849502728asd"),
("dam36109","sistemas de gesti�n empresarial","754336ab8f","segundo","2","3","273849502728asd"),
("dam44471","empresa e iniciativa emprendedora dam","226265df03","segundo","2","3","273849502728asd");


insert into modulos (cod_m,nombre_m,profesor,curso,sesiones,horas,ciclo)
values ("daw56734","lenguajes de marcas y sistemas de gesti�n de informaci�n daw","48cfd64714","primero","2","6","283947165038zrx"),
("daw34521","sistemas inform�ticos daw","b09bd71d86","primero","3","7","283947165038zrx"),
("daw12803","bases de datos daw","1b22874fc4","primero","2","3","283947165038zrx"),
("daw29041","programaci�n daw","886e0067f4","primero","3","6","283947165038zrx"),
("daw89444","entornos de desarrollo daw","defc97343e","primero","4","8","283947165038zrx"),
("daw11146","formaci�n y orientaci�n laboral daw","ec1fb85b9f","primero","1","1","283947165038zrx"),
("daw57234","despliegue de aplicaciones web","48cfd64714","segundo","3","6","283947165038zrx"),
("daw12376","dise�o de interfaces web","886e0067f4","segundo","3","3","283947165038zrx"),
("daw03481","desarrollo web entorno cliente","defc97343e","segundo","3","5","283947165038zrx"),
("daw12984","desarrollo web entorno servidor","ec1fb85b9f","segundo","4","7","283947165038zrx"),
("daw44471","empresa e iniciativa emprendedora daw","226265df03","segundo","2","3","283947165038zrx");


insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("20394751d","2021","rpae11146","5",true,"10","2022-01-10",true,"2022-02-20"),
("20394751d","2021","rpae12803","6",false,"3",null,false,null),
("20394751d","2021","rpae29041","7",false,"3",null,false,null),
("20394751d","2021","rpae34521","3",true,"14","2022-01-17",true,"2022-02-15"),
("20394751d","2021","rpae56734","8",false,"2",null,false,null),
("20394751d","2021","rpae89444","10",false,"0",null,false,null),
("20394751d","2022","rpae03481","7",false,"5",null,false,null),
("20394751d","2022","rpae12376","8",false,"3",null,false,null),
("20394751d","2022","rpae12984","6",false,"3",null,false,null),
("20394751d","2022","rpae36109","5",false,"4",null,false,null),
("20394751d","2022","rpae44471","7",false,"2",null,false,null),
("20394751d","2022","rpae57234","7",false,"0",null,false,null);

insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("39450125f","2021","rpae11146","6",false,"3",null,false,null),
("39450125f","2021","rpae12803","7",false,"2",null,false,null),
("39450125f","2021","rpae29041","8",false,"1",null,false,null),
("39450125f","2021","rpae34521","6",false,"0",null,false,null),
("39450125f","2021","rpae56734","9",false,"1",null,false,null),
("39450125f","2021","rpae89444","10",false,"0",null,false,null),
("39450125f","2022","rpae03481","7",false,"2",null,false,null),
("39450125f","2022","rpae12376","8",false,"1",null,false,null),
("39450125f","2022","rpae12984","8",false,"0",null,false,null),
("39450125f","2022","rpae36109","9",false,"2",null,false,null),
("39450125f","2022","rpae44471","7",false,"1",null,false,null),
("39450125f","2022","rpae57234","9",false,"1",null,false,null);

insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("59736219c","2021","rpae11146","6",false,"4",null,false,null),
("59736219c","2021","rpae12803","5",false,"5",null,false,null),
("59736219c","2021","rpae29041","7",false,"6",null,false,null),
("59736219c","2021","rpae34521","6",false,"5",null,false,null),
("59736219c","2021","rpae56734","3",true,"11","2021-10-17",true,"2022-02-20"),
("59736219c","2021","rpae89444","9",false,"5",null,false,null),
("59736219c","2022","rpae03481","6",false,"4",null,false,null),
("59736219c","2022","rpae12376","7",false,"3",null,false,null),
("59736219c","2022","rpae12984","8",false,"2",null,false,null),
("59736219c","2022","rpae36109","10",false,"3",null,false,null),
("59736219c","2022","rpae44471","7",false,"4",null,false,null),
("59736219c","2022","rpae57234","8",false,"4",null,false,null);

insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("97047391g","2021","rpae11146","7",false,"0",null,false,null),
("97047391g","2021","rpae12803","7",false,"2",null,false,null),
("97047391g","2021","rpae29041","9",false,"1",null,false,null),
("97047391g","2021","rpae34521","7",false,"2",null,false,null),
("97047391g","2021","rpae56734","9",false,"1",null,false,null),
("97047391g","2021","rpae89444","8",false,"3",null,false,null),
("97047391g","2022","rpae03481","6",false,"2",null,false,null),
("97047391g","2022","rpae12376","7",false,"1",null,false,null),
("97047391g","2022","rpae12984","8",false,"1",null,false,null),
("97047391g","2022","rpae36109","10",false,"1",null,false,null),
("97047391g","2022","rpae44471","7",false,"2",null,false,null),
("97047391g","2022","rpae57234","8",false,"2",null,false,null);

insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("44483772x","2021","rpae11146","8",false,"0",null,false,null),
("44483772x","2021","rpae12803","8",false,"1",null,false,null),
("44483772x","2021","rpae29041","9",false,"1",null,false,null),
("44483772x","2021","rpae34521","8",false,"0",null,false,null),
("44483772x","2021","rpae56734","10",false,"1",null,false,null),
("44483772x","2021","rpae89444","8",false,"0",null,false,null),
("44483772x","2022","rpae03481","7",false,"2",null,false,null),
("44483772x","2022","rpae12376","7",false,"1",null,false,null),
("44483772x","2022","rpae12984","8",false,"1",null,false,null),
("44483772x","2022","rpae36109","9",false,"1",null,false,null),
("44483772x","2022","rpae44471","6",false,"2",null,false,null),
("44483772x","2022","rpae57234","6",false,"2",null,false,null);


insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("44478233k","2021","dam11146","5",true,"10","2022-02-10",true,"2022-03-20"),
("44478233k","2021","dam12803","6",false,"3",null,false,null),
("44478233k","2021","dam29041","7",false,"3",null,false,null),
("44478233k","2021","dam34521","3",true,"14","2022-01-27",true,"2022-03-28"),
("44478233k","2021","dam56734","8",false,"2",null,false,null),
("44478233k","2021","dam89444","10",false,"0",null,false,null),
("44478233k","2022","dam03481","7",false,"5",null,false,null),
("44478233k","2022","dam12376","8",false,"3",null,false,null),
("44478233k","2022","dam12984","6",false,"3",null,false,null),
("44478233k","2022","dam36109","5",true,"11","2021-9-25",true,"2022-02-20"),
("44478233k","2022","dam44471","7",false,"2",null,false,null),
("44478233k","2022","dam57234","10",false,"0",null,false,null);

insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("44498265v","2021","dam11146","5",false,"4",null,false,null),
("44498265v","2021","dam12803","5",false,"3",null,false,null),
("44498265v","2021","dam29041","6",false,"3",null,false,null),
("44498265v","2021","dam34521","7",true,"14","2022-03-20",true,"2022-05-20"),
("44498265v","2021","dam56734","7",false,"2",null,false,null),
("44498265v","2021","dam89444","6",false,"0",null,false,null),
("44498265v","2022","dam03481","7",false,"5",null,false,null),
("44498265v","2022","dam12376","8",false,"3",null,false,null),
("44498265v","2022","dam12984","6",false,"3",null,false,null),
("44498265v","2022","dam36109","5",true,"11","2021-10-20",true,"2022-02-20"),
("44498265v","2022","dam44471","7",false,"2",null,false,null),
("44498265v","2022","dam57234","7",false,"0",null,false,null);

insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("44469723z","2021","dam11146","7",false,"2",null,false,null),
("44469723z","2021","dam12803","7",false,"3",null,false,null),
("44469723z","2021","dam29041","6",false,"3",null,false,null),
("44469723z","2021","dam34521","7",false,"3",null,false,null),
("44469723z","2021","dam56734","8",false,"2",null,false,null),
("44469723z","2021","dam89444","9",false,"0",null,false,null),
("44469723z","2022","dam03481","7",false,"2",null,false,null),
("44469723z","2022","dam12376","8",false,"3",null,false,null),
("44469723z","2022","dam12984","7",false,"3",null,false,null),
("44469723z","2022","dam36109","5",false,"2",null,false,null),
("44469723z","2022","dam44471","7",false,"2",null,false,null),
("44469723z","2022","dam57234","8",false,"1",null,false,null);

insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("44672095x","2021","dam11146","7",false,"2",null,false,null),
("44672095x","2021","dam12803","8",false,"0",null,false,null),
("44672095x","2021","dam29041","7",false,"0",null,false,null),
("44672095x","2021","dam34521","7",false,"1",null,false,null),
("44672095x","2021","dam56734","9",false,"2",null,false,null),
("44672095x","2021","dam89444","9",false,"0",null,false,null),
("44672095x","2022","dam03481","8",false,"2",null,false,null),
("44672095x","2022","dam12376","8",false,"1",null,false,null),
("44672095x","2022","dam12984","7",false,"1",null,false,null),
("44672095x","2022","dam36109","9",false,"0",null,false,null),
("44672095x","2022","dam44471","7",false,"2",null,false,null),
("44672095x","2022","dam57234","8",false,"1",null,false,null);

insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("46628499l","2021","dam11146","7",false,"2",null,false,null),
("46628499l","2021","dam12803","8",false,"0",null,false,null),
("46628499l","2021","dam29041","7",false,"0",null,false,null),
("46628499l","2021","dam34521","7",false,"1",null,false,null),
("46628499l","2021","dam56734","9",false,"2",null,false,null),
("46628499l","2021","dam89444","9",false,"0",null,false,null),
("46628499l","2022","dam03481","8",false,"2",null,false,null),
("46628499l","2022","dam12376","8",false,"1",null,false,null),
("46628499l","2022","dam12984",null,false,"1",null,false,null),
("46628499l","2022","dam36109","9",false,"0",null,false,null),
("46628499l","2022","dam44471","7",false,"2",null,false,null),
("46628499l","2022","dam57234","8",false,"1",null,false,null);


insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("44927734j","2021","daw11146","7",false,"2",null,false,null),
("44927734j","2021","daw12803","8",false,"0",null,false,null),
("44927734j","2021","daw29041","7",false,"0",null,false,null),
("44927734j","2021","daw34521","7",false,"1",null,false,null),
("44927734j","2021","daw56734","9",false,"2",null,false,null),
("44927734j","2021","daw89444","9",false,"0",null,false,null),
("44927734j","2022","daw03481","8",false,"2",null,false,null),
("44927734j","2022","daw12376","8",false,"1",null,false,null),
("44927734j","2022","daw12984","7",false,"1",null,false,null),
("44927734j","2022","daw44471","9",false,"0",null,false,null),
("44927734j","2022","daw57234","8",false,"1",null,false,null);

insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("44758692h","2021","daw11146","6",false,"2",null,false,null),
("44758692h","2021","daw12803","7",false,"0",null,false,null),
("44758692h","2021","daw29041","6",false,"0",null,false,null),
("44758692h","2021","daw34521","7",false,"1",null,false,null),
("44758692h","2021","daw56734","3",true,"17","2022-2-11",true,"2022-05-20"),
("44758692h","2021","daw89444","7",false,"0",null,false,null),
("44758692h","2022","daw03481","6",false,"2",null,false,null),
("44758692h","2022","daw12376","6",false,"1",null,false,null),
("44758692h","2022","daw12984","7",false,"1",null,false,null),
("44758692h","2022","daw44471","8",false,"0",null,false,null),
("44758692h","2022","daw57234","8",false,"1",null,false,null);

insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("45782314t","2021","daw11146","6",false,"2",null,false,null),
("45782314t","2021","daw12803","7",false,"3",null,false,null),
("45782314t","2021","daw29041","4",true,"11","2022-3-11",true,"2022-05-01"),
("45782314t","2021","daw34521","7",false,"4",null,false,null),
("45782314t","2021","daw56734","6",false,"3",null,false,null),
("45782314t","2021","daw89444","7",false,"3",null,false,null),
("45782314t","2022","daw03481","7",false,"2",null,false,null),
("45782314t","2022","daw12376","7",false,"3",null,false,null),
("45782314t","2022","daw12984","9",false,"1",null,false,null),
("45782314t","2022","daw44471","7",false,"2",null,false,null),
("45782314t","2022","daw57234","8",false,"1",null,false,null);

insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("46792351s","2021","daw11146","8",false,"2",null,false,null),
("46792351s","2021","daw12803","7",false,"3",null,false,null),
("46792351s","2021","daw29041","8",false,"3",null,false,null),
("46792351s","2021","daw34521","7",false,"2",null,false,null),
("46792351s","2021","daw56734","8",false,"3",null,false,null),
("46792351s","2021","daw89444","7",false,"3",null,false,null),
("46792351s","2022","daw03481","9",false,"2",null,false,null),
("46792351s","2022","daw12376","10",false,"3",null,false,null),
("46792351s","2022","daw12984","9",false,"1",null,false,null),
("46792351s","2022","daw44471","7",false,"2",null,false,null),
("46792351s","2022","daw57234","8",false,"1",null,false,null);

insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap, perdida_ec, fecha_pec)
values ("44669234f","2021","daw11146","8",false,"2",null,false,null),
("44669234f","2021","daw12803","9",false,"0",null,false,null),
("44669234f","2021","daw29041","8",false,"1",null,false,null),
("44669234f","2021","daw34521","10",false,"2",null,false,null),
("44669234f","2021","daw56734","8",false,"1",null,false,null),
("44669234f","2021","daw89444","10",false,"1",null,false,null),
("44669234f","2022","daw03481","9",false,"0",null,false,null),
("44669234f","2022","daw12376","10",false,"1",null,false,null),
("44669234f","2022","daw12984","9",false,"1",null,false,null),
("44669234f","2022","daw44471","7",false,"2",null,false,null),
("44669234f","2022","daw57234","10",false,"1",null,false,null);


insert into matricula (alumno, curso_a, ciclo, fecha_alta, fecha_baja)
values ("20394751d","2021","183408524466lps","2021-09-01","2022-03-27"),
("39450125f","2021","183408524466lps","2021-09-01",null),
("44469723z","2021","273849502728asd","2021-09-01",null),
("44478233k","2021","273849502728asd","2021-09-01",null),
("44483772x","2021","183408524466lps","2021-09-02",null),
("44498265v","2021","273849502728asd","2021-09-02",null),
("44669234f","2021","283947165038zrx","2021-09-02",null),
("44672095x","2021","273849502728asd","2021-09-02",null),
("44758692h","2021","283947165038zrx","2021-09-03",null),
("44927734j","2021","283947165038zrx","2021-09-03",null),
("45782314t","2021","283947165038zrx","2021-09-03",null),
("46628499l","2021","273849502728asd","2021-09-04",null),
("46792351s","2021","283947165038zrx","2021-09-04","2021-10-20"),
("59736219c","2021","183408524466lps","2021-09-04",null),
("97047391g","2021","183408524466lps","2021-09-04",null);


insert into matricula (alumno, curso_a, ciclo, fecha_alta, fecha_baja)
values ("39450125f","2022","183408524466lps","2022-09-01",null),
("44469723z","2022","273849502728asd","2022-09-01",null),
("44478233k","2022","273849502728asd","2022-09-01",null),
("44483772x","2022","183408524466lps","2022-09-02",null),
("44498265v","2022","273849502728asd","2022-09-02",null),
("44669234f","2022","283947165038zrx","2022-09-02",null),
("44672095x","2022","273849502728asd","2022-09-02",null),
("44758692h","2022","283947165038zrx","2022-09-03",null),
("44927734j","2022","283947165038zrx","2022-09-03",null),
("45782314t","2022","283947165038zrx","2022-09-03",null),
("46628499l","2022","273849502728asd","2022-09-04",null),
("59736219c","2022","183408524466lps","2022-09-04",null),
("97047391g","2022","183408524466lps","2022-09-04",null);

###############################################################################################################
############################################# consultas #######################################################
###############################################################################################################


/*************************************** Consulta 1 ***************************************************
 
Mostrar para el curso actual los profesores que est�n impartiendo menos de 20 sesiones semanales.

+subconsultas:
select distinct modulo from curso_alumno where curso_a = year(now());

select m.profesor, m.cod_m, sum(m.sesiones) as total_sesiones from modulos m
inner join (select distinct modulo from curso_alumno where curso_a = year(now())) as t
on m.cod_m = t.modulo group by profesor;

select t1.* from (select m.profesor, m.cod_m, sum(m.sesiones) as total_sesiones from modulos m
inner join (select distinct modulo from curso_alumno where curso_a = year(now())) as t
on m.cod_m = t.modulo group by profesor) as t1 where t1.total_sesiones > 20;

*NOTA: muestra todos los profesores ya que ninguno se pasa de las 20 sesiones.*/

select p.nombre_p as profesores_menos_20_sesiones from profesores p 
left join (select t1.* from (select m.profesor, m.cod_m, sum(m.sesiones) as total_sesiones from modulos m
			inner join (select distinct modulo from curso_alumno where curso_a = year(now())) as t
			on m.cod_m = t.modulo group by profesor) as t1 where t1.total_sesiones > "20") as t2
	on p.nrp = t2.profesor where t2.profesor is null;

/*************************************** Consulta 2 *****************************************************

Mostrar para el curso actual, el n�mero de alumnos por m�dulo con el profesor que lo imparte en la actualidad.
se deben contar los alumnos que han perdido el derecho a la evaluaci�n continua, pero no aquellos que hayan sido dados de baja en el ciclo.

+subconsultas
select ma.alumno from matricula ma where ma.fecha_baja is not null and ma.curso_a = year(now());

select count(ca.alumno) as num_alumnos, ca.modulo from curso_alumno ca
left join (select ma.alumno from matricula ma where ma.fecha_baja is not null and ma.curso_a = year(now())) as t 
on ca.alumno = t.alumno where t.alumno is null and curso_a = year(now()) group by modulo;

select m.profesor, t1.* from modulos m 
	inner join (select count(ca.alumno) as num_alumnos, ca.modulo from curso_alumno ca
				left join (select ma.alumno from matricula ma where ma.fecha_baja is not null and ma.curso_a = year(now())) as t 
					on ca.alumno = t.alumno where t.alumno is null and curso_a = year(now()) group by modulo) as t1
		on m.cod_m = t1.modulo;
*/

select p.nombre_p, t4.num_alumnos as num_alumnos, t4.modulo as modulo from profesores p 
inner join (select m.profesor, t1.* from modulos m 
			inner join (select count(ca.alumno) as num_alumnos, ca.modulo from curso_alumno ca
						left join (select ma.alumno from matricula ma where ma.fecha_baja is not null and ma.curso_a = year(now())) as t 
						on ca.alumno = t.alumno where t.alumno is null and curso_a = year(now()) group by modulo) as t1
			on m.cod_m = t1.modulo) as t4 
on t4.profesor = p.nrp;

	
	
/*************************************** Eonsulta 3 *****************************************************
 
Mostrar el porcentaje de aprobados en el m�dulo �programaci�n� en todos los cursos ya finalizados, sin tener en cuenta las bajas.

+subconsultas:	
select c.ano from cursos c where finalizado is true;
	
select m.alumno from matricula m 
	inner join (select c.ano from cursos c where finalizado is true) as t
	on m.curso_a = t.ano where fecha_baja is null;

select ca.alumno, ca.curso_a, ca.modulo, ca.nota  from curso_alumno ca
	inner join (select m.alumno from matricula m 
				inner join (select c.ano from cursos c where finalizado is true) as t
				on m.curso_a = t.ano where fecha_baja is null) as t3
	on ca.alumno = t3.alumno where ca.nota < "5" and ca.modulo = "dam29041" or ca.modulo = "daw29041";

select ca.modulo, ca.nota, t1.* from curso_alumno ca 
	inner join (select m.alumno from matricula m 
				inner join (select c.ano from cursos c where finalizado is true) as t
				on m.curso_a = t.ano where fecha_baja is null) as t1
	on ca.alumno = t1.alumno where ca.modulo = "dam29041" or ca.modulo = "daw29041";


select ca.modulo, ca.nota, ca.alumno from curso_alumno ca where ca.nota < 5;

select count(ca.alumno) from curso_alumno ca 
	inner join (select ca.modulo, ca.nota, ca.alumno from curso_alumno ca where ca.nota < 5) as t4
	on ca.alumno = t4.alumno and ca.nota = t4.nota where ca.modulo = "dam29041" or ca.modulo = "daw29041";

*/

	
select concat((count(t2.nota) - (select count(ca.alumno) from curso_alumno ca 
							inner join (select ca.modulo, ca.nota, ca.alumno from curso_alumno ca where ca.nota < "5") as t4
							on ca.alumno = t4.alumno and ca.nota = t4.nota where ca.modulo = "dam29041" or ca.modulo = "daw29041") /
	   count(t2.nota)) * "10", " %") as aprobados_pro from (select ca.modulo, ca.nota, t1.* from curso_alumno ca
							inner join (select m.alumno from matricula m 
											inner join (select c.ano from cursos c where finalizado is true) as t
											on m.curso_a = t.ano where fecha_baja is null) as t1
							on ca.alumno = t1.alumno where ca.modulo = "dam29041" or ca.modulo = "daw29041") as t2;
		

/*************************************** Consulta 4 *****************************************************

Listar para el curso actual los alumnos de cada m�dulo a los que es necesario enviar el apercibimiento de p�rdida de derecho a la evaluaci�n continua.

+subconsulta: 
select c.ano from cursos c where finalizado is false;

*/

select ca.alumno, ca.modulo, ca.faltas, ca.enviado_ap, ca.fecha_ap from curso_alumno ca 
	inner join (select c.ano from cursos c where finalizado is false) as t
	on ca.curso_a = t.ano where ca.faltas >= "10";


###############################################################################################################
################################# funciones procedimientos triggers ###########################################
###############################################################################################################


# Creamos usuarios:

drop user if exists "1b22874fc4"@"%";
drop user if exists "226265df03"@"%";
drop user if exists "48cfd64714"@"%";
drop user if exists "754336ab8f"@"%";
drop user if exists "886e0067f4"@"%";
drop user if exists "b09bd71d86"@"%";
drop user if exists "defc97343e"@"%";
drop user if exists "ec1fb85b9f"@"%";


create user "1b22874fc4"@"%" identified by "1b22874fc4";
create user "226265df03"@"%" identified by "226265df03";
create user "48cfd64714"@"%" identified by "48cfd64714";
create user "754336ab8f"@"%" identified by "754336ab8f";
create user "886e0067f4"@"%" identified by "886e0067f4";
create user "b09bd71d86"@"%" identified by "b09bd71d86";
create user "defc97343e"@"%" identified by "defc97343e";
create user "ec1fb85b9f"@"%" identified by "ec1fb85b9f";


/*
 ***************************************************************************************************
 * Si es necesario, modificar la bd para poder conocer, por cada curso acad�mico en qu� ciclo se matriculan los alumnos.
 ********************************************************************************************
 */

drop view if exists ciclos_curso;

create view ciclos_curso as
select distinct m.ciclo as ciclos_con_matricula, m.curso_a as curso_de_matriculacion from matricula m;



/*
 ***************************************************************************************************
 * Programar una funci�n que obtenga el c�digo del curso actual.
 ********************************************************************************************
 */

set global log_bin_trust_function_creators = 1;

drop function if exists cod_ano;

delimiter //

create function cod_ano()
returns year
begin
declare ano_act year;
select ano into ano_act from cursos where finalizado is false;
return ano_act;
end;
//

delimiter ;


/*
 **************************************************************************************************
 *Para aquellos alumnos del curso actual que est�n cursando m�dulos que no se corresponden con el ciclo que figura en su impreso de matr�cula, 
 *listar las parejas alumno � m�dulo. utilizar la funci�n programada en el punto anterior. 
 **********************************************************************************************

 -Consulta alumnos del curso actual que est�n cursando m�dulos que no se corresponden con el ciclo que figura en su impreso de matr�cula:
 
+subconsultas:
drop view if exists alumno_modulo_incorrecto as 

select c.ano from cursos c where finalizado is false;

select ca.alumno, ca.modulo, ca.curso_a from curso_alumno ca 
inner join (select c.ano from cursos c where finalizado is false) as t 
on ca.curso_a = t.ano;

select t1.*, mo.nombre_m, mo.ciclo from modulos mo 
inner join (select ca.alumno, ca.modulo, ca.curso_a from curso_alumno ca 
			inner join (select c.ano from cursos c where finalizado is false) as t 
			on ca.curso_a = t.ano) as t1
on mo.cod_m = t1.modulo;

 *********************consulta final**********************

select m.alumno, m.ciclo as ciclo_matricula, t2.modulo, t2.nombre_m as nombre_modulo, t2.ciclo as ciclo_modulo, t2.curso_a as curso from matricula m 
inner join (select t1.*, mo.nombre_m, mo.ciclo from modulos mo 
			inner join (select ca.alumno, ca.modulo, ca.curso_a from curso_alumno ca 
						inner join (select c.ano from cursos c where finalizado is false) as t 
						on ca.curso_a = t.ano) as t1
			on mo.cod_m = t1.modulo) as t2
on m.alumno = t2.alumno and m.ciclo != t2.ciclo where m.curso_a = t2.curso_a;
 */


# View alumno � m�dulo (ciclo incorrecto) (LA TABLA APARECE SIN DATOS PORQUE NO HAY NINGUN CICLO INCORRECTO):
drop view if exists alumno_modulo_ciclo_incorrecto;

create view alumno_modulo_ciclo_incorrecto as
select m.alumno, m.ciclo as ciclo_matricula, t2.modulo, t2.nombre_m as nombre_modulo, t2.ciclo as ciclo_modulo, t2.curso_a as curso from matricula m 
inner join (select t1.*, mo.nombre_m, mo.ciclo from modulos mo 
			inner join (select ca.alumno, ca.modulo, ca.curso_a from curso_alumno ca where ca.curso_a = cod_ano()) as t1
			on mo.cod_m = t1.modulo) as t2
on m.alumno = t2.alumno and m.ciclo != t2.ciclo where m.curso_a = t2.curso_a;




/*
 **************************************************************************************************
 *Escribir el sql necesario para a�adir a la bd un mecanismo que impida que un alumno curse m�dulos que no se correspondan con el ciclo en que se haya matriculado.
 **********************************************************************************************
 */


drop trigger if exists comprobar_modulocomprobar_modulos_alumno_triggs_alumno_trigg;

delimiter //

create trigger comprobar_modulos_alumno_trigg
after insert on curso_alumno
for each row
begin
declare cic_matricula varchar(15);
declare cic_modulo varchar(15);
select m.ciclo into cic_matricula from matricula m where m.alumno = new.alumno and m.curso_a like (select c.ano from cursos c where finalizado is false);
select m.ciclo into cic_modulo from modulos m where new.modulo = m.cod_m;
if cic_modulo <> cic_matricula then
	delete from curso_alumno where alumno = new.alumno and modulo = new.modulo;
end if;
end;
//

delimiter ;

# ************ PRUEBAS Trigger (comprobar_modulos_alumno_trigg) *********************


# No inserta:
/*
insert into alumnos (dni, nombre_a, fecha_nac, tlf)
values ("22224751d","almona rageno" ,"2000-08-12","624473635");

insert into matricula (alumno, curso_a, ciclo, fecha_alta, fecha_baja)
values ("22224751d","2022","183408524466lps","2022-09-01",null);

insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap)
values ("22224751d","2022","dam11146","7",false,"2",null);
*/

/*
# Inserte correctamente:

insert into alumnos (dni, nombre_a, fecha_nac, tlf)
values ("33334751d","pepe rag" ,"2000-08-12","626673635");

insert into matricula (alumno, curso_a, ciclo, fecha_alta, fecha_baja)
values ("33334751d","2022","273849502728asd","2022-09-01",null);

insert into curso_alumno (alumno, curso_a, modulo, nota, enviado_ap, faltas, fecha_ap)
values ("33334751d","2022","dam11146","7",false,"2",null);
*/



/***************************** Enunciado del apartado 5 *******************************************
 **************************************************************************************************
 *Escribir el sql necesario para a�adir a la bd un mecanismo que impida modificar el ciclo en que est� matriculado un alumno si ya se le ha asignado alg�n m�dulo.
 **********************************************************************************************
*/


/*********** PROCEDIMIENTO ************/
drop procedure if exists control_mod_matricula;

delimiter //

create procedure control_mod_matricula (in alum varchar(9))
begin
	declare ciclo_ant varchar(15);
	declare alumno_con_mod varchar(9);
	select m.ciclo into ciclo_ant from matricula m where m.alumno = alum;
	select ca.alumno into alumno_con_mod from curso_alumno ca where ca.alumno = alum;
		if alum = alumno_con_mod then
			update matricula set ciclo = ciclo_ant where alumno = alum;
		end if;
end;
//

delimiter ;


/*********** TRIGGER ************/
drop trigger if exists control_mod_matricula_trigg;

delimiter //

create trigger control_mod_matricula_trigg
after update on matricula
for each row
begin
	if new.ciclo != old.ciclo then 
		call control_mod_matricula(new.alumno);
	end if;
end;
//

delimiter ;

# ************ Pruebas trigger (comprobar_modulos_alumno_trigg) *********************
/* 
# No modifica:

update matricula set ciclo = "183429004466pru" where alumno = "97047391g" and curso_a like cod_ano();

# Modifica correctamente:

insert into alumnos (dni, nombre_a, fecha_nac, tlf)
values ("00004751d","juan remo" ,"2000-08-12","627470035");

insert into matricula (alumno, curso_a, ciclo, fecha_alta, fecha_baja)
values ("00004751d","2022","183408524466lps","2022-09-01",null);

update matricula set ciclo = "183429004466pru" where alumno = "00004751d" and curso_a like cod_ano();

*/

/*
select c.ano from cursos c where finalizado is false;


select ciclo from matricula where alumno = "97047391g" and curso_a like (select c.ano from cursos c where finalizado is false);
*/


###############################################################################################################
######################################## vistas roles permisos ################################################
###############################################################################################################



/*
 ***************************************************************************************************
 * crear una vista que muestre, para los m�dulos que imparte el profesor conectado al sgbd, los alumnos matriculados, sus notas y sus faltas
 ********************************************************************************************
 */

/*
 * consulta
select m.alumno, m.curso_a, m.ciclo  from matricula m 
				inner join (select c.ano from cursos c where finalizado is false) as t
				on m.curso_a = t.ano where fecha_baja is null;
			
select m.profesor, t2.*  from modulos m 
inner join (select m.curso_a, m.alumno, m.ciclo from matricula m 
				inner join (select c.ano from cursos c where finalizado is false) as t
				on m.curso_a = t.ano where fecha_baja is null) as t2
on m.ciclo = t2.ciclo where m.profesor like "1b22874fc4" group by t2.alumno;


select t3.profesor, t3.alumno, ca.modulo, ca.nota, ca.faltas from curso_alumno ca 
inner join (select m.profesor, t2.*  from modulos m 
inner join (select m.curso_a, m.alumno, m.ciclo from matricula m 
				inner join (select c.ano from cursos c where finalizado is false) as t
				on m.curso_a = t.ano where fecha_baja is null) as t2
on m.ciclo = t2.ciclo where m.profesor like "1b22874fc4" group by t2.alumno) as t3
on ca.alumno = t3.alumno;
	
*/


drop view if exists profesor_alumnos_matriculados;

create view profesor_alumnos_matriculados as
select t3.profesor, t3.alumno, ca.modulo, ca.nota, ca.faltas from curso_alumno ca 
inner join (select m.profesor, t2.*  from modulos m 
inner join (select m.curso_a, m.alumno, m.ciclo from matricula m 
				inner join (select c.ano from cursos c where finalizado is false) as t
				on m.curso_a = t.ano where fecha_baja is null) as t2
on m.ciclo = t2.ciclo where m.profesor like (select left(current_user(), instr(current_user(), '@') - 1)) group by t2.alumno) as t3
on ca.alumno = t3.alumno;
			



/*
 ***************************************************************************************************
 * crear una segunda vista que muestre para el profesor conectado al sgbd, los alumnos de los que es tutor, 
 * con el n�mero de faltas por m�dulo y la informaci�n de si se ha enviado o no el apercibimiento, 
 * o si el alumno ha perdido el derecho a la evaluaci�n continua, y en qu� fechas.
 ********************************************************************************************
 */


/* consulta:
select ca.curso_a, ca.alumno, ca.modulo, ca.faltas, ca.enviado_ap, ca.fecha_ap from curso_alumno ca where ca.curso_a = cod_ano();


select t.*, m.ciclo from modulos m
inner join (select ca.curso_a, ca.alumno, ca.modulo, ca.faltas, ca.enviado_ap, ca.fecha_ap from curso_alumno ca where ca.curso_a = cod_ano()) as t 
on m.cod_m = t.modulo;

select c.tutor, t2.curso_a as curso, t2.alumno, t2.modulo, t2.faltas, t2.fecha_ap, t2.enviado_ap, t2.perdida_ec, t2.fecha_pec from ciclos c
inner join (select t.*, m.ciclo from modulos m
			inner join (select ca.curso_a, ca.alumno, ca.modulo, ca.faltas, ca.enviado_ap, ca.fecha_ap, ca.perdida_ec, ca.fecha_pec from curso_alumno ca where ca.curso_a = cod_ano()) as t 
			on m.cod_m = t.modulo) as t2 
on c.cod_c = t2.ciclo where c.tutor = "ec1fb85b9f";

*/


drop view if exists tutor_alumnos;

create view tutor_alumnos as
select c.tutor, t2.curso_a as curso, t2.alumno, t2.modulo, t2.faltas, t2.fecha_ap, t2.enviado_ap, t2.perdida_ec, t2.fecha_pec as fecha_perdida_ec from ciclos c
inner join (select t.*, m.ciclo from modulos m
			inner join (select ca.curso_a, ca.alumno, ca.modulo, ca.faltas, ca.enviado_ap, ca.fecha_ap, ca.perdida_ec, ca.fecha_pec from curso_alumno ca where ca.curso_a = cod_ano()) as t 
			on m.cod_m = t.modulo) as t2 
on c.cod_c = t2.ciclo where c.tutor like (select left(current_user(), instr(current_user(), '@') - 1));

/*
 ***************************************************************************************************
 * crear dos roles en la bd: administrador y profesor.
 ********************************************************************************************
 */

drop role if exists "administrador";
drop role if exists "profesor";

create role "administrador";
create role "profesor";


/*
 ***************************************************************************************************
 * definir permisos sobre las vistas anteriores de forma que los usuarios con el rol profesor solo puedan modificar las notas y 
 * el n�mero de faltas de los m�dulos que imparten y la informaci�n relacionada con la p�rdida de derecho a la evaluaci�n continua de los alumnos de los que son tutores. 
 * los usuarios con el role administrador tienen permisos totales sobre las mismas.
 ********************************************************************************************
 */


grant all on instituto.* to "administrador"@"%";
grant select, update (nota) on instituto.curso_alumno to "profesor"@"%";
grant select, update (faltas) on instituto.curso_alumno to "profesor"@"%";
grant select, update (perdida_ec) on instituto.curso_alumno to "profesor"@"%";
grant select, update (fecha_pec) on instituto.curso_alumno to "profesor"@"%";
grant select, show view on instituto.tutor_alumnos to "profesor"@"%";
grant select, show view on instituto.profesor_alumnos_matriculados to "profesor"@"%";

grant select, update (nota) on instituto.curso_alumno to "1b22874fc4","226265df03","48cfd64714","754336ab8f","886e0067f4","b09bd71d86","defc97343e","ec1fb85b9f";
grant select, update (faltas) on instituto.curso_alumno to "1b22874fc4","226265df03","48cfd64714","754336ab8f","886e0067f4","b09bd71d86","defc97343e","ec1fb85b9f";
grant select, update (perdida_ec) on instituto.curso_alumno to "1b22874fc4","226265df03","48cfd64714","754336ab8f","886e0067f4","b09bd71d86","defc97343e","ec1fb85b9f";
grant select, update (fecha_pec) on instituto.curso_alumno to "1b22874fc4","226265df03","48cfd64714","754336ab8f","886e0067f4","b09bd71d86","defc97343e","ec1fb85b9f";
grant select, show view on instituto.tutor_alumnos to "1b22874fc4","226265df03","48cfd64714","754336ab8f","886e0067f4","b09bd71d86","defc97343e","ec1fb85b9f";
grant select, show view on instituto.profesor_alumnos_matriculados to "1b22874fc4","226265df03","48cfd64714","754336ab8f","886e0067f4","b09bd71d86","defc97343e","ec1fb85b9f";

show grants for "profesor";
show grants for "administrador";


/*
grant "1b22874fc4" to "profesor";
grant "226265df03" to "profesor";
grant "48cfd64714" to "profesor";
grant "754336ab8f" to "profesor";
grant "886e0067f4" to "profesor";
grant "b09bd71d86" to "profesor";
grant "defc97343e" to "profesor";
grant "ec1fb85b9f" to "profesor";
*/

/*
Obtienes el usuario sin "@" y sin el "localhost" o "%":

select left(current_user(), instr(current_user(), '@') - 1);

obtienes el usuario:

select current_user();
*/



/*
 ***************************************************************************************************
 * no se debe permitir cerrar un curso acad�mico si existen alumnos sin calificar que no hayan sido dados de baja.
 ********************************************************************************************
 */

drop trigger if exists control_cierre_curso_alumnos_sin_calificar;

delimiter //

create trigger control_cierre_curso_alumnos_sin_calificar
after update on cursos 
for each row
begin
declare calificacion int;
select ca.nota into calificacion from curso_alumno ca
inner join (select m.alumno from matricula m where fecha_baja is null and m.curso_a = cod_ano()) as t
on ca.alumno = t.alumno where nota is null group by ca.nota;
	if calificacion is not null then
		update cursos set finalizado = false where ano = cod_ano();
	end if;
end;
//

delimiter ;

select m.alumno from matricula m where fecha_baja is null and m.curso_a = cod_ano();

select ca.nota from curso_alumno ca
inner join (select m.alumno from matricula m where fecha_baja is null and m.curso_a = cod_ano()) as t 
on ca.alumno = t.alumno where nota is null group by ca.nota;


/*
 ***************************************************************************************************
 * crear un procedimiento que ponga la nota que se le pase como par�metro a aquellos alumnos del curso actual que no tengan nota ni hayan sido dados de baja. 
 * a continuaci�n debe finalizar el curso acad�mico actual y dar de alta el siguiente.
 ********************************************************************************************
 */

drop procedure if exists fin_curso_actual;

delimiter //

create procedure fin_curso_actual(in calif int)
begin
    declare ano_a year;
    set ano_a = cod_ano();
    update curso_alumno set nota = calif where curso_a = ano_a and nota is null;
    update cursos set finalizado = true where ano = ano_a;
    insert into cursos (ano, finalizado) values (ano_a + 1, false);
end;
//

delimiter ;

# PRUEBA TRIGGER:
 
# call fin_curso_actual(5);











