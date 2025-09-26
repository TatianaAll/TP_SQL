<?php

$handle = fopen("villes.csv", "r");
if ($handle) {
  while (($data = fgetcsv($handle, 1000, ",")) !== false) {
    return ($data[1] === "33");
  }
  fclose($handle);
}
