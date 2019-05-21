-- phpMyAdmin SQL Dump
-- version 4.0.5
-- http://www.phpmyadmin.net
--
-- Хост: mysql314.1gb.ua
-- Время создания: Май 21 2019 г., 13:22
-- Версия сервера: 5.7.13-6-log
-- Версия PHP: 5.2.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `gbua_zpu1`
--

-- --------------------------------------------------------

--
-- Структура таблицы `reports`
--

CREATE TABLE IF NOT EXISTS `reports` (
  `reportId` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `sentBy` int(11) NOT NULL,
  PRIMARY KEY (`reportId`),
  KEY `reportsId` (`reportId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci AUTO_INCREMENT=3 ;

--
-- Дамп данных таблицы `reports`
--

INSERT INTO `reports` (`reportId`, `title`, `sentBy`) VALUES
(1, 'Первый отчет', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `rows`
--

CREATE TABLE IF NOT EXISTS `rows` (
  `rowId` int(11) NOT NULL AUTO_INCREMENT,
  `platform` int(20) NOT NULL,
  `container1` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `container2` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `ZPU1` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `ZPU2` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `reportId` int(11) NOT NULL,
  PRIMARY KEY (`rowId`),
  KEY `reportId` (`reportId`),
  KEY `rowId` (`rowId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `mode` int(11) NOT NULL,
  UNIQUE KEY `userId_2` (`userId`),
  KEY `userId` (`userId`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`userId`, `email`, `password`, `mode`) VALUES
(1, 'root', '9zaacac7434', 1);

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `rows`
--
ALTER TABLE `rows`
  ADD CONSTRAINT `rows_ibfk_1` FOREIGN KEY (`reportId`) REFERENCES `reports` (`reportId`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
