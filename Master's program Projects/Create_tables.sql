--------------------------------------------------------------------------------
------------------------------- Create tables  ---------------------------------
--------------------------------------------------------------------------------

--#Création du schéma
CREATE SCHEMA Caserne_pompier;

--#Définition du schéma comme chemin par défaut
SET SCHEMA 'Caserne_pompier';

--#Création du type habitation
CREATE TYPE Type_habitation AS ENUM('Caserne', 'Ferme', 'HLM','Pavillon');

--#Création de la relation Ville
CREATE TABLE Ville(
Nom_ville VARCHAR(20),
CP INT CHECK(CP>999 AND CP<98889),
Nb_hab INT CHECK(Nb_hab>0),
PRIMARY KEY(Nom_ville, CP));

--#Création de la relation Adresse
CREATE TABLE Adresse(
Num_rue INT CHECK(Num_rue>0),
Nom_rue VARCHAR(20),
CP INT CHECK(CP>999 AND cp<98889),
Nom_ville VARCHAR(20),
Type_habitation VARCHAR,
Proche_caserne INTEGER,
Km INTEGER,
PRIMARY KEY(Num_rue, Nom_rue, CP, Nom_ville),
FOREIGN KEY(Nom_ville, CP) REFERENCES Ville(Nom_Ville, CP));

--#Création de la relation Caserne
CREATE TABLE Caserne(
Id_caserne INTEGER,
Capa_camion INT CHECK(Capa_camion>0) NOT NULL,
Capa_pompier INT CHECK(Capa_pompier>0) NOT NULL,
Num_rue INTEGER CHECK(Num_rue>0),
Nom_rue VARCHAR(20),
CP INT CHECK(CP>999 AND CP<98889),
Nom_ville VARCHAR(20),
PRIMARY KEY(Id_caserne),
FOREIGN KEY(Num_rue, Nom_rue, CP, Nom_ville) REFERENCES Adresse(Num_rue, Nom_rue, CP, Nom_ville));

--#Ajout de la clé étrangère
ALTER TABLE Adresse
ADD FOREIGN KEY(Proche_caserne) REFERENCES Caserne(Id_caserne);

--#Création de la relation Protege
CREATE TABLE Protege(
Id_caserne INTEGER,
Nom_ville VARCHAR(20),
CP INTEGER,
PRIMARY KEY(Id_caserne, Nom_ville, CP),
FOREIGN KEY(Id_caserne) REFERENCES Caserne(Id_caserne),
FOREIGN KEY(Nom_Ville, CP) REFERENCES Ville(Nom_Ville, CP));

--#Création de la relation Pompier
CREATE TABLE Pompier(
Id_caserne INTEGER,
Id_pompier INTEGER,
Nom VARCHAR(20),
Prenom VARCHAR(20),
Nom_rue VARCHAR(20),
Num_rue INTEGER,
Nom_ville VARCHAR(20),
CP INTEGER,
PRIMARY KEY(Id_caserne, Id_pompier),
FOREIGN KEY(Num_rue, Nom_rue, CP, Nom_ville) REFERENCES Adresse(Num_rue, Nom_rue, CP, Nom_ville));

--#Création de la relation Fabricant
CREATE TABLE Fabricant(
Nom_fabricant VARCHAR(20),
Delai INTEGER,
Num_rue INTEGER,
Nom_rue VARCHAR(20),
CP INTEGER,
Nom_ville VARCHAR(20),
PRIMARY KEY(Nom_fabricant),
FOREIGN KEY(Num_rue, Nom_rue, CP, Nom_ville) REFERENCES Adresse(Num_rue, Nom_rue, CP, Nom_ville));

--#Création de la relation Modele
CREATE TABLE Modele(
Nom_modele VARCHAR(20),
Type_modele VARCHAR(20),
Motorisation VARCHAR(20),
Nom_fabricant VARCHAR(20),
PRIMARY KEY(Nom_modele),
FOREIGN KEY(Nom_fabricant) REFERENCES Fabricant(Nom_fabricant));

--#Création de la relation Camion
CREATE TABLE Camion(
Id_caserne INTEGER,
Id_camion INTEGER,
Nb_places INTEGER,
Modele VARCHAR(20),
PRIMARY KEY(Id_caserne, Id_camion),
FOREIGN KEY(Id_caserne) REFERENCES Caserne(Id_caserne),
FOREIGN KEY(Modele) REFERENCES Modele(Nom_modele));

--#Création de la relation Citerne
CREATE TABLE Citerne(
Id_caserne INTEGER,
Id_camion INTEGER,
Contenance INTEGER NOT NULL,
PRIMARY KEY(Id_caserne, Id_camion),
FOREIGN KEY(Id_caserne, Id_camion) REFERENCES Camion(Id_caserne, Id_camion));
