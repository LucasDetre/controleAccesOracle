-- VPD 1 Table Contact
CREATE OR REPLACE FUNCTION auth_ctc_admin30(
    schema_var IN VARCHAR2,
    table_var IN VARCHAR2
)
RETURN VARCHAR2
IS
    return_val VARCHAR2 (400);
    user_role VARCHAR2 (200);
BEGIN
    user_role := SYS_CONTEXT('CAL_CTX_ADMIN30', 'ROLE');
    IF user_role = 'R_CLIENT_ADMIN30' THEN
        return_val := 'id = SYS_CONTEXT(''USERENV'', ''SESSION_USER'')';
    ELSIF user_role = 'R_INFORMATICIEN_ADMIN30' THEN
        return_val := 'categorie = ''informaticien'' OR categorie = ''commercial''';
    ELSE
        return_val := '1=1';
    END IF; 
    RETURN return_val;
END auth_ctc_admin30;
/

BEGIN
    DBMS_RLS.ADD_POLICY (
        object_name => 'Contact_ADMIN30',
        policy_name => 'ctc_policy_admin30',
        policy_function => 'auth_ctc_admin30',
        statement_types => 'select'
    );
    END;
/

COMMIT;