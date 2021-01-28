--#Suppression des tables une par une dans l’ordre inverse de création
DROP TABLE Citerne;
DROP TABLE Camion;
DROP TABLE Modele;
DROP TABLE Fabricant;
DROP TABLE Pompier;
DROP TABLE Protege;

--#Pour supprimer l’attribut proche_caserne, on utilise la même commande que pour sa création mais cette fois-ci en utilisant la commande DROP 
ALTER TABLE Adresse DROP Proche_caserne;

DROP TABLE Caserne;
DROP TABLE Adresse;
DROP TABLE Ville;

--# Suppression du TYPE habitation;
DROP TYPE habitation;

--# Suppression du schéma
DROP SCHEMA casernes_de_pompiers;
