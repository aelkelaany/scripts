/* Formatted on 12/22/2022 9:50:22 AM (QP5 v5.371) */
  SELECT F_GET_DESC_FNC ('STVCOLL', SIRDPCL_COLL_CODE, 60)    COLL_DESC,
         F_GET_DESC_FNC ('STVDEPT', SIRDPCL_DEPT_CODE, 60)    DEPT_DESC,
         f_get_std_name (sirasgn_pidm)                        faculty_name,
         f_get_std_id (sirasgn_pidm)                          faculty_id,
         spbpers_ssn                                          ssn,
         ssbsect_crn                                          crn,
         ssbsect_schd_code,
         f_get_desc_fnc ('stvschd', ssbsect_schd_code, 30)    schd_desc,
         DECODE (
             ssbsect_schd_code,
             'Ú', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
             'ã', DECODE (SIRASGN_CATEGORY,
                           '01', 0,
                           NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0)),
             /*'Ñ', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),*/
             'Ó', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
             'Ê', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
             0)                                               lab_hr,
         DECODE (
             ssbsect_schd_code,
             'ã', DECODE (
                       SIRASGN_CATEGORY,
                       '01', NVL (NVL (ssbsect_lec_hr, scbcrse_lec_hr_low), 0),
                       0),
             'ä', NVL (NVL (ssbsect_lec_hr, scbcrse_lec_hr_low), 0),
             0)                                               lec_hr,
         DECODE (ssbsect_schd_code,
                 'Ñ', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
                 0)                                           clincal_hrs,
         sirasgn_pidm,
         A.SCBCRSE_SUBJ_CODE || A.SCBCRSE_crse_numb           crse_code,
         scbcrse_title, (SELECT count(sfrstcr_pidm)
                    FROM sfrstcr
                   WHERE     sfrstcr_term_code = ssbsect_term_code
                         AND sfrstcr_rsts_code IN ('RE', 'RW')
                         AND sfrstcr_crn = ssbsect_crn) enrl_cnt ,
         THE_SSRMEET_TIMES.*
    FROM scbcrse a,
         ssbsect,
         sirasgn,
         spbpers,
         SIRDPCL,
         (SELECT DISTINCT THE_TERM,
                          THE_CRN,
                          ssrmeet_catagory,
                          THE_SUN,
                          THE_MON,
                          THE_TUE,
                          THE_WED,
                          THE_THU,
                          THE_FRI,
                          THE_SAT
            FROM (  SELECT DISTINCT
                           SSRMEET_TERM_CODE             THE_TERM,
                           SSRMEET_CRN                   THE_CRN,
                           ssrmeet_catagory,
                           THE_DAY,
                           LISTAGG (THE_TIME, ' , ')
                           WITHIN GROUP (ORDER BY
                                             SSRMEET_TERM_CODE,
                                             SSRMEET_CRN,
                                             THE_DAY)    THE_TIMES
                      FROM (SELECT DISTINCT
                                   SSRMEET_TERM_CODE,
                                   SSRMEET_CRN,
                                   ssrmeet_catagory,
                                   NVL2 (
                                       SSRMEET_SUN_DAY,
                                          SSRMEET_BEGIN_TIME
                                       || ' - '
                                       || SSRMEET_END_TIME,
                                       '')    SUN_DAY,
                                   NVL2 (
                                       SSRMEET_MON_DAY,
                                          SSRMEET_BEGIN_TIME
                                       || ' - '
                                       || SSRMEET_END_TIME,
                                       '')    MON_DAY,
                                   NVL2 (
                                       SSRMEET_TUE_DAY,
                                          SSRMEET_BEGIN_TIME
                                       || ' - '
                                       || SSRMEET_END_TIME,
                                       '')    TUE_DAY,
                                   NVL2 (
                                       SSRMEET_WED_DAY,
                                          SSRMEET_BEGIN_TIME
                                       || ' - '
                                       || SSRMEET_END_TIME,
                                       '')    WED_DAY,
                                   NVL2 (
                                       SSRMEET_THU_DAY,
                                          SSRMEET_BEGIN_TIME
                                       || ' - '
                                       || SSRMEET_END_TIME,
                                       '')    THU_DAY,
                                   NVL2 (
                                       SSRMEET_FRI_DAY,
                                          SSRMEET_BEGIN_TIME
                                       || ' - '
                                       || SSRMEET_END_TIME,
                                       '')    FRI_DAY,
                                   NVL2 (
                                       SSRMEET_SAT_DAY,
                                          SSRMEET_BEGIN_TIME
                                       || ' - '
                                       || SSRMEET_END_TIME,
                                       '')    SAT_DAY
                              FROM SSRMEET)
                           UNPIVOT (THE_TIME
                                   FOR THE_DAY
                                   IN (SUN_DAY AS 'SUN',
                                      MON_DAY AS 'MON',
                                      TUE_DAY AS 'TUE',
                                      WED_DAY AS 'WED',
                                      THU_DAY AS 'THU',
                                      FRI_DAY AS 'FRI',
                                      SAT_DAY AS 'SAT'))
                  GROUP BY SSRMEET_TERM_CODE,
                           SSRMEET_CRN,
                           THE_DAY,
                           ssrmeet_catagory
                  ORDER BY SSRMEET_TERM_CODE,
                           SSRMEET_CRN,
                           THE_DAY,
                           THE_TIME)
                 PIVOT (LISTAGG (THE_TIMES)
                            WITHIN GROUP (ORDER BY THE_DAY DESC)
                       FOR THE_DAY
                       IN ('SUN' AS THE_SUN,
                          'MON' AS THE_MON,
                          'TUE' AS THE_TUE,
                          'WED' AS THE_WED,
                          'THU' AS THE_THU,
                          'FRI' AS THE_FRI,
                          'SAT' AS THE_SAT))) THE_SSRMEET_TIMES
   WHERE     A.SCBCRSE_EFF_TERM =
             (SELECT MAX (SCBCRSE_EFF_TERM)
                FROM SCBCRSE
               WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                     AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                     AND SCBCRSE_EFF_TERM <= :term_code)
         AND A.SCBCRSE_SUBJ_CODE = ssbsect_subj_code
         AND A.SCBCRSE_CRSE_NUMB = ssbsect_crse_numb
         AND ssbsect_term_code = :term_code
         AND sirasgn_term_code = ssbsect_term_code
         AND EXISTS
                 (SELECT '1'
                    FROM sfrstcr
                   WHERE     sfrstcr_term_code = ssbsect_term_code
                         AND sfrstcr_rsts_code IN ('RE', 'RW')
                         AND sfrstcr_crn = ssbsect_crn)
         AND sirasgn_crn = ssbsect_crn
        --  AND sirasgn_pidm = f_get_pidm ( :inst_id)
         AND THE_SSRMEET_TIMES.THE_crn = ssbsect_crn
         AND THE_SSRMEET_TIMES.THE_TERM = ssbsect_term_code
         AND sirasgn_category = THE_SSRMEET_TIMES.ssrmeet_catagory
         AND spbpers_pidm = sirasgn_pidm
         AND SIRDPCL_PIDM = sirasgn_pidm
         AND SIRDPCL_TERM_CODE_EFF = (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                                        FROM SIRDPCL
                                       WHERE SIRDPCL_PIDM = sirasgn_pidm)
ORDER BY coll_desc,
         dept_desc,
         faculty_id,
         crn