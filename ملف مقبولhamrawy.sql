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
       '1' "Õ«·… «·ﬁ»Ê·",
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
				
/*****************************************************************************************************/
  SELECT "College",
         "City",
         "SECTION",
         "MAJOR",
         "Semester",
         "DGREE",
         "STDYMODE",
         "Gender",
         COUNT (pidm) "Capacity"
    FROM (SELECT DECODE (saradap_coll_code_1,
                         '17', 'F09',
                         '19', 'F09',
                         '18', 'F09',
                         '42', 'F09',
                         '13', 'F09',
                         '15', 'B29',
                         '31', 'F01',
                         '32', 'G01',
                         '14', 'H03',
                         '55', 'J03',
                         '33', 'K01',
                         '41', 'N21',
                         '16', 'C01',
                         '25', 'I01',
                         '12', 'P01')
                    "College",
                 '1201000' "City",
                 'PA45' "SECTION",
                 'PA29' "MAJOR",
                 '1' "Semester",
                 DECODE (SUBSTR (saradap_program_1, 1, 1),
                         '1', '2',
                         '4', '1')
                    "DGREE",
                 '0' "STDYMODE",
                 DECODE (spbpers_sex,  'M', '1',  'F', '2') "Gender",
                 saradap_pidm pidm
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
                          WHERE     applicant_pidm = sarappd_pidm
                                AND admit_term = '144510'))
GROUP BY "College",
         "City",
         "SECTION",
         "MAJOR",
         "Semester",
         "DGREE",
         "STDYMODE",
         "Gender"
         order by "Capacity" desc;				
/************************************************OLD**************************************************/
SELECT spbpers_ssn "SSN",
       '1' "ID Type",
       "FirstNameArabic" "First Name",
       "SecondNameArabic" "Second Name",
       "ThirdNameArabic" "Third Name",
       "FamilyNameArabic" "Fourth Name",
       DECODE (spbpers_sex,  'M', '1',  'F', '2') "Gender",
       DECODE ("StudentNationalityArabic",
               '«·”⁄ÊœÌ…', '101',
               '«·√—œ‰', '107')
          "Nationality",
       "StudentBirthDateHijri" "Birth Date",
       DECODE (saradap_coll_code_1,
               '17', 'F09',
               '19', 'F09',
               '18', 'F09',
               '42', 'F09',
               '13', 'F09',
               '15', 'B29',
               '31', 'F01',
               '32', 'G01',
               '14', 'H03',
               '55', 'J03',
               '33', 'K01',
               '41', 'N21',
               '16', 'C01',
               '25', 'I01',
               '12', 'P01')
          "College",
       '1200000' "CityOrMuhafatha",
       'PA45' "SECTION",
       'PA29' "MAJOR",
       '0' "STDYMODE",
       DECODE (SUBSTR (saradap_program_1, 1, 1),  '1', '2',  '4', '1')
          "DGREE",
       "GraduationYear" "HSGrdDate",
       '1' "AcceptanceSemester",
       DECODE (sarappd_apdc_code,  'QA', '1',  'FA', '1',  'WA', '2')
          "APPStatus",
       TO_CHAR (SYSDATE, 'DD/MM/YYYY') "ActionDate",
       x.mobile "Mobile",
       LOWER (x.email) "Email"
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
       AND x.admission_type = 'UG'
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