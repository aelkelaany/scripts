/* Formatted on 8/25/2020 11:43:13 PM (QP5 v5.360) */
SELECT f_get_std_id(SGRADVR_PIDM) student_id ,f_get_std_name(SGRADVR_PIDM) student_name,f_get_std_id(SGRADVR_ADVR_PIDM) advisor_id ,  f_get_std_name(SGRADVR_ADVR_PIDM) advisor_name , SGBSTDN_STST_CODE , sgbstdn_dept_code
  FROM sgradvr, SGBSTDN SG
 WHERE     SGRADVR_PIDM = SGBSTDN_PIDM
       AND SGBSTDN_TERM_CODE_EFF =
           (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
              FROM SGBSTDN
             WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                   AND SGBSTDN_TERM_CODE_EFF <= '144320')
       AND SGBSTDN_DEPT_CODE NOT IN
               (SELECT SIRDPCL_DEPT_CODE
                  FROM SIRDPCL
                 WHERE     SIRDPCL_PIDM = SGRADVR_ADVR_PIDM
                       AND SIRDPCL_TERM_CODE_EFF =
                           (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                              FROM SIRDPCL
                             WHERE SIRDPCL_PIDM = SGRADVR_ADVR_PIDM));
                             
      SELECT SIRDPCL_DEPT_CODE
                  FROM SIRDPCL a
                 WHERE     SIRDPCL_PIDM = f_get_pidm('3685')
                       AND SIRDPCL_TERM_CODE_EFF =
                           (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                              FROM SIRDPCL
                             WHERE SIRDPCL_PIDM = a.SIRDPCL_pidm) ;                       
                             


DELETE FROM
    sgradvr
      WHERE (SGRADVR_PIDM,SGRADVR_ADVR_PIDM) IN
                (SELECT SGRADVR_PIDM,SGRADVR_ADVR_PIDM
                   FROM sgradvr, SGBSTDN SG
                  WHERE     SGRADVR_PIDM = SGBSTDN_PIDM
                        AND SGBSTDN_TERM_CODE_EFF =
                            (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                               FROM SGBSTDN
                              WHERE     SGBSTDN_PIDM = SG.SGBSTDN_PIDM
                                    AND SGBSTDN_TERM_CODE_EFF <= '144320')
                        AND SGBSTDN_DEPT_CODE NOT IN
                                (SELECT SIRDPCL_DEPT_CODE
                                   FROM SIRDPCL
                                  WHERE     SIRDPCL_PIDM = SGRADVR_ADVR_PIDM
                                        AND SIRDPCL_TERM_CODE_EFF =
                                            (SELECT MAX (
                                                        SIRDPCL_TERM_CODE_EFF)
                                               FROM SIRDPCL
                                              WHERE SIRDPCL_PIDM =
                                                    SGRADVR_ADVR_PIDM)));


DELETE FROM
    sgradvr
      WHERE SGRADVR_PIDM IN
                (SELECT DISTINCT sgbstdn_pidm
                   FROM sgbstdn sg
                  WHERE     sgbstdn_stst_code IN ('ÎÌ',
                                                  'ØÓ',
                                                  'ãÓ',
                                                  'ãÎ',
                                                  'IS',
                                                  'ãä',
                                                  'TE',
                                                  'ãÝ',
                                                  'Øä')
                        AND SGBSTDN_TERM_CODE_EFF =
                            (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                               FROM sgbstdn
                              WHERE sgbstdn_pidm = sg.sgbstdn_pidm)) ;
                              
                              
                              object_definition
                              
                          
                        
                         SFRSTCA