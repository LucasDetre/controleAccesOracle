-- Test Contexte
EXECUTE admin30.set_cal_ctx_pkg_admin30.set_cal;
SELECT SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE') FROM DUAL;

prompt "******************************************************"
prompt "*******************DOIT FONCTIONNER*******************"
prompt "******************************************************"

    prompt "SELECT SUR TOUTES LES TABLES"

        prompt "Résultat attendu : 7 lignes : tous les contacts"
        SELECT * FROM admin30.Contact_ADMIN30;
        prompt "Résultat attendu : 5 lignes : tous les événements"
        SELECT * FROM admin30.Evenement_ADMIN30;
        prompt "Résultat attendu : 18 lignes : tous les calendriers"
        SELECT * FROM admin30.Calendrier_ADMIN30;

    prompt "INSERTION, SUPPRESSION, MISE A JOUR Contact"

        SELECT * FROM admin30.Contact_ADMIN30 WHERE id='USER8';
        INSERT INTO admin30.Contact_ADMIN30 (id, nom, prenom, telephone, courriel, categorie) VALUES ('USER8', 'Testeur', 'Jean-Michel', 0777777777, 'test@gmail.com','Client');
        SELECT * FROM admin30.Contact_ADMIN30 WHERE id='USER8';

        DELETE FROM admin30.Contact_ADMIN30 WHERE id_contact='USER8';
        SELECT * FROM admin30.Contact_ADMIN30 WHERE id='USER8';

        SELECT * FROM admin30.Contact_ADMIN30 WHERE id='USER2';
        UPDATE admin30.Contact_ADMIN30 SET nom='SMITH' WHERE id='USER2';
        SELECT * FROM admin30.Contact_ADMIN30 WHERE id='USER2';

    prompt "INSERTION, SUPPRESSION, MISE A JOUR Evenement"


        SELECT * FROM admin30.Evenement_ADMIN30 WHERE id=6;
        INSERT INTO admin30.Evenement_ADMIN30 (id, id_createur, date_evenement, lieu, description) VALUES (6,'USER2', CURRENT_TIMESTAMP, 'A distance', 'Demonstration TP SSI');
        SELECT * FROM admin30.Evenement_ADMIN30 WHERE id=6;

        DELETE FROM admin30.Evenement_ADMIN30 WHERE id=6;
        SELECT * FROM admin30.Evenement_ADMIN30 WHERE id=6;

        SELECT * FROM admin30.Evenement_ADMIN30 WHERE id=3;
        UPDATE admin30.Evenement_ADMIN30 SET lieu='Salle de réunion C' WHERE id=3;
        SELECT * FROM admin30.Evenement_ADMIN30 WHERE id=3;

    prompt "INSERTION, SUPPRESSION, MISE A JOUR Calendrier"

        SELECT * FROM admin30.Calendrier_ADMIN30 WHERE id_contact='USER3' AND id_evenement=1;
        INSERT INTO admin30.Calendrier_ADMIN30 (id_contact, id_evenement) VALUES ('USER3', 1);
        SELECT * FROM admin30.Calendrier_ADMIN30 WHERE id_contact='USER3' AND id_evenement=1;
        DELETE FROM admin30.Calendrier_ADMIN30 WHERE id_contact='USER3' AND id_evenement=1;
        SELECT * FROM admin30.Calendrier_ADMIN30 WHERE id_contact='USER3' AND id_evenement=1;

        prompt "On change l'utilisateur 3 d'événement depuis l'évenement 4 vers l'évenement 1"
        SELECT * FROM admin30.Calendrier_ADMIN30  WHERE id_contact='USER3' AND id_evenement=1;
        SELECT * FROM admin30.Calendrier_ADMIN30  WHERE id_contact='USER3' AND id_evenement=4;
        UPDATE admin30.Calendrier_ADMIN30 SET id_evenement=1 WHERE id='USER3'  AND id_evenement=4;
        SELECT * FROM admin30.Calendrier_ADMIN30  WHERE id_contact='USER3' AND id_evenement=1;
        SELECT * FROM admin30.Calendrier_ADMIN30  WHERE id_contact='USER3' AND id_evenement=4;

ROLLBACK;
