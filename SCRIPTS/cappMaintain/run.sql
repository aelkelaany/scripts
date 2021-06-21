BEGIN
   CAPP_MANIPULATION_FUNCTIONAL.LOG_DELETE(4400);
    /*  CAPP_MANIPULATION_FUNCTIONAL.LOG_DELETE(500);
          CAPP_MANIPULATION_FUNCTIONAL.LOG_DELETE(400);
          
          GENERAL.GJBPRUN
       */
          commit ;
    SYKCMPG.SYPCMPG;
   COMMIT;
END;


SELECT SGBSTDN_PIDM PIDM
           FROM (SELECT F_CHECK_RULE (SGBSTDN_PIDM, 'R_CAPP_NUTR_33') FUNC,
                        SGBSTDN_PIDM
                   FROM SGBSTDN X
                  WHERE     SGBSTDN_TERM_CODE_EFF =
                               (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                  FROM SGBSTDN D
                                 WHERE D.SGBSTDN_PIDM = X.SGBSTDN_PIDM)
                        AND SGBSTDN_LEVL_CODE = 'Ã„'
                        AND sgbstdn_stst_code NOT IN
                               ('ŒÃ', '„”', 'ÿ”', 'IS', 'PS', '„Œ')
                        AND SGBSTDN_STYP_CODE NOT IN ('‰') /* AND (SGBSTDN_PIDM = P_PPIDM OR P_PPIDM = 0)*/
                         AND SGBSTDN_PIDM in (F_GET_PIDM('437005543') ,F_GET_PIDM('437006639') )) 
                        
           WHERE FUNC = 'N'
 