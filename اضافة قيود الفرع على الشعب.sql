 

SELECT *
  FROM ssbsect
 WHERE     ssbsect_term_code = '144210'

            and  NOT EXISTS
                    (SELECT '2'
                       FROM SSRRCMP
                      WHERE     SSRRCMP_term_code = ssbsect_term_code
                            AND SSRRCMP_crn = ssbsect_crn);
---------------
/*
INSERT INTO SSRRCMP (SSRRCMP_TERM_CODE,
                     SSRRCMP_CRN,
                     SSRRCMP_REC_TYPE,
                     SSRRCMP_CAMP_IND,
                     SSRRCMP_CAMP_CODE,
                     SSRRCMP_ACTIVITY_DATE)
   SELECT '144210',
          BU_DEV.TMP_TBL04.COL01,
          '1',
          'I',
          NULL,
          SYSDATE
     FROM BU_DEV.TMP_TBL04;

INSERT INTO SSRRCMP (SSRRCMP_TERM_CODE,
                     SSRRCMP_CRN,
                     SSRRCMP_REC_TYPE,
                     SSRRCMP_CAMP_IND,
                     SSRRCMP_CAMP_CODE,
                     SSRRCMP_ACTIVITY_DATE)
   SELECT '144210',
          BU_DEV.TMP_TBL04.COL01,
          '2',
          NULL,
          BU_DEV.TMP_TBL04.COL02,
          SYSDATE
     FROM BU_DEV.TMP_TBL04;
     
    */ 
     ;
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
    WHERE     ssbsect_term_code = '144210'
       
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
    WHERE     ssbsect_term_code = '144210'
       
            and  NOT EXISTS
                    (SELECT '2'
                       FROM SSRRCMP
                      WHERE     SSRRCMP_term_code = ssbsect_term_code
                            AND SSRRCMP_crn = ssbsect_crn
                            and SSRRCMP_REC_TYPE='2');