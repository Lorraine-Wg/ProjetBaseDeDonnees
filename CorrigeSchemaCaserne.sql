--#Création du schéma casernes_de_pompiers
CREATE SCHEMA casernes_de_pompiers;
--#Définir ce schéma comme chemin par défaut pour la session en cours
SET SCHEMA 'casernes_de_pompiers';

--Creation des tables
CREATE TYPE habitation AS ENUM ('Caserne', 'Ferme', 'HLM', 'Pavillon');

CREATE TABLE Caserne(
    Id_caserne 			INTEGER		,
    Capa_camions 		INTEGER		CHECK (Capa_camions > 0),
    Capa_pompiers		INTEGER		CHECK (Capa_pompiers > 0),
    Num_rue 			INTEGER		,
    Nom_rue 			VARCHAR(20)	,
    CP 					INTEGER		,
    Nom_ville 			VARCHAR(20)	,
    PRIMARY KEY(Id_caserne)
);


CREATE TABLE Ville(
    Nom_ville 			VARCHAR(20)	,
    CP 					INTEGER		CHECK (CP > 1000 AND CP < 98890),
    Nb_hab 				INTEGER		CHECK (Nb_hab > 0) NOT NULL,
    PRIMARY KEY(Nom_ville,CP)
);


CREATE TABLE Adresse(
    Num_rue 			INTEGER		,
    Nom_rue 			VARCHAR(20)	,
    CP 					INTEGER		,
    Nom_ville 			VARCHAR(20)	,
    Type_habitation		VARCHAR(20)	NOT NULL,
    Proche_caserne		INTEGER		,
    Km					INTEGER		,
    PRIMARY KEY(Nom_rue,Num_rue,Nom_ville,CP),
    FOREIGN KEY(Nom_ville,CP) REFERENCES Ville(Nom_ville,CP),
    FOREIGN KEY(Proche_caserne) REFERENCES Caserne(Id_caserne)
);


--ajouter la cle etrangere dans la caserne (reference circulaire)
ALTER TABLE Caserne
ADD CONSTRAINT caserne_fkey FOREIGN KEY(Nom_rue,Num_rue,Nom_ville,CP) REFERENCES Adresse(Nom_rue,Num_rue,Nom_ville,CP);


CREATE TABLE Protege(
    Id_caserne			INTEGER		,
    Nom_ville			VARCHAR(20)	,
    CP					INTEGER		,
    PRIMARY KEY(Id_caserne,Nom_ville,CP),
    FOREIGN KEY(Nom_ville,CP) REFERENCES Ville(Nom_ville,CP),
    FOREIGN KEY(Id_caserne) REFERENCES Caserne(Id_caserne)
);

CREATE TABLE Fabricant(
    Nom_fabricant		VARCHAR(20)	,
    Delai				INTEGER		,
    Num_rue				INTEGER		,
    Nom_rue				VARCHAR(20)	,
    CP					INTEGER		,
    Nom_ville			VARCHAR(20)	,
    PRIMARY KEY(Nom_fabricant),
    FOREIGN KEY(Num_rue,Nom_rue,Nom_ville,CP) REFERENCES Adresse(Num_rue,Nom_rue,Nom_ville,CP)
);


CREATE TABLE Modele(
    Nom_modele			VARCHAR(20)	,
    Type_modele			VARCHAR(20)	NOT NULL,
    Motorisation		VARCHAR(20)	NOT NULL,
    Nom_fabricant		VARCHAR(20)	NOT NULL,
    PRIMARY KEY(Nom_modele),
    FOREIGN KEY(Nom_fabricant) REFERENCES Fabricant(Nom_fabricant)
);


CREATE TABLE Pompier(
    Id_caserne		INTEGER		,
    Id_pompier		INTEGER		,
    Nom				VARCHAR(20) NOT NULL,
    Prenom			VARCHAR(20) NOT NULL,
    Nom_rue			VARCHAR(20)	,
    Num_rue			INTEGER		,
    Nom_ville		VARCHAR(20)	,
    CP				INTEGER		,
    PRIMARY KEY(Id_caserne,Id_pompier),
    FOREIGN KEY(Id_caserne) REFERENCES Caserne(Id_caserne),
    FOREIGN KEY(Nom_rue,Num_rue,NOM_ville,CP) REFERENCES Adresse(Nom_rue,Num_rue,Nom_ville,CP)
);


CREATE TABLE Camion(
    Id_caserne		INTEGER		,
    Id_camion		INTEGER		,
    Nb_places		INTEGER		NOT NULL,
    Modele			VARCHAR(20) NOT NULL,
    PRIMARY KEY(Id_caserne,Id_camion),
    FOREIGN KEY(Id_caserne) REFERENCES Caserne(Id_caserne),
    FOREIGN KEY(Modele) REFERENCES Modele(Nom_modele)
);


CREATE TABLE Citerne(
    Id_caserne		INTEGER		,
    Id_camion		INTEGER		,
    Contenance		INTEGER		NOT NULL,
    PRIMARY KEY(Id_caserne,Id_camion),
    FOREIGN KEY(Id_caserne,Id_camion) REFERENCES Camion(Id_caserne,Id_camion)
);
