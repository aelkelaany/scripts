



UPDATE SFRSTCR

SET SFRSTCR_CREDIT_HR_HOLD=SFRSTCR_CREDIT_HR
WHERE 
SFRSTCR_PIDM=F_GET_PIDM('436006052')
AND SFRSTCR_TERM_CODE IN ('143930','143620')
AND SFRSTCR_CREDIT_HR_HOLD<>SFRSTCR_CREDIT_HR;



UPDATE   SHRTCKG
SET SHRTCKG_HOURS_ATTEMPTED=SHRTCKG_CREDIT_HOURS
WHERE SHRTCKG_PIDM=F_GET_PIDM('436006052')
AND SHRTCKG_TERM_CODE IN ('143930','143620')
AND SHRTCKG_HOURS_ATTEMPTED<>SHRTCKG_CREDIT_HOURS ;

--COMMIT ;


   UPDATE SHRTCKG G1
         SET SHRTCKG_HOURS_ATTEMPTED= SHRTCKG_CREDIT_HOURS  
       WHERE     SHRTCKG_TERM_CODE = :TermCode
             AND SHRTCKG_TCKN_SEQ_NO =
                    (SELECT SHRTCKN_SEQ_NO
                       FROM SHRTCKN
                      WHERE     SHRTCKN_PIDM = SHRTCKG_PIDM
                            AND SHRTCKN_TERM_CODE = :TermCode
                            AND SHRTCKN_SUBJ_CODE||SHRTCKN_CRSE_NUMB = :SUBJCODE)
                      AND G1.SHRTCKG_SEQ_NO =
                    (SELECT MAX (G2.SHRTCKG_SEQ_NO)
                       FROM SHRTCKG G2
                      WHERE     G2.SHRTCKG_PIDM = G1.SHRTCKG_PIDM
                            AND G2.SHRTCKG_TERM_CODE = G1.SHRTCKG_TERM_CODE
                            AND G2.SHRTCKG_TCKN_SEQ_NO =
                                   G1.SHRTCKG_TCKN_SEQ_NO)
             AND SHRTCKG_HOURS_ATTEMPTED<>:Cr_Hrs ;
             
             
           SELECT * FROM  SHRTCKG G1
         
       WHERE     SHRTCKG_TERM_CODE = :TermCode
             AND SHRTCKG_TCKN_SEQ_NO =
                    (SELECT SHRTCKN_SEQ_NO
                       FROM SHRTCKN
                      WHERE     SHRTCKN_PIDM = SHRTCKG_PIDM
                            AND SHRTCKN_TERM_CODE = :TermCode
                            AND SHRTCKN_SUBJ_CODE||SHRTCKN_CRSE_NUMB = :SUBJCODE)
                            AND G1.SHRTCKG_SEQ_NO =
                    (SELECT MAX (G2.SHRTCKG_SEQ_NO)
                       FROM SHRTCKG G2
                      WHERE     G2.SHRTCKG_PIDM = G1.SHRTCKG_PIDM
                            AND G2.SHRTCKG_TERM_CODE = G1.SHRTCKG_TERM_CODE
                            AND G2.SHRTCKG_TCKN_SEQ_NO =
                                   G1.SHRTCKG_TCKN_SEQ_NO)
            AND SHRTCKG_HOURS_ATTEMPTED<>:Cr_Hrs  ;