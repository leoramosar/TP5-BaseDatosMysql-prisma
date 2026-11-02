-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 01-11-2026 a las 22:09:13
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `distribuidora`
--

CREATE DATABASE IF NOT EXISTS `distribuidora` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `distribuidora`;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `detalle_pedido`;
DROP TABLE IF EXISTS `envios`;
DROP TABLE IF EXISTS `pedidos`;
DROP TABLE IF EXISTS `productos`;
DROP TABLE IF EXISTS `categorias`;
DROP TABLE IF EXISTS `clientes`;
DROP TABLE IF EXISTS `companias_envios`;
DROP TABLE IF EXISTS `empleados`;
DROP TABLE IF EXISTS `proveedores`;
DROP TABLE IF EXISTS `users`;

SET FOREIGN_KEY_CHECKS = 1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(80) NOT NULL,
  `descripcion` varchar(200) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`, `descripcion`, `createdAt`, `updatedAt`) VALUES
(1, 'Bebidas', 'Gaseosas, aguas y jugos', '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(2, 'Snacks', 'Galletitas y alfajores', '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(3, 'Almacén', 'Aceites, harinas y pastas', '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `cuit` varchar(20) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `cuit`, `telefono`, `email`, `direccion`, `activo`, `createdAt`, `updatedAt`) VALUES
(1, 'Supermercado El Sol', '20-11111111-1', '1144441111', 'compras@elsol.com', 'Av. Corrientes 500', 1, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(2, 'Almacén Doña Rosa', '27-22222222-2', '1144442222', 'rosa@almacen.com', 'Calle Falsa 123', 1, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `companias_envios`
--

CREATE TABLE `companias_envios` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `costo_base` decimal(10,2) NOT NULL CHECK (`costo_base` >= 0),
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `companias_envios`
--

INSERT INTO `companias_envios` (`id`, `nombre`, `telefono`, `costo_base`, `createdAt`, `updatedAt`) VALUES
(1, 'Andreani', '0800-333-3333', 2500.00, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(2, 'Correo Argentino', '0800-777-7777', 1800.00, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `id` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL CHECK (`cantidad` > 0),
  `precio_unitario` decimal(10,2) NOT NULL CHECK (`precio_unitario` >= 0),
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `detalle_pedido`
--

INSERT INTO `detalle_pedido` (`id`, `id_pedido`, `id_producto`, `cantidad`, `precio_unitario`, `createdAt`, `updatedAt`) VALUES
(1, 1, 1, 10, 3500.00, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(2, 1, 3, 20, 900.00, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(3, 2, 5, 5, 4200.00, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleados`
--

CREATE TABLE `empleados` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `puesto` varchar(60) NOT NULL,
  `salario` decimal(10,2) NOT NULL CHECK (`salario` >= 0),
  `fecha_ingreso` date NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `empleados`
--

INSERT INTO `empleados` (`id`, `nombre`, `apellido`, `puesto`, `salario`, `fecha_ingreso`, `activo`, `createdAt`, `updatedAt`) VALUES
(1, 'Juan', 'Pérez', 'Vendedor', 850000.00, '2023-03-01', 1, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(2, 'Ana', 'Gómez', 'Administrativa', 900000.00, '2022-08-15', 1, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `envios`
--

CREATE TABLE `envios` (
  `id` int(11) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_compania` int(11) NOT NULL,
  `direccion` varchar(200) NOT NULL,
  `fecha_envio` date DEFAULT NULL,
  `estado` enum('preparando','en camino','entregado','cancelado') NOT NULL DEFAULT 'preparando',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `envios`
--

INSERT INTO `envios` (`id`, `id_pedido`, `id_compania`, `direccion`, `fecha_envio`, `estado`, `createdAt`, `updatedAt`) VALUES
(3, 1, 1, 'Av. Corrientes 500', '2025-06-02', 'entregado', '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(4, 2, 2, 'Calle Falsa 123', '2025-06-06', 'en camino', '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  `estado` enum('pendiente','confirmado','facturado','cancelado') NOT NULL DEFAULT 'pendiente',
  `numero_factura` varchar(191) DEFAULT NULL,
  `fecha_factura` date DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL CHECK (`subtotal` IS NULL OR `subtotal` >= 0),
  `iva` decimal(10,2) DEFAULT NULL CHECK (`iva` IS NULL OR `iva` >= 0),
  `total` decimal(10,2) DEFAULT NULL CHECK (`total` IS NULL OR `total` >= 0),
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pedidos`
--

INSERT INTO `pedidos` (`id`, `fecha`, `id_cliente`, `id_empleado`, `estado`, `numero_factura`, `fecha_factura`, `subtotal`, `iva`, `total`, `createdAt`, `updatedAt`) VALUES
(1, '2025-06-01', 1, 1, 'pendiente', NULL, NULL, NULL, NULL, NULL, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(2, '2025-06-05', 2, 2, 'pendiente', NULL, NULL, NULL, NULL, NULL, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio` decimal(10,2) NOT NULL CHECK (`precio` >= 0),
  `stock` int(11) NOT NULL DEFAULT 0 CHECK (`stock` >= 0),
  `id_categoria` int(11) DEFAULT NULL,
  `id_proveedor` int(11) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `precio`, `stock`, `id_categoria`, `id_proveedor`, `activo`, `createdAt`, `updatedAt`) VALUES
(1, 'Coca-Cola 2.25L', 3500.00, 100, 1, 1, 1, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(2, 'Agua Mineral 500ml', 1200.00, 200, 1, 1, 1, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(3, 'Alfajor Triple', 900.00, 150, 2, 2, 1, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(4, 'Galletitas Oreo', 1500.00, 80, 2, 2, 1, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(5, 'Aceite Girasol 1.5L', 4200.00, 60, 3, 3, 1, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(6, 'Harina 000 1kg', 1300.00, 90, 3, 3, 1, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `cuit` varchar(20) NOT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `nombre`, `cuit`, `telefono`, `email`, `direccion`, `activo`, `createdAt`, `updatedAt`) VALUES
(1, 'Coca-Cola FEMSA', '30-12345678-1', '1145551111', 'ventas@coca.com', 'Av. Rivadavia 1000', 1, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(2, 'Arcor S.A.', '30-87654321-2', '1145552222', 'contacto@arcor.com', 'Ruta 9 Km 50', 1, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000'),
(3, 'Molinos Río de la Plata', '30-11111111-3', '1145553333', 'info@molinos.com', 'Av. Belgrano 2000', 1, '2026-11-01 13:33:38.000', '2026-11-01 13:33:38.000');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(150) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `rol` enum('ADMIN','USER') NOT NULL DEFAULT 'USER',
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `nombre`, `email`, `password`, `rol`, `activo`, `createdAt`, `updatedAt`) VALUES
(1, 'Emmanuel', 'emmanuel@test.com', '$2b$10$byWbNQDzPmGb1KaVvGO2BucVAfHmaGlN/tLPuZj2ZumdfKgeblq3O', 'USER', 1, '2026-11-01 19:30:32.498', '2026-11-01 19:30:32.498');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cuit` (`cuit`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `companias_envios`
--
ALTER TABLE `companias_envios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_pedido_producto` (`id_pedido`,`id_producto`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `empleados`
--
ALTER TABLE `empleados`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `envios`
--
ALTER TABLE `envios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_pedido` (`id_pedido`),
  ADD KEY `id_compania` (`id_compania`);

--
-- Indices de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pedidos_numero_factura_key` (`numero_factura`),
  ADD KEY `id_cliente` (`id_cliente`),
  ADD KEY `id_empleado` (`id_empleado`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_categoria` (`id_categoria`),
  ADD KEY `id_proveedor` (`id_proveedor`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `cuit` (`cuit`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `companias_envios`
--
ALTER TABLE `companias_envios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `empleados`
--
ALTER TABLE `empleados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `envios`
--
ALTER TABLE `envios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `detalle_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detalle_pedido_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `envios`
--
ALTER TABLE `envios`
  ADD CONSTRAINT `envios_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `envios_ibfk_2` FOREIGN KEY (`id_compania`) REFERENCES `companias_envios` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `clientes` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`id_empleado`) REFERENCES `empleados` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `productos_ibfk_2` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
