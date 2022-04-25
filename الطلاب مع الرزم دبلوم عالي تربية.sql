/* Formatted on 4/19/2022 10:26:32 AM (QP5 v5.371) */
  SELECT f_get_std_id (A.SGBSTDN_PIDM)       AS "«·—ﬁ„ «·Ã«„⁄Ì",
         f_get_std_name (A.SGBSTDN_PIDM)     StudentName,
         A.SGBSTDN_PROGRAM_1,
         C.SMRPRLE_PROGRAM_DESC,
         A.SGBSTDN_BLCK_CODE,
         F_GET_DESC_FNC ('STVBLCK', A.SGBSTDN_BLCK_CODE, 30),
         SSRBLCK_CRN,
         SCBCRSE_TITLE
    FROM SGBSTDN A,
         SMRPRLE C,
         SSRBLCK,
         SSBSECT,
         SCBCRSE
   WHERE     A.SGBSTDN_LEVL_CODE = 'œ⁄'
         AND f_get_std_id (A.SGBSTDN_PIDM) LIKE '443%'
         AND A.SGBSTDN_PROGRAM_1 = C.SMRPRLE_PROGRAM
         AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (B.SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN B
                                       WHERE B.SGBSTDN_PIDM = A.SGBSTDN_PIDM)
         AND A.SGBSTDN_STST_CODE = 'AS'
         AND SSRBLCK_BLCK_CODE = A.SGBSTDN_BLCK_CODE
         AND SSRBLCK_TERM_CODE = '144330'
         AND SSBSECT_TERM_CODE = '144330'
         AND SSBSECT_CRN = SSRBLCK_CRN
         AND SSBSECT_SUBJ_CODE || SSBSECT_CRSE_NUMB =
             SCBCRSE_SUBJ_CODE || SCBCRSE_CRSE_NUMB
ORDER BY 3,
         5,
         1,
         7;

SELECT f_get_std_id (A.SGBSTDN_PIDM)       AS "«·—ﬁ„ «·Ã«„⁄Ì",
       f_get_std_name (A.SGBSTDN_PIDM)     StudentName,
       SGBSTDN_BLCK_CODE,
       A.SGBSTDN_PROGRAM_1,
       C.SMRPRLE_PROGRAM_DESC
  FROM SGBSTDN A, SMRPRLE C
 WHERE     A.SGBSTDN_LEVL_CODE = 'œ⁄'
       AND f_get_std_id (A.SGBSTDN_PIDM) LIKE '443%'
       AND A.SGBSTDN_PROGRAM_1 = C.SMRPRLE_PROGRAM
       AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (B.SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN B
                                     WHERE B.SGBSTDN_PIDM = A.SGBSTDN_PIDM)
       AND A.SGBSTDN_STST_CODE = 'AS'
       AND SGBSTDN_BLCK_CODE NOT IN (SELECT SSRBLCK_BLCK_CODE
                                       FROM SSRBLCK
                                      WHERE SSRBLCK_TERM_CODE = '144330');

--all

SELECT DISTINCT
       f_get_std_id (A.SGBSTDN_PIDM),
       SGBSTDN_BLCK_CODE,
       F_GET_DESC_FNC ('STVBLCK', A.SGBSTDN_BLCK_CODE, 30)
  FROM SGBSTDN A
 WHERE     A.SGBSTDN_LEVL_CODE = 'œ⁄'
       AND f_get_std_id (A.SGBSTDN_PIDM) LIKE '443%'
       AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (B.SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN B
                                     WHERE B.SGBSTDN_PIDM = A.SGBSTDN_PIDM)
       AND A.SGBSTDN_STST_CODE = 'AS';

SELECT DISTINCT
       f_get_std_id (A.SGBSTDN_PIDM),
       SGBSTDN_BLCK_CODE,
       F_GET_DESC_FNC ('STVBLCK', A.SGBSTDN_BLCK_CODE, 30)
  FROM SGBSTDN A
 WHERE     A.SGBSTDN_LEVL_CODE = 'œ⁄'
       AND f_get_std_id (A.SGBSTDN_PIDM) LIKE '443%'
       AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (B.SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN B
                                     WHERE B.SGBSTDN_PIDM = A.SGBSTDN_PIDM)
       AND A.SGBSTDN_STST_CODE = 'AS'
       AND SGBSTDN_BLCK_CODE NOT IN (SELECT SSRBLCK_BLCK_CODE
                                       FROM SSRBLCK
                                      WHERE SSRBLCK_TERM_CODE = '144330');

SELECT DISTINCT SSRBLCK_BLCK_CODE
  FROM SSRBLCK
 WHERE     SSRBLCK_TERM_CODE = '144330'
       AND SSRBLCK_BLCK_CODE IN
               (SELECT SGBSTDN_BLCK_CODE
                  FROM SGBSTDN
                 WHERE     SGBSTDN_TERM_CODE_EFF = '144320'
                       AND SGBSTDN_LEVL_CODE = 'œ⁄');


SELECT SSBSECT_CRN, SCBCRSE_TITLE
  FROM SSBSECT, SCBCRSE
 WHERE     SSBSECT_TERM_CODE = '144330'
       AND SSBSECT_CRN NOT IN (SELECT SSRBLCK_CRN
                                 FROM SSRBLCK
                                WHERE SSRBLCK_TERM_CODE = SSBSECT_TERM_CODE)
       AND SSBSECT_SUBJ_CODE || SSBSECT_CRSE_NUMB =
           SCBCRSE_SUBJ_CODE || SCBCRSE_CRSE_NUMB;

           --upload
Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'D3_STUDENTS', 'SAISUSR', 'ÿ·«» œ»·Ê„ ⁄«·Ì', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'D3_STUDENTS', 'SAISUSR', 'SAISUSR', PIDM, 
    SYSDATE, 'S', NULL  FROM 
(
SELECT DISTINCT
A.SGBSTDN_PIDM as pidm ,
       f_get_std_id (A.SGBSTDN_PIDM)       AS "«·—ﬁ„ «·Ã«„⁄Ì",
       f_get_std_name (A.SGBSTDN_PIDM)     StudentName
  FROM SGBSTDN A 
 WHERE     A.SGBSTDN_LEVL_CODE = 'œ⁄'
       AND f_get_std_id (A.SGBSTDN_PIDM) LIKE '443%'
       AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (B.SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN B
                                     WHERE B.SGBSTDN_PIDM = A.SGBSTDN_PIDM)
     --  AND A.SGBSTDN_STST_CODE = 'AS'
        
       );
       
       
       
     