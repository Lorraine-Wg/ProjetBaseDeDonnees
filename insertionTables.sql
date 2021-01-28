-- #Insertion de valeurs dans la table Ville --
INSERT INTO Ville VALUES ('Paris 10e', 75010, 90000); /*Ville de la 1ère caserne*/
INSERT INTO Ville VALUES ('Paris 19e', 75019, 180000); /*Ville du Pompier id_pompier 367*/
INSERT INTO Ville VALUES ('Ivry-sur-Seine', 94205, 50000); /*Ville du fabricant Renault*/
INSERT INTO Ville VALUES ('Paris 17e', 75017, 160000); /*Pour le 1er exemple d’insertion non respectueuse*/
INSERT INTO Ville VALUES ('Paris 16e', 75016, 140000); /*Ville du fabricant Citroen*/
INSERT INTO Ville VALUES ('Villejuif', 94800, 50000); /*Ville de la caserne 2*/

-- #Insertion de valeurs dans la table Adresse --
INSERT INTO Adresse VALUES (30, 'rue de la paix', 75010, 'Paris 10e', 'caserne', NULL, 0); /*Adresse de la 1ère caserne*/
INSERT INTO Adresse VALUES (12, 'boulevard Massena', 75019, 'Paris 19e', 'HLM', NULL, 4); /*Adresse du Pompier id_pompier 367*/
INSERT INTO Adresse VALUES (39, 'Rue Saint-Didier', 75016, 'Paris 16e', 'ferme', NULL, 5); /*Adresse du fabricant Renault*/
INSERT INTO Adresse VALUES (24, 'avenue de la gare', 75017, 'Paris 17e', 'caserne', NULL, 3);  /*Pour le 1er exemple d’insertion non respectueuse*/
INSERT INTO Adresse VALUES (46, 'avenue Charles Foix', 94205, 'Ivry-sur-Seine', 'ferme', NULL, 16); /*Adresse du fabricant citroen*/
INSERT INTO Adresse VALUES (144, 'Boulevard Grenelle', 94800, 'Villejuif', 'caserne', NULL, 18); /*Adresse de la caserne 2*/

-- #Insertion de valeurs dans la table Caserne --
INSERT INTO Caserne VALUES (1, 2, 10, 30, 'rue de la paix', 75010, 'Paris 10e');
INSERT INTO Caserne VALUES (4, 2, 10, 30, 'rue de la paix', 75010, 'Paris 10e'); --#Cette insertion est utilisée pour faire un exemple d'insertion non respectueuse dans la table Protege
INSERT INTO Caserne VALUES (2, 5, 15, 144, 'Boulevard Grenelle', 94800, 'Villejuif');

--#Après création des tables Adresse et Caserne, on peut ajouter les valeurs de l'attribut Proche_caserne
UPDATE Adresse SET Proche_caserne = 1 WHERE Km <= 10;
UPDATE Adresse SET Proche_caserne = 2 WHERE Km >= 10;

-- #Insertion de valeurs dans la table Protege --
INSERT INTO Protege VALUES (1, 75010,'Paris 10e');
INSERT INTO Protege VALUES (2, 94800, 'Villejuif');

-- #Insertion de valeurs dans la table Pompier --
INSERT INTO Pompier VALUES (1, 367, 'Dupont', 'Jean', 12, 'boulevard Massena', 75019, 'Paris 19e');
INSERT INTO Pompier VALUES (4, 600, '' , 'Nicolas', 12, 'boulevard Massena', 75019, 'Paris 19e');

-- #Insertion de valeurs dans la table Fabricant --
INSERT INTO Fabricant VALUES ('Renault', NULL, 39, 'Rue Saint-Didier', 75016, 'Paris 16e');
INSERT INTO Fabricant VALUES ('Citroen', 3, 46, 'avenue Charles Foix', 94205, 'Ivry-sur-Seine');

-- #Insertion de valeurs dans la table Modele --
INSERT INTO Modele VALUES ('Premium210', 'lourd', '210hp', 'Renault');
INSERT INTO Modele VALUES ('U55', 'lourd', '73ch', 'Citroen');

-- #Insertion de valeurs dans la table Camion --
INSERT INTO Camion VALUES (1, 5, 12, 'Premium210');
INSERT INTO Camion VALUES (2, 3, 10, 'U55');

-- #Insertion de valeurs dans la table Citerne --
INSERT INTO Citerne VALUES (1, 5, 50);
INSERT INTO Citerne VALUES (2, 3, 30);
