/* Formatted on 18/05/2021 09:45:01 (QP5 v5.227.12220.39754) */
SELECT *
  FROM ssbsect
 WHERE     ssbsect_term_code = '144310'
       AND NOT EXISTS
                  (SELECT '1'
                     FROM SSRRCMP
                    WHERE     SSRRCMP_CRN = ssbsect_CRN
                          AND SSRRCMP_TERM_CODE = '144310') ;
                          
                          
                 SELECT *
  FROM ssbsect
 WHERE     ssbsect_term_code = '144310'
       AND NOT EXISTS
                  (SELECT '1'
                     FROM SSRRCol
                    WHERE     SSRRCol_CRN = ssbsect_CRN
                          AND SSRRCol_TERM_CODE = '144310') ;  
                          
                          
                                           SELECT *
  FROM ssbsect
 WHERE     ssbsect_term_code = '144310'
       AND NOT EXISTS
                  (SELECT '1'
                     FROM SSRRdep
                    WHERE    SSRRdep_CRN = ssbsect_CRN
                          AND SSRRdep_TERM_CODE = '144310') ; 
                                 
                          
                                                                     SELECT *
 from ssbsect
 WHERE     ssbsect_term_code = '144310'
       AND NOT EXISTS
                  (SELECT '1'
                     FROM Sirasgn
                    WHERE    Sirasgn_CRN = ssbsect_CRN
                          AND Sirasgn_TERM_CODE = '144310')
                          and SSBSECT_MAX_ENRL>0 ; 