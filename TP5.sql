-- INNER JOIN
-- extraire liste client avec facture, afficher nom, prenom, total et date facture
SELECT
  CONCAT (Customer.FirstName, ' ', Customer.LastName) AS nom_client,
  Invoice.InvoiceDate AS date_facture,
  Invoice.Total AS total
FROM
  Customer
  INNER JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId;

-- montant total factures par client - qui a le + depense ? Helena Holý
SELECT
  CONCAT (Customer.FirstName, ' ', Customer.LastName) AS nom_client,
  SUM(Invoice.Total) AS total
FROM
  Customer
  INNER JOIN Invoice ON Customer.CustomerId = Invoice.CustomerId
GROUP BY
  Customer.CustomerId
ORDER BY
  total DESC;

-- recuperer les album d'un artiste - nom du groupe + nom album
SELECT
  Artist.Name AS groupe,
  Album.Title AS nom_album
FROM
  Artist
  INNER JOIN Album ON Artist.ArtistId = Album.ArtistId
WHERE
  Artist.Name = 'Green day';

SELECT
  Artist.Name AS groupe,
  Album.Title AS nom_album
FROM
  Artist
  INNER JOIN Album ON Artist.ArtistId = Album.ArtistId
WHERE
  Artist.Name LIKE 'Led%';

-- recuperer en plus le nom des chansons
SELECT
  Artist.Name AS groupe,
  Album.Title AS nom_album,
  Track.Name AS titre_chanson
FROM
  Artist
  INNER JOIN Album ON Artist.ArtistId = Album.ArtistId
  INNER JOIN Track ON Album.AlbumId = Track.AlbumId
WHERE
  Artist.Name = 'Green day';

-- nombre d'album et de titre par artiste - IRON MAIDEN avec 21 albums et 213 titres
SELECT
  Artist.Name AS groupe,
  COUNT(DISTINCT Album.AlbumId) AS nombre_album,
  COUNT(Track.TrackId) AS nombre_chansons
FROM
  Artist
  INNER JOIN Album ON Artist.ArtistId = Album.ArtistId
  INNER JOIN Track ON Album.AlbumId = Track.AlbumId
GROUP BY
  Artist.ArtistId;

-- IRON MAIDEN avec 21 albums et 213 titres
-- Led Zeppelin avec 14 albums et 114 titres
-- Deep Purple avec 11 albums et 92 titres

-- affichage direct du top 3 en nombre d'album
SELECT
  Artist.Name AS groupe,
  COUNT(DISTINCT Album.AlbumId) AS nombre_album,
  COUNT(Track.TrackId) AS nombre_chansons
FROM
  Artist
  INNER JOIN Album ON Artist.ArtistId = Album.ArtistId
  INNER JOIN Track ON Album.AlbumId = Track.AlbumId
GROUP BY
  Artist.ArtistId;
ORDER BY
  nombre_album DESC
LIMIT
  3;