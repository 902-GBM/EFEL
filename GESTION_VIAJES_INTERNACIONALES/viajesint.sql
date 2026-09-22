-- Esquema básico para la gestión de viajes internacionales

CREATE TABLE pasajeros (
    id_pasajero INT PRIMARY KEY AUTO_INCREMENT,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    pasaporte VARCHAR(30) NOT NULL UNIQUE,
    nacionalidad VARCHAR(60) NOT NULL,
    fecha_nacimiento DATE,
    correo VARCHAR(150) UNIQUE
);

CREATE TABLE destinos (
    id_destino INT PRIMARY KEY AUTO_INCREMENT,
    pais VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    requiere_visado BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE viajes (
    id_viaje INT PRIMARY KEY AUTO_INCREMENT,
    codigo_reserva VARCHAR(20) NOT NULL UNIQUE,
    id_destino INT NOT NULL,
    fecha_salida DATETIME NOT NULL,
    fecha_regreso DATETIME,
    estado ENUM('PLANIFICADO', 'CONFIRMADO', 'CANCELADO', 'FINALIZADO') NOT NULL DEFAULT 'PLANIFICADO',
    FOREIGN KEY (id_destino) REFERENCES destinos(id_destino)
);

CREATE TABLE reservas (
    id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    id_viaje INT NOT NULL,
    id_pasajero INT NOT NULL,
    fecha_reserva TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    clase ENUM('ECONOMICA', 'EJECUTIVA', 'PRIMERA') NOT NULL DEFAULT 'ECONOMICA',
    precio DECIMAL(10, 2) NOT NULL,
    estado ENUM('PENDIENTE', 'PAGADA', 'CANCELADA') NOT NULL DEFAULT 'PENDIENTE',
    UNIQUE (id_viaje, id_pasajero),
    FOREIGN KEY (id_viaje) REFERENCES viajes(id_viaje),
    FOREIGN KEY (id_pasajero) REFERENCES pasajeros(id_pasajero)
);