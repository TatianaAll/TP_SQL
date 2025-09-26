<?php
$oldDBFile = "old_dep.sql";
$outputFile = "migration_departement.sql";

// Vider le fichier de sortie
file_put_contents($outputFile, "");

// Lire tout le contenu du fichier
$content = file_get_contents($oldDBFile);

// Ne garder que les INSERT INTO departement
if (preg_match_all("/INSERT INTO `departement`.*?VALUES\s*(.+?);/is", $content, $matches)) {

    foreach ($matches[1] as $valuesBlock) {
        // Supprimer les retours à la ligne pour avoir tout sur une ligne
        $valuesBlock = str_replace(["\n", "\r"], "", $valuesBlock);

        // Séparer les tuples par '),('
        $rows = preg_split("/\),\s*\(/", $valuesBlock);

        foreach ($rows as $row) {
            // Supprimer les éventuels parenthèses résiduelles
            $row = trim($row, " ()");

            // Parser correctement les champs CSV
            $values = str_getcsv($row, ',', "'", "\\");

            if (count($values) < 6) continue;

            $id      = trim($values[0]);
            $code    = addslashes(trim($values[1]));
            $nom     = addslashes(trim($values[2]));
            $slug    = addslashes(trim($values[4]));
            $soundex = addslashes(trim($values[5]));

            $sql = "INSERT INTO Departement (Id_Departement, numero_departement, nom_departement, slug, soundex) 
VALUES ($id, '$code', '$nom', '$slug', '$soundex');\n";

            file_put_contents($outputFile, $sql, FILE_APPEND);
        }
    }
}

echo "Migration terminée pour les départements.\n";
