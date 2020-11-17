-- Test Contexte
EXECUTE admin30.set_cal_ctx_pkg_admin30.set_cal;
SELECT SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE') FROM DUAL;

prompt "******************************************************"
prompt "*******************DOIT FONCTIONNER*******************"
prompt "******************************************************"

    prompt "SELECT SUR TOUTES LES TABLES"
        SELECT * FROM admin30.Contact_ADMIN30;
        SELECT * FROM admin30.Evenement_ADMIN30;
        SELECT * FROM admin30.Calendrier_ADMIN30;

    prompt "INSERTION Contact"
        SELECT * FROM admin30.Contact_ADMIN30 WHERE id='USER8';
        INSERT INTO admin30.Contact_ADMIN30 (id, nom, prenom, telephone, courriel, categorie) VALUES ('USER8', 'Testeur', 'Jean-Michel', 0777777777, 'test@gmail.com','Client');
        SELECT * FROM admin30.Contact_ADMIN30 WHERE id='USER8';

    prompt "INSERTION Evenement"
        SELECT * FROM admin30.Evenement_ADMIN30 WHERE id=6;
        INSERT INTO admin30.Evenement_ADMIN30 (id, id_createur, date_evenement, lieu, description) VALUES (6,'USER2', CURRENT_TIMESTAMP, 'A distance', 'Demonstration TP SSI');
        SELECT * FROM admin30.Evenement_ADMIN30 WHERE id=6;

    prompt "INSERTION ET SUPPRESSION Calendrier"
        SELECT * FROM admin30.Calendrier_ADMIN30 WHERE id_contact='USER3' AND id_evenement=1;
        INSERT INTO admin30.Calendrier_ADMIN30 (id_contact, id_evenement) VALUES ('USER3', 1);
        SELECT * FROM admin30.Calendrier_ADMIN30 WHERE id_contact='USER3' AND id_evenement=1;
        DELETE FROM admin30.Calendrier_ADMIN30 WHERE id_contact='USER3' AND id_evenement=1;
        SELECT * FROM admin30.Calendrier_ADMIN30 WHERE id_contact='USER3' AND id_evenement=1;

prompt "******************************************************"
prompt "****************DOIT NE PAS FONCTIONNER***************"
prompt "******************************************************"

    prompt "UPDATE, SUPPRESSION Contact"

        UPDATE Contact_ADMIN30 SET nom='SMITH' WHERE id='USER2';
        DELETE FROM admin30.Contact_ADMIN30 WHERE id_contact='USER8';

    prompt "UPDATE, SUPPRESSION Evenement"

        UPDATE Contact_ADMIN30 SET lieu='Salle de réunion C' WHERE id=3;
        DELETE FROM admin30.Evenement_ADMIN30 WHERE id=6;

    prompt "UPDATE, Calendrier"

        UPDATE Contact_ADMIN30 SET id_evenement=1 WHERE id='USER3'  AND id_evenement=4;


