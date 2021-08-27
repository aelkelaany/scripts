update users_attributes
set ATTRIBUTE_VALUE='Y'
 
where ATTRIBUTE_CODE='TRN_ALLOW_APPROVALS'
and role_code in ('RO_DEPT_MANAGER','RO_COLLEGE_DEAN')
and USER_PIDM in (select user_pidm from role_users where ACTIVE='Y') ;