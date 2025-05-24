CREATE DATABASE billeterie;
USE billeterie;

CREATE TABLE utilisateurs (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nom VARCHAR(100),
  email VARCHAR(100)UNIQUE,
  mot_de_passe varchar(225),
  date_inscription DATE
);
CREATE TABLE evenements (
  id INT PRIMARY KEY AUTO_INCREMENT,
  titre VARCHAR(200),
  lieu  VARCHAR(100),
  date_evenement DATE,
  places_disponibles INT
);
CREATE TABLE organisations (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nom VARCHAR(100),
  contact VARCHAR(100),
  date_inscription DATE
  );

INSERT INTO utilisateurs (nom, email, mot_de_passe, date_inscription)
VALUES  ('Abdoul Aziz','diomandesegbeabdoulaziz1@gmail.com','Alpha225', CURDATE());
INSERT INTO utilisateurs (nom, email, mot_de_passe, date_inscription)
VALUES  ('Daouda Sidibe','dao@gmail.com','westaff23', CURDATE());
INSERT INTO utilisateurs (nom, email, mot_de_passe, date_inscription)
VALUES  ('fatima kone','astridk1@gmail.com','quennaz', CURDATE());
INSERT INTO evenements (titre, lieu, date_evenement, place_disponible)
VALUES  ('concert de DiDi B','Stade Felix Houphouet Boigni(Abidjan)','2025-07-27',15000, 500);
ALTER TABLE evenements ADD prix INT;
INSERT INTO evenements (titre, lieu, date_evenement, place_disponible)
VALUES  ('HAPPY RUN','Place Jean Paul 2(Yakro)','2025-07-05',3000, 200);
INSERT INTO evenements (titre, lieu, date_evenement, place_disponible)
VALUES  ('concert de HIMRA','Parc des Expositions(Abidjan','2025-12-24',8000, 300);
INSERT INTO organisations (nom, contact, date_inscription)
VALUES  ('Z-event','+90 534 319 87 14','14-05-2025');
SELECT * FROM utilisateurs;
SELECT * FROM evenements;

UPDATE evenements SET lieu = 'Stade_de_yakro' WHERE id = 2;
DELETE FROM utilisateurs WHERE email = 'astridk1@gmail.com';
CREATE TABLE commandes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  utilisateur_id INT,
  date_commande DATE,
 FOREIGN KEY  ( utilisateur_id) REFERENCES utilisateurs(id)
);
CREATE TABLE  billets (
id INT PRIMARY KEY AUTO_INCREMENT,
commande_id INT,
evenement_id INT,
quantite INT,
FOREIGN KEY (commande_id) REFERENCES commandes(id),
FOREIGN KEY (evenement_id) REFERENCES evenements(id)
);
SELECT u.nom, e.titre, b.quantite
FROM utilisateurs u 
JOIN commandes c ON u.id = c.utilisateur_id
JOIN billets b ON c.id = b.commande_id
JOIN evenements e ON b.evenement_id = e.id;
SELECT SUM(quantite) FROM billets;
SELECT * FROM evenements WHERE date_evenement BETWEEN '2025-07-01' AND '2025-12-30';
SELECT utilisateur_id, COUNT(*) AS nb_commandes FROM commandes GROUP BY utilisateur_id;

CREATE VIEW evenements_disponibles AS
SELECT * FROM evenements WHERE places_disponibles > 0;
CREATE INDEX idx_utilisateur_nom ON utilisateurs(nom);
ALTER TABLE billets
ADD CONSTRAINT check_quantite CHECK (quantite > 0);

START TRANSACTION;
UPDATE evenements SET places_disponibles = places_disponibles - 2 WHERE id = 1;
INSERT INTO commandes (utilisateur_id, date_commande) VALUES (1, CURDATE());
SET @commande_id = LAST_INSERT_ID();
INSERT INTO billets (commande_id, evenement_id, quantite) VALUES (@commande_id, 1, 2);
COMMIT;




  
  



