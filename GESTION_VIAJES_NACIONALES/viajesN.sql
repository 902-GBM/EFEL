-- Gestión de viajes nacionales

CREATE DATABASE IF NOT EXISTS gestion_viajes_nacionales;
USE gestion_viajes_nacionales;

CREATE TABLE pasajeros (
    id_pasajero INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(80) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    documento VARCHAR(30) NOT NULL UNIQUE,
    telefono VARCHAR(25),
    correo VARCHAR(120)
);

CREATE TABLE destinos (
    id_destino INT AUTO_INCREMENT PRIMARY KEY,
    ciudad VARCHAR(80) NOT NULL,
    departamento VARCHAR(80) NOT NULL,
    descripcion VARCHAR(255),
    UNIQUE (ciudad, departamento)
);

CREATE TABLE vehiculos (
    id_vehiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(15) NOT NULL UNIQUE,
    tipo VARCHAR(40) NOT NULL,
    capacidad INT NOT NULL,
    estado ENUM('Disponible', 'En viaje', 'Mantenimiento') NOT NULL DEFAULT 'Disponible',
    CHECK (capacidad > 0)
);

CREATE TABLE conductores (
    id_conductor INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(80) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    licencia VARCHAR(30) NOT NULL UNIQUE,
    telefono VARCHAR(25)
);

CREATE TABLE viajes (
    id_viaje INT AUTO_INCREMENT PRIMARY KEY,
    id_destino INT NOT NULL,
    id_vehiculo INT NOT NULL,
    id_conductor INT NOT NULL,
    fecha_salida DATETIME NOT NULL,
    fecha_llegada DATETIME,
    precio DECIMAL(10,2) NOT NULL,
    estado ENUM('Programado', 'En curso', 'Finalizado', 'Cancelado') NOT NULL DEFAULT 'Programado',
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculos(id_vehiculo),
    FOREIGN KEY (id_conductor) REFERENCES conductores(id_conductor),
    CHECK (precio >= 0),
    CHECK (fecha_llegada IS NULL OR fecha_llegada >= fecha_salida)
);

CREATE TABLE reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_viaje INT NOT NULL,
    id_pasajero INT NOT NULL,
    fecha_reserva DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    asiento INT NOT NULL,
    estado ENUM('Confirmada', 'Pendiente', 'Cancelada') NOT NULL DEFAULT 'Pendiente',
    FOREIGN KEY (id_viaje) REFERENCES viajes(id_viaje),
    FOREIGN KEY (id_pasajero) REFERENCES pasajeros(id_pasajero),
    UNIQUE (id_viaje, asiento),
    UNIQUE (id_viaje, id_pasajero),
    CHECK (asiento > 0)
);

INSERT INTO destinos (ciudad, departamento, descripcion) VALUES
('Bogotá', 'Cundinamarca', 'Capital del país'),
('Medellín', 'Antioquia', 'Ciudad de la eterna primavera'),
('Cartagena', 'Bolívar', 'Destino turístico del Caribe');