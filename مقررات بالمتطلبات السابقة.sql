/* Formatted on 11/1/2023 12:50:08 PM (QP5 v5.371) */
  SELECT SCRRTST_SUBJ_CODE,
         SCRRTST_CRSE_NUMB,
         mc.scbcrse_title     main_course_title,
         SCRRTST_TERM_CODE_EFF,
         SCRRTST_SEQNO,
         SCRRTST_TESC_CODE,
         SCRRTST_TEST_SCORE,
         SCRRTST_SUBJ_CODE_PREQ,
         SCRRTST_CRSE_NUMB_PREQ,
         pq.scbcrse_title     pq_course_title,
         SCRRTST_LEVL_CODE,
         SCRRTST_MIN_GRDE,
         SCRRTST_CONCURRENCY_IND,
         SCRRTST_CONNECTOR,
         SCRRTST_LPAREN,
         SCRRTST_RPAREN
    FROM SCRRTST, scbcrse mc, scbcrse pq
   WHERE     EXISTS
                 (SELECT '1'
                    FROM smracaa
                   WHERE     SMRACAA_SUBJ_CODE || SMRACAA_CRSE_NUMB_LOW =
                             SCRRTST_SUBJ_CODE || SCRRTST_CRSE_NUMB
                         AND EXISTS
                                 (SELECT '2'
                                    FROM smrpaap
                                   WHERE     SMRPAAP_AREA = smracaa_area
                                         AND SMRPAAP_PROGRAM LIKE '%45'))
         AND SCRRTST_SUBJ_CODE || SCRRTST_CRSE_NUMB =
             mc.scbcrse_subj_code || mc.scbcrse_crse_numb
         AND SCRRTST_SUBJ_CODE_PREQ || SCRRTST_CRSE_NUMB_PREQ =
             pq.scbcrse_subj_code || pq.scbcrse_crse_numb
ORDER BY SCRRTST_SUBJ_CODE, SCRRTST_CRSE_NUMB,SCRRTST_SEQNO