/* Formatted on 8/27/2020 8:40:25 PM (QP5 v5.360) */
UPDATE bu_dev.tmp_tbl03
   SET (col02, col03, col06) =
           (SELECT f_get_std_id (sgbstdn_pidm)       stid,
                   sgbstdn_pidm,
                   f_get_std_name (sgbstdn_pidm)     std_name
              FROM sgbstdn sg, spbpers
             WHERE sgbstdn_pidm = spbpers_pidm AND spbpers_ssn = col01);

UPDATE bu_dev.tmp_tbl03
   SET col05 =
           (SELECT MAX (SYRBLKR_BLCK_CODE)
              FROM syrblkr
             WHERE SYRBLKR_TERM_CODE = '144210' AND SYRBLKR_PROGRAM = col04);


UPDATE bu_dev.tmp_tbl03
   SET col07 = f_get_desc_fnc ('STVBLCK', col05, 60);

UPDATE bu_dev.tmp_tbl03
   SET (col08, col09) =
           (SELECT DISTINCT SORCMJR_DEPT_CODE, SORCMJR_majr_CODE
              FROM SOBCURR, SORCMJR
             WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
                   AND SOBCURR_PROGRAM = col04
                   AND SOBCURR_LEVL_CODE = 'Ã„');



INSERT INTO TRANSFER_STUDENT_PROGRAM (PIDM_CD,
                                      PROGRAM_CD,
                                      DEPT_CODE,
                                      MAJOR_CODE,
                                      NOTES)
    SELECT DISTINCT col03     PIDM_CD,
                    col04,
                    col08,
                    col09,
                    NULL
      FROM bu_dev.tmp_tbl03;

     EXEC ITRANSFER_PROC ('144210');


SELECT *
  FROM TRANSFER_STUDENT_PROGRAM
 WHERE PIDM_CD IN (SELECT col03 FROM bu_dev.tmp_tbl03);

UPDATE SGBSTDN A
   SET A.sgbstdn_blck_code =
           (SELECT col05
              FROM bu_dev.tmp_tbl03
             WHERE col03 = A.SGBSTDN_PIDM)
 WHERE     A.SGBSTDN_TERM_CODE_EFF =
           (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
              FROM SGBSTDN
             WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                   AND SGBSTDN_TERM_CODE_EFF <= '144210')
       AND SGBSTDN_TERM_CODE_ADMIT = '144210'
       AND A.SGBSTDN_PIDM IN (SELECT col03 FROM bu_dev.tmp_tbl03);


DELETE FROM
    sfrstcr
      WHERE     sfrstcr_term_code = '144210'
            AND sfrstcr_pidm IN (SELECT col03 FROM bu_dev.tmp_tbl03);

INSERT INTO GLBSLCT (GLBSLCT_APPLICATION,
                     GLBSLCT_SELECTION,
                     GLBSLCT_CREATOR_ID,
                     GLBSLCT_DESC,
                     GLBSLCT_LOCK_IND,
                     GLBSLCT_ACTIVITY_DATE,
                     GLBSLCT_TYPE_IND)
     VALUES ('STUDENT',
             'BLOCKSRYADH_REG_144210',
             'SAISUSR',
             ' ”ÃÌ· —“„ 144010  ',
             'N',
             SYSDATE,
             NULL);

INSERT INTO GLBEXTR
    SELECT 'STUDENT',
           'BLOCKSRYADH_REG_144210',
           'SAISUSR',
           'SAISUSR',
           PIDM,
           SYSDATE,
           'S',
           NULL
      FROM (SELECT col03 PIDM FROM bu_dev.tmp_tbl03);