drop database if exists jugueteria;

create database jugueteria;

use jugueteria;

create table empleados (
nombre varchar(20) not null primary key
);

create table articulos (
cod_articulo varchar(10) primary key,
precio double not null,
nombre_articulo varchar(30) not null,
stock int not null,
constraint ck_stock check (stock >= 0),
constraint ck_precio check (precio >= 0)
);

create table tickets (
num_ticket varchar(20) not null primary key,
efectivo boolean not null,
fecha_hora timestamp default current_timestamp not null,
empleado varchar(10) not null,
constraint fk_empleado foreign key (empleado) references empleados(nombre) on delete no action on update cascade,
constraint ck_fecha check (Fecha_hora >= '1.1.2015')
);

create table registro_caja (
num_registro int primary key,
empleado varchar(20) not null,
F_inicio timestamp not null,
F_fin timestamp,
constraint fk_empleado1 foreign key (empleado) references empleados(nombre) on delete no action on update cascade,
constraint ck_fechas check (F_fin > F_inicio or F_fin is null),
constraint ck_fecha_inicio check (F_inicio >= '1.1.2015')
);

create table articulos_tickets(
articulo varchar(10) not null,
ticket varchar(20) not null,
uds int not null,
precio real not null,
constraint pk_articulos_tickets primary key (articulo,ticket),
constraint fk_articulo foreign key (articulo) references articulos(cod_articulo) on delete no action on update cascade,
constraint fk_ticket foreign key (ticket) references tickets(num_ticket) on delete cascade on update cascade,
constraint ck_precio1 check (precio >= 0)
);


############### Insertamos valores ################

insert into articulos(cod_articulo, nombre_articulo , stock , precio)
values ('001', 'Muñeco de plastico', 10, 15),
('002', 'Pelota de goma', 20, 20),
('003', 'Paquete de piezas montables', 35, 10.5),
('004', 'Baraja de Cartas', 5, 5),
('005', 'Peluche', 14, 6),
('006', 'Mini futbolin', 2, 23),
('007', 'Yo-yo', 25, 4),
('008', 'Bicicleta', 23, 199),
('009', 'Muñeco de acción', 50, 25),
('010', 'Muñeca', 32, 9.5),
('011', 'Cometa', 7, 8);



insert into empleados (nombre) values ('Julio'),('Maria'),('Emilio');



insert into registro_caja (num_registro, empleado , F_inicio, F_fin)
values (1,'Julio','2015-01-06 10:00:00','2015-01-06 18:00:00'),
(2,'Maria','2015-01-07 10:00:00','2015-01-07 18:00:00'),
(3,'Julio','2015-01-08 10:00:00','2015-01-08 14:00:00'),
(4,'Maria','2015-01-08 14:00:00','2015-01-08 18:00:00'),
(5,'Julio','2015-01-09 10:00:00','2015-01-09 18:00:00'),
(6,'Maria','2015-01-10 10:00:00','2015-01-10 18:00:00'),
(7,'Julio','2015-01-11 10:00:00','2015-01-11 18:00:00'),
(8,'Maria','2015-01-12 10:00:00','2015-01-12 18:00:00'),
(9,'Emilio','2015-01-13 10:00:00','2015-01-13 18:00:00'),
(10,'Julio','2015-01-14 10:00:00','2015-01-14 18:00:00'),
(11,'Emilio','2015-01-15 10:00:00','2015-01-15 18:00:00'),
(12,'Maria','2015-01-16 10:00:00','2015-01-16 18:00:00'),
(13,'Julio','2015-01-01 10:00:00',null),
(14,'Maria','2016-05-01 10:00:00','2016-05-04 18:00:00'),
(15, 'Maria', CURRENT_DATE, null);



insert into tickets (num_ticket, empleado, efectivo, fecha_hora)
values ('001', 'Julio', 1, '2015-01-06 11:00:00'),
('002', 'Julio', 1, '2015-01-08 13:00:00'),
('003', 'Julio', 1, '2015-01-09 12:00:00'),
('004', 'Julio', 1,'2015-01-14 10:30:00'),
('005', 'Maria', 0, '2015-01-07 14:00:00'),
('006', 'Maria', 0, '2015-01-07 17:00:00'),
('007', 'Maria', 1, '2015-01-10 13:00:00'),
('008', 'Maria', 1, '2015-01-10 11:30:00'),
('009', 'Maria', 1, '2015-01-16 10:20:00'),
('010', 'Emilio', 1, '2015-01-13 14:00:00'),
('011', 'Emilio', 0, '2015-01-15 16:00:00'),
('012', 'Maria', 0, '2016-05-01 14:00:00'),
('013', 'Emilio', 1, '2016-05-01 14:00:00'),
('014', 'Maria', 1, current_date),
('015', 'Maria', 0, current_date),
('016', 'Emilio', 1, current_date);



insert into articulos_tickets (articulo, ticket, uds, precio)
values ('001', '001', 1, 15),
('003', '002', 2, 21),
('002', '003', 3, 60),
('004', '004', 2,10),
('007', '004', 1,4),
('008', '005', 1, 199),
('009', '006', 4, 100),
('006', '007', 2, 46),
('010', '008', 2, 19),
('008', '009', 1, 199),
('011', '010', 1, 8),
('004', '011', 1, 5),
('011','012',1,8),
('008', '014', 1, 199),
('008', '015', 1, 199),
('009','013',1,25),
('009','016',1,25);

/*
* 1. Obtener a partir de los tickets de caja el importe total vendido en efectivo por
cada empleado en el día actual.
* */
select empleado, sum(precio * uds) as ImpTotal
from tickets t inner join articulos_tickets ta on t.num_ticket = ta.ticket
WHERE cast(fecha_hora as date) = current_date and efectivo = 1
group by empleado;



/*
* 2. Mostrar el nombre del empleado que ha vendido más artículos durante el año
2015.
* */
select empleado
from tickets t inner join articulos_tickets ta on t.num_ticket = ta.ticket
where extract(year from fecha_hora) = 2015 group by empleado
having sum(uds) = ( select MAX(Ventas2015) from ( select sum(uds) as Ventas2015 from tickets t2 inner join articulos_tickets ta2
on t2.num_ticket = ta2.ticket where extract(year from fecha_hora) = 2015 group by empleado ) as ventas
);



/*
* 3. Listar los artículos que no se han vendido en el mes de mayo de 2016,
ordenados por el número de existencias, de mayor a menor.
* */
select * from articulos a where a.cod_articulo not in
( select cod_articulo from tickets t inner join articulos_tickets ta
on t.num_ticket = ta.ticket where cast(fecha_hora as date) between '2016-05-01 00:00:00' and '2016-05-31 23:59:59'
) order by stock desc;



# La consulta para obtener el listado de tickets erróneos sería:
select tickets.*
from tickets, registro_caja
where tickets.empleado <> registro_caja.empleado and fecha_hora
between F_inicio and F_fin;


# Mecanismo que verifique que el nombre del usuario que figura en un ticket cuando se crea se corresponde con el usuario que está usando la caja en ese momento.
drop trigger if exists verificar_empleado;

DELIMITER //

create trigger verificar_empleado
after insert on tickets
for each row
begin
call modificar_usuario_ticket(new.num_ticket);
end;
//

DELIMITER ;

/*
Crear un procedimiento almacenado que reciba un código de ticket y sobrescribe el
nombre del vendedor que figura en el mismo con el nombre del vendedor que estaba
utilizando la caja en el momento en que se emitió, en caso de que ambos sean
distintos.
*/

/*
Tabla para registrar los cambios.
*/
drop table if exists registro_cambios;

create table registro_cambios (
id int primary key auto_increment,
FechaRegistro timestamp default current_timestamp on update current_timestamp,
ticket varchar(20) not null,
empleadoANTIGUO varchar(10) not null,
empleadoNUEVO varchar(10) not null,
constraint empleado_ant foreign key (empleadoANTIGUO) references empleados(nombre)
on delete no action on update cascade,
constraint cajero_new foreign key (empleadoNUEVO) references empleados(nombre)
on delete no action on update cascade
);

/*
Procdimiento modificar empleado ticket.
*/

drop procedure if exists modificar_empleado_ticket;

DELIMITER //

create procedure modificar_empleado_ticket (in tick varchar(20))
begin
declare empleado_ant, empleado_nuevo varchar(10);
declare fecha_ticket timestamp;
select empleado, fecha_hora into empleado_ant, fecha_ticket from tickets where num_ticket = tick;
select empleado into empleado_nuevo from registro_caja where fecha_ticket between F_inicio and F_fin = null;
if empleado_ant <> empleado_nuevo then
insert into registro_cambios (ticket, empleadoANTIGUO, empleadoNUEVO)
values (tick, empleado_ant, empleado_nuevo);
update tickets set empleado = empleado_nuevo where num_ticket = tick;
end if;
end;
//

DELIMITER ;

/*
Modificar la información que se guarda de cada artículo para añadir el porcentaje de
IVA que le corresponde, poniendo 21% a los ya existentes.
*/

alter table articulos add IVA real default 0.21;

update articulos set IVA = 0.21;

alter table articulos add constraint IVA_not_null check (IVA is not null);

/*
Crear una vista que muestre para cada ticket únicamente la información
correspondiente a la fecha y a su importe total, desglosado en base e IVA.
 */

create view resumen_ticket as 
select t.fecha_hora as fecha, concat(sum(ta.uds * a.precio), "€") as importe,
format(sum(ta.uds * a.precio * a.IVA / (1 + a.IVA)),2) as importe_IVA,
format(sum(ta.uds * a.precio / (1 + a.IVA)),2) AS importe_base
FROM tickets t, articulos_tickets ta, articulos a where a.cod_articulo = ta.articulo and t.num_ticket = ta.ticket group by t.num_ticket;

/*
Crear tres roles en la BD: admin, cajero y supervisor. Definir permisos sobre la BD
de forma que los usuarios con el rol cajero puedan introducir, borrar y actualizar la
información correspondiente a las ventas; los usuarios del rol supervisor únicamente
podrán acceder a la información que proporciona la vista creada en el paso anterior.
Los usuarios del rol admin tienen acceso total a la BD.
 */

create role if not exists "admin","cajero","supervisor";

grant insert, delete, update on tickets to "cajero";
grant show view on resumen_ticket to "supervisor";
grant all on tienda_juguetes to "admin";

/*
Programar una función que obtenga el nombre del usuario que está usando la caja
en el momento actual, y otro que devuelva el nombre del último usuario que usó la
caja si no hay nadie usándola (si está abierta debe devolver NULL).
 */

# Obtener el usuario que tiene abierta la caja:
set global log_bin_trust_function_creators = 1;

drop function if exists usuario_actual;

DELIMITER //

create function usuario_actual()
returns varchar(10)
begin
declare usuario varchar(10);
select empleado into usuario from registro_caja where F_fin is null;
return usuario;
end;
//

DELIMITER ;


# Obtener el último usuario que utilizó la caja:
drop function if exists usuario_anterior;

DELIMITER //

create function usuario_anterior()
returns varchar(10)
begin
declare usuario varchar(10);
select empleado into usuario from registro_caja where F_fin = (select max(F_fin) from registro_caja);
return usuario;
end;
//

DELIMITER ;

/*
Añadir un mecanismo para que, cada vez que la caja se asigne a un usuario, a éste
le sea asignado en ese momento el rol cajero; este rol le debe ser retirado cuando el
usuario ya no tenga asignada la caja.
*/
drop trigger if exists auto_rol_cajero;

DELIMITER //

create trigger auto_rol_cajero
after insert on registro_caja
for each row
begin
declare grt varchar(50);
set grt = ' grant cajero TO ' or new.empleado or ';';
call grt;
end;
//

DELIMITER ;

/*
Crear una nueva tabla Pedido, que almacena para cada artículo el número de uds
que se piden, la fecha en que se registra el pedido, la fecha en que se lleva a cabo,
y la fecha en que se recibe. Estos dos últimos campos tendrán valor NULL mientras
no se pide y recibe el artículo, respectivamente.
*/

drop table if exists pedido;

create table pedido (
id int primary key auto_increment not null,
articulo varchar(10) not null,
uds int not null,
fecha_reg_pedido timestamp not null,
fecha_pedido timestamp null,
fecha_recep_pedido timestamp null,
constraint fk_articulo_pedido foreign key (articulo) references articulos(cod_articulo) on delete no action on update cascade
);


insert into pedido (uds, articulo, fecha_reg_pedido, fecha_pedido, fecha_recep_pedido)
values ('12','002','2015-01-06 11:00:00','2015-01-06 11:25:00','2015-01-20 11:00:00'),
('2','001','2015-01-08 13:00:00','2015-01-09 12:00:00','2015-01-13 10:00:00'),
('5','003','2015-01-09 12:00:00','2015-01-12 12:00:00','2015-01-15 9:00:00'),
('9','006','2015-01-14 10:30:00','2015-01-14 12:30:00','2015-01-27 10:00:00'),
('16','007','2015-01-07 14:00:00','2015-01-10 14:00:00','2015-01-17 10:00:00'),
('2','010','2015-01-07 17:00:00','2015-01-12 17:00:00','2015-01-28 17:00:00'),
('7','011','2015-01-10 13:00:00','2015-01-11 09:00:00','2015-01-14 10:00:00'),
('8','009','2015-01-10 11:30:00','2015-01-10 13:30:00','2015-01-20 10:30:00'),
('9','008','2015-01-16 10:20:00','2015-01-17 10:20:00','2015-01-27 10:20:00'),
('17','005','2015-01-13 14:00:00','2015-01-16 10:00:00','2015-01-20 10:00:00'),
('2','004','2015-01-15 16:00:00',null,null),
('4','001','2016-05-01 14:00:00','2016-05-03 14:00:00','2016-05-08 14:00:00'),
('6','003','2016-05-05 10:00:00',null,null),
('9','002','2016-06-08 11:00:00','2016-06-09 10:00:00','2016-06-11 09:00:00'),
('11','006','2016-06-10 09:00:00','2016-06-10 12:00:00','2016-06-12 10:00:00'),
('18','007','2016-07-10 10:00:00',null,null);

/*
Añadir a cada artículo un campo que indique el número de uds óptimo que se deben
tener en tienda del mismo (por defecto 6). Crear un procedimiento nuevo que
registre para cada artículo con X o menos uds disponibles (X es un valor variable)
una nueva línea de pedido por tantas uds como hagan falta para alcanzar las uds
óptimas.
Se debe tener en cuenta que ya puede existir un pedido para ese artículo pendiente
de ser llevado a cabo. En ese caso, solamente se deberá ajustar el número de uds a
pedir.
*/

alter table articulos add stock_optimo int default 6;

update articulos set stock_optimo = 6;

alter table articulos add constraint stock_not_null check (stock_optimo is not null);


drop procedure if exists pedido_auto;

DELIMITER //

/**************************************************************
create procedure pedido_auto ()
begin
declare uds_pedido int;
declare articulo_pedido varchar(10);
declare art_con_pedido varchar(10);
declare fecha timestamp;
select stock_optimo - stock, cod_articulo into uds_pedido, articulo_pedido from articulos where stock < stock_optimo;
select articulo into art_con_pedido from pedido;
if articulo_pedido != art_con_pedido then
insert into pedido (uds, articulo, fecha_reg_pedido, fecha_pedido, fecha_recep_pedido)
values (uds_pedido, articulo_pedido, fecha, fecha, null);
elseif articulo_pedido = articulo_con_pedido then
update pedido set uds = uds_pedido;
end if;
end;
//
*****************************************************************/

CREATE PROCEDURE pedido_auto()
begin
	declare articulo_a_pedir varchar(10);
	declare uds_pedido int;
	declare art_con_pedido varchar(10);
	declare fecha timestamp;
	declare n int default 0;
	declare i int default 0;
	select count(*) from articulos into n;
	select articulo into art_con_pedido from pedido;
	set i=0;
	WHILE i < n DO
		select cod_articulo into articulo_a_pedir from articulos limit i,1;
		if articulo_a_pedir != art_con_pedido then
			select stock_optimo - stock into uds_pedido from articulos where stock_optimo > stock limit i,1;
			insert into pedido (uds, articulo, fecha_reg_pedido, fecha_pedido, fecha_recep_pedido)
			values (uds_pedido, articulo_a_pedir, fecha, fecha, null);
		elseif articulo_a_pedir = articulo_con_pedido then
			update pedido set uds = uds_pedido where articulo = articulo_a_pedir;
		end if;
	 	set i = i + 1;
	end while;
end;
//

DELIMITER ;


/*
Crear un disparador que registre un nuevo pedido de un artículo cuando la tienda se
quede sin stock o con solo una unidad del mismo.
*/

drop procedure if exists pedido_stock_cero;

DELIMITER //

create procedure pedido_stock_cero (in articulo_a_pedir varchar(10))
begin
	declare uds_pedido int;
	declare art_con_pedido varchar(10);
	declare fecha timestamp;
	select stock_optimo - stock into uds_pedido from articulos where articulo_a_pedir = cod_articulo;
	select articulo into art_con_pedido from pedido;
	if articulo_a_pedir != art_con_pedido then
		insert into pedido (uds, articulo, fecha_reg_pedido, fecha_pedido, fecha_recep_pedido)
		values (uds_pedido, articulo_a_pedir, fecha, fecha, null);
		elseif articulo_a_pedir = articulo_con_pedido then
		update pedido set uds = uds_pedido where articulo = articulo_a_pedir;
	end if;
end;
//

DELIMITER ;

drop trigger if exists pedido_stock_0;

DELIMITER //

create trigger pedido_stock_0
after update on articulos
for each row
begin
if new.stock <= 1 or new.cod_articulo then 
call pedido_stock_cero(new.cod_articulo);
end if;
end;
//

DELIMITER ;


/*
Crear un procedimiento que ponga como recibido con la fecha actual el pedido de un
artículo dado, aumentando el stock del mismo en el número de uds recibidas.
 */

drop procedure if exists recepcion_pedidos; 

DELIMITER //

create procedure recepcion_pedidos (in art_recibido varchar (10)) 
begin
	declare new_stock int;
	declare art_ped varchar(10);
	declare fecha_act timestamp;
	select articulo into art_ped from pedido;
	if art_recibido = art_ped then
		select uds into new_stock from pedido where articulo = art_recibido;
		update articulos set stock = new_stock where cod_articulo = art_recibido;
		update pedido set fecha_recep_pedido = fecha_act where cod_articulo = art_recibido;
	end if;
end;
//
DELIMITER ;


drop trigger if exists restar_stock;

DELIMITER //

create trigger restar_stock
after insert on articulos_tickets
for each row
begin
declare num_art_vendidos int;
declare art_vendido varchar(10);
select articulo from articulos_tickets into art_vendido;
select uds from articulos_tickets into num_art_vendidos;
if new.articulo = 
update articulos set stock = num_art_vendidos;
end if;
end;
//

DELIMITER ;

drop procedure if exists restar_stock; 

DELIMITER //

create procedure restar_stock (in art_recibido varchar (10)) 
begin
declare num_art_vendidos int;
select uds from articulos_tickets into num_art_vendidos where articulo = new.articulo;
update articulos set stock = num_art_vendidos;
end;
//
DELIMITER ;

