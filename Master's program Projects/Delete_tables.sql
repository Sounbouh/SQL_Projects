--- Delete tables ---

--#Suppression de la table Citerne

DROP TABLE Citerne;

--#Suppression de la table Camion

DROP TABLE Camion;

--#Suppression de la table Modele

DROP TABLE Modele ;

--#Suppression de la table Fabricant

DROP TABLE Fabricant ;

--#Suppression de la table Pompier

DROP TABLE Pompier;

--#Suppression de la clé étrangère
ALTER TABLE Adresse DROP Proche_caserne;

--#Suppression de la table Protege

DROP TABLE Protege ;

--#Suppression de la table Caserne

DROP TABLE Caserne ;

--#Suppression de la table Adresse

DROP TABLE Adresse ;

--#Suppression de la table Ville

DROP TABLE Ville ;

--#Suppression du type

DROP TYPE Type_habitation;

--#Suppression du schéma caserne_pompier

DROP SCHEMA projetbd;
