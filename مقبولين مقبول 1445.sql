SELECT    "FirstNameArabic"
       || ' '
       || "SecondNameArabic"
       || ' '
       || "ThirdNameArabic"
       || ' '
       || "FamilyNameArabic"
          "«·«”„ —»«⁄Ì",
       DECODE (spbpers_sex,  'M', '1',  'F', '2') "«·Ã‰”",
       spbpers_ssn "«·”Ã· «·„œ‰Ì",
       '1' "«·›’· «·œ—«”Ì",
       "StudentBirthDateHijri" " «—ÌŒ «·„Ì·«œ",
       '1201000' "«·„Õ«›Ÿ…",
       '1' "Õ«·…«·ﬁ»Ê·",
       TO_CHAR (SARAPPD_APDC_DATE, 'DD/MM/YYYY') " «—ÌŒ «·«Ã—«¡",
       'G17' "«·„ƒ””…"
  FROM sarappd s1,
       saradap,
       spbpers,
       moe_cd_temp z,
       stu_main_data_vw x
WHERE     sarappd_pidm = saradap_pidm
       AND sarappd_term_code_entry = saradap_term_code_entry
       AND saradap_appl_no = sarappd_appl_no
       AND saradap_pidm = spbpers_pidm
       AND x.ADMIT_TERM = sarappd_term_code_entry
       AND spbpers_ssn = z."Student_Identity"
       AND z."Student_Identity"(+) = x.student_ssn
       AND s1.sarappd_term_code_entry = '144510'
       AND x.admission_type IN ('UG', 'U2')
       AND s1.sarappd_seq_no =
              (SELECT MAX (s2.sarappd_seq_no)
                 FROM sarappd s2
                WHERE     s2.sarappd_pidm = s1.sarappd_pidm
                      AND s2.sarappd_term_code_entry =
                             s1.sarappd_term_code_entry
                      AND s2.sarappd_appl_no = s1.sarappd_appl_no)
       AND sarappd_apdc_code IN ('QA', 'FA')
       AND EXISTS
              (SELECT 1
                 FROM adm_student_confirmation
           WHERE applicant_pidm = sarappd_pidm AND admit_term = '144510');
