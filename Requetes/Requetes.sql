
--Question 1 : Quelles sont les casernes protègeant à la fois Brignoles et Le Luc et où sont les casernes (on veut les casernes et la ville de ces casernes) ?--

SELECT P1.id_caserne, caserne.nom_ville
FROM protege P1, protege P2, caserne /*Duplication de la table*/
WHERE P1.id_caserne = caserne.id_caserne /*Le nom de la ville des casernes est différente de celle qu'elles protègent*/
	AND P2.id_caserne = caserne.id_caserne
	AND P1.nom_ville = 'Brignoles'
  	AND P2.nom_ville = 'Le Luc';

--Question 2 : Quels sont les pompiers (identifiants, noms, prenoms) de la caserne 3 habitant à plus de 5 kms d’une caserne ?--

SELECT Id_pompier,Pompier.Nom,Pompier.Prenom
FROM Pompier, Adresse
WHERE Pompier.Num_rue=Adresse.Num_rue
	AND Pompier.CP=Adresse.CP
	AND Pompier.Nom_ville=Adresse.Nom_ville /*Besoin de jointures sur nom, num_rue, nom_ville et CP, sinon insuffisant*/
	AND Pompier.Nom_rue=Adresse.Nom_rue
	AND Pompier.Id_caserne=3
	AND Adresse.Km>5;
	
--Question 3 : Quels sont les pompiers (identifiants, noms, prenoms) habitant Le Luc ou des villes ≥ 20 000 habitants ?--
		
SELECT Id_pompier,Pompier.Nom,Pompier.Prenom
FROM Pompier, Ville
WHERE Pompier.Nom_ville=Ville.Nom_ville
	AND (Ville.Nom_ville='Le Luc'
	OR Ville.Nb_hab>=20000);

--Question 4 : Quel est le délai moyen de livraison des fabricants de citernes de moins de 1000 litres ?--

SELECT AVG (Delai) AS "Délai moyen de livraison"
FROM Fabricant, Citerne, Modele, Camion
WHERE Fabricant.Nom_fabricant = Modele.Nom_fabricant /*Permet de faire le lien entre table Citerne et Fabricqnat*/
	AND Modele.Nom_modele = Camion.modele
	AND Camion.Id_caserne = Citerne.Id_caserne
	AND Camion.Id_camion = citerne.Id_camion
	AND Contenance < 1000;

--Question 5 : Classez par ordre décroissant le temps moyen de livraison de camions par caserne--

SELECT AVG(Delai) AS "Délai moyen de livraison des camions", Camion.Id_caserne
FROM Fabricant, Modele, Camion
WHERE Fabricant.Nom_fabricant=Modele.Nom_fabricant
	AND Modele.Nom_modele=Camion.modele
GROUP BY (Camion.Id_caserne)
ORDER BY AVG(Delai) DESC; /*ordre décroissant*/

--Question 6: Quel est le nombre de pompiers par caserne ?--

SELECT Pompier.Id_caserne, COUNT (*) AS "Nombre de pompiers par caserne"
FROM Pompier
GROUP BY Pompier.Id_caserne
ORDER BY Pompier.Id_caserne ASC; /*Pour un meilleur affichage*/

--Question 7 : Dans quelle(s) caserne(s) (id, ville) se trouve(nt) la (les) citerne(s) de plus grosse contenance?--

SELECT Caserne.Id_caserne,Caserne.Nom_ville
FROM Citerne,Caserne
WHERE Caserne.Id_caserne=Citerne.Id_caserne
	AND Citerne.contenance= (SELECT MAX(Contenance) FROM Citerne) /*sous-requête pour sélectionner les citernes ayant la plus grande contenance*/
GROUP BY (Caserne.Id_caserne);

--Question 8 : Quelles sont les casernes ayant atteint leur capacité maximale humaine ?--

SELECT caserne.id_caserne, COUNT(pompier.id_pompier) AS "nombre de pompiers", caserne.capa_pompiers AS "capacité max humaine"
FROM caserne, pompier
WHERE caserne.id_caserne = pompier.id_caserne
GROUP BY (caserne.id_caserne)
HAVING COUNT(pompier.id_pompier) = caserne.capa_pompiers;

--Question 9 : Quels sont les pompiers (id, nom, prenom) qui ne travaillent pas dans la ville où ils habitent? (affichez la ville d’habitation et la ville de travail)--

SELECT pompier.id_pompier, pompier.nom, pompier.prenom,pompier.nom_ville AS "habite à", caserne.nom_ville AS "travaille à"
FROM Caserne,Pompier
WHERE Pompier.Id_caserne = Caserne.id_caserne
	AND Pompier.Nom_Ville != Caserne.Nom_ville;

--Question 10: Listez par ordre décroissant les casernes en fonction du nombre de pompiers y travaillant--

SELECT Pompier.Id_caserne, Count(*) as "Nombre de pompiers par caserne"
FROM Pompier
GROUP BY (Pompier.Id_caserne)
ORDER BY COUNT(*) DESC;

--Question 11: Quelle est la première caserne de la liste précedente ?--

SELECT Pompier.Id_caserne
FROM Pompier
GROUP BY (Pompier.Id_caserne)
ORDER BY COUNT(*) DESC
LIMIT 1;  /*commande qui permet de prendre le TOP 1 d'une liste*/

--Question 12: Donnez pour chaque caserne le volume total d’eau de ses citernes-- 

SELECT Caserne.Id_caserne, SUM (citerne.contenance) AS "Volume d eau total"
FROM Caserne,Citerne
WHERE Citerne.Id_caserne = Caserne.Id_caserne
GROUP BY Caserne.Id_caserne
ORDER BY Caserne.Id_caserne; 

--Question 13 : Quelles sont les casernes sans citerne?--

SELECT Id_caserne
FROM Caserne
EXCEPT
SELECT Caserne.Id_caserne
FROM Citerne, Caserne
WHERE Citerne.Id_caserne = Caserne.Id_caserne; 
/*Selectionne toutes les casernes avec la première requête et on enlève les casernes ayant des citernes, afin d obtenir les casernes sans citernes*/

--Question 14 : Quelles villes sont protégées par au moins deux casernes?--

SELECT DISTINCT(C1.nom_ville)
FROM caserne C1, caserne C2, protege
WHERE C1.id_caserne = C2.Id_caserne
	AND C1.nom_ville = C2.nom_ville
	AND C1.nom_ville = protege.nom_ville;

--Question 15: Quelle est en moyenne le nombre d’habitants des villes protégées par des casernes de plus de deux camions?--

SELECT AVG(nb_hab) AS "Nombre d’habitants moyen"
FROM
	(SELECT Ville.Nb_hab
	FROM Ville,Protege,Caserne,Camion
	WHERE Ville.Nom_ville=Protege.Nom_ville
		AND Ville.CP=Protege.CP
		AND Protege.Id_caserne=Caserne.Id_caserne
		AND Camion.Id_caserne=Caserne.Id_caserne
		GROUP BY (Ville.Nb_hab)
		HAVING COUNT(Camion.Id_camion)>2)  AS "nb_hab";
/*on a créé une sous-requête nommée nb_hab qui correspond au nombre d’habitants des villes protégées par des casernes de plus de 2 camions.
On a ensuite sélectionné la moyenne du nombre d’habitants de cette sous-requête*/


