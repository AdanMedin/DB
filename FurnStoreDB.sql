drop database if exists tienda_muebles;

create database tienda_muebles;

use tienda_muebles;

create table departamentos (
	cod_departamento char(6) not null primary key,
	nombre varchar(20) not null,
	constraint chk_cod_departamento check (cod_departamento regexp "[0-9]{3}[a-z]{3}")
);

create table cajas (
	cod_caja char(5) not null primary key,
	cod_departamento char(6) not null,
	constraint chk_cod_caja check (cod_caja regexp "[0-9]{2}[a-z]{3}"),
	constraint fk_cod_departamento_cajas foreign key (cod_departamento) references departamentos(cod_departamento) on delete no action on update cascade
);

create table dependientes (
	id char(9) not null primary key,
	nombre varchar(30) not null,
	constraint chk_id check (id regexp "[0-9]{8}[a-z]{1}")
);

create table dependiente_caja (
	id varchar(9) not null,
	cod_caja char(5) not null,
	constraint fk_id foreign key (id) references dependientes(id) on delete no action on update cascade,
	constraint fk_cod_caja foreign key (cod_caja) references cajas(cod_caja) on delete no action on update cascade
);

create table articulos (
	cod_articulo char(10) not null primary key,
	stock int not null,
	precio decimal(8,3) not null,
	cod_departamento char(6),
	constraint chk_cod_articulo check (cod_articulo regexp "[0-9]{10}"),
	constraint chk_precio check (precio>"0"),
	constraint fk_cod_departamento_art foreign key (cod_departamento) references departamentos(cod_departamento) on delete no action on update cascade
);

create table muebles (
	cod_articulo char(10) not null,
	nombre varchar(100) not null,	
	estancia enum("salon","cocina","baño","dormitorio","habtacion infantil","comedor",
				  "pasillo","entrada","jardin y terraza","garaje") not null,				  
	tipo enum("clasico","zen","moderno","barroco","rustico","de diseño","contemporaneo","colonial",
			  "pop","vintage","minimalista","trabajo","almacenaje") not null,
			  
	color enum("hera","roble olmo","nebraska","siroko","smoky","virginia","cemento","gris antracita","gris marengo","azul cielo",
				"oceano","arena","rojo brillo","pistacho brillo","chocolate brillo","lila","turquesa","forja grafito") not null,	
				
	material enum("madera maciza","tablero aglomerado","mimbre","tapizados","metalico","material plastico","porcelanicos") not null,
	alto int null,
	ancho int null,
	largo int null,
	peso int null,
	constraint pk_mueble primary key (cod_articulo),
	constraint fk_cod_articulo_muebles foreign key (cod_articulo) references articulos(cod_articulo) on delete cascade on update cascade
);

create table menaje (
	cod_articulo char(10) not null,
	nombre varchar(30) not null,
	tipo enum("vajilla","cuberteria","utensilio de cocina","dispensadores y dosificadores","reposteria","perchas y colgadores","vajilla baño","cuadros","centros",
			  "ollas y cacerolas","sartenes","almacenaje de alimentos","figuras","alfombras","tapas inodoro","complementos salon") not null,
	constraint pk_alumno_curso_ciclo primary key (cod_articulo),
	constraint fk_cod_articulo_menaje foreign key (cod_articulo) references articulos(cod_articulo) on delete cascade on update cascade
);

create table tickets (
	num_ticket int not null primary key auto_increment,
	total decimal(9,3) null,
	fecha datetime not null default current_timestamp,
	id char(9) not null,
	constraint chk_total_tiket check (total>"0"),
	constraint fk_id_ticket foreign key (id) references dependientes(id) on delete no action on update cascade
) auto_increment = 101;

create table ventas (
	num_venta int not null primary key auto_increment,
	num_ticket int not null,
	cod_articulo char(10) not null,
	uds int not null,
	total decimal (9,3) null,
	constraint chk_uds check (uds>"0"),
	constraint chk_total_venta check (total>"0"),
	constraint fk_cod_articulo_venta foreign key (cod_articulo) references articulos(cod_articulo) on delete cascade on update cascade,
	constraint fk_num_ticket foreign key (num_ticket) references tickets(num_ticket) on delete cascade on update cascade
) auto_increment = 101;

##################### INSERTS ########################################## INSERTS ########################################## INSERTS ########################
##################### INSERTS ########################################## INSERTS ########################################## INSERTS ########################
##################### INSERTS ########################################## INSERTS ########################################## INSERTS ########################

insert into departamentos (cod_departamento,nombre)
values ("382ban","baño"),
("945coc","cocina"),
("927dor","dormitorio"),
("305sal","salon"),
("461dec","decoracion"),
("553ord","ordenacion"),
("461jar","jardin");

insert into cajas (cod_caja,cod_departamento)
values ("01ban","382ban"),
("02coc","945coc"),
("03dor","927dor"),
("04sal","305sal"),
("05dec","461dec"),
("06ord","553ord"),
("07jar","461jar");

insert into dependientes (id,nombre)
values ("44473829d","Eustaquia Perez"),
("44382905x","Nimesia Lopez"),
("43329547g","Ladislao Gomez"),
("44872239z","Gumersindo Varela"),
("44448922a","Castor Meno"),
("46673459j","Anacleta Rivas"),
("33367328c","Piedad Vazquez");

insert into dependiente_caja (id,cod_caja)
values ("44473829d","01ban"),
("44382905x","02coc"),
("43329547g","03dor"),
("44872239z","04sal"),
("44448922a","05dec"),
("46673459j","06ord"),
("33367328c","07jar");


########### ARTICULOS MUEBLES ############
insert into articulos (cod_articulo,stock,precio,cod_departamento)
values ("1916162999","3","2665.96","305sal"),
("1798126121","2","1448.86","382ban"),
("1541038768","5","1343.12","461dec"),
("1928211419","4","314.48","461jar"),
("1534749395","6","122.59","553ord"),
("1373679355","3","43.29","927dor"),
("1538016128","2","194.31","945coc"),
("1796521992","0","1263.88","553ord"),
("2129031941","1","3341.43","927dor"),
("2052207775","2","3559.83","945coc"),
("1428103568","6","5733.58","305sal"),
("1313783467","4","947.36","382ban"),
("2028082666","6","94.48","461dec"),
("1336426659","4","338.78","461dec"),
("1453728373","7","1349.13","461jar"),
("2005336208","8","624.08","305sal"),
("1480637134","9","1730.09","927dor"),
("1317324494","2","7296.98","945coc"),
("1698618045","3","209.50","553ord"),
("1627103203","0","820.23","382ban"),
("1298932673","3","2005.96","305sal"),
("2595116643","2","148.86","382ban"),
("1786165036","5","133.12","461dec"),
("1535149724","4","34.48","461jar"),
("1457898279","6","172.59","553ord"),
("6095130502","3","33.29","927dor"),
("2500761834","2","197.31","945coc"),
("1068157898","0","1163.88","553ord"),
("2103459273","1","3141.43","927dor"),
("2041502479","2","2559.83","945coc"),
("1530123987","6","1733.58","305sal"),
("7325002186","4","47.36","382ban"),
("1192733098","6","94.48","461dec"),
("7347390636","4","338.78","461dec"),
("1910424687","7","1349.13","461jar"),
("1762827449","8","724.08","305sal"),
("6348192328","9","1930.09","927dor"),
("1984194180","2","3296.98","945coc"),
("1750684102","3","209.50","553ord"),
("1027649654","0","220.23","382ban");

insert into muebles (cod_articulo,nombre,estancia,tipo,color,material,alto,ancho,largo,peso)
values ("1916162999","Mueble de salón PEPA","salon","moderno","hera","madera maciza","60","100","340","150"),
("1798126121","Conjunto de baño RODOMIRA","baño","clasico","azul cielo","tablero aglomerado","110","90","100","34"),
("1541038768","Mueble pasillo JUANITA","pasillo","barroco","turquesa","madera maciza","100","98","65","20"),
("1928211419","Conjunto terraza LIMA","jardin y terraza","contemporaneo","hera","mimbre","50","60","130","45"),
("1534749395","Cajonera herramientas BULL","garaje","trabajo","gris antracita","material plastico","100","98","100","12"),
("1373679355","Mesa ausiliar LISA","dormitorio","colonial","chocolate brillo","madera maciza","60","70","40","17"),
("1538016128","Modulo vajilla RITA","cocina","de diseño","cemento","tablero aglomerado","110","98","100","15"),
("1796521992","Mesa de trabajo HERCULES","garaje","trabajo","gris marengo","metalico","120","110","210","215"),
("2129031941","Mueble dormitorio ARGEL","dormitorio","rustico","siroko","madera maciza","210","240","100","53"),
("2052207775","Conjunto modulos cocina ISABEL","cocina","vintage","oceano","tablero aglomerado",null,null,null,null),
("1428103568","Cheslong DELUX","salon","pop","nebraska","tapizados","65","180","100","60"),
("1313783467","Bañera ROCA","baño","clasico","nebraska","porcelanicos","64","110","165","37"),
("2028082666","Lampara ESTEPA","comedor","zen","siroko","metalico","105","75",null,"7"),
("1336426659","Espejo retroiluminado","salon","contemporaneo","arena","madera maciza","160","120",null,"36"),
("1453728373","Set jardin LEONA","jardin y terraza","pop","hera","material plastico","45","110","210","43"),
("2005336208","Sofá individual MONA","salon","barroco","cemento","tapizados","50","100","110","46"),
("1480637134","Cabecero y mesas de noche JAPO","dormitorio","zen","siroko","madera maciza",null,null,null,"63"),
("1317324494","Cocina ANTRAC modulos + encimera","cocina","de diseño","gris antracita","tablero aglomerado",null,null,null,null),
("1698618045","Baul","garaje","almacenaje","smoky","material plastico","50","70","110","5"),
("1627103203","Mueble de baño 3 cajones DAKOTA","baño","moderno","azul cielo","madera maciza","110","100","100","26"),
("1298932673","Mesa comedor LONDON","comedor","contemporaneo","chocolate brillo","madera maciza","100","120","235","140"),
("2595116643","Mueble de baño esquinero TITO","baño","barroco","virginia","madera maciza","50","100","76","26"),
("1786165036","Mueble entrada PUMA","entrada","vintage","forja grafito","metalico","100","90","36","32"),
("1535149724","Hamaca de tela","jardin y terraza","vintage","gris marengo","tapizados",null,"70","220",null),
("1457898279","Cajonera tornillería JUMBO","garaje","trabajo","smoky","material plastico","125","130","140","21"),
("6095130502","Comoda CUCO","dormitorio","minimalista","hera","madera maciza","110","145","70","48"),
("2500761834","Estanteria microondas","cocina","almacenaje","smoky","metalico",null,"50","53","1"),
("1068157898","Mueble de garaje EXCALIBUR","garaje","almacenaje","smoky","metalico","185","150","110","120"),
("2103459273","Habitación infantil ERIKA","habtacion infantil","moderno","pistacho brillo","madera maciza",null,null,null,"270"),
("2041502479","Conjunto modulos de cocina BOR","cocina","clasico","arena","tablero aglomerado",null,null,null,null),
("1530123987","Sofá MITRA","salon","colonial","virginia","mimbre","74","150","230","98"),
("7325002186","Bidé SOFIA","baño","clasico","azul cielo","porcelanicos","50","35","90","24"),
("1192733098","Mueble de entrada COLORS","entrada","moderno","roble olmo","madera maciza","110","120","35","69"),
("7347390636","Muebles entrada ARDA","entrada","minimalista","turquesa","madera maciza","110","150","30","51"),
("1910424687","Mesa de jardin ECUADOR","jardin y terraza","rustico","roble olmo","madera maciza","110","150","230","160"),
("1762827449","Mesa salón TOMASA","salon","rustico","virginia","madera maciza","110","120","230","210"),
("6348192328","Cabecero ALICANTE","dormitorio","vintage","rojo brillo","madera maciza","130","150",null,"26"),
("1984194180","Conjunto modulos de cocina NICANOR","cocina","de diseño","oceano","tablero aglomerado",null,null,null,null),
("1750684102","Estantes para herraminetas PROTEC","garaje","trabajo","lila","metalico",null,"120","60","17"),
("1027649654","Mueble de baño LOLA","baño","zen","oceano","tablero aglomerado","110","50","60","15");


########### ARTICULOS MENAJE ############
insert into articulos (cod_articulo,stock,precio,cod_departamento)
values ("2147349036","20","2.43","945coc"),
("1567343819","7","154.69","945coc"),
("1757349263","6","69.19","945coc"),
("2007812924","23","8.43","945coc"),
("1757367717","10","102.03","945coc"),
("1891366966","48","12.95","945coc"),
("1878956635","54","6.42","945coc"),
("1442849739","6","3.70","945coc"),
("2094334197","59","15.32","945coc"),
("1927682592","29","34.24","945coc"),
("1955822737","32","45.87","382ban"),
("1314229201","37","18.70","382ban"),
("1589671949","33","21.41","382ban"),
("1761960273","21","47.44","382ban"),
("1846695313","22","34.62","382ban"),
("1704874806","21","29.40","382ban"),
("1749309299","41","11.26","382ban"),
("2015184656","74","5.90","382ban"),
("2069560163","47","15.00","382ban"),
("1808278929","43","3.75","382bañ"),
("1321473142","5","20.95","305sal"),
("1752645498","71","5.65","305sal"),
("1679332846","14","102.03","305sal"),
("1604841549","54","12.95","305sal"),
("1523967039","0","47.44","305sal"),
("1950555781","6","34.62","305sal"),
("1652504471","17","9.72","305sal"),
("2091727362","41","5.29","305sal"),
("1996826975","2","45.20","305sal"),
("2004593173","12","52.70","305sal");

insert into menaje (cod_articulo,nombre,tipo)
values ("2147349036","Cuenco de bambú","dispensadores y dosificadores"),
("1567343819","Olla rápida","ollas y cacerolas"),
("1757349263","Sarten 21 cm","sartenes"),
("2007812924","Set 6 copas vino","vajilla"),
("1757367717","Olla a presión","ollas y cacerolas"),
("1891366966","Recipiente tipo tupper","almacenaje de alimentos"),
("1878956635","Set de 6 cuchillos carne","cuberteria"),
("1442849739","Espumadera","utensilio de cocina"),
("2094334197","Manga pastelera","reposteria"),
("1927682592","Sarten de 18 cm","sartenes"),
("1955822737","Estantería ducha","perchas y colgadores"),
("1314229201","Tapa inodoro Roca","tapas inodoro"),
("1589671949","Dispensador de jabón","dispensadores y dosificadores"),
("1761960273","Set cuelga toallas Roca","perchas y colgadores"),
("1846695313","Alfombra de baño","alfombras"),
("1704874806","Alfombra antideslizante bañera","alfombras"),
("1749309299","Plato pastilla de jabón","vajilla baño"),
("2015184656","Baso de baño","vajilla baño"),
("2069560163","Soporte secador","perchas y colgadores"),
("1808278929","Cuelga toallas simple","perchas y colgadores"),
("1321473142","Figura buda pequeña","figuras"),
("1752645498","Planta artificial pequeña","complementos salon"),
("1679332846","Figura Sargadelos pescador","figuras"),
("1604841549","Plato decorativo Sargadelos","figuras"),
("1523967039","Cuadro paisaje","cuadros"),
("1950555781","Centro de mesa salón","centros"),
("1652504471","Mantel mesa salón","complementos salon"),
("2091727362","Vela prefumada","complementos salon"),
("1996826975","Revistero","complementos salon"),
("2004593173","Set de velas 3 uds","complementos salon");


##################### TRIGGERS ########################################## FUNCIONES ########################################## TRIGGERS ########################
##################### TRIGGERS ########################################## FUNCIONES ########################################## TRIGGERS ########################
##################### TRIGGERS ########################################## FUNCIONES ########################################## TRIGGERS ########################

/* 
 * NOTA: Los id insertados en los trigger se sustituirán por la expresión:
 * (select left(current_user(), instr(current_user(), '@') - 1);)
 * para que coja automáticamente el usuario conectado a la BD.
*/

set global log_bin_trust_function_creators = 1;

############# FUNCIÓN ULTIMO TICKET #############
#################################################
drop function if exists last_ticket;

delimiter //

create function last_ticket()
returns int
begin
declare last_t int;
select max(t.num_ticket) into last_t from tickets t;
return last_t;
end;
//

delimiter ;

############# FUNCIÓN ULTIMA VENTA #############
################################################
drop function if exists last_sell;

delimiter //

create function last_sell()
returns int
begin
declare last_s int;
select max(v.num_venta) into last_s from ventas v;
return last_s;
end;
//

delimiter ;


############# FUNCIÓN TOTAL VENDIDO PARA UN MES DADO #############
##################################################################
drop function if exists bruto_mes;

delimiter //

create function bruto_mes(mes int)
returns decimal(9,3)
begin
declare bruto decimal(9,3);
select sum(total) into bruto from tickets where month(fecha) = mes;
return bruto;
end;
//

delimiter ;

/*# RPUEBA
 select bruto_mes(5);
*/


############# TRIGGER EVITAR VENTAS SI NO HAY STOCK SUFICIENTE #############
############################################################################

/* CONSULTA ESTOCK:

select v.cod_articulo , v.uds from ventas v where v.cod_articulo = "2015184656" and num_ticket = last_ticket();

select a.cod_articulo, a.stock from articulos a 
inner join (select v.cod_articulo , v.uds from ventas v where v.cod_articulo = "2015184656" and num_ticket = last_ticket()) as t
on a.cod_articulo = t.cod_articulo where a.stock > t.uds;
*/

drop trigger if exists verificar_stock_trigger;

delimiter //

create trigger verificar_stock_trigger
after insert on ventas
for each row
begin
	declare sin_stock char(10);
	select a.cod_articulo into sin_stock from articulos a where a.cod_articulo = new.cod_articulo and a.stock < new.uds;
	if sin_stock is not null then
		#call verificar_stock(sin_stock);
		signal sqlstate "45000" set message_text = "Stock insuficiente. Venta denegada";
	end if;
end;
//

delimiter ;

/*# PRUEBA TRIGGER:

insert into tickets (id)
values ("43329547g");

# No inserta, stock insuficiente:
insert into ventas (num_ticket,cod_articulo,uds)
values (last_ticket(),"6095130502","5");

# Inserta correctamente, stock suficiente:
insert into ventas (num_ticket,cod_articulo,uds)
values (last_ticket(),"6095130502","1");
*/



############# TRIGGERS TOTAL TICKET AUTOMÁTICO #############
############################################################


# TRIGGER 1/2
drop trigger if exists total_venta;

delimiter //

create trigger total_venta
before insert on ventas
for each row
begin
	declare total_v decimal(9,3);
	declare precio_art decimal(8,3);
	select precio into precio_art from articulos where cod_articulo = new.cod_articulo;
	set total_v = precio_art * new.uds;
	set new.total = total_v;
end;
//

delimiter ;

# TRIGGER 2/2
drop trigger if exists total_ticket;

delimiter //

create trigger total_ticket
after insert on ventas
for each row
begin
	declare total_t decimal(9,3);
	select sum(v.total) into total_t from ventas v where v.num_ticket = (select max(num_ticket) from tickets);
	update tickets set total = total_t where new.num_ticket = num_ticket;
end;
//

delimiter ;



############# TRIGGER PARA REDUCIR STOCK (VENTAS) #############
###############################################################

drop trigger if exists modificar_stock_ventas;

delimiter //

create trigger modificar_stock_ventas
after insert on ventas
for each row
begin
	update articulos set stock = (stock - new.uds) where cod_articulo = new.cod_articulo;
end;
//

delimiter ;

/*# PRUEBA TRIGGER:

insert into tickets (id)
values ("44448922a");

insert into ventas (num_ticket,cod_articulo,uds)
values
(last_ticket(),"2041502479","1");
*/


############# INSERTS PREDETERMINADOS BASE DE DATOS #############
###############################################################

 ########### INSERT 1 ###########
insert into tickets (fecha,id)
values ("2022-03-04 17:40:38","44473829d");

insert into ventas (num_ticket,cod_articulo,uds)
values ("101","1604841549","1"),
("101","2015184656","4"),
("101","1752645498","2");
update tickets set total = "47.85" where num_ticket = "101";

 ########### INSERT 2 ###########
insert into tickets (fecha,id)
values ("2022-04-14 10:30:38","46673459j");

insert into ventas (num_ticket,cod_articulo,uds)
values ("102","2091727362","1"),
("102","1757367717","2");
update tickets set total = "209.35" where num_ticket = "102";

 ########### INSERT 3 ###########
insert into tickets (fecha,id)
values ("2022-01-01 09:30:38","44448922a");

insert into ventas (num_ticket,cod_articulo,uds)
values (last_ticket(),"2147349036","4");

 ########### INSERT 4 ###########
insert into tickets (fecha,id)
values ("2022-05-09 11:30:38","44448922a");

insert into ventas (num_ticket,cod_articulo,uds)
values (last_ticket(),"1652504471","1"),
(last_ticket(),"2015184656","4"),
(last_ticket(),"1761960273","2");


############# TRIGGER PARA AUMENTAR STOCK (DEVOLUCIONES) #############
######################################################################

drop trigger if exists modificar_stock_devos;

delimiter //

create trigger modificar_stock_devos
after delete on ventas
for each row
begin	
	update articulos set stock = (stock + old.uds) where cod_articulo = old.cod_articulo;
end;
//

delimiter ;

/*# PRUEBA TRIGGER:

insert into tickets (id)
values ("44448922a");

insert into ventas (num_ticket,cod_articulo,uds)
values (last_ticket(),"1752645498","20"),
(last_ticket(),"2041502479","2");

delete from ventas where num_ticket = last_ticket() and cod_articulo = "2041502479";

*/

############# TRIGGER PARA MODIFICAR STOCK (MODIFICACIÓN DE VENTA) #############
################################################################################


drop trigger if exists modificar_stock_modVenta;

delimiter //

create trigger modificar_stock_modVenta
after update on ventas
for each row
begin	
	update articulos set stock =stock + (old.uds - new.uds) where cod_articulo = new.cod_articulo;
end;
//

delimiter ;

/*# PRUEBA TRIGGER:
update ventas set uds = "18" where num_venta = "102";
*/




############# TRIGGER PARA ELIMINAR TICKETS VACIOS Y CORREGIR EL TOTAL SI NO SE ELIMINAN (DEVUELVEN) TODAS LAS FILAS QUE CORRESPONDEN AL TICKET #############
#############################################################################################################################################################

drop trigger if exists control_tickets_vacios_total;

delimiter //

create trigger control_tickets_vacios_total
after delete on ventas
for each row
begin
	declare new_total decimal(9,3);
	declare tick int;
	select sum(v.total) into new_total from ventas v where v.num_ticket = old.num_ticket;
	select v.num_ticket into tick from ventas v where num_ticket = old.num_ticket;
	if tick is null then
		delete from tickets where num_ticket = old.num_ticket;
	else if tick is not null then
		update tickets set total = new_total where num_ticket = old.num_ticket;
	end if;	
	end if;
end;
//

delimiter ;

/*# PRUEBA TRIGGER:

insert into tickets (id)
values ("44448922a");

insert into ventas (num_ticket,cod_articulo,uds)
values (last_ticket(),"2007812924","20"),
(last_ticket(),"2041502479","2");

# Borra solo una linea, quedan mas lineas para el ticket (CORREGIR EL TOTAL):
delete from ventas where num_ticket = last_ticket() and cod_articulo = "2041502479";

# Borra la linea que quedaba, el ticket se queda con 0 lineas de venta (ELIMINA EL TICKET VACÍO):
delete from ventas where num_ticket = last_ticket();
*/



############# TRIGGERS PARA CORREGIR EL TOTAL EN CASO DE MODIFICAR LAS UDS VENDIDAS DE UN ARTICULO #############
################################################################################################################

# TRIGGER 1/2
drop trigger if exists revisar_total_venta;

delimiter //

create trigger revisar_total_venta
before update on ventas
for each row
begin	
	declare total_v decimal(9,3);
	declare precio_art decimal(8,3);
	select precio into precio_art from articulos where cod_articulo = new.cod_articulo;
	set total_v = precio_art * new.uds;
	set new.total = total_v;
end;
//

delimiter ;

# TRIGGER 2/2
drop trigger if exists revisar_total_ticket;

delimiter //

create trigger revisar_total_ticket
after update on ventas
for each row
begin
	declare new_total decimal(9,3);
	select sum(v.total) into new_total from ventas v where v.num_ticket = new.num_ticket;
	update tickets set total = new_total where num_ticket = new.num_ticket;
end;
//

delimiter ;

/* # PRUEBA TRIGGER:
update ventas set uds = "1" where num_venta = "104";
*/



##################### VISTAS ########################################## VISTAS ########################################## VISTAS ########################
##################### VISTAS ########################################## VISTAS ########################################## VISTAS ########################
##################### VISTAS ########################################## VISTAS ########################################## VISTAS ########################


############# VISTA ARTÍCULOS DISPONIBLES #############
#######################################################


/* SUBCONSULTAS:
select a.cod_articulo, a.stock, a.precio from articulos a where a.stock > "0";


select m.nombre, m.tipo, t.cod_articulo, t.stock, t.precio from menaje m 
right join (select a.cod_articulo, a.stock, a.precio from articulos a where a.stock > "0") as t 
on m.cod_articulo = t.cod_articulo;


select t1.*, m1.nombre, m1.tipo from muebles m1 
right join (select m.nombre, m.tipo, t.cod_articulo, t.stock, t.precio from menaje m 
right join (select a.cod_articulo, a.stock, a.precio from articulos a where a.stock > "0") as t 
on m.cod_articulo = t.cod_articulo) as t1 
on m1.cod_articulo = t1.cod_articulo;
 */

drop view if exists articulos_disponibles;

create view articulos_disponibles as
select concat_ws("",m1.nombre,t1.nombre) as Producto, t1.cod_departamento as Departamento, concat_ws("",t1.tipo,m1.tipo) as Tipo, t1.cod_articulo as Codigo, t1.stock as Stock, t1.precio as Precio from muebles m1 
right join (select m.nombre, m.tipo,t.cod_departamento, t.cod_articulo, t.stock, t.precio from menaje m 
			right join (select a.cod_articulo, a.stock, a.precio, a.cod_departamento from articulos a where a.stock > "0") as t 
			on m.cod_articulo = t.cod_articulo) as t1 
on m1.cod_articulo = t1.cod_articulo order by Producto;



############# VISTA RESUMEN DE TICKETS #############
####################################################

drop view if exists resumen_tickets;

create view resumen_tickets as
select * from tickets order by fecha desc;



############# VISTA TOP 5 VENTAS #############
##############################################


/* SUBCONSULTAS:
select v.cod_articulo, sum(v.uds) as uds_vendidas from ventas v group by cod_articulo order by uds_vendidas desc limit 5;


select m.nombre, t.* from menaje m 
right join (select v.cod_articulo, sum(v.uds) as uds_vendidas from ventas v group by cod_articulo order by uds_vendidas desc limit 5) as t 
on m.cod_articulo = t.cod_articulo;

select concat_ws("",m1.nombre,t1.nombre) as Producto, t1.cod_articulo as Codigo, t1.Ventas as Ventas from muebles m1 
right join (select m.nombre, t.* from menaje m 
			right join (select v.cod_articulo, sum(v.uds) as Ventas from ventas v group by cod_articulo order by Ventas desc limit 5) as t 
			on m.cod_articulo = t.cod_articulo) as t1
on m1.cod_articulo = t1.cod_articulo;
 */

drop view if exists top_ventas;

create view top_ventas as
select concat_ws("",m1.nombre,t1.nombre) as Producto, t1.cod_articulo as Codigo, t1.Ventas as Ventas from muebles m1 
right join (select m.nombre, t.* from menaje m 
			right join (select v.cod_articulo, sum(v.uds) as Ventas from ventas v group by cod_articulo order by Ventas desc limit 5) as t 
			on m.cod_articulo = t.cod_articulo) as t1
on m1.cod_articulo = t1.cod_articulo;



############# VISTA INFORMACIÓN ARTÍCULOS A LA VENTA #############
##################################################################


drop view if exists informacion_articulos_venta;

create view informacion_articulos_venta as
select concat_ws("",m1.nombre,t1.nombre) as Producto, t1.cod_departamento as Departamento, concat_ws("",t1.tipo,m1.tipo) as Tipo, t1.cod_articulo as Codigo, m1.estancia, m1.color, m1.material, m1.alto, m1.ancho, m1.largo, m1.peso, t1.stock as Stock, t1.precio as Precio from muebles m1 
right join (select m.nombre, m.tipo,t.cod_departamento, t.cod_articulo, t.stock, t.precio from menaje m 
			right join (select a.cod_articulo, a.stock, a.precio, a.cod_departamento from articulos a) as t
			on m.cod_articulo = t.cod_articulo) as t1
on m1.cod_articulo = t1.cod_articulo order by estancia desc;



############# VISTA PRECIO ARTÍCULOS #############
##################################################

drop view if exists precio_articulos_asc;

create view precio_articulos_asc as
select concat_ws("",m1.nombre,t1.nombre) as Producto, t1.cod_departamento as Departamento, t1.cod_articulo as Codigo, t1.stock as Stock, t1.precio as Precio from muebles m1 
right join (select m.nombre, t.cod_departamento, t.cod_articulo, t.stock, t.precio from menaje m 
			right join (select a.cod_articulo, a.stock, a.precio, a.cod_departamento from articulos a where a.stock > "0") as t 
			on m.cod_articulo = t.cod_articulo) as t1 
on m1.cod_articulo = t1.cod_articulo order by Precio asc;



############# VISTA BRUTO DE UN MES Y EL MES Y AÑO ENCUESTIÓN (MES ACTUAL) #############
########################################################################################

drop view if exists bruto_mes_actual;

create view bruto_mes_actual as
select sum(total) as Total_mes, month(now()) as Mes, year(now()) as Anho from tickets where month(now());


##################### USUARIOS ########################################## PERMISOS ########################################## USUARIOS ########################
##################### USUARIOS ########################################## PERMISOS ########################################## USUARIOS ########################
##################### USUARIOS ########################################## PERMISOS ########################################## USUARIOS ########################


drop user if exists "admin"@"%";
drop user if exists "empleado"@"%";

create user "admin"@"%" identified by "admin";
create user "empleado"@"%" identified by "1234";

drop role if exists "adm";
drop role if exists "dep";

create role "adm";
create role "dep";

grant all on tienda_muebles.* to "admin"@"%";
grant all on tienda_muebles.ventas to "empleado"@"%";
grant all on tienda_muebles.tickets to "empleado"@"%";
grant show view on tienda_muebles.informacion_articulos_venta to "empleado"@"%";
grant show view on tienda_muebles.precio_articulos_asc to "empleado"@"%";
grant show view on tienda_muebles.articulos_disponibles to "empleado"@"%";

grant "adm" to "admin"@"%";
grant "dep" to "empleado"@"%";

show grants for "admin"@"%";
show grants for "empleado"@"%";


