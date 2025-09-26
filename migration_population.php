<?php
$oldDBFile = "old_villes.sql";
$outputFile = "migration_population.sql";

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

            // Vérification minimale des colonnes nécessaires
            if (count($values) < 18) {
                echo "Ligne ignorée (colonnes manquantes) : $row\n";
                continue;
            }

            // Id de la ville dans la nouvelle table
            $idVille = trim($values[0]);

            // Colonnes population / densité
            $pop1999 = trim($values[15]);
            $pop2010 = trim($values[14]);
            $pop2012 = trim($values[16]);
            $densite2010 = trim($values[17]);

            // Générer les lignes SQL pour chaque année
            $sqlLines = [];

            if ($pop1999 !== "") {
                $sqlLines[] = "INSERT INTO population (annee, population, densite, Id_Villes_France) VALUES (1999, $pop1999, NULL, $idVille);";
            }
            if ($pop2010 !== "") {
                $densiteVal = ($densite2010 !== "") ? $densite2010 : "NULL";
                $sqlLines[] = "INSERT INTO population (annee, population, densite, Id_Villes_France) VALUES (2010, $pop2010, $densiteVal, $idVille);";
            }
            if ($pop2012 !== "") {
                $sqlLines[] = "INSERT INTO population (annee, population, densite, Id_Villes_France) VALUES (2012, $pop2012, NULL, $idVille);";
            }

            // Écrire dans le fichier
            foreach ($sqlLines as $sql) {
                file_put_contents($outputFile, $sql . "\n", FILE_APPEND);
            }
        }
    }
}

echo "Migration population terminée. Fichier créé : $outputFile\n";
?>