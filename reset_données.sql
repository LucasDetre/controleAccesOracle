prompt "ON VIDE TOUTES LES TABLES"

TRUNCATE TABLE admin30.Calendrier_ADMIN30;
TRUNCATE TABLE admin30.Contact_ADMIN30;
TRUNCATE TABLE admin30.Evenement_ADMIN30;

prompt "ON RÉGENERE LA TABLE CONTACT"

INSERT INTO Contact_ADMIN30 (id, nom, prenom, telephone, courriel, categorie)
VALUES ('USER1', 'Henaff', 'Maxime', 0611111111, 'mail1@gmail.com','Informaticien');

INSERT INTO Contact_ADMIN30 (id, nom, prenom, telephone, courriel, categorie)
VALUES ('USER2', 'Detre', 'Lucas', 0722222222, 'mail2@gmail.com','Informaticien');

INSERT INTO Contact_ADMIN30 (id, nom, prenom, telephone, courriel, categorie)
VALUES ('USER3', 'Zidane', 'Zinedine', 0633333333, 'mail3@gmail.com','Client');

INSERT INTO Contact_ADMIN30 (id, nom, prenom, telephone, courriel, categorie)
VALUES ('USER4', 'Hallyday', 'Johnny', 0644444444, 'mail4@gmail.com','Client');

INSERT INTO Contact_ADMIN30 (id, nom, prenom, telephone, courriel, categorie)
VALUES ('USER5', 'Hollande', 'François', 0655555555, 'mail5@gmail.com','Commercial');

INSERT INTO Contact_ADMIN30 (id, nom, prenom, telephone, courriel, categorie)
VALUES ('USER6', 'Depardieu', 'Gérard', 0766666666, 'mail6@gmail.com','Commercial');

INSERT INTO Contact_ADMIN30 (id, nom, prenom, telephone, courriel, categorie)
VALUES ('USER7', 'Dujardin', 'Jean', 0777777777, 'mail7@gmail.com','Client');

prompt "ON RÉGENERE LA TABLE EVENEMENT"

INSERT INTO Evenement_ADMIN30 (id, id_createur, date_evenement, lieu, description)
VALUES (1,'USER5', CURRENT_TIMESTAMP, 'Bureau 25', 'RDV MOE');

INSERT INTO Evenement_ADMIN30 (id, id_createur, date_evenement, lieu, description)
VALUES (2,'USER5', CURRENT_TIMESTAMP, 'Salle de conférence', 'RDV Suivi devis');

INSERT INTO Evenement_ADMIN30 (id, id_createur, date_evenement, lieu, description)
VALUES (3,'USER2', CURRENT_TIMESTAMP, 'Bureau A', 'RDV mensuel interne');

INSERT INTO Evenement_ADMIN30 (id, id_createur, date_evenement, lieu, description)
VALUES (4,'USER6', CURRENT_TIMESTAMP, 'Entreprise B', 'RDV Expression du besoin');

INSERT INTO Evenement_ADMIN30 (id, id_createur, date_evenement, lieu, description)
VALUES (5,'USER1', CURRENT_TIMESTAMP, 'Bureau 25', 'Pot de départ');

prompt "ON RÉGENERE LA TABLE CALENDRIER"

INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER1', 1);
INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER2', 1);

INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER4', 2);
INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER5', 2);
INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER6', 2);

INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER1', 3);
INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER2', 3);
INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER5', 3);
INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER6', 3);

INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER5', 4);
INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER3', 4);
INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER7', 4);

INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER1', 5);
INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER2', 5);
INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER3', 5);
INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER4', 5);
INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER5', 5);
INSERT INTO Calendrier_ADMIN30 (id_contact, id_evenement)
VALUES ('USER6', 5);