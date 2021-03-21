/* Formatted on 8/13/2020 10:12:07 PM (QP5 v5.360) */
SELECT *
  FROM (  SELECT DISTINCT
                 SHRLGPA_PIDM
                     PIDM,
                 f_get_std_id (SHRLGPA_PIDM)
                     "«·—ﬁ„ «·„—Ã⁄Ì",
                 f_get_std_name (SHRLGPA_PIDM)
                     "«”„ «·ÿ«·»",
                 SHRTTRM_TERM_CODE
                     "«·›’· «·œ—«”Ì",
                 f_get_desc_fnc ('STVASTD', SHRTTRM_ASTD_CODE_END_OF_TERM, 60)
                     "«·Ê÷⁄ «·«ﬂ«œÌ„Ì",
                 SHRTTRM_ASTD_CODE_END_OF_TERM " ﬂÊœ «·Ê÷⁄",
                 ROUND (SHRLGPA_GPA, 2) "«·„⁄œ· «· —«ﬂ„Ì",
                 SHRLGPA_HOURS_ATTEMPTED "” „⁄ „œ…" ,
                     SHRLGPA_HOURS_EARNED "” „ﬂ ”»…",
                 SHRLGPA_GPA_HOURS "” „⁄œ·",
                 SHRLGPA_HOURS_PASSED "” „Ã «“…",
                 SHRLGPA_QUALITY_POINTS "«·‰ﬁ«ÿ"
            FROM shrttrm, SHRLGPA
           WHERE     SHRLGPA_PIDM = shrttrm_PIDM
                 AND SHRLGPA_GPA_TYPE_IND = 'O'
                 AND SHRTTRM_TERM_CODE = '144030'
                 AND SHRLGPA_PIDM IN
                         (SELECT SFRSTCR_PIDM
                            FROM SFRSTCR
                           WHERE     SFRSTCR_TERM_CODE = '143820'
                                 AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
                                 AND SFRSTCR_CRN = '27361')
        ORDER BY 1, 2 ASC)
 WHERE "«·›’· «·œ—«”Ì" =
       (SELECT MAX (SHRTTRM_TERM_CODE)
          FROM SHRTTRM
         WHERE SHRTTRM_PIDM = PIDM AND SHRTTRM_TERM_CODE <= '144030')