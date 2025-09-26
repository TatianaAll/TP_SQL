<?php
include 'departement_PK.php';
$oldDBFile = "old_villes.sql";
$outputFile = "migration_villes.sql";


// Vider le fichier de sortie
file_put_contents($outputFile, "");

// Lire tout le contenu
$content = file_get_contents($oldDBFile);

// Chercher tous les INSERT INTO villes_france_free
if (preg_match_all("/INSERT INTO `villes_france_free`.*?VALUES\s*(.+?);/is", $content, $matches)) {

    foreach ($matches[1] as $valuesBlock) {
        $valuesBlock = str_replace(["\n", "\r"], "", $valuesBlock);
        $rows = preg_split("/\),\s*\(/", $valuesBlock);

        foreach ($rows as $row) {
            $row = trim($row, " ()");
            $values = str_getcsv($row, ',', "'", "\\");

            if (count($values) < 26) {
                echo "Ligne ignorée (colonnes manquantes) : $row\n";
                continue;
            }

            $villeNom     = addslashes(trim($values[3]));
            $villeSlug    = addslashes(trim($values[2]));
            $villeCodeDep = trim($values[1]);
            $codeCommune  = trim($values[10]);
            $latitude     = trim($values[20]);
            $longitude    = trim($values[19]);
            $surface      = trim($values[18]);
            $altMin = isset($values[26]) ? trim($values[26]) : "NULL";
            $altMax = isset($values[27]) ? trim($values[27]) : "NULL";

            // Trouver l'Id_Departement correspondant
            if (!isset($departements[$villeCodeDep])) {
                echo "Département inconnu pour la ville $villeNom : $villeCodeDep\n";
                continue;
            }
            $idDepartement = $departements[$villeCodeDep];

            $sql = "INSERT INTO Villes_France 
(nom_ville, code_commune, longitude_deg, latitude_deg, surface_km_2, altitude_min, altitude_max, Id_Departement)
VALUES 
('$villeNom', '$codeCommune', '$longitude', '$latitude', '$surface', '$altMin', '$altMax', $idDepartement);\n";


            file_put_contents($outputFile, $sql, FILE_APPEND);
        }
    }
}

echo "Migration terminée. Fichier créé : $outputFile\n";
