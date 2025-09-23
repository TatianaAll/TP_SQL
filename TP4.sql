-- REQUETE IMBRIQUEES

-- les titre des albums de Queen
SELECT
  (Album.Title)
FROM
  Album
WHERE
  Album.ArtistId = (
    SELECT
      Artist.ArtistId
    FROM
      Artist
    WHERE
      Artist.Name = 'Queen'
  );

-- 3 albums : Greatest Hits II, Greatest Hits I, News Of The World
-- les artistes ayant plus de 10 albums
SELECT
  Artist.Name AS nom_artiste
FROM
  Artist
WHERE
  Artist.ArtistId IN (
    SELECT
      Album.ArtistId
    FROM
      Album
    GROUP BY
      Album.ArtistId
    HAVING
      COUNT(Album.AlbumId) > 10
  );

-- les artistes n'ayant pas d'album (il n'y en a aucun dans la BD)
SELECT
  Artist.Name AS nom_artiste
FROM
  Artist
WHERE
  Artist.ArtistId IN (
    SELECT
      Album.ArtistId
    FROM
      Album
    GROUP BY
      Album.ArtistId
    HAVING
      COUNT(Album.AlbumId) = 0
  );

-- titre de piste dont la duree est sup à la duree moyenne de toutes les pistes -> 494 morceaux
SELECT
  Track.Name
FROM
  Track
WHERE
  Track.Milliseconds > (
    SELECT
      AVG(Track.Milliseconds)
    FROM
      Track
  );

-- nom de ou des albums dont toutes les pistes sont sup à 10min (600000 ms) -> 13 albums
SELECT
  Album.Title AS album
FROM
  Album
WHERE
  Album.AlbumId IN (
    SELECT
      Track.AlbumId
    FROM
      Track
    GROUP BY
      Track.AlbumId
    HAVING
      MIN(Track.Milliseconds) > 600000
  );

-- nom du client qui a fait la commande la plus chère -> Helena Holý
SELECT
  CONCAT (Customer.FirstName, ' ', Customer.LastName) AS nom_client
FROM
  Customer
WHERE
  Customer.CustomerId = (
    SELECT
      Invoice.CustomerId
    FROM
      Invoice
    WHERE
      Invoice.Total = (
        SELECT
          MAX(Invoice.Total)
        FROM
          Invoice
      )
  );

-- nom du groupe de genre Rock avec la track la plus longue
SELECT
  Artist.Name as groupe
FROM
  Artist
WHERE
  Artist.ArtistId = (
    SELECT
      Album.ArtistId AS artist_album
    FROM
      Album
    WHERE
      Album.AlbumId = (
        SELECT
          Track.AlbumId
        FROM
          Track
        WHERE Track.GenreId =
          (
            SELECT
              Genre.GenreId
            FROM
              Genre
            WHERE
              Genre.Name LIKE '%Rock'
          )
        ORDER BY
          Track.Milliseconds DESC
        LIMIT
          1
      )
  );