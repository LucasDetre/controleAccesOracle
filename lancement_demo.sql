set lines 256
set trimout on
set tab off

CONNECT admin30/admin@cienetdb
@clear_all
@create_tables
@create_view
@create_roles
@create_context
@create_vpd

CONNECT USER1/user@cienetdb
@test_client

CONNECT USER4/user@cienetdb
@test_commercial

CONNECT USER6/user@cienetdb
@test_informaticien

CONNECT USER7/user@cienetdb
@test_admin
