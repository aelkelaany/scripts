/* Formatted on 8/27/2019 9:50:48 AM (QP5 v5.227.12220.39754) */
SELECT student_pidm student_pidm,
       x.student_ssn "«·ÂÊÌ…",
       mobile "«·ÃÊ«·",
       first_name_ar || ' ' || middle_name_ar || ' ' || last_name_ar
          "«·≈”„",
       education_center "«·„‰ÿﬁ… ",
       DECODE (student_diploma_type,  '⁄', '⁄·„Ì',  'œ', '√œ»Ì')
          "«·À«‰ÊÌÂ",
       student_graduation_year "”‰… «· Œ—Ã",
       test_score_3 "«·‰”»… «·À‰«∆Ì…"
  FROM stu_main_data_vw d, moe_cd x, adm_quota_batch_edu_center z
 WHERE     d.student_ssn = x.student_ssn
       AND z.quota_education_center = x.education_center
       AND quota_batch_no = 1
       AND student_gender = 'F'
       AND student_diploma_type = 'œ'
       AND test_score_3 <= 75.18
       AND test_score_3 >= 74.5
       AND NOT EXISTS
                  (SELECT 'X'
                     FROM vw_applicant_choices y
                    WHERE     y.applicant_pidm = d.student_pidm
                          AND y.applicant_decision IN
                                 ('QA', 'CA', 'WA', 'RA'));