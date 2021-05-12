drop database if exists ci_cunori;
create database ci_cunori;
use ci_cunori;

create table usuario (
	id int not null primary key auto_increment,
    usuario varchar(50) not null,
    clave varchar (25) not null,
    rol_id int not null
);

create table roles (
	id int not null primary key auto_increment,
    rol varchar(50) not null
);


create table categoria (
	codigo_control varchar(6) not null primary key unique,
    descripcion varchar(100) not null
);

create table tipo(
	idtipo int not null primary key auto_increment,
    descripcion varchar(25) not null
);

create table areaemp(
	idarea tinyint not null primary key auto_increment,
    descripcion varchar(45) not null
);

create table articulo(
	idarticulo int not null  primary key auto_increment,
    no_clave_control varchar(45) not null, 
    descripcion longtext not null,
    valor decimal(12,2) not null,
    fecha_ingreso timestamp,
    categoria_codigo_control varchar(6) primary key,
    tipo_idtipo int not null primary key,
    activo tinyint not null default 1, 
    disponible tinyint not null default 1,
    foreign key (categoria_codigo_control) references categoria(codigo_control),
    foreign key (tipo_idtipo) references tipo(idtipo)
);

create table empleado(
	idempleado smallint not null auto_increment primary key,
    dpi varchar(20) not null,
    codigo varchar(45),
    nombre varchar(45),
    apellidos varchar(45),
    areaemp_idarea tinyint not null primary key,
    foreign key (area_idarea) references areaemp(idearea)
);


create table asignacion(
	idasignacion int not null primary key auto_increment,
    tarjeta_responsable mediumint null,
    fecha_asignacion timestamp not null,
    articulo_idarticulos int not null primary key, 
    estado tinyint not null default 1,
    empleado_idempleado tinyint not null primary key,
    foreign key (articulo_idarticulo) references articulo(id_articulo),
    foreign key (empleado_idempleado) references empleado(idempleado)
);

create table mantenimiento_vehiculo(
	idmantenimiento int not null auto_increment primary key,
    fecha_mantenimiento timestamp not null,
    descripcion text not null,
    no_factura varchar(45) null,
    valor_neto decimal(10,2) not null
);


alter table usuario add foreign key (rol_id) references roles(id);
insert into roles (rol) values ('Administrador');
insert into roles (rol) values ('Lector');