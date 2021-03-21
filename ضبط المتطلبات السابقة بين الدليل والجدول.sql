/* Formatted on 27/12/2020 15:23:32 (QP5 v5.227.12220.39754) */
INSERT INTO SSRRTST
   SELECT DISTINCT
          SSBSECT_TERM_CODE,
          ssbsect_crn,
          NVL (
               ROW_NUMBER ()
                  OVER (PARTITION BY ssbsect_crn ORDER BY ssbsect_crn)
             + (SELECT MAX (SSRRTST_SEQNO)
                  FROM SSRRTST
                 WHERE     SSRRTST_TERM_CODE = SSBSECT_TERM_CODE
                       AND SSRRTST_CRN = SSBSECT_CRN),
             SCRRTST_SEQNO)
             row_num,
          -- SCRRTST_SEQNO,
          SCRRTST_TESC_CODE,
          SCRRTST_TEST_SCORE,
          SCRRTST_SUBJ_CODE_PREQ,
          SCRRTST_CRSE_NUMB_PREQ,
          SCRRTST_LEVL_CODE,
          SCRRTST_MIN_GRDE,
          SCRRTST_CONCURRENCY_IND,
          SCRRTST_CONNECTOR,
          SCRRTST_LPAREN,
          SCRRTST_RPAREN,
          SCRRTST_ACTIVITY_DATE
     FROM SCRRTST, SSBSECT
    WHERE     SSBSECT_TERM_CODE = '144220'
          AND SCRRTST_SUBJ_CODE = SSBSECT_SUBJ_CODE
          AND SCRRTST_CRSE_NUMB = SSBSECT_CRSE_NUMB
          AND NOT EXISTS
                     (SELECT '1'
                        FROM SSRRTST
                       WHERE     SSRRTST_CRN = ssbsect_crn
                             AND SSRRTST_TERM_CODE = SSBSECT_TERM_CODE
                             AND SSRRTST_SUBJ_CODE_PREQ =
                                    SCRRTST_SUBJ_CODE_PREQ
                             AND SSRRTST_CRSE_NUMB_PREQ =
                                    SCRRTST_CRSE_NUMB_PREQ/*AND SSRRTST_SEQNO=SCRRTST_SEQNO*/
                                                          )
-- AND SSBSECT_CRN = '22100'
;