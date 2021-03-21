/* Formatted on 9/16/2019 9:52:33 AM (QP5 v5.227.12220.39754) */
  SELECT student_pidm student_pidm,
         F_GET_STD_ID (student_pidm),
         x.student_ssn "ÇáåæíÉ",
         mobile "ÇáÌæÇá",
         first_name_ar || ' ' || middle_name_ar || ' ' || last_name_ar
            "ÇáÅÓã",
         education_center "ÇáãäØŞÉ ",
         DECODE (student_diploma_type,  'Ú', 'Úáãí',  'Ï', 'ÃÏÈí')
            "ÇáËÇäæíå",
         student_graduation_year "ÓäÉ ÇáÊÎÑÌ",
         test_score_3 "ÇáäÓÈÉ ÇáËäÇÆíÉ"
    FROM stu_main_data_vw d, moe_cd x, adm_quota_batch_edu_center z
   WHERE     d.student_ssn = x.student_ssn
         AND z.quota_education_center = x.education_center
         AND quota_batch_no = 1
         AND student_gender = 'M'
         AND student_diploma_type = 'Ú'
         -- AND test_score_3 <= 75.18
         AND test_score_3 <= 68
         AND EXISTS
                (SELECT 'X'
                   FROM vw_applicant_choices y
                  WHERE     y.applicant_pidm = d.student_pidm
                        AND y.applicant_decision IN
                               ('QA', 'CA', 'WA', 'RA', 'FA'))
         AND EXISTS
                (SELECT 'X'
                   FROM ADM_QUOTA_RULE_SEQ, vw_applicant_choices
                  WHERE     QUOTA_SCORE_CODE = 'ã.ß'
                        AND QUOTA_BATCH_NO = '1'
                        AND QUOTA_RUN_SEQUENCE = 3
                        AND QUOTA_TERM = '144010'
                        AND ADMIT_TERM = '144010'
                        AND APPLICANT_CHOICE = QUOTA_PROGRAM
                        AND applicant_decision IN
                               ('QA', 'CA', 'WA', 'RA', 'FA')
                        AND applicant_pidm = d.student_pidm)
ORDER BY 9 ASC