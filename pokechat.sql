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
-- Volcado de datos para la tabla `mensajes`
--

INSERT INTO `mensajes` (`id_m`, `id_u`, `mensaje`, `fecha_creacion`, `fecha_creacion_unix`, `observable`) VALUES
(1, 1, 'prueba1!', '2016-10-26 09:42:26', 1477439394, 0),
(2, 1, 'prueba1!', '2016-10-26 09:45:52', 1477439394, 1),
(3, 1, 'Hola k ase como esta o k ase', '2016-10-26 09:42:33', 1477439476, 0),
(4, 1, 'alert("Hola k ase como esta o k ase");', '2016-10-26 09:42:36', 1477439552, 0),
(5, 2, 'Hola k ase soy pepe1', '2016-10-26 00:31:56', 123456789, 1),
(6, 2, 'Soy pepe mensaje 2', '2016-10-26 00:31:56', 12345677, 1),
(7, 3, 'Soy juan', '2016-10-26 00:32:04', NULL, 1),
(8, 1, 'eto e un prueb dle cht', '2016-10-26 11:01:10', 1477479670, 1),
(9, 1, 'Esto es una prueba para meter', '2016-10-26 12:10:08', 1477483808, 1),
(10, 1, 'Esto es una prueba para meter', '2016-10-26 12:10:10', 1477483810, 1),
(11, 1, 'meteme al principio cariño', '2016-10-26 12:11:45', 1477483905, 1),
(12, 1, 'meteme al principio cariño', '2016-10-26 12:11:46', 1477483906, 1),
(13, 1, 'pero que pasa acá', '2016-10-26 12:12:33', 1477483953, 1),
(14, 1, 'ENVIO', '2016-10-26 12:14:32', 1477484072, 1),
(15, 1, 'ENVIO', '2016-10-26 12:14:33', 1477484073, 1),
(16, 1, 'ENVIO', '2016-10-26 12:14:33', 1477484073, 1),
(17, 1, 'ENVIO', '2016-10-26 12:14:33', 1477484073, 1),
(18, 1, 'ENVIO', '2016-10-26 12:14:33', 1477484073, 1),
(19, 1, 'ENVIO', '2016-10-26 12:14:33', 1477484073, 1),
(20, 1, 'ENVIO', '2016-10-26 12:14:34', 1477484074, 1),
(21, 1, 'hola', '2016-10-26 12:17:41', 1477484261, 1),
(22, 1, 'como estas', '2016-10-26 12:17:47', 1477484267, 1),
(23, 4, 'hol chico oy nuevo en el cht', '2016-10-26 12:18:30', 1477484310, 1),
(24, 1, 'bueno esto es una prueba', '2016-10-26 12:19:11', 1477484351, 1),
(25, 4, 'oh crllo', '2016-10-26 12:20:20', 1477484420, 1),
(26, 4, 'Eto e l leche con ceboll', '2016-10-26 12:21:39', 1477484499, 1),
(27, 4, 'no on igule', '2016-10-26 12:22:45', 1477484565, 1),
(28, 4, 'hor cojon', '2016-10-26 12:23:34', 1477484614, 1),
(29, 4, 'nooooo"', '2016-10-26 12:24:08', 1477484648, 1),
(30, 1, 'yo escribir', '2016-10-26 12:24:48', 1477484688, 1),
(31, 4, 'yo no ecribir', '2016-10-26 12:25:00', 1477484700, 1),
(32, 4, 'unif', '2016-10-26 12:25:33', 1477484733, 1),
(33, 4, 'entr en unifth', '2016-10-26 12:26:16', 1477484776, 1),
(34, 4, 'on do', '2016-10-26 12:26:26', 1477484786, 1),
(35, 4, 'quier lmi', '2016-10-26 12:28:20', 1477484900, 1),
(36, 4, 'kiere lmi', '2016-10-26 12:28:50', 1477484930, 1),
(37, 4, 'kier', '2016-10-26 12:29:14', 1477484954, 1),
(38, 4, 'lmiiiiiii', '2016-10-26 12:29:24', 1477484964, 1),
(39, 4, 'LMI', '2016-10-26 12:30:23', 1477485023, 1),
(40, 4, 'Mmi quiere mi lmi', '2016-10-26 12:31:33', 1477485093, 1),
(41, 4, 'ppi limoo', '2016-10-26 12:32:11', 1477485131, 1),
(42, 4, 'iy guy', '2016-10-26 12:32:52', 1477485172, 1),
(43, 4, 'cojone', '2016-10-26 12:38:14', 1477485494, 1),
(44, 1, 'no se informa', '2016-10-26 12:38:33', 1477485513, 1),
(45, 1, 'como', '2016-10-26 12:38:41', 1477485521, 1),
(46, 1, 'como', '2016-10-26 12:38:44', 1477485524, 1),
(47, 1, 'como', '2016-10-26 12:38:46', 1477485526, 1),
(48, 1, 'soy er nuevo', '2016-10-26 12:49:01', 1477486141, 1),
(49, 1, 'soy er nuevo dos', '2016-10-26 12:50:29', 1477486229, 1),
(50, 4, 'Hola karakulo', '2016-10-26 12:51:29', 1477486289, 1),
(51, 1, 'Es lo que hay', '2016-10-26 20:04:18', 1477512258, 1),
(52, 1, 'zñakjsiodpfjasoidfja psdofi a````````', '2016-10-26 20:04:51', 1477512291, 1),
(53, 1, 'jasdoipf jaiospdj fioj987987890q7w8er90q7ewb 70 89er89 07/%()=%/()= %/890 7895072890789=(/)%$·"!"·$%&/() +`+ `+`+`+`ç´ç´ç -.-.-', '2016-10-26 20:05:13', 1477512313, 1),
(54, 2, 'Soy el pepe', '2016-10-26 20:06:10', 1477512370, 1),
(55, 2, 'como estas', '2016-10-26 20:06:13', 1477512373, 1),
(56, 2, 'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz', '2016-10-26 20:06:22', 1477512382, 1),
(57, 2, 'El pepe es la leche carallo', '2016-10-26 20:06:33', 1477512393, 1);

-- --------------------------------------------------------

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
