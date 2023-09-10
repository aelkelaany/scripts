/* Formatted on 8/22/2023 3:22:20 PM (QP5 v5.371) */
--CRN>>COL11

SELECT * FROM BU_DEV.TMP_TBL_kilany1;

SELECT DISTINCT COL11
  FROM BU_DEV.TMP_TBL_kilany1;

SELECT COUNT (1)
  FROM BU_DEV.TMP_TBL_kilany1
 WHERE NOT EXISTS
           (SELECT '1'
              FROM SSBSECT
             WHERE SSBSECT_TERM_CODE = '144510' AND SSBSECT_CRN = COL11);

-- store current block 

UPDATE BU_DEV.TMP_TBL_kilany1
   SET col13 =
           (SELECT sgbstdn_blck_code
              FROM sgbstdn
             WHERE SGBSTDN_TERM_CODE_EFF = '144510' AND sgbstdn_pidm = col01);

-- create new temp blocks 

INSERT INTO STVBLCK
      SELECT DISTINCT 'ENGL' || COL11, 'ENGLISH CENTER ' || COL11, SYSDATE
        FROM BU_DEV.TMP_TBL_kilany1
    ORDER BY 1;

-- fill blocks with crns

INSERT INTO SSRBLCK (SSRBLCK_TERM_CODE,
                     SSRBLCK_BLCK_CODE,
                     SSRBLCK_CRN,
                     SSRBLCK_ACTIVITY_DATE)
    SELECT DISTINCT '144510',
                    'ENGL' || COL11,
                    COL11,
                    SYSDATE
      FROM BU_DEV.TMP_TBL_kilany1;

      ------- link students with block 

DECLARE
    L_COUNT         NUMBER (1) := 0;
    L_TOTAL_COUNT   NUMBER (6) := 0;

    CURSOR GET_DATA IS
        SELECT 'ENGL' || COL11 BLCK, COL01 PIDM
          FROM BU_DEV.TMP_TBL_kilany1
         WHERE col01 != 326147;
BEGIN
    FOR REC IN GET_DATA
    LOOP
        UPDATE SGBSTDN B
           SET SGBSTDN_BLCK_CODE = REC.BLCK
         WHERE     B.SGBSTDN_PIDM = REC.PIDM
               AND b.SGBSTDN_TERM_CODE_EFF = '144510'
               AND b.sgbstdn_stst_code = 'AS'
               AND EXISTS
                       (SELECT '1'
                          FROM SARAPPD
                         WHERE     SARAPPD_PIDM = B.SGBSTDN_PIDM
                               AND SARAPPD_APDC_CODE = 'FA'
                               AND SARAPPD_TERM_CODE_ENTRY = '144510');

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
             'BLOCKS_REGS_1445101',
             'SAISUSR',
             'ÊÓÌíá ÑÒã 144510  ',
             'N',
             SYSDATE,
             NULL);

INSERT INTO GLBEXTR
    SELECT 'STUDENT',
           'BLOCKS_REGS_1445101',
           'SAISUSR',
           'SAISUSR',
           SGBSTDN_PIDM,
           SYSDATE,
           'S',
           NULL
      FROM (SELECT DISTINCT col01     SGBSTDN_PIDM
              FROM BU_DEV.TMP_TBL_kilany1
             WHERE EXISTS
                       (SELECT '2'
                          FROM sgbstdn b
                         WHERE     B.SGBSTDN_PIDM = col01
                               AND b.SGBSTDN_TERM_CODE_EFF = '144510'
                               AND b.sgbstdn_stst_code = 'AS'
                               AND EXISTS
                                       (SELECT '1'
                                          FROM SARAPPD
                                         WHERE     SARAPPD_PIDM =
                                                   B.SGBSTDN_PIDM
                                               AND SARAPPD_APDC_CODE = 'FA'
                                               AND SARAPPD_TERM_CODE_ENTRY =
                                                   '144510')));

     --- go to sfamreg 

     -- check regist crn 

SELECT *
  FROM BU_DEV.TMP_TBL_kilany1
 WHERE NOT EXISTS
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
          FROM BU_DEV.TMP_TBL_kilany1
         WHERE col01 != 326147;
BEGIN
    FOR REC IN GET_DATA
    LOOP
        UPDATE SGBSTDN B
           SET SGBSTDN_BLCK_CODE = REC.BLCK
         WHERE     B.SGBSTDN_PIDM = REC.PIDM
               AND b.SGBSTDN_TERM_CODE_EFF = '144510'
               AND b.sgbstdn_stst_code = 'AS'
               AND EXISTS
                       (SELECT '1'
                          FROM SARAPPD
                         WHERE     SARAPPD_PIDM = B.SGBSTDN_PIDM
                               AND SARAPPD_APDC_CODE = 'FA'
                               AND SARAPPD_TERM_CODE_ENTRY = '144510');

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
              FROM BU_DEV.TMP_TBL_kilany1
             WHERE     'ENGL' || COL11 = SSRBLCK_blck_code
                   AND SSRBLCK_TERM_CODE = '144510');

-- remove stvblck

DELETE stvblck
 WHERE EXISTS
           (SELECT '1'
              FROM BU_DEV.TMP_TBL_kilany1
             WHERE 'ENGL' || COL11 = stvblck_code);