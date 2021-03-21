/* Formatted on 8/17/2020 8:51:48 AM (QP5 v5.360) */
  SELECT *
    FROM (SELECT spbpers_ssn as "—ﬁ„ «·ÂÊÌ…",
                 decode(ADMISSION_TYPE ,'UG','«”«”Ì…','‘Ê«€—') as "ﬂÊœ «·»Ê«»…" ,
                 f_get_std_id (spbpers_pidm) as "«·—ﬁ„ «·Ã«„⁄Ì" ,
                 f_get_std_name (spbpers_pidm)
                     AS "«”„ «·ÿ«·»",
                 DECODE (spbpers_sex,  'M', '–ﬂ—',  'F', '«‰ÀÏ')
                     "«·‰Ê⁄",
                 saradap_coll_code_1
                     "«·ﬂ·Ì…",
                 SARADAP_PROGRAM_1 as "ﬂÊœ «·»—‰«„Ã",
                 (SELECT SORCMJR_DESC
                    FROM SORCMJR
                   WHERE     SORCMJR_CURR_RULE = SARADAP_CURR_RULE_1
                         AND SORCMJR_CMJR_RULE = SARADAP_CMJR_RULE_1_1)
                    as "Ê’› «·»—‰«„Ã"  ,
                 SARAPPD_APPL_NO
                     "—ﬁ„ «·—€»…",
                 DECODE (sarappd_apdc_code,  'QA', '1',  'FA', '1',  'WA', '2')
                     "APPStatus",
                 x.mobile
                     "—ﬁ„ «·ÃÊ«·",
                 LOWER (x.email)
                     "«·«Ì„Ì·" , null as "«·»—‰«„Ã «·ÃœÌœ", null as "«·—€»… «·ÃœÌœ…"
            FROM sarappd         s1,
                 saradap,
                 spbpers,
                 stu_main_data_vw x
           WHERE     sarappd_pidm = saradap_pidm
                 AND spbpers_pidm = saradap_pidm
                 AND x.STUDENT_PIDM = saradap_pidm
                 AND sarappd_term_code_entry = saradap_term_code_entry
                 AND saradap_appl_no = sarappd_appl_no
                 AND sarappd_pidm = spbpers_pidm
                 AND s1.sarappd_term_code_entry = '144210'
                 AND s1.sarappd_seq_no =
                     (SELECT MAX (s2.sarappd_seq_no)
                        FROM sarappd s2
                       WHERE     s2.sarappd_pidm = s1.sarappd_pidm
                             AND s2.sarappd_term_code_entry =
                                 s1.sarappd_term_code_entry
                             AND s2.sarappd_appl_no = s1.sarappd_appl_no)
                 AND sarappd_apdc_code IN ('QA')
                 AND EXISTS
                         (SELECT 1
                            FROM adm_student_confirmation
                           WHERE     applicant_pidm = sarappd_pidm
                                 AND admit_term = '144210'))
   WHERE "APPStatus" = '1'
ORDER BY 1;