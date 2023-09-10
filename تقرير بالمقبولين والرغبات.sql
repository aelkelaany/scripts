/* Formatted on 8/22/2023 12:31:47 PM (QP5 v5.371) */
  SELECT *
    FROM (SELECT sarappd_pidm ,spbpers_ssn
                     AS "—ﬁ„ «·ÂÊÌ…",
                 DECODE (ADMISSION_TYPE, 'UG', '«”«”Ì…', '‘Ê«€—')
                     AS "ﬂÊœ «·»Ê«»…",
                 f_get_std_id (spbpers_pidm)
                     AS "«·—ﬁ„ «·Ã«„⁄Ì",
                 f_get_std_name (spbpers_pidm)
                     AS "«”„ «·ÿ«·»",
                 DECODE (spbpers_sex,  'M', '–ﬂ—',  'F', '«‰ÀÏ')
                     "«·‰Ê⁄",
                 saradap_coll_code_1
                     "«·ﬂ·Ì…",
                 SARADAP_PROGRAM_1
                     AS "ﬂÊœ «·»—‰«„Ã",
                 (SELECT SORCMJR_DESC
                    FROM SORCMJR
                   WHERE     SORCMJR_CURR_RULE = SARADAP_CURR_RULE_1
                         AND SORCMJR_CMJR_RULE = SARADAP_CMJR_RULE_1_1)
                     AS "Ê’› «·»—‰«„Ã",
                 SARAPPD_APPL_NO
                     "—ﬁ„ «·—€»…",
                 DECODE (sarappd_apdc_code,  'QA', '1',  'FA', '1',  'WA', '2')
                     "APPStatus",
                 x.mobile
                     "—ﬁ„ «·ÃÊ«·",
                 ADDRESS_CITY,
                 ADDRESS_STREET,
                 BIRTH_DATE,
                 TO_CHAR (BIRTH_DATE,
                          'DD-MM-YYYY',
                          'nls_calendar=''arabic hijrah''')
                     hijriBdate,
                 f_get_desc_fnc ('stvcamp', SARADAP_CAMP_CODE, 30)
                     campus,
                 f_get_desc_fnc ('stvcoll', SARADAP_COLL_CODE_1, 30)
                     college,
                 f_get_desc_fnc ('stvdegc', SARADAP_DEGC_CODE_1, 30)
                     levl,
                 f_get_desc_fnc ('stvmajr', SARADAP_MAJR_CODE_1, 30)
                     major,
                 LOWER (x.email)
                     "«·«Ì„Ì·",
                 EDUCATION_CENTER,
                 GPA,
                 STUDENT_QUDORAT_SCORE
                     qdurat,
                 STUDENT_TAHSEELY_SCORE
                     tahseely,
                 TEST_SCORE_2
                     "À·«ÀÌ…",
                 TEST_SCORE_3
                     "À‰«∆Ì…",
                 NULL
                     AS "«·»—‰«„Ã «·ÃœÌœ",
                 NULL
                     AS "«·—€»… «·ÃœÌœ…"
            FROM sarappd         s1,
                 saradap,
                 spbpers,
                 moe_cd,
                 stu_main_data_vw x
           WHERE     sarappd_pidm = saradap_pidm
                 AND spbpers_pidm = saradap_pidm
                 AND x.STUDENT_PIDM = saradap_pidm
                 AND sarappd_term_code_entry = saradap_term_code_entry
                 AND saradap_appl_no = sarappd_appl_no
                 AND sarappd_pidm = spbpers_pidm
                 AND s1.sarappd_term_code_entry = '144510'
                 AND moe_cd.STUDENT_SSN = spbpers.spbpers_ssn
                 AND ADMISSION_TYPE IN ('UG', 'U2')
                 AND s1.sarappd_seq_no =
                     (SELECT MAX (s2.sarappd_seq_no)
                        FROM sarappd s2
                       WHERE     s2.sarappd_pidm = s1.sarappd_pidm
                             AND s2.sarappd_term_code_entry =
                                 s1.sarappd_term_code_entry
                             AND s2.sarappd_appl_no = s1.sarappd_appl_no)
                 -- AND sarappd_apdc_code IN ('QA')
                 AND EXISTS
                         (SELECT 1
                            FROM adm_student_confirmation
                           WHERE     applicant_pidm = sarappd_pidm
                                 AND admit_term = '144510'))
   WHERE     "APPStatus" = '1'
         AND EXISTS
                 (SELECT '1'
                    FROM sgbstdn
                   WHERE     SGBSTDN_PIDM = sarappd_pidm
                         AND SGBSTDN_TERM_CODE_EFF = '144510'
                         AND SGBSTDN_STST_CODE = 'AS')
ORDER BY 6;