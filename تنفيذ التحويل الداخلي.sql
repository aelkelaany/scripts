/* Formatted on 16/08/2021 14:30:17 (QP5 v5.227.12220.39754) */
/* validation */



/* Execution*/

DELETE TRANSFER_STUDENT_PROGRAM;

INSERT INTO TRANSFER_STUDENT_PROGRAM (PIDM_CD,
                                      PROGRAM_CD,
                                      DEPT_CODE,
                                      MAJOR_CODE,
                                      NOTES)
   SELECT PIDM_CD,
          PROGRAM_CD,
          DEPT_CODE,
          MAJOR_CODE,
          NOTES
     FROM (SELECT m.request_no,
                  REQUESTER_PIDM PIDM_CD,
                  (SELECT d.item_value
                     FROM request_details d
                    WHERE     d.request_no = m.request_no
                          AND d.sequence_no = 1
                          AND d.item_code = 'TRANSFER_PROGRAM')
                     PROGRAM_CD,
                  (SELECT d.item_value
                     FROM request_details d
                    WHERE     d.request_no = m.request_no
                          AND d.sequence_no = 1
                          AND d.item_code = 'TRANSFER_DEPT')
                     DEPT_CODE,
                  (SELECT d.item_value
                     FROM request_details d
                    WHERE     d.request_no = m.request_no
                          AND d.sequence_no = 1
                          AND d.item_code = 'TRANSFER_MAJOR')
                     MAJOR_CODE,
                  NULL NOTES
             FROM request_master m
            WHERE     object_code = 'WF_TRANSFER'
                  AND request_status IN ('C')
                  AND EXISTS
                         (SELECT '1'
                            FROM request_details d
                           WHERE     d.request_no = m.request_no
                                 AND d.sequence_no = 1
                                 AND d.item_code = 'TERM'
                                 AND D.ITEM_VALUE = '144230'));

                                 /*validation after insertion*/

SELECT SOBCURR_CURR_RULE,
       SOBCURR_PROGRAM,
       SORCMJR_CMJR_RULE,
       SOBCURR_CAMP_CODE,
       SOBCURR_COLL_CODE
  FROM SOBCURR, SORCMJR
 WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
       AND SOBCURR_PROGRAM IN
              (SELECT PROGRAM_CD FROM TRANSFER_STUDENT_PROGRAM);

SELECT COUNT (DISTINCT PROGRAM_CD) FROM TRANSFER_STUDENT_PROGRAM;

  SELECT f_get_std_id(pidm_cd),A.*
    FROM TRANSFER_STUDENT_PROGRAM A
   WHERE (PROGRAM_CD IS NULL OR DEPT_CODE IS NULL OR MAJOR_CODE IS NULL)
ORDER BY 2, 3;

-- update the missing program code

UPDATE TRANSFER_STUDENT_PROGRAM t
   SET t.PROGRAM_CD =
          (SELECT PROGRAM_CD
             FROM TRANSFER_STUDENT_PROGRAM
            WHERE     DEPT_CODE = t.DEPT_CODE
                  AND MAJOR_CODE = t.MAJOR_CODE
                  AND f_get_gender (pidm_cd) = f_get_gender (t.pidm_cd)
                  AND ROWNUM < 2)
 WHERE PROGRAM_CD IS NULL;

                  -- check again

SELECT SOBCURR_CURR_RULE,
       SOBCURR_PROGRAM,
       SORCMJR_CMJR_RULE,
       SOBCURR_CAMP_CODE,
       SOBCURR_COLL_CODE
  FROM SOBCURR, SORCMJR
 WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
       AND SOBCURR_PROGRAM IN
              (SELECT PROGRAM_CD FROM TRANSFER_STUDENT_PROGRAM);

SELECT *
  FROM TRANSFER_STUDENT_PROGRAM a
 WHERE     EXISTS
              (SELECT '1'
                 FROM spbpers
                WHERE spbpers_pidm = PIDM_CD AND spbpers_sex = 'F')
       AND EXISTS
              (SELECT '1'
                 FROM symtrcl_dept_mapping
                WHERE PROGRAM_CODE = PROGRAM_CD AND GENDER = 'M');
                
                SELECT *
  FROM TRANSFER_STUDENT_PROGRAM a
 WHERE     EXISTS
              (SELECT '1'
                 FROM spbpers
                WHERE spbpers_pidm = PIDM_CD AND spbpers_sex = 'M')
       AND EXISTS
              (SELECT '1'
                 FROM symtrcl_dept_mapping
                WHERE PROGRAM_CODE = PROGRAM_CD AND GENDER = 'F');


SELECT DISTINCT PROGRAM_CD, f_get_program_full_desc ('144310', PROGRAM_CD)
  FROM TRANSFER_STUDENT_PROGRAM a
 WHERE EXISTS
          (SELECT '1'
             FROM spbpers
            WHERE spbpers_pidm = PIDM_CD AND spbpers_sex = 'F');
            
            SELECT DISTINCT PROGRAM_CD, f_get_program_full_desc ('144310', PROGRAM_CD)
  FROM TRANSFER_STUDENT_PROGRAM a
 WHERE EXISTS
          (SELECT '1'
             FROM spbpers
            WHERE spbpers_pidm = PIDM_CD AND spbpers_sex = 'M');

              /*reporting*/

  SELECT SOBCURR_CURR_RULE,
         SORCMJR_CMJR_RULE,
         SOBCURR_PROGRAM,
         f_get_desc_fnc ('STVMAJR', SORCMJR_MAJR_CODE, 60),
         SORCMJR_MAJR_CODE,
         f_get_desc_fnc ('STVDEPT', SORCMJR_DEPT_CODE, 60),
         SORCMJR_DEPT_CODE,
         f_get_desc_fnc ('STVCAMP', SOBCURR_CAMP_CODE, 60),
         SOBCURR_CAMP_CODE,
         f_get_desc_fnc ('STVCOLL', SOBCURR_COLL_CODE, 60),
         SOBCURR_COLL_CODE
    FROM SOBCURR, SORCMJR
   WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
         AND SOBCURR_PROGRAM IN
                (SELECT PROGRAM_CD FROM TRANSFER_STUDENT_PROGRAM)
ORDER BY SOBCURR_COLL_CODE;




/*Excuting*/

--exec ITRANSFER_PROC ('144310') ;

 SELECT f_get_std_id(pidm_cd),a.*
          FROM TRANSFER_STUDENT_PROGRAM a
         WHERE notes ='Y' ;
         
         ----compilance----
          Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'ST_TRANS_1443', 'SAISUSR', 'ØáÇÈ ãÍæáíä 1443', 'N', 
    SYSDATE, NULL);
                                  INSERT INTO GLBEXTR
   SELECT 'STUDENT',
          'ST_TRANS_1443',
          'SAISUSR',
          'SAISUSR',
          PIDM,
          SYSDATE,
          'S',
          NULL
     FROM (SELECT PIDM_CD PIDM
             FROM  TRANSFER_STUDENT_PROGRAM);
             
             
             --ACADEMIC ADVISING 
             --
             DELETE FROM
    sgradvr
      WHERE SGRADVR_PIDM IN
                (  SELECT PIDM_CD PIDM
             FROM  TRANSFER_STUDENT_PROGRAM);