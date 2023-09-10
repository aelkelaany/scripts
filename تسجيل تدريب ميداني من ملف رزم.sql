/* Formatted on 8/22/2023 3:22:20 PM (QP5 v5.371) */
--CRN>>COL11
-- pidm.col01 

 update BU_DEV.TMP_TBL_kilany set col01=col02 ;
SELECT * FROM BU_DEV.TMP_TBL_kilany 
where col13 is null;

SELECT DISTINCT COL01
  FROM BU_DEV.TMP_TBL_kilany;

SELECT DISTINCT COL11
  FROM BU_DEV.TMP_TBL_kilany;

SELECT COUNT (1)
  FROM BU_DEV.TMP_TBL_kilany
 WHERE NOT EXISTS
           (SELECT '1'
              FROM SSBSECT
             WHERE SSBSECT_TERM_CODE = '144510' AND SSBSECT_CRN = COL11);

-- store current block 

UPDATE BU_DEV.TMP_TBL_kilany
   SET col13 =
           (SELECT sgbstdn_blck_code
              FROM sgbstdn
             WHERE SGBSTDN_TERM_CODE_EFF =(select max(SGBSTDN_TERM_CODE_EFF) from SGBSTDN where sgbstdn_pidm = col01 ) AND sgbstdn_pidm = col01);

-- create new temp blocks 

INSERT INTO STVBLCK
      SELECT DISTINCT 'FTRNG' || COL11, 'ÊÏÑíÈ ãíÏÇäí ' || COL11, SYSDATE
        FROM BU_DEV.TMP_TBL_kilany
    ORDER BY 1;

-- fill blocks with crns

INSERT INTO SSRBLCK (SSRBLCK_TERM_CODE,
                     SSRBLCK_BLCK_CODE,
                     SSRBLCK_CRN,
                     SSRBLCK_ACTIVITY_DATE)
    SELECT DISTINCT '144510',
                    'FTRNG' || COL11,
                    COL11,
                    SYSDATE
      FROM BU_DEV.TMP_TBL_kilany;

      ------- link students with block 

DECLARE
    L_COUNT         NUMBER (1) := 0;
    L_TOTAL_COUNT   NUMBER (6) := 0;

    CURSOR GET_DATA IS
        SELECT 'FTRNG' || COL11 BLCK, COL01 PIDM
          FROM BU_DEV.TMP_TBL_kilany
         WHERE col01 != 326147;
BEGIN
    FOR REC IN GET_DATA
    LOOP
        UPDATE SGBSTDN B
           SET SGBSTDN_BLCK_CODE = REC.BLCK
         WHERE     B.SGBSTDN_PIDM = REC.PIDM
               AND b.SGBSTDN_TERM_CODE_EFF =(select max(SGBSTDN_TERM_CODE_EFF) from SGBSTDN where sgbstdn_pidm = REC.PIDM )
               AND b.sgbstdn_stst_code = 'AS'
                ;

        L_COUNT := SQL%ROWCOUNT;
        L_TOTAL_COUNT := L_TOTAL_COUNT + L_COUNT;
        DBMS_OUTPUT.put_line (
            REC.PIDM || ' >>UPDATE ROWS PER STUDENT ' || L_COUNT);
    END LOOP;

    DBMS_OUTPUT.put_line ('TOTAL ' || L_TOTAL_COUNT);
END;





-- create population selection

INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                     GLBSLCT_SELECTION,
                     GLBSLCT_CREATOR_ID,
                     GLBSLCT_DESC,
                     GLBSLCT_LOCK_IND,
                     GLBSLCT_ACTIVITY_DATE,
                     GLBSLCT_TYPE_IND)
     VALUES ('STUDENT',
             'BLOCKS_REGS_1445103',
             'SAISUSR',
             'ÊÓÌíá ÑÒã 144510  ',
             'N',
             SYSDATE,
             NULL);

INSERT INTO GLBEXTR
    SELECT 'STUDENT',
           'BLOCKS_REGS_1445103',
           'SAISUSR',
           'SAISUSR',
           SGBSTDN_PIDM,
           SYSDATE,
           'S',
           NULL
      FROM (SELECT DISTINCT col01     SGBSTDN_PIDM
              FROM BU_DEV.TMP_TBL_kilany
              WHERE  F_GET_STATUS(col01)='AS'
              
             );

     --- go to sfamreg 

     -- check regist crn 

SELECT A.*,F_GET_STATUS(A.COL01) STST ,F_GET_STD_NAME(A.COL01)
  FROM BU_DEV.TMP_TBL_kilany A
 WHERE   EXISTS
           (SELECT '1'
              FROM sfrstcr
             WHERE     sfrstcr_term_code = '144510'
                   AND sfrstcr_rsts_code IN ('RE', 'RW')
                   AND sfrstcr_pidm = col01
                   AND sfrstcr_crn = col11);

-- return student to previous block

DECLARE
    L_COUNT         NUMBER (1) := 0;
    L_TOTAL_COUNT   NUMBER (6) := 0;

    CURSOR GET_DATA IS
        SELECT col13 BLCK, COL01 PIDM
          FROM BU_DEV.TMP_TBL_kilany
         WHERE col01 != 326147;
BEGIN
    FOR REC IN GET_DATA
    LOOP
        UPDATE SGBSTDN B
           SET SGBSTDN_BLCK_CODE = REC.BLCK
         WHERE     B.SGBSTDN_PIDM = REC.PIDM
               AND b.SGBSTDN_TERM_CODE_EFF =(select max(SGBSTDN_TERM_CODE_EFF) from SGBSTDN where sgbstdn_pidm = REC.PIDM )
               AND b.sgbstdn_stst_code = 'AS'
                ;

        L_COUNT := SQL%ROWCOUNT;
        L_TOTAL_COUNT := L_TOTAL_COUNT + L_COUNT;
        DBMS_OUTPUT.put_line (
            REC.PIDM || ' >>UPDATE ROWS PER STUDENT ' || L_COUNT);
    END LOOP;

    DBMS_OUTPUT.put_line ('TOTAL ' || L_TOTAL_COUNT);
END;

-- remove ssrblck

DELETE SSRBLCK
 WHERE EXISTS
           (SELECT '1'
              FROM BU_DEV.TMP_TBL_kilany
             WHERE     'FTRNG' || COL11 = SSRBLCK_blck_code
                   AND SSRBLCK_TERM_CODE = '144510');

-- remove stvblck

DELETE stvblck
 WHERE EXISTS
           (SELECT '1'
              FROM BU_DEV.TMP_TBL_kilany
             WHERE 'FTRNG' || COL11 = stvblck_code);
             
             --- REPORT 
             
             
             
               SELECT DISTINCT ssbsect_crn,
         DECODE (stvrsts_auto_grade, NULL, NULL, STVRSTS_AUTO_GRADE)
             rsts_code,
            
         scbcrse_coll_code,
         scbcrse_dept_code,
         stvcoll_desc,
         stvdept_desc,
         NVL (ssbsect_credit_hrs, scbcrse_credit_hr_low)
             credits,
         ssbsect_subj_code || '-' || ssbsect_crse_numb
             course_code,
         
         ssbsect_seq_numb,
         scbcrse_title,
         ssbsect_enrl,
          
         spriden_id,
         ' '
         || spriden_first_name
         || ' '
         || spriden_mi
         || ' '
         || spriden_last_name
             student_name, 
         ssbsect_camp_code,F_GET_DESC_FNC('STVCAMP',ssbsect_camp_code,30) CAMPUS ,
         
         f_get_desc_fnc ('stvcoll', a.sgbstdn_coll_code_1, 30)
             student_college , (SELECT sprtele_intl_access
                  FROM sprtele
                 WHERE     sprtele_pidm = spriden_pidm
                       AND sprtele_tele_code = 'MO'
                       AND ROWNUM = 1)     Mobile_NO
    FROM scbcrse,
         ssbsect,
         sfrstcr,
        
         stvcoll,
         stvdept,
         stvrsts,
         spriden,
         sgbstdn a
   WHERE     ssbsect_term_code = :p_term_code
          
         
         AND scbcrse_subj_code = ssbsect_subj_code
         AND scbcrse_crse_numb = ssbsect_crse_numb
         AND scbcrse_eff_term =
             (SELECT MAX (scbcrse_eff_term)
                FROM scbcrse
               WHERE     scbcrse_subj_code = ssbsect_subj_code
                     AND scbcrse_crse_numb = ssbsect_crse_numb
                     AND scbcrse_eff_term <= :p_term_code)
         AND   
             ssbsect_term_code = sfrstcr_term_code
         AND ssbsect_crn = sfrstcr_crn
         
          
         AND scbcrse_coll_code = stvcoll_code(+)
         AND scbcrse_dept_code = stvdept_code(+)
         AND sfrstcr_rsts_code = stvrsts_code
         AND sfrstcr_pidm = spriden_pidm
         AND spriden_change_ind IS NULL
         AND spriden_pidm = sgbstdn_pidm
         AND sgbstdn_term_code_eff = (SELECT MAX (sgbstdn_term_code_eff)
                                        FROM sgbstdn b
                                       WHERE b.sgbstdn_pidm = a.sgbstdn_pidm)
          
         
         AND EXISTS (SELECT '1' FROM BU_DEV.TMP_TBL_KILANY WHERE COL11=SFRSTCR_CRN)
         
--and SFRSTCR_crn='40240'
ORDER BY ssbsect_camp_code,
         scbcrse_coll_code,
         scbcrse_dept_code,
         course_code,
         ssbsect_crn,
         rsts_code DESC,
         student_name