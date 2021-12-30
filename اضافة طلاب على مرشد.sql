/* Formatted on 8/17/2020 9:19:20 AM (QP5 v5.360) */
--select f_get_pidm('2233') from dual ;
--ÿ«·»
UPDATE BU_DEV.TMP_TBL03
   SET COL02 = F_GET_PIDM (COL01);
   --„—‘œ
UPDATE BU_DEV.TMP_TBL03
   SET COL04 = F_GET_PIDM (COL03);

INSERT INTO SATURN.SGRADVR (SGRADVR_PIDM,
                            SGRADVR_TERM_CODE_EFF,
                            SGRADVR_ADVR_PIDM,
                            SGRADVR_ADVR_CODE,
                            SGRADVR_PRIM_IND,
                            SGRADVR_ACTIVITY_DATE)
    SELECT std_pidm,
           '144010',
           f_get_pidm('3955'),
           '„—‘œ',
           'Y',
           SYSDATE - 50
      FROM (SELECT sgbstdn_pidm     std_pidm
              FROM sgbstdn a, sirdpcl x
             WHERE     a.sgbstdn_term_code_eff =
                       (SELECT MAX (b.sgbstdn_term_code_eff)
                          FROM sgbstdn b
                         WHERE     b.sgbstdn_pidm = a.sgbstdn_pidm
                               AND b.sgbstdn_term_code_eff <=
                                   f_get_param ('GENERAL', 'CURRENT_TERM', 1))
                   AND sirdpcl_pidm = f_get_pidm('3955')
                   AND x.sirdpcl_term_code_eff =
                       (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                          FROM sirdpcl y
                         WHERE y.sirdpcl_pidm = x.sirdpcl_pidm)
                   AND sgbstdn_dept_code = SIRDPCL_DEPT_CODE
                   AND sgbstdn_coll_code_1 = SIRDPCL_COLL_CODE
                   AND sgbstdn_stst_code IN ('AS','„⁄','„Ê'));
-------------------------------------------------------------------------------------------------
--*********************************************************************************
--*************************************************from file *********************
--********************************************************************************
DECLARE
    CURSOR GET_STUDENTS IS SELECT COL02 PIDM, COL04 ADV FROM BU_DEV.TMP_TBL03;

    l_FALIURE_COUNTER    NUMBER:=0;
    L_SUCCSESS_COUNTER   NUMBER:=0;
BEGIN
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
                         '144010',
                         STD.ADV,
                          '„—‘œ',
           'Y',
           SYSDATE );

            L_SUCCSESS_COUNTER := L_SUCCSESS_COUNTER + 1;
            update  BU_DEV.TMP_TBL03
   SET COL05 = 'DONE'
   where col02=STD.PIDM ;
        EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN 
        UPDATE SATURN.SGRADVR SET SGRADVR_ADVR_PIDM=STD.ADV
        WHERE SGRADVR_PIDM=STD.PIDM;
        DBMS_OUTPUT.put_line (
        STD.PIDM || '<<-ROWS>>' || SQL%ROWCOUNT);
            WHEN OTHERS
            THEN
                l_FALIURE_COUNTER := l_FALIURE_COUNTER + 1;
        END;
    END LOOP;

    DBMS_OUTPUT.put_line (
        L_SUCCSESS_COUNTER || '<<--->>' || l_FALIURE_COUNTER);
END;


---------------------- œ›⁄… „⁄Ì‰… 

INSERT INTO SATURN.SGRADVR (SGRADVR_PIDM,
                            SGRADVR_TERM_CODE_EFF,
                            SGRADVR_ADVR_PIDM,
                            SGRADVR_ADVR_CODE,
                            SGRADVR_PRIM_IND,
                            SGRADVR_ACTIVITY_DATE)
    SELECT std_pidm,
           '144310',
           f_get_pidm('2278'),
           '„—‘œ',
           'Y',
           SYSDATE - 50
      FROM (SELECT sgbstdn_pidm     std_pidm
              FROM sgbstdn a, sirdpcl x
             WHERE     a.sgbstdn_term_code_eff =
                       (SELECT MAX (b.sgbstdn_term_code_eff)
                          FROM sgbstdn b
                         WHERE     b.sgbstdn_pidm = a.sgbstdn_pidm
                               AND b.sgbstdn_term_code_eff <=
                                   f_get_param ('GENERAL', 'CURRENT_TERM', 1))
                                   and exists (select '1' from spriden where spriden_pidm=sgbstdn_pidm and spriden_id like '443%')
                                   and not exists (select '1' from SATURN.SGRADVR where SGRADVR_PIDM=sgbstdn_pidm  )
                                   and sgbstdn_program_1='4F12NUTR43'
                   AND sirdpcl_pidm = f_get_pidm('2278')
                   AND x.sirdpcl_term_code_eff =
                       (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                          FROM sirdpcl y
                         WHERE y.sirdpcl_pidm = x.sirdpcl_pidm)
                   AND sgbstdn_dept_code = SIRDPCL_DEPT_CODE
                   AND sgbstdn_coll_code_1 = SIRDPCL_COLL_CODE
                   AND sgbstdn_stst_code IN ('AS','„⁄','„Ê'));
                   
                   
                   
                   ---  œ›⁄… „⁄Ì‰… ·ÿ·«» „ÕÊ·Ì‰ «·Ï »—‰«„Ã „⁄Ì‰ 
                   
                   INSERT INTO SATURN.SGRADVR (SGRADVR_PIDM,
                            SGRADVR_TERM_CODE_EFF,
                            SGRADVR_ADVR_PIDM,
                            SGRADVR_ADVR_CODE,
                            SGRADVR_PRIM_IND,
                            SGRADVR_ACTIVITY_DATE)
    SELECT std_pidm,
           '144310',
           f_get_pidm('2278'),
           '„—‘œ',
           'Y',
           SYSDATE - 50
      FROM (SELECT sgbstdn_pidm     std_pidm
              FROM sgbstdn a, sirdpcl x
             WHERE     a.sgbstdn_term_code_eff =
                       (SELECT MAX (b.sgbstdn_term_code_eff)
                          FROM sgbstdn b
                         WHERE     b.sgbstdn_pidm = a.sgbstdn_pidm
                               AND b.sgbstdn_term_code_eff <=
                                   f_get_param ('GENERAL', 'CURRENT_TERM', 1))
                                   and exists (select '1' from spriden where spriden_pidm=sgbstdn_pidm and spriden_id like '442%')
                                   and not exists (select '1' from SATURN.SGRADVR where SGRADVR_PIDM=sgbstdn_pidm  )
                                   and sgbstdn_program_1='1F17NUTR38'
                                    AND NOT EXISTS (SELECT '1' FROM  SGBSTDN
                 WHERE SGBSTDN_PIDM=A.SGBSTDN_PIDM AND SGBSTDN_PROGRAM_1='1F17NUTR38' AND SGBSTDN_TERM_CODE_EFF <'144310' )
                   AND sirdpcl_pidm = f_get_pidm('1595')
                   AND x.sirdpcl_term_code_eff =
                       (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                          FROM sirdpcl y
                         WHERE y.sirdpcl_pidm = x.sirdpcl_pidm)
                   AND sgbstdn_dept_code = SIRDPCL_DEPT_CODE
                   AND sgbstdn_coll_code_1 = SIRDPCL_COLL_CODE
                   AND sgbstdn_stst_code IN ('AS','„⁄','„Ê'));