prompt (appuyer sur une touche pour continuer);
accept temp default '100';
prompt "On nettoie la base pour commencer"
prompt (appuyer sur une touche pour continuer);
accept temp default '100';

BEGIN
    DBMS_RLS.DROP_POLICY (object_name => 'Contact_ADMIN30', policy_name => 'sel_ctc_policy_admin30');
    DBMS_RLS.DROP_POLICY (object_name => 'Contact_ADMIN30', policy_name => 'upd_ctc_policy_admin30');
    DBMS_RLS.DROP_POLICY (object_name => 'Calendrier_ADMIN30', policy_name => 'sel_cld_policy_admin30');
    DBMS_RLS.DROP_POLICY (object_name => 'Calendrier_ADMIN30', policy_name => 'del_cld_policy_admin30');
    DBMS_RLS.DROP_POLICY (object_name => 'Evenement_ADMIN30', policy_name => 'sel_evt_policy_admin30');
END;
/

DROP FUNCTION sel_ctc_admin30;
DROP FUNCTION upd_ctc_admin30;
DROP FUNCTION sel_cld_admin30;
DROP FUNCTION del_cld_admin30;
DROP FUNCTION sel_evt_admin30;

DROP PACKAGE set_cal_ctx_pkg_admin30;

REVOKE R_CLIENT_ADMIN30 FROM USER1, USER2, USER3;
REVOKE R_COMMERCIAL_ADMIN30 FROM USER4, USER5;
REVOKE R_INFORMATICIEN_ADMIN30 FROM USER6;
REVOKE R_ADMIN_ADMIN30 FROM USER7;

DROP ROLE R_CLIENT_ADMIN30;
DROP ROLE R_INFORMATICIEN_ADMIN30;
DROP ROLE R_COMMERCIAL_ADMIN30;
DROP ROLE R_ADMIN_ADMIN30;

DROP VIEW VCal_Evnt_Contact_ADMIN30;

DROP TABLE Calendrier_ADMIN30;
DROP TABLE Evenement_ADMIN30;
DROP TABLE Contact_ADMIN30;

COMMIT;