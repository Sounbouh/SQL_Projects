-- Insert into tables

-- #Insertion de deux données dans la table Ville

INSERT INTO Ville
VALUES('Longjumeau', 91160, 25000);
INSERT INTO Ville
VALUES('Palaiseau', 91120, 30000);

-- #Insertion de deux données dans la table Adresse

INSERT INTO Adresse
VALUES (12, 'Square Patricia', 91120, 'Palaiseau', 'Pavillon', NULL, 12);
INSERT INTO Adresse
VALUES(22, 'Rue de Yvette', 91160, 'Longjumeau', 'HLM', NULL, 6);

-- #Insertion de deux données dans la table Caserne

INSERT INTO Caserne
VALUES (1, 55, 67, 12, 'Square Patricia', 91120, 'Palaiseau');
INSERT INTO Caserne
VALUES (2, 80, 99, 22, 'Rue de Yvette', 91160, 'Longjumeau');

-- #Insertion de deux données dans la table Protege

INSERT INTO Protege
VALUES (1, 'Palaiseau', 91120);
INSERT INTO Protege
VALUES(2, 'Longjumeau', 91160);

-- #Insertion de deux données dans la table Pompier

INSERT INTO Pompier
VALUES(1, 78, 'Willis', 'Bruce', 'Square Patricia', 12, 'Palaiseau', 91120);
INSERT INTO Pompier
VALUES(2, 89, 'Depp', 'Johnny', 'Rue de Yvette', 22, 'Longjumeau', 91160);

-- #Insertion de deux données dans la table Fabricant

INSERT INTO Fabricant
VALUES ('Pierrot', 7, 22, 'Rue de Yvette', 91160, 'Longjumeau');
INSERT INTO Fabricant
VALUES ('Mecano Riot', 9, 12, 'Square Patricia', 91120, 'Palaiseau');

-- #Insertion de deux données dans la table Modele

INSERT INTO Modele
VALUES ('Pompus3000', 'lourd', 'Diesel', 'Pierrot');
INSERT INTO Modele
VALUES ('ArrosaxV2', 'leger', 'Essence', 'Mecano Riot');

-- #Insertion de deux données dans la table Camion

INSERT INTO Camion
VALUES (1, 1996, 8, 'Pompus3000');
INSERT INTO Camion
VALUES (2, 1997, 5, 'ArrosaxV2');

-- #Insertion de deux données dans la table Citerne

INSERT INTO Citerne
VALUES (1, 1996, 15000);
-- #Insertion de deux données dans la table
INSERT INTO Citerne
VALUES (2, 1997, 5000);

-- #Insertion avec non-respect de la clé primaire

INSERT INTO Ville(Nom_ville, CP)
VALUES('Palaiseau', 91300);
INSERT INTO Ville(Nom_ville, CP)
VALUES('Palaiseau', 91120);

-- #Insertion avec non-respect de la clé étrangère

INSERT INTO Citerne(Id_caserne, Id_camion)
VALUES(1, 1997);

-- #insertion avec non-respect d’une autre contrainte d’intégrité

INSERT INTO Ville
VALUES('Palaiseau', 23, 3445);
