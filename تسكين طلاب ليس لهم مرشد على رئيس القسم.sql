 /*truncate table BU_DEV.TMP_TBL_kilany_ADVR ;
 insert into BU_DEV.TMP_TBL_kilany_ADVR(col01,col02)*/
SELECT sgbstdn_pidm st_pidm, sgbstdn_dept_code 
           FROM sgbstdn a
          WHERE     sgbstdn_term_code_eff =
                       (SELECT MAX (b.sgbstdn_term_code_eff)
                          FROM sgbstdn b
                         WHERE b.sgbstdn_pidm = a.sgbstdn_pidm
                         and b.sgbstdn_term_code_eff <= '1444510')
                AND sgbstdn_stst_code = 'AS'
                --AND sgbstdn_levl_code   IN ('Ìã')
                and not exists (select '1' from SGRADVR where SGRADVR_pidm=a.sgbstdn_pidm )
 ;

--UPDATE BU_DEV.TMP_TBL_kilany_ADVR
--   SET COL02 = f_get_pidm (COL01);


UPDATE BU_DEV.TMP_TBL_kilany_ADVR
   SET (COL03, COL04, col05) =
           (SELECT a.USER_PIDM,
                   f_get_std_id (a.USER_PIDM),
                   f_get_std_name (a.USER_PIDM)
              FROM users_attributes a, ROLE_USERS r
             WHERE     a.USER_PIDM = r.USER_PIDM
                   AND ATTRIBUTE_CODE = 'DEPARTMENT'
                   AND ACTIVE = 'Y'
                   AND a.ROLE_CODE = r.ROLE_CODE
                   AND r.ROLE_CODE = 'RO_DEPT_MANAGER'
                   AND ATTRIBUTE_VALUE = col02);


-- col01 student pidm
--col02 dept code 
--col03 adv pidm
  select f_get_std_id(COL01) stid,f_get_std_name(COL01) stname, f_get_desc_fnc('stvdept',COL02,30) dept, COL03, COL04 from BU_DEV.TMP_TBL_kilany_ADVR ;

DECLARE
    CURSOR GET_STUDENTS IS
        SELECT COL01 PIDM, COL03 ADV FROM BU_DEV.TMP_TBL_kilany_ADVR;

    l_FALIURE_COUNTER    NUMBER := 0;
    L_SUCCSESS_COUNTER   NUMBER := 0;
BEGIN

 
delete  BU_DEV.TMP_TBL_kilany_ADVR  ;
 insert into BU_DEV.TMP_TBL_kilany_ADVR(col01,col02)
SELECT sgbstdn_pidm st_pidm, sgbstdn_dept_code 
           FROM sgbstdn a
          WHERE     sgbstdn_term_code_eff =
                       (SELECT MAX (b.sgbstdn_term_code_eff)
                          FROM sgbstdn b
                         WHERE b.sgbstdn_pidm = a.sgbstdn_pidm
                         and b.sgbstdn_term_code_eff <= '144510')
                AND sgbstdn_stst_code = 'AS'
               -- AND sgbstdn_levl_code   IN ('Ìã')
                and not exists (select '1' from SGRADVR where SGRADVR_pidm=a.sgbstdn_pidm )
 ;

--UPDATE BU_DEV.TMP_TBL_kilany_ADVR
--   SET COL02 = f_get_pidm (COL01);


UPDATE BU_DEV.TMP_TBL_kilany_ADVR
   SET (COL03, COL04, col05) =
           (SELECT a.USER_PIDM,
                   f_get_std_id (a.USER_PIDM),
                   f_get_std_name (a.USER_PIDM)
              FROM users_attributes a, ROLE_USERS r
             WHERE     a.USER_PIDM = r.USER_PIDM
                   AND ATTRIBUTE_CODE = 'DEPARTMENT'
                   AND ACTIVE = 'Y'
                   AND a.ROLE_CODE = r.ROLE_CODE
                   AND r.ROLE_CODE = 'RO_DEPT_MANAGER'
                   AND ATTRIBUTE_VALUE = col02);

    FOR STD IN GET_STUDENTS
    LOOP
        BEGIN
            INSERT INTO SATURN.SGRADVR (SGRADVR_PIDM,
                                        SGRADVR_TERM_CODE_EFF,
                                        SGRADVR_ADVR_PIDM,
                                        SGRADVR_ADVR_CODE,
                                        SGRADVR_PRIM_IND,
                                        SGRADVR_ACTIVITY_DATE)
                 VALUES (STD.PIDM,
                         '144510',
                         STD.ADV,
                         'ãÑÔÏ',
                         'Y',
                         SYSDATE);

            L_SUCCSESS_COUNTER := L_SUCCSESS_COUNTER + 1;

            UPDATE BU_DEV.TMP_TBL_kilany_ADVR
               SET COL05 = 'DONE'
             WHERE col02 = STD.PIDM;
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX
            THEN
                UPDATE SATURN.SGRADVR
                   SET SGRADVR_ADVR_PIDM = STD.ADV
                 WHERE SGRADVR_PIDM = STD.PIDM;

                DBMS_OUTPUT.put_line (
                    STD.PIDM || '<<-ROWS>>' || SQL%ROWCOUNT);
            WHEN OTHERS
            THEN
                l_FALIURE_COUNTER := l_FALIURE_COUNTER + 1;
        END;
    END LOOP;

    DBMS_OUTPUT.put_line (
        'S ' || L_SUCCSESS_COUNTER || '<<--->>' || l_FALIURE_COUNTER || ' F');
END;


/*
--INTERNAL_VISITOR

DELETE FROM SGRADVR WHERE SGRADVR_PIDM  IN ( 
select REQUESTER_PIDM from request_master m , request_details term

where 
m.request_no=term.request_no
and term.item_code='TERM'
and teRm.item_value='1444510'
AND term.SEQUENCE_NO=1
and m.object_code='WF_INTERNAL_VISITOR'
AND m.REQUEST_STATUS='C')


*/