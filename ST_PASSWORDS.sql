
     SELECT 
   ROWID, USER_ID, USER_PWD, STATUS, 
   SEQ_ID
FROM BU_APPS.GINUCRD
where f_get_pidm(USER_ID) in (select pidm_cd from TRANSFER_STUDENT_PROGRAM )
and substr(USER_ID,0,3)='442'

