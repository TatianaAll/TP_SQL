-- LEFT JOIN
-- les artistes sans album (il y en a 71)
SELECT
  Artist.Name AS groupe,
  COUNT(DISTINCT Album.AlbumId) AS nombre_album
FROM
  Artist
  LEFT JOIN Album ON Artist.ArtistId = Album.ArtistId
WHERE
  Album.AlbumId IS NULL
GROUP BY
  groupe;

-- pareil mais avec RIGHT JOIN -- pas de résultats car les artistes qui n'ont pas d'albums n'apparaissent pas dans la table Album
SELECT
  Artist.Name AS groupe,
  COUNT(DISTINCT Album.AlbumId) AS nombre_album
FROM
  Artist
  RIGHT JOIN Album ON Artist.ArtistId = Album.ArtistId
WHERE
  Album.AlbumId IS NULL
GROUP BY
  groupe;

-- les titres qui n'ont jamais été achetés JOIN avec InvoiceLine et Customer
SELECT
  Track.TrackId AS id_chanson,
  Track.Name AS nom_chanson,
FROM
  Track
  LEFT JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
WHERE
  InvoiceLine.InvoiceId IS NULL;

-- pareil mais avec RIGHT JOIN
SELECT
  Track.TrackId AS id_chanson,
  Track.Name AS nom_chanson
FROM
  Track
  RIGHT JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId
WHERE
  InvoiceLine.InvoiceId IS NULL;