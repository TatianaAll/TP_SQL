-- Changer le type de la colonne test
ALTER TABLE `recette` 
MODIFY COLUMN `test` INT; 

-- Renommer la colonne test en béta :  
ALTER TABLE `recette` 
CHANGE COLUMN `test` `beta` INT 

-- Supprimer la colonne beta : 
ALTER TABLE `recette` DROP COLUMN beta; 


-- Créer une nouvelle table :  
CREATE TABLE ingredient ( 
    id INT, 
    name VARCHAR(50) 
    ); 