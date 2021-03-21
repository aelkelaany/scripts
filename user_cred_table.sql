drop table user_cred ;
create table user_cred (
ldap_user varchar2(30) primary key,
user_id varchar2(30),
user_pwd varchar(50)) ;

grant select , update , delete on BU_APPS.USER_CRED ;

create public synonym USER_CRED for BU_APPS.USER_CRED ;