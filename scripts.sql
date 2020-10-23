F1
    IF SYS_CONTEXT() = R.CLIENT.ADMIN30 : id = SYS_CONTEXT('USRENV', 'SESSION_USER')
    ELSE IF SYS_CONTEXT() = R.INFORMATICIEN.ADMIN30 : categorie = 'informaticien' OR categorie = 'commercial'
    ELSE IF SYS_CONTEXT() = R.COMMERCIAL.ADMIN30 OR SYS_CONTEXT() = R.ADMIN.ADMIN30 : 1=1

F2
    IF SYS_CONTEXT() = R.CLIENT.ADMIN30 : id_contact = SYS_CONTEXT('USRENV', 'SESSION_USER')
    ELSE IF SYS_CONTEXT() = R.INFORMATICIEN.ADMIN30 : 
        id_contact = SYS_CONTEXT('USRENV', 'SESSION_USER') OR
        id_evenement IN (
            SELECT id
            FROM EVENEMENT
            WHERE id_creator = SYS_CONTEXT('USRENV', 'SESSION_USER')
        )
    ELSE IF SYS_CONTEXT() = R.COMMERCIAL.ADMIN30 OR SYS_CONTEXT() = R.ADMIN.ADMIN30 : 1=1

F3
    IF SYS_CONTEXT() = R.CLIENT.ADMIN30 : 
        id IN (
            SELECT id_evenement 
            FROM Calendrier 
            WHERE id_contact = SYS_CONTEXT('USRENV', 'SESSION_USER')
        )
    ELSE IF SYS_CONTEXT() = R.INFORMATICIEN.ADMIN30 OR SYS_CONTEXT() = R.COMMERCIAL.ADMIN30 : 
        id IN ( SELECT id_evenement 
                FROM Calendrier 
                WHERE id_contact = SYS_CONTEXT('USRENV', 'SESSION_USER') )
        OR id_creator = SYS_CONTEXT('USRENV', 'SESSION_USER')
    ELSE IF SYS_CONTEXT() = R.ADMIN.ADMIN30 : 1=1


c. CREATE OR REPLACE FUNCTION pat_auth1 (
    schema_var IN VARCHAR2,
    table_var IN VARCHAR2
)
RETURN VARCHAR2
IS
    role VARCHAR2(400);
BEGIN
    -- utiliser la table DBA_ROLE_PRIUS et SYS_CONTEXT('USRENV', 'SESSION_USER')
    return role;
END;
/
