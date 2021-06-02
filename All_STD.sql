/* Formatted on 1/5/2020 1:02:13 PM (QP5 v5.227.12220.39754) */
INSERT INTO GLBEXTR
   SELECT 'STUDENT',
          'ALL_STD',
          'SAISUSR',
          'SAISUSR',
          PIDM,
          SYSDATE,
          'S',
          NULL
     FROM (SELECT DISTINCT TO_CHAR (SGBSTDN_PIDM) PIDM
             FROM SGBSTDN SG
            WHERE     SGBSTDN_TERM_CODE_EFF =
                         (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                            FROM SGBSTDN
                           WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                                  )
                  AND SGBSTDN_STST_CODE IN
                         ('AS', '„Ê', '„⁄', 'ÿ„', '≈ﬁ', '›ﬂ','')
           MINUS
           SELECT GLBEXTR_KEY
             FROM GLBEXTR
            WHERE     GLBEXTR_APPLICATION = 'STUDENT'
                  AND GLBEXTR_SELECTION LIKE 'ALL_STD'
                  AND GLBEXTR_CREATOR_ID = 'SAISUSR');



SELECT F_GET_STD_ID(GLBEXTR_KEY) FROM GLBEXTR
      WHERE     GLBEXTR_APPLICATION = 'STUDENT'
            AND GLBEXTR_SELECTION LIKE 'ALL_STD'
            AND GLBEXTR_CREATOR_ID = 'SAISUSR'
            AND EXISTS
                   (SELECT 'x'
                      FROM SGBSTDN SG
                     WHERE     sg.SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                                           )
                           AND SGBSTDN_STST_CODE IN
                                   ('ŒÃ', 'ÿ”', '„”', '„‰')
                                  and sgbstdn_pidm=GLBEXTR_KEY) ;

DELETE FROM GLBEXTR
      WHERE     GLBEXTR_APPLICATION = 'STUDENT'
            AND GLBEXTR_SELECTION LIKE 'ALL_STD'
            AND GLBEXTR_CREATOR_ID = 'SAISUSR'
            AND EXISTS
                   (SELECT 'x'
                      FROM SGBSTDN SG
                     WHERE     sg.SGBSTDN_TERM_CODE_EFF =
                                  (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                     FROM SGBSTDN
                                    WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                                           )
                           AND SGBSTDN_STST_CODE IN
                                  ('ŒÃ', 'ÿ”', '„”', '„‰')
                                  and sgbstdn_pidm=GLBEXTR_KEY) ;
                                  
                                  
                                  select f_get_pidm('441003436') from dual 
                                  ;
                                  
                                  ------------intesab
                                   Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'ALL_STD_IR', 'SAISUSR', 'All students «‰ ”«»', 'N', 
    SYSDATE, NULL);
                                  INSERT INTO GLBEXTR
   SELECT 'STUDENT',
          'ALL_STD_IR',
          'SAISUSR',
          'SAISUSR',
          PIDM,
          SYSDATE,
          'S',
          NULL
     FROM (SELECT DISTINCT TO_CHAR (SGBSTDN_PIDM) PIDM
             FROM SGBSTDN SG
            WHERE     SGBSTDN_TERM_CODE_EFF =
                         (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                            FROM SGBSTDN
                           WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                                  )
                  AND SGBSTDN_STST_CODE IN
                         ('AS', '„Ê', '„⁄', 'ÿ„', '≈ﬁ', '›ﬂ','ÿÌ')
                         and sgbstdn_styp_code='‰'
           MINUS
           SELECT GLBEXTR_KEY
             FROM GLBEXTR
            WHERE     GLBEXTR_APPLICATION = 'STUDENT'
                  AND GLBEXTR_SELECTION LIKE 'ALL_STD_IR'
                  AND GLBEXTR_CREATOR_ID = 'SAISUSR');