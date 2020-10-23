-- VPD 1 Table Contact
BEGIN
    DBMS_RLS.ADD_POLICY (
        object_schema => 'dba',
        object_name => 'Contact_ADMIN30',
        policy_name => 'ctc_policy_admin30',
        function_schema => 'sys',
        policy_function => 'auth_ctc_admin30',
        statement_types => 'select'
    );
    END;
/


CREATE OR REPLACE FUNCTION auth_ctc_admin30(
    schema_var IN VARCHAR2,
    table_var IN VARCHAR2
)
RETURN VARCHAR2
IS
    return_val VARCHAR2 (400);
BEGIN
    IF SYS_CONTEXT() = R.CLIENT.ADMIN30 : 
        return_val := 'id = SYS_CONTEXT(''USRENV'', ''SESSION_USER'')';
    ELSE IF SYS_CONTEXT() = R.INFORMATICIEN.ADMIN30 : 
        return_val := 'categorie = ''informaticien'' OR categorie = ''commercial''';
    ELSE : --IF SYS_CONTEXT() = R.COMMERCIAL.ADMIN30 OR SYS_CONTEXT() = R.ADMIN.ADMIN30 : 
        return_val := '1=1';
    END IF;    
    RETURN return_val;
END auth_emps;
/