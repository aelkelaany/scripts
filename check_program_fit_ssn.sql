/* Formatted on 8/23/2023 1:24:36 PM (QP5 v5.371) */
SELECT spbpers_pidm,
       f_get_std_id (spbpers_pidm)       stid,
       f_get_std_name (spbpers_pidm)     std_name  ,APPLICANT_CHOICE_NO ,APPLICANT_CHOICE
  FROM spbpers ,vw_applicant_choices
 WHERE     spbpers_ssn LIKE :ssn
 and spbpers_pidm=APPLICANT_PIDM
 and ADMIT_TERM='144510'
 and APPLICANT_CHOICE=:program_cd
       AND NOT EXISTS
               (SELECT '1'
                  FROM sgbstdn
                 WHERE sgbstdn_pidm = spbpers_pidm)
       AND EXISTS
               (SELECT '1'
                  FROM DUAL
                 WHERE bu_apps.f_get_applicant_rate ('144510',
                                                     spbpers_pidm,
                                                     :program_cd) >=
                       (SELECT MIN (APPLICANT_RATE)
                          FROM VW_APPLICANT_CHOICES
                         WHERE     ADMIT_TERM = '144510'
                               AND APPLICANT_DECISION = 'FA'
                               AND APPLICANT_CHOICE = :program_cd));