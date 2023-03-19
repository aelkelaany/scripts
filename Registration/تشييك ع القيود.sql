 
SELECT SSBSECT_CRN ,SSBSECT_SUBJ_CODE ,SSBSECT_CRSE_NUMB ,F_GET_DESC_FNC('STVCAMP',SSBSECT_CAMP_CODE,30) CAMPUS  ,SSBSECT_CAMP_CODE
  FROM ssbsect
 WHERE     ssbsect_term_code = '144430'
       AND SSBSECT_PTRM_CODE = 1
       AND SSBSECT_MAX_ENRL > 0
       AND NOT EXISTS
               (SELECT '1'
                  FROM SSRRCMP
                 WHERE     SSRRCMP_CRN = ssbsect_CRN
                       AND SSRRCMP_TERM_CODE = '144430')
                       AND SSBSECT_CAMP_CODE NOT IN ('03','37')
                       
                       ;


--
SELECT SSBSECT_CRN ,SSBSECT_SUBJ_CODE ,SSBSECT_CRSE_NUMB ,F_GET_DESC_FNC('STVCAMP',SSBSECT_CAMP_CODE,30) CAMPUS  ,SSBSECT_CAMP_CODE
  FROM ssbsect
 WHERE     ssbsect_term_code = '144430'
       AND SSBSECT_PTRM_CODE = 1
       AND SSBSECT_MAX_ENRL > 0
       AND NOT EXISTS
               (SELECT '1'
                  FROM SSRRCMP
                 WHERE     SSRRCMP_CRN = ssbsect_CRN
                       AND SSRRCMP_TERM_CODE = '144430')
       AND NOT EXISTS
               (SELECT '1'
                  FROM SSRRCol
                 WHERE     SSRRCol_CRN = ssbsect_CRN
                       AND SSRRCol_TERM_CODE = '144430')
       AND NOT EXISTS
               (SELECT '1'
                  FROM SSRRdep
                 WHERE     SSRRdep_CRN = ssbsect_CRN
                       AND SSRRdep_TERM_CODE = '144430');


SELECT *
  FROM ssbsect
 WHERE     ssbsect_term_code = '144430'
       AND NOT EXISTS
               (SELECT '1'
                  FROM SSRRCol
                 WHERE     SSRRCol_CRN = ssbsect_CRN
                       AND SSRRCol_TERM_CODE = '144430');


SELECT *
  FROM ssbsect
 WHERE     ssbsect_term_code = '144430'
       AND NOT EXISTS
               (SELECT '1'
                  FROM SSRRdep
                 WHERE     SSRRdep_CRN = ssbsect_CRN
                       AND SSRRdep_TERM_CODE = '144430');


SELECT *
  FROM ssbsect
 WHERE     ssbsect_term_code = '144430'
       AND NOT EXISTS
               (SELECT '1'
                  FROM Sirasgn
                 WHERE     Sirasgn_CRN = ssbsect_CRN
                       AND Sirasgn_TERM_CODE = '144430')
       AND SSBSECT_MAX_ENRL > 0;