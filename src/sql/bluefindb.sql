drop database if exists bluefin;
create database bluefin;
use bluefin;

CREATE TABLE usuario (
    id_us INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    correo VARCHAR(40),
    genero VARCHAR(40),
    icono INT,
    edad INT,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    fecha DATE
);

CREATE TABLE sesion (
    id_se INT PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(80),
    contraseña VARCHAR(20),
    tipo INT,
    id_us INT,
    FOREIGN KEY (id_us) REFERENCES usuario(id_us)
);


create table logros (
  id_lo int primary key auto_increment not null,
  descripcion varchar (200),
  titulo varchar (35),
  progreso tinyint,
  id_us int,
  foreign key (id_us) references usuario(id_us)
);

create table faqs (
  id_fa int primary key auto_increment not null,
  preguntas varchar (50),
  respuestas varchar (60),
  fecha date,
  id_us int,
  foreign key (id_us) references usuario(id_us)
);

create table puzzle (
  id_pu int primary key auto_increment not null,
  nombre varchar (50),
  descripcion varchar (60),
  estado tinyint,
  npiezas int,
  id_us int,
  foreign key (id_us) references usuario(id_us)
);

create table faqs_puzzle (
  id_fa int,
  id_pu int,
  foreign key (id_fa) references faqs(id_fa),
  foreign key (id_pu) references puzzle(id_pu),
  primary key (id_fa, id_pu)
);

create table quiz (
  id_qu int primary key auto_increment not null,
  pregunta varchar (50),
  fecha date,
  id_us int,
  foreign key (id_us) references usuario(id_us)
);

create table respuestas (
  id_re int primary key auto_increment not null,
  respuesta varchar (100),
  fecha date,
  id_us int,
  foreign key (id_us) references usuario(id_us)
);