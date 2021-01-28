--#Quelques insertions non respectueuses

--#Création d’une insertion avec non-respect d'une cle primaire --
INSERT INTO Caserne VALUES (1, 1, 7, 24, 'avenue de la gare', 75017, 'Paris 17e'); /*Il existe déjà une caserne avec pour clé primaire Id_caserne = 1. La clé primaire étant unique, il n’est pas possible d’avoir pour deux casernes la même valeur d’Id_caserne*/

--#Création d’une insertion avec non-respect d'une cle etrangere --
INSERT INTO Camion VALUES (27, 5, 14, 'Premium210'); /*La table camion a pour clé étrangère l’attribut Id_Caserne qui renvoie à l’Id_caserne de la table de référence Caserne. L’Id_caserne = 27 ne correspond à aucune Id_caserne que nous avons créé précédemment*/

--#Création d’une insertion avec non-respect d'une autre contrainte d'integrite (format de l'attribut, not null...) --
INSERT INTO Ville VALUES ('Arcueil', 998, 19000); /*Le code postal 998 n’est pas compris entre 1000 et 98890 et ne respecte donc pas la contrainte d’intégrité imposée par la commande CHECK sur l’attribut code postal dans la table Ville*/
