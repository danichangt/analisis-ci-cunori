drop database if exists ci_cunori;
create database ci_cunori;
use ci_cunori;

create table rol(
	idrol smallint not null primary key auto_increment,
    rol varchar(50) not null unique,
    crear tinyint not null default 0,
    leer tinyint not null default 0,
    editar tinyint not null default 0,
    eliminar tinyint not null default 0
);

insert into rol (rol, crear, leer, editar, eliminar) values ('Administrador', 1, 1, 1, 1);
insert into rol (rol, crear, leer, editar, eliminar) values ('Lector', 0, 1, 0, 0);

create table usuario(
	idusuario smallint not null primary key auto_increment,
    usuario varchar(50) not null unique,
    clave text not null,
    nombres varchar(50) not null, 
    apellidos varchar(50) not null,
    estado tinyint not null default 0,
    rol_idrol smallint not null,
    foreign key (rol_idrol) references rol(idrol) on update cascade
);

create table token(
	idtoken tinyint not null primary key auto_increment,
	usuario varchar(50) not null unique,
    token text not null
);

create table categoria(
	idcategoria smallint not null primary key auto_increment,
	codigo_control varchar(6) not null unique,
    descripcion varchar(100) not null
);

create table tipo(
	idtipo smallint not null primary key auto_increment,
    descripcion varchar(50) not null
);

create table areaemp(
	idarea tinyint not null primary key auto_increment,
    descripcion varchar(50) not null
);

create table articulo(
	idarticulo int not null  primary key auto_increment,
    no_clave_control varchar(50) not null, 
    descripcion longtext not null,
    valor decimal(12,2) not null,
    fecha_ingreso date not null,
    folio mediumint not null,
    activo tinyint not null default 1, 
    disponible tinyint not null default 1,
    categoria_idcategoria smallint not null,
    tipo_idtipo smallint not null,
    foreign key (categoria_idcategoria) references categoria(idcategoria) on update cascade,
    foreign key (tipo_idtipo) references tipo(idtipo) on update cascade
);

create table empleado(
	idempleado smallint not null auto_increment primary key,
    dpi varchar(20) not null,
    codigo varchar(45),
    nombres varchar(45),
    apellidos varchar(45),
    areaemp_idarea tinyint not null,
    foreign key (areaemp_idarea) references areaemp(idarea) on update cascade
);


create table asignacion(
	idasignacion int not null primary key auto_increment,
    tarjeta_responsable mediumint null,
    fecha_asignacion date not null,
    estado tinyint not null default 1,
    localizacion varchar(100) not null,
    autorizacion varchar(50) null,
    seccion text null,
    contador_traslado tinyint not null default 1,
    articulo_idarticulo int not null, 
    empleado_idempleado smallint not null,
    asignacion_idasignacion int null, 
    foreign key (articulo_idarticulo) references articulo(idarticulo) on update cascade,
    foreign key (empleado_idempleado) references empleado(idempleado) on update cascade,
    foreign key (asignacion_idasignacion) references asignacion(idasignacion) on update cascade
);

create table mantenimiento(
	idmantenimiento int not null auto_increment primary key,
    fecha_mantenimiento date not null,
    descripcion text not null,
    no_factura varchar(50) null,
    valor_neto decimal(10,2) not null,
    asignacion_idasignacion int not null,
    foreign key (asignacion_idasignacion) references asignacion(idasignacion) on update cascade
);


insert into categoria (codigo_control, descripcion) values('24-A', 'Equipo educacional, cultura y recreativo'),
														('24-B', 'Mobiliario y equipo médico-sanitario y de laboratorio'),
                                                        ('24-C', 'Mobiliario y equipo de oficina'),
                                                        ('24-D', 'Equipo de computación'),
                                                        ('24-E', 'Obras de arte'),
                                                        ('24-F', 'Equipo militar y de seguridad'),
                                                        ('24-G', 'Animales'),
                                                        ('24-H', 'Libros, revistas y otros elementos coleccionables'),
                                                        ('24-I', 'Equipo para comunicaciones'),
                                                        ('24-M', 'Equipo de transporte'),
                                                        ('24-O', 'Maquinaria y equipo de producción'),
                                                        ('24-P', 'Maquinaria y equipo para la construcción'),
                                                        ('24-Z', 'Otras máquinas y equipos');
