-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-11-2016 a las 14:00:34
-- Versión del servidor: 10.1.13-MariaDB
-- Versión de PHP: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pokechat`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes`
--

CREATE TABLE `mensajes` (
  `id_m` int(11) NOT NULL,
  `id_u` int(11) DEFAULT NULL,
  `mensaje` text,
  `fecha_creacion` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `fecha_creacion_unix` int(10) UNSIGNED DEFAULT NULL,
  `observable` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Estructura Stand-in para la vista `todochat`
--
CREATE TABLE `todochat` (
`id_u` int(11)
,`id_m` int(11)
,`user_name` varchar(50)
,`mensaje` text
,`fecha_creacion` timestamp
,`fecha_creacion_unix` int(10) unsigned
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `user_name` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `save_name` varchar(100) DEFAULT NULL,
  `save_data` longtext
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `user_name`, `password`, `save_name`, `save_data`) VALUES
(1, 'gammafp', 'nopass', 'noob', 'noob'),
(2, 'pepe', 'pepe', 'pepe', 'pepe'),
(3, 'juan', 'juan', 'juan', 'juan'),
(4, 'triski', 'triski', 'noob', 'noob'),
(5, 'asdf', 'asdf', 'noob', 'noob');

-- --------------------------------------------------------

--
-- Estructura para la vista `todochat`
--
DROP TABLE IF EXISTS `todochat`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `todochat`  AS  select `me`.`id_u` AS `id_u`,`me`.`id_m` AS `id_m`,`us`.`user_name` AS `user_name`,`me`.`mensaje` AS `mensaje`,`me`.`fecha_creacion` AS `fecha_creacion`,`me`.`fecha_creacion_unix` AS `fecha_creacion_unix` from (`usuarios` `us` left join `mensajes` `me` on((`me`.`id_u` = `us`.`id`))) where (`me`.`observable` = 1) group by `me`.`id_m` ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id_m`),
  ADD KEY `fk_usermen` (`id_u`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id_m` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;
--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `mensajes`
--
ALTER TABLE `mensajes`
  ADD CONSTRAINT `fk_usermen` FOREIGN KEY (`id_u`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
