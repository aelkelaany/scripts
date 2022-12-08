/* Formatted on 8/30/2022 8:59:44 AM (QP5 v5.371) */
  SELECT c.*,
         (SELECT '»·Ã—‘‹‹Ì'     program_DESC
            FROM DUAL
           WHERE EXISTS
                     (SELECT smrprle_coll_code
                        FROM smrprle
                       WHERE     smrprle_program = curr_camps
                             AND SMRPRLE_CAMP_CODE IN
                                     (SELECT STVCAMP_CODE
                                        FROM STVCAMP
                                       WHERE STVCAMP_DESC LIKE '%»·Ã%'))
          UNION
          SELECT '«·„Œ‹‹Ê«…'     AREA_DESC
            FROM DUAL
           WHERE EXISTS
                     (SELECT smrprle_coll_code
                        FROM smrprle
                       WHERE     smrprle_program = curr_camps
                             AND SMRPRLE_CAMP_CODE IN
                                     (SELECT STVCAMP_CODE
                                        FROM STVCAMP
                                       WHERE STVCAMP_DESC LIKE '%„Œ%'))
          UNION
          SELECT '«·»«Õ‹‹…'     AREA_DESC
            FROM DUAL
           WHERE NOT EXISTS
                     (SELECT smrprle_coll_code
                        FROM smrprle
                       WHERE     smrprle_program = curr_camps
                             AND SMRPRLE_CAMP_CODE IN
                                     (SELECT STVCAMP_CODE
                                        FROM STVCAMP
                                       WHERE    STVCAMP_DESC LIKE '%„Œ%'
                                             OR STVCAMP_DESC LIKE '%»·Ã%')))    curr_area
    FROM (SELECT a.*,
                 DECODE (decision,
                         'QA', '„ﬁ»Ê·',
                         'QR', '„—›Ê÷',
                         'CA', '«·€«¡ ﬁ»Ê· ·⁄œ„ «· √ﬂÌœ',
                         'WA', '„‰”Õ»')
                     "Õ«·… «·ﬁ»Ê·",
                 (SELECT    '('
                         || applicant_choice_no
                         || ') - '
                         || applicant_choice
                         || ' - '
                         || f_get_program_full_desc ('144410',
                                                     applicant_choice)
                    FROM vw_applicant_choices c
                   WHERE     applicant_pidm = a.student_pidm
                         AND c.admit_term = a.admit_term
                         AND applicant_decision IN ('QA', 'CA', 'WA'))
                     accepted_prog,
                 (SELECT applicant_choice
                    FROM vw_applicant_choices c
                   WHERE     applicant_pidm = a.student_pidm
                         AND c.admit_term = a.admit_term
                         AND applicant_decision IN ('QA', 'CA', 'WA'))
                     curr_camps
            FROM (SELECT vw.admit_term,
                         vw.student_pidm,
                         vw.student_ssn
                             "«·ÂÊÌ…",
                         DECODE (vw.admission_type,
                                 'UG', 'œ›⁄… «Ê·Ï',
                                 'U2', '»Ê«»… ‘Ê«€—')
                             "‰Ê⁄ «·ﬁ»Ê·",
                            FIRST_NAME_AR
                         || ' '
                         || MIDDLE_NAME_AR
                         || ' '
                         || LAST_NAME_AR
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
                                     AND applicant_decision IN
                                             ('QA', 'CA', 'WA')),
                             'QR')
                             decision,
                         SUBSTR (GRADUATION_DATE, 7)
                             graduation_year,
                         REQUEST.CURRENT_PROGRAM                    /*,NOTES*/
                                                ,
                         DECODE (new_campus,
                                 '1', '«·»«Õ‹‹…',
                                 '2', '»·Ã—‘‹‹Ì',
                                 '3', '«·„Œ‹‹Ê«…')
                             req_campus
                    FROM stu_main_data_vw          vw,
                         moe_cd                    cd,
                         ADM_realocate_CAMP_REQUEST REQUEST,
                         ADM_rlct_CAMP_REQ_DETAILS DETAILS
                   WHERE     vw.student_ssn = cd.student_ssn
                         AND vw.admit_term = '144410'
                         AND vw.admission_type IN ('UG')
                         AND vw.STUDENT_PIDM = request.STUDENT_PIDM
                         AND request.student_pidm = DETAILS.student_pidm
                         AND request.ADMISSION_TYPE = vw.ADMISSION_TYPE
                         AND request.request_no = DETAILS.request_no
                         AND REQUEST.REQUEST_STATUS = 'P') a) c
ORDER BY 3, 4 DESC;