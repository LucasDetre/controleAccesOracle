-- Test Contexte
EXECUTE admin30.set_cal_ctx_pkg_admin30.set_cal;
SELECT SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE') FROM DUAL;

prompt "Tous les privilèges directs du user sur les tables : résultat attendu : rien sauf execute (pas de privilège direct, uniquement de l'execute de vpd)"
select * from user_tab_privs where table_name like '%_ADMIN30';
prompt "Le ou les rôles affecté au user : résultat attendu : R_ADMIN_ADMIN30 "
select granted_role from dba_role_privs where grantee = SYS_CONTEXT('USERENV', 'SESSION_USER') and granted_role like '%_ADMIN30';
prompt "Tous les privilèges donnés par le rôle"
select * from dba_tab_privs where grantee IN (select granted_role from user_role_privs where granted_role like '%_ADMIN30');

prompt "******************************************************"
prompt "*******************DOIT FONCTIONNER*******************"
prompt "*************EN TANT QUE USER 7 : ADMIN***************"
prompt "******************************************************"

    prompt (appuyer sur une touche pour continuer);
    accept temp default '100';
    prompt "SELECT SUR TOUTES LES TABLES"

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        prompt "Résultat attendu : 7 lignes : tous les contacts"
        prompt SELECT * FROM admin30.Contact_ADMIN30;
        SELECT * FROM admin30.Contact_ADMIN30;

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        prompt "Résultat attendu : 5 lignes : tous les événements"
        prompt SELECT * FROM admin30.Evenement_ADMIN30;
        SELECT * FROM admin30.Evenement_ADMIN30;

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        prompt "Résultat attendu : 18 lignes : tous les calendriers"
        prompt SELECT * FROM admin30.Calendrier_ADMIN30;
        SELECT * FROM admin30.Calendrier_ADMIN30;


    prompt (appuyer sur une touche pour continuer);
    accept temp default '100';
    prompt "INSERTION, SUPPRESSION, MISE A JOUR Contact"

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        INSERT INTO admin30.Contact_ADMIN30 (id, nom, prenom, telephone, courriel, categorie) VALUES ('USER8', 'Testeur', 'Jean-Michel', 0777777777, 'test@gmail.com','Client');

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        DELETE FROM admin30.Contact_ADMIN30 WHERE id_contact='USER8';

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        UPDATE admin30.Contact_ADMIN30 SET nom='SMITH' WHERE id='USER2';


    prompt "INSERTION, SUPPRESSION, MISE A JOUR Evenement"

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        INSERT INTO admin30.Evenement_ADMIN30 (id, id_createur, date_evenement, lieu, description) VALUES (6,'USER2', CURRENT_TIMESTAMP, 'A distance', 'Demonstration TP SSI');

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        DELETE FROM admin30.Evenement_ADMIN30 WHERE id=6;

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        SELECT * FROM admin30.Evenement_ADMIN30 WHERE id=3;
        UPDATE admin30.Evenement_ADMIN30 SET lieu='Salle de réunion C' WHERE id=3;
        SELECT * FROM admin30.Evenement_ADMIN30 WHERE id=3;

    prompt "INSERTION, SUPPRESSION, MISE A JOUR Calendrier"

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        INSERT INTO admin30.Calendrier_ADMIN30 (id_contact, id_evenement) VALUES ('USER3', 1);
        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        DELETE FROM admin30.Calendrier_ADMIN30 WHERE id_contact='USER3' AND id_evenement=1;

        prompt (appuyer sur une touche pour continuer);
        accept temp default '100';
        UPDATE admin30.Calendrier_ADMIN30 SET id_evenement=1 WHERE id='USER3'  AND id_evenement=4;


ROLLBACK;
