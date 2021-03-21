/* Formatted on 07/01/2021 09:32:12 (QP5 v5.227.12220.39754) */
SELECT SSBSECT_CRN,
       SSBSECT_CAMP_CODE,
       f_get_desc_fnc ('STVCAMP', SSBSECT_CAMP_CODE, 30) campus,f_get_desc_fnc ('STVCOLL', scbcrse_coll_CODE, 30) college ,
       scbcrse_title
  FROM ssbsect, scbcrse
 WHERE     ssbsect_term_code = '144220'
       AND SCBCRSE_EFF_TERM =
              (SELECT MAX (SCBCRSE_EFF_TERM)
                 FROM SCBCRSE
                WHERE     scbcrse_SUBJ_CODE = SSBSECT_SUBJ_CODE
                      AND scbcrse_CRSE_NUMB = SSBSECT_CRSE_NUMB)
       AND SSBSECT_PTRM_CODE = 1
       AND SSBSECT_SSTS_CODE = 'ä'
       AND scbcrse_SUBJ_CODE = SSBSECT_SUBJ_CODE
       AND scbcrse_CRSE_NUMB = SSBSECT_CRSE_NUMB
       and scbcrse_coll_CODE in('15','16','17','18','19','31','42')
       AND NOT EXISTS
                  (SELECT '2'
                     FROM SSRRDEP
                    WHERE     SSRRDEP_term_code = ssbsect_term_code
                          AND SSRRDEP_crn = ssbsect_crn);

 -- maintain

 /*
     INSERT INTO SSRRdep (SSRRdep_TERM_CODE,
                     SSRRdep_CRN,
                     SSRRdep_REC_TYPE,
                     SSRRdep_CAMP_IND,
                     SSRRdep_CAMP_CODE,
                     SSRRdep_ACTIVITY_DATE)
   SELECT ssbsect_term_code,
          ssbsect_crn,
          '1',
          'I',
          NULL,
          SYSDATE
      FROM ssbsect, scbcrse
 WHERE     ssbsect_term_code = '144220'
       AND SCBCRSE_EFF_TERM =
              (SELECT MAX (SCBCRSE_EFF_TERM)
                 FROM SCBCRSE
                WHERE     scbcrse_SUBJ_CODE = SSBSECT_SUBJ_CODE
                      AND scbcrse_CRSE_NUMB = SSBSECT_CRSE_NUMB)
       AND SSBSECT_PTRM_CODE = 1
       AND SSBSECT_SSTS_CODE = 'ä'
       AND scbcrse_SUBJ_CODE = SSBSECT_SUBJ_CODE
       AND scbcrse_CRSE_NUMB = SSBSECT_CRSE_NUMB
       and scbcrse_coll_CODE in('15','16','17','18','19','31','42')
       AND NOT EXISTS
                  (SELECT '2'
                     FROM SSRRDEP
                    WHERE     SSRRDEP_term_code = ssbsect_term_code
                          AND SSRRDEP_crn = ssbsect_crn);

INSERT INTO SSRRdep (SSRRdep_TERM_CODE,
                     SSRRdep_CRN,
                     SSRRdep_REC_TYPE,
                     SSRRdep_dep_IND,
                     SSRRdep_dept_CODE,
                     SSRRdep_ACTIVITY_DATE)
   SELECT ssbsect_term_code,
          ssbsect_crn,
          '2',
          NULL,
          scbcrse_dept_code,
          SYSDATE
     FROM ssbsect, scbcrse
 WHERE     ssbsect_term_code = '144220'
       AND SCBCRSE_EFF_TERM =
              (SELECT MAX (SCBCRSE_EFF_TERM)
                 FROM SCBCRSE
                WHERE     scbcrse_SUBJ_CODE = SSBSECT_SUBJ_CODE
                      AND scbcrse_CRSE_NUMB = SSBSECT_CRSE_NUMB)
       AND SSBSECT_PTRM_CODE = 1
       AND SSBSECT_SSTS_CODE = 'ä'
       AND scbcrse_SUBJ_CODE = SSBSECT_SUBJ_CODE
       AND scbcrse_CRSE_NUMB = SSBSECT_CRSE_NUMB
       and scbcrse_coll_CODE in('15','16','17','18','19','31','42')
       AND NOT EXISTS
                  (SELECT '2'
                     FROM SSRRDEP
                    WHERE     SSRRDEP_term_code = ssbsect_term_code
                          AND SSRRDEP_crn = ssbsect_crn);
                            
                            ------- end ; 
                            */