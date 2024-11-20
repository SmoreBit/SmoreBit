USE bluefin;
-- Datos Iniciales
INSERT IGNORE INTO usuario (correo, genero, icono, edad, nombre, apellido, fecha) VALUES
('test@example.com', 'Masculino', 1, 25, 'Test', 'User', '2023-11-10'),
('test2@example.com', 'Femenino', 2, 30, 'Test2', 'User', '2023-11-10'),
('jane.doe@gmail.com', 'Femenino', 1, 28, 'Jane', 'Doe', '2023-08-15'),
('john.smith@gmail.com', 'Masculino', 2, 35, 'John', 'Smith', '2023-05-20'),
('alice.jones@gmail.com', 'Femenino', 3, 22, 'Alice', 'Jones', '2023-07-10'),
('bob.brown@gmail.com', 'Masculino', 1, 40, 'Bob', 'Brown', '2023-03-25'),
('carol.white@gmail.com', 'Femenino', 2, 29, 'Carol', 'White', '2023-09-05');

INSERT IGNORE INTO sesion (usuario, contraseña, tipo, id_us) VALUES
('test', '1234', 1, 1),
('test2', '1234', 0, 2),
('jane', '1234', 1, 3),
('john', '1234', 0, 4),
('alice', '1234', 1, 5),
('bob', '1234', 0, 6),
('carol', '1234', 1, 7);