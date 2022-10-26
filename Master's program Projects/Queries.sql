-- Queries

--- Requête 1.  Quelles sont les casernes prot`egeant `a la fois Brignoles et Le Luc et o`u sont les casernes (on veutles casernes et la ville de ces casernes) ?

SELECT Caserne.id_caserne, Caserne.Nom_ville AS "Ville de la caserne"
FROM Protege, Caserne
WHERE Protege.id_caserne = Caserne.id_caserne
AND Protege.Nom_ville = 'Le Luc'
INTERSECT
SELECT Caserne.id_caserne, Caserne.Nom_ville AS "Ville de la caserne"
FROM Protege, Caserne
WHERE Protege.id_caserne = Caserne.id_caserne
AND Protege.Nom_ville = 'Brignoles';

--- Requête 2.  Quels sont les pompiers (identifiants,  noms,  prenoms) de la caserne 3 habitant `a plus de 5 kmsd’une caserne ?.

SELECT id_pompier, nom, Prenom
FROM pompier, adresse
WHERE pompier.Nom_rue=adresse.Nom_rue
  AND pompier.Num_rue=adresse.Num_rue
  AND pompier.CP=adresse.CP
  AND pompier.nom_ville=adresse.Nom_ville
  AND id_caserne=3
  AND km>5
;

--- Requête 3.  Quels  sont  les  pompiers  (identifiants,  noms,  prenoms)  habitant  Le  Luc  ou  des  villes≥20  000habitants ?

SELECT id_pompier, Nom, Prenom
FROM Pompier, Ville’
WHERE (Ville.Nb_hab >= 20000 OR Ville.Nom_ville = 'Le Luc')
AND Ville.Nom_ville = Pompier.Nom_ville
AND Ville.CP = Pompier.CP’’
;

--- Requête 4.  Quel est le d ́elai moyen de livraison des fabricants de citernes de moins de 1000 litres ?
--Commentaire : on a considéré qu'on voulait la moyenne non pondérée des délais de tous les fabricants pour la livraison de citerne de moins de 1000L.

SELECT AVG(Delai) AS "Délai livraison moyen"
FROM fabricant
WHERE fabricant.nom_fabricant IN (SELECT DISTINCT fabricant.Nom_fabricant
  FROM citerne, modele, camion, fabricant
  WHERE citerne.id_camion=camion.Id_camion
    AND camion.modele=modele.Nom_modele
    AND modele.nom_fabricant=fabricant.Nom_fabricant
    AND contenance < 1000)
;

--- Requête 5.  Classez par ordre d ́ecroissant le temps moyen de livraison de camions par caserne.

SELECT Caserne.id_caserne, AVG(Delai) AS "Delai de livraison moyen"
FROM Caserne, Camion, Modele, Fabricant
WHERE Fabricant.Nom_fabricant = Modele.Nom_Fabricant
AND Modele.Nom_modele = Camion.Modele
AND Camion.id_caserne = Caserne.id_caserne
GROUP BY Caserne.Id_caserne
ORDER BY AVG(Delai) DESC
;

--- Requête 6.  Quel est le nombre de pompiers par caserne ?

SELECT Caserne.id_caserne, COUNT(Pompier.id_caserne) AS "Nombre de pompier"
FROM Caserne, Pompier
WHERE Pompier.id_caserne = Caserne.id_caserne
GROUP BY Caserne.id_caserne
ORDER BY (Caserne.id_caserne) ASC
;

--- Requête 7.  Dans quelle(s) caserne(s) (id, ville) se trouve(nt) la (les) citerne(s) de plus grosse contenance?

SELECT Caserne.id_caserne, caserne.nom_ville AS "Ville de la caserne", Contenance
FROM Caserne, Citerne
WHERE Caserne.id_caserne = Citerne.id_caserne
AND Citerne.Contenance = (SELECT MAX(Contenance) FROM Citerne)
;

--- Requête 8.  Quelles sont les casernes ayant atteint leur capacit ́e maximale humaine ?

SELECT Caserne.id_caserne, COUNT(Pompier.id_caserne) AS "Nombre de pompiers"
FROM Caserne, Pompier
WHERE Caserne.id_caserne = Pompier.id_caserne
GROUP BY Caserne.id_caserne
HAVING COUNT(Pompier.id_caserne) = Caserne.Capa_pompiers
;

--- Requête 9.  Quels  sont  les  pompiers  (id,  nom,  prenom)  qui  ne  travaillent  pas  dans  la  ville  o`u  ils  habitent? (affichez la ville d’habitation et la ville de travail)

SELECT Pompier.id_pompier, Pompier.Nom, Pompier.Prenom, Pompier.Nom_ville AS "Ville du pompier", Caserne.Nom_ville as "Ville de la caserne"
FROM Pompier, Caserne
WHERE Pompier.id_caserne = Caserne.id_caserne
EXCEPT
SELECT Pompier.id_pompier, Pompier.Nom, Pompier.Prenom, Pompier.Nom_ville AS "Ville du pompier", Caserne.Nom_ville as "Ville de la caserne"
FROM Caserne, Pompier
WHERE Pompier.Nom_ville = Caserne.Nom_ville
;

--- Requête 10.  Listez par ordre d ́ecroissant les casernes en fonction du nombre de pompiers y travaillant.

SELECT caserne.id_caserne, COUNT(id_pompier) AS "Nombre de pompiers"
FROM pompier, caserne
WHERE caserne.id_caserne=pompier.id_caserne
GROUP BY (caserne.id_caserne)
ORDER BY COUNT(id_pompier) DESC
;

--- Requête 11.  Quelle est la premi`ere caserne de la liste pr ́ecedente ?

SELECT caserne.id_caserne, COUNT(id_pompier) AS "Nombre de pompiers"
FROM pompier, caserne
WHERE caserne.id_caserne=pompier.id_caserne
GROUP BY (caserne.id_caserne)
ORDER BY COUNT(id_pompier) DESC
LIMIT 1
;

--- Requête 12.  Donnez pour chaque caserne le volume total d’eau de ses citernes.

SELECT citerne.id_caserne, SUM(contenance) AS "Volume total d'eau des citernes"
FROM citerne
GROUP BY (citerne.id_caserne)
ORDER BY citerne.id_caserne ASC
;

--- Requête 13.  Quelles sont les casernes sans citerne?

SELECT Caserne.id_caserne AS "Caserne sans citerne"
FROM Caserne
EXCEPT
SELECT Caserne.id_caserne
FROM Citerne, Caserne
WHERE Caserne.id_caserne = Citerne.id_caserne
;

--- Requête 14.  Quelles villes sont prot ́eg ́ees par au moins deux casernes?

SELECT Protege.Nom_ville, Protege.CP
FROM Protege
GROUP BY Protege.Nom_ville, Protege.CP
HAVING COUNT(id_caserne) > 1
;

--- Requête 15.  Quelle est en moyenne le nombre d’habitants des villes prot ́eg ́ees par des casernes de plus de deux camions?

SELECT AVG(Ville.Nb_hab)
FROM Ville
WHERE (Ville.nom_ville,Ville.CP) IN (SELECT DISTINCT Ville.nom_ville,Ville.CP
    FROM Ville , Protege, Camion
    WHERE Ville.Nom_ville = Protege.Nom_ville
      AND Ville.CP=Protege.CP
      AND Protege.id_caserne= Camion.id_caserne
    GROUP BY Protege.id_caserne, Ville.CP, Ville.Nom_ville
    HAVING COUNT(camion.id_caserne)>2)
;
