-- Test Contexte
EXECUTE admin30.set_cal_ctx_pkg_admin30.set_cal;
SELECT SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE') FROM DUAL;

prompt "******************************************************"
prompt "*******************DOIT FONCTIONNER*******************"
prompt "***********EN TANT QUE USER 6 : INFORMATICIEN*********"
prompt "******************************************************"

    prompt "SELECT SUR TOUTES LES TABLES"
        prompt "Résultat attendu : 4 lignes : les commerciaux et les informaticiens"
        SELECT * FROM admin30.Contact_ADMIN30;
        prompt "Résultat attendu : 3 lignes : les événements auquel il participe ou qu'il a créé"
        SELECT * FROM admin30.Evenement_ADMIN30;
        prompt "Résultat attendu : 3 lignes : le calendrier de ses événements"
        SELECT * FROM admin30.Calendrier_ADMIN30;

    prompt "MISE A JOUR CONTACT"
        prompt "Résultat attendu : 1 ligne mise à jour"
        UPDATE admin30.Contact_ADMIN30 SET nom='SMITH';

    prompt "INSERTION EVENEMENT"
        prompt "Résultat attendu : 1 ligne insérée"
        INSERT INTO admin30.Evenement_ADMIN30 (id, id_createur, date_evenement, lieu, description) VALUES (6,'USER2', CURRENT_TIMESTAMP, 'A distance', 'Demonstration TP SSI');

    prompt "INSERTION ET SUPPRESSION CALENDRIER"
        prompt "Résultat attendu : 1 ligne insérée"
        INSERT INTO admin30.Calendrier_ADMIN30 (id_contact, id_evenement) VALUES ('USER6', 2);
        prompt "Résult attendu : 4 lignes supprimées"
        DELETE FROM admin30.Calendrier_ADMIN30;

prompt "******************************************************"
prompt "****************DOIT NE PAS FONCTIONNER***************"
prompt "******************************************************"

    prompt "INSERTION, SUPPRESSION Contact"

        INSERT INTO admin30.Contact_ADMIN30 (id, nom, prenom, telephone, courriel, categorie) VALUES ('USER8', 'Testeur', 'Jean-Michel', 0777777777, 'test@gmail.com','Client');
        DELETE FROM admin30.Contact_ADMIN30 WHERE id_contact='USER7';

    prompt "UPDATE, SUPPRESSION Evenement"

        UPDATE admin30.Evenement_ADMIN30 SET lieu='Salle de réunion C' WHERE id=3;
        DELETE FROM admin30.Evenement_ADMIN30 WHERE id=5;

    prompt "UPDATE Calendrier"

        UPDATE admin30.Calendrier_ADMIN30 SET id_evenement=1 WHERE id='USER3' AND id_evenement=4;

ROLLBACK;