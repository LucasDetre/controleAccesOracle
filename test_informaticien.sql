-- Test Contexte
EXECUTE admin30.set_cal_ctx_pkg_admin30.set_cal;
SELECT SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE') FROM DUAL;

prompt "******************************************************"
prompt "************INTERROGATION DES DICTIONNAIRES***********"
prompt "******************************************************"

prompt (appuyer sur une touche pour continuer);
accept temp default '100';
prompt "Tous les privilèges directs du user sur les tables : résultat attendu : rien sauf execute (pas de privilège direct, uniquement de l'execute de vpd)"
select * from user_tab_privs where table_name like '%_ADMIN30';

prompt (appuyer sur une touche pour continuer);
accept temp default '100';
prompt "Le ou les rôles affecté au user : résultat attendu : R_INFORMATICIEN_ADMIN30 "
select granted_role from dba_role_privs where grantee = SYS_CONTEXT('USERENV', 'SESSION_USER') and granted_role like '%_ADMIN30';

prompt (appuyer sur une touche pour continuer);
accept temp default '100';
prompt "Tous les privilèges donnés par le rôle"
select * from dba_tab_privs where grantee IN (select granted_role from user_role_privs where granted_role like '%_ADMIN30');

prompt (appuyer sur une touche pour continuer);
accept temp default '100';
prompt "******************************************************"
prompt "*******************DOIT FONCTIONNER*******************"
prompt "***********EN TANT QUE USER 6 : INFORMATICIEN*********"
prompt "******************************************************"

    prompt (appuyer sur une touche pour continuer);
    accept temp default '100';
    prompt "SELECT SUR TOUTES LES TABLES"
        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        prompt "Résultat attendu : 4 lignes : les commerciaux et les informaticiens"
        prompt SELECT * FROM admin30.Contact_ADMIN30;
        SELECT * FROM admin30.Contact_ADMIN30;

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        prompt "Résultat attendu : 3 lignes : les événements auquel il participe ou qu'il a créé"
        prompt SELECT * FROM admin30.Evenement_ADMIN30;
        SELECT * FROM admin30.Evenement_ADMIN30;

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        prompt "Résultat attendu : 3 lignes : le calendrier de ses événements"
        prompt SELECT * FROM admin30.Calendrier_ADMIN30;
        SELECT * FROM admin30.Calendrier_ADMIN30;

    prompt (appuyer sur une touche pour continuer);
    accept temp default '100';
    prompt "MISE A JOUR CONTACT"
        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        prompt "Résultat attendu : 1 ligne mise à jour"
        prompt UPDATE admin30.Contact_ADMIN30 SET nom='SMITH';
        UPDATE admin30.Contact_ADMIN30 SET nom='SMITH';

    prompt (appuyer sur une touche pour continuer);
    accept temp default '100';
    prompt "INSERTION EVENEMENT"
        prompt "Résultat attendu : 1 ligne insérée"
        prompt INSERT INTO admin30.Evenement_ADMIN30 (id, id_createur, date_evenement, lieu, description) VALUES (6,'USER2', CURRENT_TIMESTAMP, 'A distance', 'Demonstration TP SSI');
        INSERT INTO admin30.Evenement_ADMIN30 (id, id_createur, date_evenement, lieu, description) VALUES (6,'USER2', CURRENT_TIMESTAMP, 'A distance', 'Demonstration TP SSI');


    prompt (appuyer sur une touche pour continuer);
    accept temp default '100';
    prompt "INSERTION ET SUPPRESSION CALENDRIER"

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        prompt "Résultat attendu : 1 ligne insérée"
        prompt INSERT INTO admin30.Calendrier_ADMIN30 (id_contact, id_evenement) VALUES ('USER6', 2);
        INSERT INTO admin30.Calendrier_ADMIN30 (id_contact, id_evenement) VALUES ('USER6', 2);

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        prompt "Résult attendu : 4 lignes supprimées"
        prompt DELETE FROM admin30.Calendrier_ADMIN30;
        DELETE FROM admin30.Calendrier_ADMIN30;


accept temp default '100';
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

    prompt "SELECT Vue Calendrier x Evenement x Contact"
        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        SELECT * FROM admin30.VCal_Evnt_Contact_ADMIN30;

ROLLBACK;