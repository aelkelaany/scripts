update BU_APPS.ROLE_USERS
set USER_PIDM=f_get_pidm(:new)
where USER_PIDM=f_get_pidm(:old);

update USERS_ATTRIBUTES
set USER_PIDM=f_get_pidm(:new)
where USER_PIDM=f_get_pidm(:old);


update wf_request_flow
set USER_PIDM=f_get_pidm(:new)
where USER_PIDM=f_get_pidm(:old)
and ACTION_CODE is null;





