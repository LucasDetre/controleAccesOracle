/* CREATE ROLE R_INFORMATICIEN_ADMIN30;
GRANT SELECT ON Contact_ADMIN30 TO R_INFORMATICIEN_ADMIN30;
GRANT SELECT ON Calendrier_ADMIN30 TO R_INFORMATICIEN_ADMIN30;
GRANT SELECT ON Evenement_ADMIN30 TO R_INFORMATICIEN_ADMIN30;
GRANT UPDATE ON Contact_ADMIN30 TO R_INFORMATICIEN_ADMIN30;
GRANT INSERT, DELETE ON Calendrier_ADMIN30 TO R_INFORMATICIEN_ADMIN30;
GRANT INSERT ON Evenement_ADMIN30 TO R_INFORMATICIEN_ADMIN30; */

prompt "DOIT FONCTIONNER"

prompt "SELECT SUR TOUTES LES TABLES"
SELECT * FROM admin30.Contact_ADMIN30;
SELECT * FROM admin30.Evenement_ADMIN30;
SELECT * FROM admin30.Calendrier_ADMIN30;

prompt "MISE A JOUR CONTACT"
SELECT * FROM admin30.Contact WHERE id='USER2';
UPDATE Contact_ADMIN30 SET nom='SMITH' WHERE id='USER2';
SELECT * FROM admin30.Contact WHERE id='USER2';

prompt "INSERTION EVENEMENT"
INSERT INTO admin30.Evenement_ADMIN30 (id, id_createur, date_evenement, lieu, description)
VALUES (6,'USER2', CURRENT_TIMESTAMP, 'A distance', 'Demonstration TP SSI');
SELECT * FROM admin30.Evenement_ADMIN30 WHERE id=6;

prompt "INSERTION ET SUPPRESSION CALENDRIER"
SELECT * FROM admin30.Calendrier_ADMIN30 WHERE id_contact='USER3' AND id_evenement=1;
INSERT INTO admin30.Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER3', 1);
SELECT * FROM admin30.Calendrier_ADMIN30 WHERE id_contact='USER3' AND id_evenement=1;
DELETE FROM admin30.Calendrier_ADMIN30 WHERE id_contact='USER3' AND id_evenement=1;
SELECT * FROM admin30.Calendrier_ADMIN30 WHERE id_contact='USER3' AND id_evenement=1;
/*
SELECT * FROM admin30.Contact_ADMIN30 WHERE id='USER8' AND id_evenement=1;
INSERT INTO Contact_ADMIN30 (id, nom, prenom, telephone, courriel, categorie)
VALUES ('USER8', 'Testeur', 'Jean-Michel', 0777777777, 'mail8@gmail.com','Client');
SELECT * FROM admin30.Contact_ADMIN30 WHERE id='USER8'; */

prompt "DOIT NE PAS FONCTIONNER"