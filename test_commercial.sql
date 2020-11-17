-- Test Contexte
EXECUTE admin30.set_cal_ctx_pkg_admin30.set_cal;
SELECT SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE') FROM DUAL;

prompt "******************************************************"
prompt "*******************DOIT FONCTIONNER*******************"
prompt "***********EN TANT QUE USER 4 : COMMERCIAL************"
prompt "******************************************************"

    prompt "SELECT SUR TOUTES LES TABLES"
        prompt "Résultat attendu : 7 lignes : les clients, les informaticiens et les commerciaux"
        SELECT * FROM admin30.Contact_ADMIN30;
        prompt "Résultat attendu : 4 lignes : les événements auquel il participe ou qu'il a créé"
        SELECT * FROM admin30.Evenement_ADMIN30;
        prompt "Résultat attendu : 18 lignes : tous les éléments de calendrier afin de voir le planning de tous"
        SELECT * FROM admin30.Calendrier_ADMIN30;

    prompt "INSERTION Contact"
        prompt "Résultat attendu : 1 ligne insérée"
        INSERT INTO admin30.Contact_ADMIN30 (id, nom, prenom, telephone, courriel, categorie) VALUES ('USER8', 'Testeur', 'Jean-Michel', 0777777777, 'test@gmail.com','Client');

    prompt "INSERTION Evenement"
        prompt "Résultat attendu : 1 ligne insérée"
        INSERT INTO admin30.Evenement_ADMIN30 (id, id_createur, date_evenement, lieu, description) VALUES (6,'USER4', CURRENT_TIMESTAMP, 'A distance', 'Demonstration TP SSI');

    prompt "INSERTION ET SUPPRESSION Calendrier"
        prompt "Résultat attendu : 1 ligne insérée"
        INSERT INTO admin30.Calendrier_ADMIN30 (id_contact, id_evenement) VALUES ('USER3', 1);
        prompt "Résultat attendu : 19 lignes supprimées"
        DELETE FROM admin30.Calendrier_ADMIN30 WHERE id_contact='USER3' AND id_evenement=1;

prompt "******************************************************"
prompt "****************DOIT NE PAS FONCTIONNER***************"
prompt "******************************************************"

    prompt "UPDATE, SUPPRESSION Contact"

        UPDATE admin30.Contact_ADMIN30 SET nom='SMITH' WHERE id='USER2';
        DELETE FROM admin30.Contact_ADMIN30 WHERE id_contact='USER8';

    prompt "UPDATE, SUPPRESSION Evenement"

        UPDATE admin30.Evenement_ADMIN30 SET lieu='Salle de réunion C' WHERE id=3;
        DELETE FROM admin30.Evenement_ADMIN30 WHERE id=6;

    prompt "UPDATE, Calendrier"

        UPDATE admin30.Calendrier_ADMIN30 SET id_evenement=1 WHERE id='USER3'  AND id_evenement=4;

ROLLBACK;


