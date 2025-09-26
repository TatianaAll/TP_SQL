<?php
include 'departement_PK.php';

$oldDBFile = "old_villes.sql";
$outputVilles = "migration_villes.sql";
$outputCP = "migration_code_postaux.sql";
$outputPivot = "migration_ville_cp.sql";

// Vider les fichiers de sortie
file_put_contents($outputVilles, "");
file_put_contents($outputCP, "");
file_put_contents($outputPivot, "");

// Lire tout le contenu du fichier source
$content = file_get_contents($oldDBFile);

// Tableau pour suivre les codes postaux déjà insérés
$codesPostaux = [];
$nextCPId = 1;

// Tableau pour suivre les villes déjà traitées
$nextVilleId = 1;

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
            $altMin       = isset($values[26]) ? trim($values[26]) : "NULL";
            $altMax       = isset($values[27]) ? trim($values[27]) : "NULL";

            // Trouver l'Id_Departement correspondant
            if (!isset($departements[$villeCodeDep])) {
                echo "Département inconnu pour la ville $villeNom : $villeCodeDep\n";
                continue;
            }
            $idDepartement = $departements[$villeCodeDep];

            // --- INSERT pour ville_de_france ---
            $sqlVille = "INSERT INTO ville_de_france 
(nom_ville, slug, code_commune, Id_Departement, latitude_deg, longitude_deg, surface_km_2, altitude_min, altitude_max)
VALUES ('$villeNom', '$villeSlug', '$codeCommune', $idDepartement, '$latitude', '$longitude', '$surface', " . ($altMin === "NULL" ? "NULL" : "'$altMin'") . ", " . ($altMax === "NULL" ? "NULL" : "'$altMax'") . ");\n";

            file_put_contents($outputVilles, $sqlVille, FILE_APPEND);

            // --- Gestion des codes postaux ---
            $villeCPs = explode("-", trim($values[8])); // ex: "75001-75002"
            foreach ($villeCPs as $cp) {
                $cp = trim($cp);
                if ($cp === "") continue;

                // Si ce code postal n'est pas encore dans notre table, on le crée
                if (!isset($codesPostaux[$cp])) {
                    $codesPostaux[$cp] = $nextCPId;
                    $sqlCP = "INSERT INTO code_postal (id_code_postal, code_postal) VALUES ($nextCPId, '$cp');\n";
                    file_put_contents($outputCP, $sqlCP, FILE_APPEND);
                    $nextCPId++;
                }

                $idCP = $codesPostaux[$cp];

                // --- Table pivot ---
                $sqlPivot = "INSERT INTO ville_code_postal (Id_Villes_France, Id_code_postal) VALUES ($nextVilleId, $idCP);\n";
                file_put_contents($outputPivot, $sqlPivot, FILE_APPEND);
            }

            $nextVilleId++;
        }
    }
}

echo "Migration terminée. Fichiers créés : $outputVilles, $outputCP, $outputPivot\n";
