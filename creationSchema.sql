--#Création du schéma casernes_de_pompiers
CREATE SCHEMA casernes_de_pompiers;
--#Définir ce schéma comme chemin par défaut pour la session en cours
SET SCHEMA 'casernes_de_pompiers';

--#Création du type habitation avec comme valeurs ferme, HLM, pavillon et caserne
CREATE TYPE habitation AS ENUM ('ferme', 'HLM', 'pavillon', 'caserne');

--#Création de la table Ville
CREATE TABLE Ville(
    Nom_ville VARCHAR(20),
    CP INTEGER CHECK (CP>=1000 AND CP <=98890), --#On vérifie que notre code postal appartient bien à l’intervalle [1000,98890]
    Nb_hab INTEGER CHECK (Nb_hab>0) NOT NULL, --#On vérifie que le nombre d'habitants est différent de 0
    PRIMARY KEY (Nom_ville, CP)    --#On définit les clés primaires du tableau qui sont dans notre cas le nom de la ville et le code postal
);

--#Création de la table Adresse
CREATE TABLE Adresse(
    Num_rue INTEGER CHECK (Num_rue>0),
    Nom_rue VARCHAR (20),
    CP INTEGER NOT NULL,
    Nom_ville VARCHAR(20),
    Type_habitation habitation NOT NULL,
    Proche_caserne INTEGER,
    Km INTEGER,
    PRIMARY KEY (Num_rue, Nom_rue, Nom_ville, CP),
    FOREIGN KEY (Nom_ville, CP) REFERENCES Ville(Nom_ville, CP)
);

--#Création de la table Caserne
CREATE TABLE Caserne(
    Id_caserne INTEGER,
    capa_camions INTEGER CHECK (capa_camions>0),
    capa_pompiers INTEGER CHECK (capa_pompiers>0),
    Num_rue INTEGER,
    Nom_rue VARCHAR (20),
    CP INTEGER,
    Nom_ville VARCHAR(20),
    PRIMARY KEY (Id_caserne),
    FOREIGN KEY (Num_rue, Nom_rue, CP, Nom_ville) REFERENCES Adresse (Num_rue, Nom_rue, CP, Nom_ville)
);

--# On rajoute à la table Adresse une clé étrangère Proche_caserne dont ces valeurs sont issues des valeurs de l'attribut Id_caserne de la table Caserne
ALTER TABLE Adresse
ADD FOREIGN KEY (Proche_caserne) REFERENCES  Caserne (Id_caserne);

--#Création de la table Protège
CREATE TABLE Protege(
    Id_caserne INTEGER,
    CP INTEGER,
    Nom_ville VARCHAR(20),
    PRIMARY KEY (Id_caserne, CP, Nom_ville),
    FOREIGN KEY (Id_caserne) REFERENCES Caserne(Id_caserne),
    FOREIGN KEY (Nom_ville, CP) REFERENCES Ville(Nom_ville, CP)
);

--#Création de la table Pompier
CREATE TABLE Pompier(
    Id_caserne INTEGER,
    Id_pompier INTEGER,
    Nom VARCHAR (20) NOT NULL,
    Prenom VARCHAR (20) NOT NULL,
    Num_rue INTEGER,
    Nom_rue VARCHAR (20),
    CP INTEGER,
    Nom_ville VARCHAR(20),
    PRIMARY KEY (Id_caserne, Id_pompier),
    FOREIGN KEY (Id_caserne) REFERENCES Caserne(Id_caserne),
    FOREIGN KEY (Num_rue, Nom_rue, CP, Nom_ville) REFERENCES Adresse (Num_rue, Nom_rue, CP, Nom_ville)
);

--#Création de la table Fabricant
CREATE TABLE Fabricant(
    Nom_fabricant VARCHAR(20),
    Delai INTEGER,
    Num_rue INTEGER,
    Nom_rue VARCHAR (20),
    CP INTEGER,
    Nom_ville VARCHAR(20),
    PRIMARY KEY (Nom_fabricant),
    FOREIGN KEY (Num_rue, Nom_rue, CP, Nom_ville) REFERENCES Adresse (Num_rue, Nom_rue, CP, Nom_ville)
);

--#Création de la table Modèle
CREATE TABLE Modele(
    Nom_modele VARCHAR(20),
    Type_modele VARCHAR(20) NOT NULL,
    Motorisation VARCHAR(20) NOT NULL,
    Nom_fabricant VARCHAR(20) NOT NULL,
    PRIMARY KEY (Nom_modele),
    FOREIGN KEY (Nom_fabricant) REFERENCES Fabricant(Nom_fabricant)
);

--#Création de la table Camion
CREATE TABLE Camion(
    Id_caserne INTEGER,
    Id_camion INTEGER,
    Nb_places INTEGER NOT NULL,
    Modele VARCHAR(20) NOT NULL,
    PRIMARY KEY (Id_camion, Id_caserne),
    FOREIGN KEY (Id_caserne) REFERENCES Caserne(Id_caserne),
    FOREIGN KEY (modele) REFERENCES Modele(Nom_modele)
);
--#Création de la table Citerne
CREATE TABLE Citerne(
    Id_caserne INTEGER,
    Id_camion INTEGER,
    Contenance INTEGER NOT NULL,
    PRIMARY KEY (Id_caserne, Id_camion),
    FOREIGN KEY (Id_camion,Id_caserne) REFERENCES Camion(Id_camion,Id_caserne)
);
