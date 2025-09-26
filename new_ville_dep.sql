-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le : ven. 26 sep. 2025 à 09:51
-- Version du serveur : 8.0.40
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `new_ville_dep`
--

-- --------------------------------------------------------

--
-- Structure de la table `code_postal`
--

CREATE TABLE `code_postal` (
  `Id_code_postal` int NOT NULL,
  `code_postal` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Departement`
--

CREATE TABLE `Departement` (
  `Id_Departement` int NOT NULL,
  `numero_departement` varchar(3) NOT NULL,
  `nom_departement` varchar(50) NOT NULL,
  `slug` varchar(50) DEFAULT NULL,
  `soundex` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Population`
--

CREATE TABLE `Population` (
  `Id_Population` int NOT NULL,
  `annee` int NOT NULL,
  `population` int DEFAULT NULL,
  `densite` int DEFAULT NULL,
  `Id_Villes_France` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `Villes_France`
--

CREATE TABLE `Villes_France` (
  `Id_Villes_France` int NOT NULL,
  `nom_ville` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `code_commune` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `longitude_deg` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `latitude_deg` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `surface_km_2` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `altitude_max` varchar(50) DEFAULT NULL,
  `altitude_min` varchar(50) DEFAULT NULL,
  `Id_Departement` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `ville_code_postal`
--

CREATE TABLE `ville_code_postal` (
  `Id_Villes_France` int NOT NULL,
  `Id_code_postal` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `code_postal`
--
ALTER TABLE `code_postal`
  ADD PRIMARY KEY (`Id_code_postal`);

--
-- Index pour la table `Departement`
--
ALTER TABLE `Departement`
  ADD PRIMARY KEY (`Id_Departement`),
  ADD UNIQUE KEY `numero_departement` (`numero_departement`),
  ADD UNIQUE KEY `nom_departement` (`nom_departement`);

--
-- Index pour la table `Population`
--
ALTER TABLE `Population`
  ADD PRIMARY KEY (`Id_Population`),
  ADD UNIQUE KEY `annee` (`annee`),
  ADD KEY `Id_Villes_France` (`Id_Villes_France`);

--
-- Index pour la table `Villes_France`
--
ALTER TABLE `Villes_France`
  ADD PRIMARY KEY (`Id_Villes_France`),
  ADD UNIQUE KEY `code_commune` (`code_commune`),
  ADD KEY `Id_Departement` (`Id_Departement`);

--
-- Index pour la table `ville_code_postal`
--
ALTER TABLE `ville_code_postal`
  ADD PRIMARY KEY (`Id_Villes_France`,`Id_code_postal`),
  ADD KEY `Id_code_postal` (`Id_code_postal`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `code_postal`
--
ALTER TABLE `code_postal`
  MODIFY `Id_code_postal` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Departement`
--
ALTER TABLE `Departement`
  MODIFY `Id_Departement` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Population`
--
ALTER TABLE `Population`
  MODIFY `Id_Population` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `Villes_France`
--
ALTER TABLE `Villes_France`
  MODIFY `Id_Villes_France` int NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Population`
--
ALTER TABLE `Population`
  ADD CONSTRAINT `population_ibfk_1` FOREIGN KEY (`Id_Villes_France`) REFERENCES `Villes_France` (`Id_Villes_France`);

--
-- Contraintes pour la table `Villes_France`
--
ALTER TABLE `Villes_France`
  ADD CONSTRAINT `villes_france_ibfk_1` FOREIGN KEY (`Id_Departement`) REFERENCES `Departement` (`Id_Departement`);

--
-- Contraintes pour la table `ville_code_postal`
--
ALTER TABLE `ville_code_postal`
  ADD CONSTRAINT `ville_code_postal_ibfk_1` FOREIGN KEY (`Id_Villes_France`) REFERENCES `Villes_France` (`Id_Villes_France`),
  ADD CONSTRAINT `ville_code_postal_ibfk_2` FOREIGN KEY (`Id_code_postal`) REFERENCES `code_postal` (`Id_code_postal`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
