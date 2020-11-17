-- VPD1 Contact SELECT
CREATE OR REPLACE FUNCTION sel_ctc_admin30(schema_var IN VARCHAR2, table_var IN VARCHAR2) RETURN VARCHAR2
IS
    return_val VARCHAR2 (400);
    user_role VARCHAR2 (200);
BEGIN
    user_role := SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE');
    IF user_role = 'R_CLIENT_ADMIN30' THEN
        return_val := 'id = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
    ELSIF user_role = 'R_INFORMATICIEN_ADMIN30' THEN
        return_val := 'categorie = ''Informaticien'' OR categorie = ''Commercial''';
    ELSE
        return_val := '1=1';
    END IF; 
    RETURN return_val;
END sel_ctc_admin30;
/

-- VPD2 Contact UPDATE
CREATE OR REPLACE FUNCTION upd_ctc_admin30(schema_var IN VARCHAR2, table_var IN VARCHAR2) RETURN VARCHAR2
IS
    return_val VARCHAR2 (400);
    user_role VARCHAR2 (200);
BEGIN
    user_role := SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE');
    IF user_role = 'R_INFORMATICIEN_ADMIN30' THEN
        return_val := 'id = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
    ELSIF user_role = 'R_COMMERCIAL_ADMIN30' THEN
        return_val := 'id = SYS_CONTEXT(''USERENV'', ''SESSION_USER'') OR categorie = ''Client''';
    ELSE
        return_val := '1=1';
    END IF;
    RETURN return_val;
END upd_ctc_admin30;
/

-- VPD3 Calendrier SELECT
CREATE OR REPLACE FUNCTION sel_cld_admin30(schema_var IN VARCHAR2, table_var IN VARCHAR2) RETURN VARCHAR2
IS
    return_val VARCHAR2 (400);
    user_role VARCHAR2 (200);
BEGIN
    user_role := SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE');
    IF user_role = 'R_CLIENT_ADMIN30' THEN
        return_val := 'id_contact = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
    ELSIF user_role = 'R_INFORMATICIEN_ADMIN30' THEN
        return_val := ' id_contact = SYS_CONTEXT(''USERENV'', ''SESSION_USER'') OR 
                        id_evenement IN (SELECT id FROM ADMIN30.EVENEMENT_ADMIN30 WHERE id_creator = SYS_CONTEXT(''USERENV'', ''SESSION_USER''))';
    ELSE -- Commercial et Admin
        return_val := '1=1';
    END IF;
    RETURN return_val;
END sel_cld_admin30;
/

-- VPD4 Calendrier DELETE
CREATE OR REPLACE FUNCTION del_cld_admin30(schema_var IN VARCHAR2, table_var IN VARCHAR2) RETURN VARCHAR2
IS
    return_val VARCHAR2 (400);
    user_role VARCHAR2 (200);
BEGIN
    user_role := SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE');
    IF user_role = 'R_INFORMATICIEN_ADMIN30' OR user_role = 'R_COMMERCIAL_ADMIN30' THEN
        return_val := ' id_contact = SYS_CONTEXT(''USERENV'', ''SESSION_USER'') OR id_evenement IN (SELECT id FROM ADMIN30.EVENEMENT_ADMIN30 WHERE id_creator = SYS_CONTEXT(''USERENV'', ''SESSION_USER''))';
    ELSE -- Commercial et Admin
        return_val := '1=1';
    END IF;
    RETURN return_val;
END del_cld_admin30;
/

-- VPD5 Evenement SELECT
CREATE OR REPLACE FUNCTION sel_evt_admin30(schema_var IN VARCHAR2, table_var IN VARCHAR2) RETURN VARCHAR2
IS
    return_val VARCHAR2 (400);
    user_role VARCHAR2 (200);
BEGIN
    user_role := SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE');
    IF user_role = 'R_CLIENT_ADMIN30' THEN
        return_val := 'id IN (SELECT id_evenement FROM Calendrier WHERE id_contact = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
    ELSIF user_role = 'R_INFORMATICIEN_ADMIN30' OR user_role = 'R_COMMERCIAL_ADMIN30' THEN        
        return_val := 'id IN (SELECT id_evenement FROM Calendrier WHERE id_contact = SYS_CONTEXT(''USERENV'', ''SESSION_USER'') OR id_createur = SYS_CONTEXT(''USERENV'', ''SESSION_USER''))';
    ELSE -- Admin
        return_val := '1=1';
    END IF;sqld
    RETURN return_val;
END sel_evt_admin30;
/

BEGIN
    DBMS_RLS.ADD_POLICY (object_name => 'Contact_ADMIN30', policy_name => 'sel_ctc_policy_admin30', policy_function => 'sel_ctc_admin30', statement_types => 'select');
    DBMS_RLS.ADD_POLICY (object_name => 'Contact_ADMIN30', policy_name => 'upd_ctc_policy_admin30', policy_function => 'upd_ctc_admin30', statement_types => 'update');
    DBMS_RLS.ADD_POLICY (object_name => 'Calendrier_ADMIN30', policy_name => 'sel_cld_policy_admin30', policy_function => 'sel_cld_admin30', statement_types => 'select');
    DBMS_RLS.ADD_POLICY (object_name => 'Calendrier_ADMIN30', policy_name => 'upd_cld_policy_admin30', policy_function => 'del_cld_admin30', statement_types => 'delete');
    DBMS_RLS.ADD_POLICY (object_name => 'Evenement_ADMIN30', policy_name => 'sel_evt_policy_admin30', policy_function => 'sel_evt_admin30', statement_types => 'select');
END;
/

COMMIT;