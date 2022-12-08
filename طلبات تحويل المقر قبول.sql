/* Formatted on 8/24/2022 11:50:39 AM (QP5 v5.371) */
  SELECT a.*,
         DECODE (decision,
                 'QA', '„ﬁ»Ê·',
                 'QR', '„—›Ê÷',
                 'CA', '«·€«¡ ﬁ»Ê· ·⁄œ„ «· √ﬂÌœ',
                 'WA', '„‰”Õ»')                              "Õ«·… «·ﬁ»Ê·",
         (SELECT    '('
                 || applicant_choice_no
                 || ') - '
                 || applicant_choice
                 || ' - '
                 || f_get_program_full_desc ('144410', applicant_choice)
            FROM vw_applicant_choices c
           WHERE     applicant_pidm = a.student_pidm
                 AND c.admit_term = a.admit_term
                 AND applicant_decision IN ('QA', 'CA', 'WA'))    accepted_prog
    FROM (SELECT vw.admit_term,
                 vw.student_pidm,
                 vw.student_ssn
                     "«·ÂÊÌ…",
                 DECODE (vw.admission_type,
                         'UG', 'œ›⁄… «Ê·Ï',
                         'U2', '»Ê«»… ‘Ê«€—')
                     "‰Ê⁄ «·ﬁ»Ê·",
                 FIRST_NAME_AR || ' ' || MIDDLE_NAME_AR || ' ' || LAST_NAME_AR
                     "«·«”„",
                 DECODE (gender,  'M', '–ﬂ—',  'F', '«‰ÀÏ')
                     "«·Ã‰”",
                 DECODE (dplm_type,
                         'œ', '‰Ÿ—Ì',
                         '⁄', '⁄·„Ì',
                         '—', '≈œ«—Ì')
                     "‰Ê⁄ «·À«‰ÊÌ…",
                 education_center
                     "«·«œ«—…",
                 test_score_3
                     "«·‰”»… «·À‰«∆Ì…",
                 test_score_2
                     "«·‰”»… «·À·«ÀÌ…",
                 mobile
                     "«·ÃÊ«·",
                 NVL (
                     (SELECT applicant_decision
                        FROM vw_applicant_choices c
                       WHERE     applicant_pidm = vw.student_pidm
                             AND c.admit_term = vw.admit_term
                             AND applicant_decision IN ('QA', 'CA', 'WA')),
                     'QR')
                     decision,
                 SUBSTR (GRADUATION_DATE, 7)
                     graduation_year ,req_master.NOTES,decode(req_detail.NEW_CAMPUS,'1','«·»«Õ…','2','»·Ã—‘Ì','3','«·„ŒÊ«…') req_camp
            FROM stu_main_data_vw          vw,
                 moe_cd                    cd,
                 ADM_REALOCATE_CAMP_REQUEST req_master,
                 ADM_RLCT_CAMP_REQ_DETAILS req_detail
           WHERE     vw.student_ssn = cd.student_ssn
                 AND vw.STUDENT_PIDM = req_master.student_pidm
                 AND vw.STUDENT_PIDM = req_detail.student_pidm
                 and req_master.REQUEST_NO=req_detail.REQUEST_NO
                 AND req_master.REQUEST_STATUS = 'P'
                 AND vw.admit_term = '144410') a
ORDER BY 3, 4 DESC;

443025319
444900001