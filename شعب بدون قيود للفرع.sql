/* Formatted on 07/01/2021 09:32:12 (QP5 v5.227.12220.39754) */

  UPDATE ssbsect
   SET ssbsect_max_enrl = 0, SSBSECT_SEATS_AVAIL = 0, ssbsect_enrl = 0
 WHERE     ssbsect_term_code = '144510'
 and ssbsect_crn in ( select crn from (

SELECT SSBSECT_CRN crn,
       SSBSECT_CAMP_CODE,
       f_get_desc_fnc ('STVCAMP', SSBSECT_CAMP_CODE, 30) campus,f_get_desc_fnc ('STVCOLL', scbcrse_coll_CODE, 30) college ,
       scbcrse_title
  FROM ssbsect, scbcrse
 WHERE     ssbsect_term_code = '144510'
       AND SCBCRSE_EFF_TERM =
              (SELECT MAX (SCBCRSE_EFF_TERM)
                 FROM SCBCRSE
                WHERE     scbcrse_SUBJ_CODE = SSBSECT_SUBJ_CODE
                      AND scbcrse_CRSE_NUMB = SSBSECT_CRSE_NUMB)
       AND SSBSECT_PTRM_CODE = 1
       AND SSBSECT_SSTS_CODE = 'ä'
       and ssbsect_max_enrl>0
       AND scbcrse_SUBJ_CODE = SSBSECT_SUBJ_CODE
       AND scbcrse_CRSE_NUMB = SSBSECT_CRSE_NUMB
       AND NOT EXISTS
                  (SELECT '2'
                     FROM SSRRCMP
                    WHERE     SSRRCMP_term_code = ssbsect_term_code
                          AND SSRRCMP_crn = ssbsect_crn) ));

 -- maintain

 /*
     INSERT INTO SSRRCMP (SSRRCMP_TERM_CODE,
                     SSRRCMP_CRN,
                     SSRRCMP_REC_TYPE,
                     SSRRCMP_CAMP_IND,
                     SSRRCMP_CAMP_CODE,
                     SSRRCMP_ACTIVITY_DATE)
   SELECT ssbsect_term_code,
          ssbsect_crn,
          '1',
          'I',
          NULL,
          SYSDATE
     FROM ssbsect
    WHERE     ssbsect_term_code = '144510'
       and SSBSECT_PTRM_CODE =1
and SSBSECT_SSTS_CODE='ä'
            and  NOT EXISTS
                    (SELECT '2'
                       FROM SSRRCMP
                      WHERE     SSRRCMP_term_code = ssbsect_term_code
                            AND SSRRCMP_crn = ssbsect_crn
                            and SSRRCMP_REC_TYPE='1');

INSERT INTO SSRRCMP (SSRRCMP_TERM_CODE,
                     SSRRCMP_CRN,
                     SSRRCMP_REC_TYPE,
                     SSRRCMP_CAMP_IND,
                     SSRRCMP_CAMP_CODE,
                     SSRRCMP_ACTIVITY_DATE)
   SELECT ssbsect_term_code,
          ssbsect_crn,
          '2',
          NULL,
          SSBSECT_CAMP_CODE,
          SYSDATE
     FROM ssbsect
    WHERE     ssbsect_term_code = '144510'
       and SSBSECT_PTRM_CODE =1
and SSBSECT_SSTS_CODE='ä'
            and  NOT EXISTS
                    (SELECT '2'
                       FROM SSRRCMP
                      WHERE     SSRRCMP_term_code = ssbsect_term_code
                            AND SSRRCMP_crn = ssbsect_crn
                            and SSRRCMP_REC_TYPE='2');
                            
                            ------- end ; 
                            */