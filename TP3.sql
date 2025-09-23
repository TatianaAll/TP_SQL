-- Duree moyenne des morceaux en millisecondes
SELECT
  AVG(Track.Milliseconds) / 1000
FROM
  Track;

-- 393.59921210
-- arrondis a 2 decimales
SELECT
  ROUND(AVG(Track.Milliseconds) / 1000, 2)
FROM
  Track;

-- 393.60
-- nombre total de morceaux
SELECT
  COUNT(Track.TrackId)
FROM
  Track;

--3503
-- duree max et min des morceaux
SELECT
  MIN(Track.Milliseconds) AS duree_min,
  MAX(Track.Milliseconds) AS duree_max
FROM
  Track;

--duree_min : 1071	duree_max 5286953
-- convertir en secondes (division par 1000)
SELECT
  MIN(Track.Milliseconds) / 1000 AS duree_min,
  MAX(Track.Milliseconds) / 1000 AS duree_max
FROM
  Track;

--min 1.0710 secondes max : 5286.9530 secondes
-- somme totale des ventes 
SELECT
  SUM(Invoice.Total)
FROM
  Invoice;

-- 2328.60
-- Tous les noms d'album en majuscules
SELECT
  UPPER(Album.Title)
FROM
  Album;

-- nom d'artistes en minuscules
SELECT
  LOWER(Artist.Name)
FROM
  Artist;

-- concaténer le prénom nom des clients dans un seul champ
SELECT
  CONCAT (Customer.FirstName, ' ', Customer.LastName) AS nom_client
FROM
  Customer;

-- supprimer les espaces avant et après le nom des clients
SELECT
  TRIM(
    CONCAT (Customer.FirstName, ' ', Customer.LastName)
  ) AS nom_client
FROM
  Customer;

-- remplacer les espaces dans les titre d'albums par - 
SELECT
  REPLACE (Album.Title, ' ', '_')
FROM
  Album;

-- recuperer les 3 premiers caracteres des noms d'artistes
SELECT
  SUBSTR (Artist.Name, 1, 3) AS debut_nom
FROM
  Artist;

-- afficher la date actuelle
SELECT
  CURRENT_DATE;

-- ou
SELECT
  NOW ();

-- afficher uniquement annees des factures
SELECT
  YEAR (Invoice.InvoiceDate) AS annee_facture
FROM
  Invoice;

-- afficher mois et annees des factures
SELECT
  MONTH (Invoice.InvoiceDate) AS mois_facture,
  YEAR (Invoice.InvoiceDate) AS annee_facture
FROM
  Invoice;

--difference entre 2 dates : la facture la plus ancienne et la plus recente
SELECT
  DATEDIFF (
    MAX(Invoice.InvoiceDate),
    MIN(Invoice.InvoiceDate)
  ) AS ecart_jours
FROM
  Invoice;

-- 1816 jours
--hash d'un email employé avec md5
SELECT
  Employee.Email,
  MD5 (Employee.Email) AS hash_email
FROM
  Employee;

-- avec sha1
SELECT
  Employee.Email,
  SHA1 (Employee.Email) AS hash_email
FROM
  Employee;

-- calcul du nombre de piste diponible par album
SELECT
  Track.albumId as id_album,
  COUNT(Track.TrackId) AS total_track
FROM
  Track
GROUP BY
  Track.AlbumId;

-- total des ventes par client
SELECT
  Invoice.CustomerId,
  SUM(Invoice.Total) AS depense
FROM
  Invoice
GROUP BY
  Invoice.CustomerId;

-- total des ventes par client ayant depensé plus de 38 (rangé par les + gros client au moins dépensier)
SELECT
  Invoice.CustomerId,
  SUM(Invoice.Total) AS depense
FROM
  Invoice
GROUP BY
  Invoice.CustomerId
HAVING
  depense > 38
ORDER BY
  depense DESC;