
prompt (appuyer sur une touche pour continuer);
accept temp default '100';
prompt "On crée les contextes"
prompt (appuyer sur une touche pour continuer);
accept temp default '100';

CREATE OR REPLACE CONTEXT CAL_CTX_ADMIN30 USING set_cal_ctx_pkg_admin30;
/
CREATE OR REPLACE PACKAGE set_cal_ctx_pkg_admin30 IS
	PROCEDURE set_cal;
END;
/

CREATE OR REPLACE PACKAGE BODY set_cal_ctx_pkg_admin30 IS
	PROCEDURE set_cal IS
		myRole VARCHAR2(255);
	BEGIN
		SELECT granted_role INTO myRole
		FROM DBA_ROLE_PRIVS
		WHERE GRANTEE = SYS_CONTEXT('USERENV', 'SESSION_USER')
		AND granted_role LIKE '%_ADMIN30';

		DBMS_SESSION.SET_CONTEXT('CAL_CTX_ADMIN30', 'ROLE', myRole);
	END set_cal;
END set_cal_ctx_pkg_admin30;
/

GRANT EXECUTE ON set_cal_ctx_pkg_admin30 TO USER1, USER2, USER3, USER4, USER5, USER6, USER7;

COMMIT;