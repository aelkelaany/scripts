DROP VIEW JAMEE.VW_ACADEMIC_DETAILS;

/* Formatted on 10/18/2022 9:29:08 AM (QP5 v5.371) */
CREATE OR REPLACE FORCE VIEW JAMEE.VW_ACADEMIC_DETAILS
(
    STUDENTIDENTITYNUMBER,
    UNIVERSITYID,
    TARGETSCIENTIFICDEGREEID,
    GRANTEDSCIENTIFICDEGREEID,
    ADMISSIONCOLLEGEID,
    CURRENTCOLLEGEID,
    UNIVERSITYDEPARTMENTID,
    UNIVERSITYMAJORID,
    UNIVERSITYMINORID,
    STUDYPROGRAMPERIOD,
    STUDYPROGRAMPERIODUNITID,
    REQUESTEDCREDITHOURSCOUNT,
    REGISTEREDCREDITHOURSCOUNT,
    PASSEDCREDITHOURSCOUNT,
    REMAININGCREDITHOURSCOUNT,
    ACADEMICSTATUSID,
    STUDYTYPEID,
    REGISTRATIONSTATUSID,
    CURRENTACADEMICYEARID,
    ADMISSIONYEAR,
    CURRENTYEAR,
    ATTENDENCESEMESTERTYPEID,
    CURRENTSEMESTERTYPEID,
    GPATYPEID,
    GPA,
    CURRENTSEMESTERASSESSMENTID,
    WARNINGCOUNT,
    ACCUMULATEDASSESSMENTID,
    ISREWARDRECEIVEDFORCURRENT,
    STUDYLOCATIONCITYID,
    COUNTRYID,
    GRADUTIONYEAR,
    GRADUATIONSEMESTERTYPEID,
    GRADUATIONDATE,
    SUMMERSEMESTERREGISTRATIONSTAT,
    ISTRANSFERED,
    ISACCOMMODATIONINUNIVERSITY,
    ISMAJOREDUCATIONAL,
    MAJORTYPECODE,
    ACCEPTENCEDATE,
    DISCLAIMERDATE,
    DISCLAIMERDECISIONORBARGINNUNB,
    DATEOFLASTUPDATEONACADEMICSTAT,
    SAUDIMAJORCODE,
    SAUDIEDUCATIONLEVELCODE
)
BEQUEATH DEFINER
AS
    SELECT spriden_id
               studentidentitynumber,
           'G17'
               universityid,
           NVL (z1.moe_id, 9)
               targetscientificdegreeid,
           NVL (z1.moe_id, 9)
               grantedscientificdegreeid,
           ''
               admissioncollegeid,
           z2.moe_id
               currentcollegeid,
           ''
               universitydepartmentid,
           z3.moe_id
               universitymajorid,
           ''
               universityminorid,
           CASE
               WHEN g.sgbstdn_levl_code IN ('MA',
                                            '„Ã',
                                            'œ⁄',
                                            'œ»',
                                            'œ5')
               THEN
                   4
               WHEN g.sgbstdn_levl_code = 'Ã5'
               THEN
                   8
               WHEN     g.sgbstdn_levl_code = 'Ã„'
                    AND g.sgbstdn_coll_code_1 = '32'
               THEN
                   10
               WHEN     g.sgbstdn_levl_code = 'Ã„'
                    AND g.sgbstdn_coll_code_1 = '55'
               THEN
                   12
               WHEN     g.sgbstdn_levl_code = 'Ã„'
                    AND g.sgbstdn_coll_code_1 = '14'
               THEN
                   14
               WHEN     g.sgbstdn_levl_code = 'Ã„'
                    AND g.sgbstdn_coll_code_1 NOT IN ('55', '32', '14')
               THEN
                   8
           END
               studyprogramperiod,
           '2'
               studyprogramperiodunitid,
           ''
               requestedcredithourscount,
           NVL (
               (SELECT SUM (sfrstcr_credit_hr)
                  FROM sfrstcr
                 WHERE     sfrstcr_pidm = s.spriden_pidm
                       AND s.spriden_change_ind IS NULL
                       AND sfrstcr_term_code =
                           f_get_param ('GENERAL', 'CURRENT_TERM', 1)
                       AND sfrstcr_rsts_code IN ('RW', 'RE')),
               0)
               registeredcredithourscount,
           NVL (
               (SELECT shrlgpa_hours_earned
                  FROM shrlgpa l
                 WHERE     shrlgpa_pidm = g.sgbstdn_pidm
                       AND shrlgpa_gpa_type_ind = 'O'
                       AND l.shrlgpa_levl_code = g.sgbstdn_levl_code),
               0)
               passedcredithourscount,
           ''
               remainingcredithourscount,
           NVL (z4.moe_id, 9)
               academicstatusid,
           NVL (z5.moe_id, 9)
               studytypeid,
           DECODE (bu_apps.f_student_registered (g.sgbstdn_pidm), 'Y', 0, 9)
               registrationstatusid,
           ''
               currentacademicyearid,
           (SELECT SUBSTR (MIN (sgbstdn_term_code_eff), 1, 4)
              FROM sgbstdn
             WHERE s.spriden_pidm = g.sgbstdn_pidm)
               admissionyear,
           ''
               currentyear,
           NVL (
               (SELECT DECODE (SUBSTR (MIN (sgbstdn_term_code_eff), 5, 2),
                               '10', '1',
                               '20', '2',
                               '30', '3',
                               '9')
                  FROM sgbstdn x
                 WHERE g.sgbstdn_pidm = x.sgbstdn_pidm),
               '9')
               attendencesemestertypeid,
           ''
               currentsemestertypeid,
           DECODE (g.sgbstdn_levl_code,  'Ã5', '1',  'œ5', '1',  2)
               gpatypeid,
           NVL (
               (SELECT ROUND (shrlgpa_gpa, 2)
                  FROM shrlgpa l
                 WHERE     shrlgpa_pidm = g.sgbstdn_pidm
                       AND shrlgpa_gpa_type_ind = 'O'
                       AND l.shrlgpa_levl_code = g.sgbstdn_levl_code),
               0)
               gpa,
           NVL (
               (SELECT moe_id
                  FROM shrttrm, moe.map_mark
                 WHERE     bu_id = shrttrm_astd_code_end_of_term
                       AND shrttrm_pidm = s.spriden_pidm
                       AND shrttrm_term_code =
                           (SELECT MAX (shrttrm_term_code)
                              FROM shrttrm, shrtckl
                             WHERE     shrttrm_pidm = s.spriden_pidm
                                   AND shrttrm_astd_code_end_of_term
                                           IS NOT NULL
                                   AND shrttrm_pidm = shrtckl_pidm
                                   AND shrttrm_term_code = shrtckl_term_code)),
               '8')
               currentsemesterassessmentid,
           NVL (
               (SELECT COUNT (1)
                  FROM shrttrm sh
                 WHERE     shrttrm_pidm = sgbstdn_pidm
                       AND shrttrm_astd_code_end_of_term IN
                               ('‰1', '€„', '‰2')),
               0)
               warningcount,
           NVL (
               (SELECT moe_id
                  FROM shrttrm, moe.map_mark
                 WHERE     bu_id = shrttrm_astd_code_end_of_term
                       AND shrttrm_pidm = s.spriden_pidm
                       AND shrttrm_term_code =
                           (SELECT MAX (shrttrm_term_code)
                              FROM shrttrm, shrtckl
                             WHERE     shrttrm_pidm = s.spriden_pidm
                                   AND shrttrm_astd_code_end_of_term
                                           IS NOT NULL
                                   AND shrttrm_pidm = shrtckl_pidm
                                   AND shrttrm_term_code = shrtckl_term_code)
                       AND EXISTS
                               (SELECT 1
                                  FROM shrdgmr d
                                 WHERE     shrdgmr_pidm = s.spriden_pidm
                                       AND shrdgmr_levl_code =
                                           g.sgbstdn_levl_code
                                       AND shrdgmr_seq_no =
                                           (SELECT MAX (shrdgmr_seq_no)
                                              FROM shrdgmr r
                                             WHERE     r.shrdgmr_pidm =
                                                       d.shrdgmr_pidm
                                                   AND shrdgmr_degs_code =
                                                       'ŒÃ'))),
               '8')
               accumulatedassessmentid,
           DECODE (
               its_met_fa (f_get_param ('GENERAL', 'CURRENT_TERM', 1),
                           sgbstdn_pidm),
               'Y', '1',
               '2')
               isrewardreceivedforcurrent,
           (SELECT DISTINCT moe_city_code
              FROM moe.map_college_city
             WHERE     bu_college_code = sgbstdn_coll_code_1
                   AND bu_campus_code = sgbstdn_camp_code)
               studylocationcityid,
           --'1201000' studylocationcityid,


           ''
               countryid,
           (SELECT SUBSTR (shrdgmr_term_code_grad, 1, 4)
              FROM shrdgmr d
             WHERE     shrdgmr_pidm = s.spriden_pidm
                   AND shrdgmr_levl_code = g.sgbstdn_levl_code
                   AND shrdgmr_seq_no =
                       (SELECT MAX (shrdgmr_seq_no)
                          FROM shrdgmr r
                         WHERE     r.shrdgmr_pidm = d.shrdgmr_pidm
                               AND shrdgmr_degs_code = 'ŒÃ'))
               gradutionyear,
           NVL (
               (SELECT DECODE (SUBSTR (shrdgmr_term_code_grad, 5, 2),
                               '10', '1',
                               '20', '2',
                               '30', '3',
                               '9')
                  FROM shrdgmr d
                 WHERE     shrdgmr_pidm = s.spriden_pidm
                       AND shrdgmr_levl_code = g.sgbstdn_levl_code
                       AND shrdgmr_seq_no =
                           (SELECT MAX (shrdgmr_seq_no)
                              FROM shrdgmr r
                             WHERE     r.shrdgmr_pidm = d.shrdgmr_pidm
                                   AND shrdgmr_degs_code = 'ŒÃ')),
               '9')
               graduationsemestertypeid,
           (SELECT TO_CHAR (
                       f_handle_date (
                           TO_CHAR (shrdgmr_grad_date, 'YYYY-MM-DD'),
                           'G'),
                       'YYYY-MM-DD')
              FROM shrdgmr d
             WHERE     shrdgmr_pidm = g.sgbstdn_pidm
                   AND shrdgmr_levl_code = g.sgbstdn_levl_code
                   AND shrdgmr_seq_no =
                       (SELECT MAX (shrdgmr_seq_no)
                          FROM shrdgmr r
                         WHERE     r.shrdgmr_pidm = d.shrdgmr_pidm
                               AND shrdgmr_degs_code = 'ŒÃ'))
               graduationdate,
           NVL (
               (SELECT DISTINCT '1'
                  FROM sfrstcr
                 WHERE     sfrstcr_pidm = s.spriden_pidm
                       AND sfrstcr_term_code =
                              SUBSTR (
                                  f_get_param ('GENERAL', 'CURRENT_TERM', 1),
                                  1,
                                  4)
                           || '30'
                       AND sfrstcr_rsts_code IN ('RW', 'RE')),
               '2')
               summersemesterregistrationstat,
           ''
               istransfered,
           ''
               isaccommodationinuniversity,
           DECODE (bu_edu_flag, 'Y', '1', '0')
               ismajoreducational,
           DECODE (bu_id_type,  '‰', '1',  '⁄', '2',  'ÿ', '3',  '9')
               majortypecode,
           ''
               acceptencedate,
           ''
               disclaimerdate,
           ''
               disclaimerdecisionorbarginnunb,
           ''
               dateoflastupdateonacademicstat,
           sm.moe_major_code,
           sm.moe_level_code
      FROM spriden                 s,
           sgbstdn                 g,
           stvcoll,
           stvcamp,
           stvstst,
           map_degree              z1,
           moe.map_college         z2,
           moe.map_specialization  z3,
           moe.map_general_status  z4,
           moe.map_study_type      z5,
           spbpers,
           bu_apps.moe_majors      sm
     WHERE     spriden_pidm = sgbstdn_pidm
           AND spriden_change_ind IS NULL
           AND g.sgbstdn_term_code_eff =
               (SELECT MAX (sgbstdn_term_code_eff)
                  FROM sgbstdn
                 WHERE sgbstdn_pidm = s.spriden_pidm)
           AND sgbstdn_stst_code = stvstst_code
           AND sgbstdn_coll_code_1 = stvcoll_code
           AND sgbstdn_camp_code = stvcamp_code
           AND spbpers_pidm = sgbstdn_pidm
           AND sgbstdn_levl_code = z1.bu_id(+)
           AND sgbstdn_coll_code_1 = z2.bu_id(+)
           AND sgbstdn_majr_code_1 = z3.bu_id(+)
           AND sgbstdn_stst_code = z4.bu_id(+)
           AND sgbstdn_styp_code = z5.bu_id(+)
           AND sgbstdn_majr_code_1 = sm.bu_major_code(+)
           AND spbpers_citz_code IS NOT NULL
           AND spbpers_ssn IS NOT NULL
           AND LENGTH (spbpers_ssn) = 10
           AND spbpers_ssn NOT LIKE '0%'
    UNION
    SELECT student_id
               studentidentitynumber,
           'G17'
               universityid,
           student_level
               targetscientificdegreeid,
           student_level
               grantedscientificdegreeid,
           ''
               admissioncollegeid,
           college
               currentcollegeid,
           ''
               universitydepartmentid,
           major
               universitymajorid,
           ''
               universityminorid,
           8
               studyprogramperiod,
           '2'
               STUDYPROGRAMPERIODUNITID,
           ''
               REQUESTEDCREDITHOURSCOUNT,
           0
               REGISTEREDCREDITHOURSCOUNT,
           0
               PASSEDCREDITHOURSCOUNT,
           NULL
               REMAININGCREDITHOURSCOUNT,
           status
               ACADEMICSTATUSID,
           study_type
               STUDYTYPEID,
           9
               REGISTRATIONSTATUSID,
           ''
               CURRENTACADEMICYEARID,
           admission_year
               ADMISSIONYEAR,
           ''
               CURRENTYEAR,
           '9'
               ATTENDENCESEMESTERTYPEID,
           ''
               CURRENTSEMESTERTYPEID,
           gpa_type
               GPATYPEID,
           TO_NUMBER (gpa)
               GPA,
           eval
               CURRENTSEMESTERASSESSMENTID,
           0
               WARNINGCOUNT,
           eval
               ACCUMULATEDASSESSMENTID,
           '2'
               ISREWARDRECEIVEDFORCURRENT,
           city
               STUDYLOCATIONCITYID,
           ''
               COUNTRYID,
           TO_CHAR (graduation_date, 'YYYY')
               GRADUTIONYEAR,
           '1'
               GRADUATIONSEMESTERTYPEID,
           TO_CHAR (graduation_date, 'YYYY-MM-DD')
               GRADUATIONDATE,
           '2'
               SUMMERSEMESTERREGISTRATIONSTAT,
           ''
               ISTRANSFERED,
           ''
               ISACCOMMODATIONINUNIVERSITY,
           major_type
               ISMAJOREDUCATIONAL,
           ''
               MAJORTYPECODE,
           ''
               ACCEPTENCEDATE,
           ''
               DISCLAIMERDATE,
           ''
               DISCLAIMERDECISIONORBARGINNUNB,
           ''
               DATEOFLASTUPDATEONACADEMICSTAT,
           MOE_MAJOR_CODE
               SAUDIMAJORCODE,
           MOE_LEVEL_CODE
               SAUDIEDUCATIONLEVELCODE
      FROM jamee.jadara,
           (SELECT DISTINCT MOE_ID, MOE_MAJOR_CODE, MOE_LEVEL_CODE
              FROM moe_majors, moe.map_specialization
             WHERE bu_major_code = bu_id) sm
     WHERE major = MOE_ID(+);
