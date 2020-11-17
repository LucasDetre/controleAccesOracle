-- F1 : Limite le select sur la table Contact_ADMIN30 en fonction du rôle
CREATE OR REPLACE FUNCTION sel_ctc_admin30(schema_var IN VARCHAR2, table_var IN VARCHAR2) RETURN VARCHAR2
IS
    return_val VARCHAR2 (400);
    user_role VARCHAR2 (200);
BEGIN
    user_role := SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE');
    IF user_role = 'R_CLIENT_ADMIN30' THEN
        -- Client accède seulement à sa propre fiche
        return_val := 'id = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
    ELSIF user_role = 'R_INFORMATICIEN_ADMIN30' THEN
        -- Informaticien non admin ne peut accéder aux données clients
        return_val := 'categorie = ''Informaticien'' OR categorie = ''Commercial''';
    ELSE 
        -- Commercial et admin non limités
        return_val := '1=1';
    END IF; 
    RETURN return_val;
END sel_ctc_admin30;
/

-- F2 : Limite l'update sur la table Contact_ADMIN30
CREATE OR REPLACE FUNCTION upd_ctc_admin30(schema_var IN VARCHAR2, table_var IN VARCHAR2) RETURN VARCHAR2
IS
    return_val VARCHAR2 (400);
    user_role VARCHAR2 (200);
BEGIN
    user_role := SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE');
    IF user_role = 'R_INFORMATICIEN_ADMIN30' THEN
        -- Informaticien non admin ne peut update que ses données
        return_val := 'id = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
    ELSIF user_role = 'R_COMMERCIAL_ADMIN30' THEN
        -- Commercial peut update ses données et les données clients
        return_val := 'id = SYS_CONTEXT(''USERENV'', ''SESSION_USER'') OR categorie = ''Client''';
    ELSE
        -- Admin non limité (Client ne possède pas les privilèges pour update)
        return_val := '1=1';
    END IF;
    RETURN return_val;
END upd_ctc_admin30;
/

-- F3 : Limite le select sur la table Calendrier_ADMIN30
CREATE OR REPLACE FUNCTION sel_cld_admin30(schema_var IN VARCHAR2, table_var IN VARCHAR2) RETURN VARCHAR2
IS
    return_val VARCHAR2 (400);
    user_role VARCHAR2 (200);
BEGIN
    user_role := SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE');
    IF user_role = 'R_CLIENT_ADMIN30' OR user_role = 'R_INFORMATICIEN_ADMIN30' THEN
        -- Client et Informaticien non admin peuvent voir les réunions auxquels ils sont conviés
        return_val := 'id_contact = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
    ELSE 
        -- Commercial et Admin peuvent voir l'ensemble du calendrier
        return_val := '1=1';
    END IF;
    RETURN return_val;
END sel_cld_admin30;
/

-- F4 : Limite le delete sur Calendrier_ADMIN30
CREATE OR REPLACE FUNCTION del_cld_admin30(schema_var IN VARCHAR2, table_var IN VARCHAR2) RETURN VARCHAR2
IS
    return_val VARCHAR2 (400);
    user_role VARCHAR2 (200);
BEGIN
    user_role := SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE');
    IF user_role = 'R_INFORMATICIEN_ADMIN30' THEN
        -- Informaticien non admin peut seulement supprimer sa participation à une réunion
        return_val := 'id_contact = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
    ELSE 
        -- Commercial et Admin non limités
        return_val := '1=1';
    END IF;
    RETURN return_val;
END del_cld_admin30;
/

-- F5 : Limite le select sur Evenement_ADMIN30
CREATE OR REPLACE FUNCTION sel_evt_admin30(schema_var IN VARCHAR2, table_var IN VARCHAR2) RETURN VARCHAR2
IS
    return_val VARCHAR2 (400);
    user_role VARCHAR2 (200);
BEGIN
    user_role := SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE');
    IF user_role = 'R_CLIENT_ADMIN30' THEN
        -- Client peut voir les évènements auxquels il participe
        return_val := 'id IN (SELECT id_evenement FROM ADMIN30.Calendrier_ADMIN30 WHERE id_contact = SYS_CONTEXT(''USERENV'', ''SESSION_USER''))';
    ELSIF user_role = 'R_INFORMATICIEN_ADMIN30' OR user_role = 'R_COMMERCIAL_ADMIN30' THEN        
        -- Informaticien et commercial peuvent voir les informations sur les évènements auxquels ils participent ou qu'ils ont créé
        return_val := 'id IN (SELECT id_evenement FROM ADMIN30.Calendrier_ADMIN30 WHERE id_contact = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')) OR id_createur = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
    ELSE 
        -- Admin non limité
        return_val := '1=1';
    END IF;
    RETURN return_val;
END sel_evt_admin30;
/

BEGIN
    -- VPD1 : Utilise F1
    DBMS_RLS.ADD_POLICY (object_name => 'Contact_ADMIN30', policy_name => 'sel_ctc_policy_admin30', policy_function => 'sel_ctc_admin30', statement_types => 'select');
    -- VPD2 : Utilise F2
    DBMS_RLS.ADD_POLICY (object_name => 'Contact_ADMIN30', policy_name => 'upd_ctc_policy_admin30', policy_function => 'upd_ctc_admin30', statement_types => 'update');
    -- VPD3 : Utilise F3
    DBMS_RLS.ADD_POLICY (object_name => 'Calendrier_ADMIN30', policy_name => 'sel_cld_policy_admin30', policy_function => 'sel_cld_admin30', statement_types => 'select');
    -- VPD4 : Utilise F4
    DBMS_RLS.ADD_POLICY (object_name => 'Calendrier_ADMIN30', policy_name => 'del_cld_policy_admin30', policy_function => 'del_cld_admin30', statement_types => 'delete');
    -- VPD5 : Utilise F5
    DBMS_RLS.ADD_POLICY (object_name => 'Evenement_ADMIN30', policy_name => 'sel_evt_policy_admin30', policy_function => 'sel_evt_admin30', statement_types => 'select');
END;
/

COMMIT;