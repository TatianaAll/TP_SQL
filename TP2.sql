-- Afficher toutes les colonnes de la table Artist
SELECT
  *
FROM
  Artist;

-- Afficher les colonnes ArtisteId et Name et renommer name
SELECT
  ArtistId,
  name as nom
FROM
  Artist;

-- Afficher toute les Track rangé par milliseconde décroissantes
SELECT
  *
FROM
  Track
ORDER BY
  Track.Milliseconds DESC;

-- Afficher l'artiste avec l'artiseID 22
SELECT
  *
FROM
  Artist
WHERE
  Artist.ArtistId = 22;

-- Afficher les album qui contiennent le mot "greatest" dans leur nom
SELECT
  *
FROM
  Album
WHERE
  Album.Title LIKE '%greatest%';

-- Track dont la duree est entre 250000 et 350000 millisecondes
SELECT
  *
FROM
  Track
WHERE
  Track.Milliseconds BETWEEN 250000 AND 350000;

-- Album dont l'ArtistId est 1, 5 ou 10
-- Methode 1 :
SELECT
  *
FROM
  Album
WHERE
  Album.ArtistId = 1
  OR Album.ArtistId = 5
  OR Album.ArtistId = 10;

-- Methode 2 :
SELECT
  *
FROM
  Album
WHERE
  Album.ArtistId IN (1, 5, 10);

-- Ajouter un nouvel artiste
INSERT INTO
  Artist (Name)
VALUES
  ('Battle Beast');

-- Ajouter un album à mon nouvel artiste
--on specifie dans la colonne l'artisteId pour viser le bon
INSERT INTO
  Album (Title, ArtistId)
VALUES
  ('King for a day', 276);

-- Mettre à jour le nom d'artiste de AC/DC en ACDC
UPDATE Artist
SET
  Artist.Name = 'ACDC'
WHERE
  Artist.Name = 'AC/DC';

-- Mettre à jour le titre de l'album 'king for a day'
UPDATE Album
SET
  Album.Title = 'King-for-a-day'
WHERE
  Album.Title = 'King for a day';

UPDATE Album
SET
  Album.Title = 'King-for-a-day'
WHERE
  Album.ArtistId = 276;

-- Supprimer l'artiste que j'ai ajouté
-- avant de le supprimer il faut supprimer ses albums
-- on peut aussi utiliser DELETE CASCADE lors de la creation de la table pour que les albums soient supprimés automatiquement
--1 on supprime le ou les albums
DELETE FROM Album
WHERE
  Album.ArtistId = 276;

--2 on supprime l'artiste
DELETE FROM Artist
WHERE
  Artist.Name = 'Battle Beast';

-- Tracks dont le nom contient 'rock' ou 'roll' rangé par nom dans l'ordre alphabétique
SELECT
  *
FROM
  Track
WHERE
  Track.Name LIKE '%rock%'
  OR Track.Name LIKE '%roll%'
ORDER BY
  Track.Name ASC;

-- Albums dont l'ArtistId est entre 50 et 60 rangé par titre dans l'ordre décroissant
SELECT
  *
FROM
  Album
WHERE
  Album.ArtistId BETWEEN 50 AND 60
ORDER BY
  Album.Title DESC;
