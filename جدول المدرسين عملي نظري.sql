/* Formatted on 12/21/2022 12:35:18 PM (QP5 v5.371) */
  SELECT COUNT (*)                        crn_count,
         SUM (
             DECODE (
                 ssbsect_schd_code,
                 'Ú', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
                 'ã', DECODE (
                           SIRASGN_CATEGORY,
                           '01', 0,
                           NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0)),
                 'Ñ', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
                 'Ó', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
                 'Ê', NVL (NVL (ssbsect_lab_hr, scbcrse_lab_hr_low), 0),
                 0))                      lab_hr,
         SUM (
             DECODE (
                 ssbsect_schd_code,
                 'ã', DECODE (
                           SIRASGN_CATEGORY,
                           '01', NVL (NVL (ssbsect_lec_hr, scbcrse_lec_hr_low),
                                      0),
                           0),
                 'ä', NVL (NVL (ssbsect_lec_hr, scbcrse_lec_hr_low), 0),
                 0))                      lec_hr,
         f_get_std_name (sirasgn_pidm)    faculty_name,
         f_get_std_id (sirasgn_pidm)      faculty_id,
         sirasgn_pidm,
           F_GET_DESC_FNC ('STVCOLL', SIRDPCL_COLL_CODE, 60)
              COLL_DESC,
            F_GET_DESC_FNC ('STVDEPT', SIRDPCL_DEPT_CODE, 60)
              DEPT_DESC
    FROM ssbsect, scbcrse b, sirasgn ,SIRDPCL
   WHERE     ssbsect_subj_code = scbcrse_subj_code
         AND ssbsect_crse_numb = scbcrse_crse_numb
         AND SSBSECT_SSTS_CODE = 'ä'
         AND sirasgn_crn = ssbsect_crn
         AND sirasgn_term_code = ssbsect_term_code
         AND ssbsect_crn IN
                 (SELECT a.sirasgn_crn
                    FROM sirasgn a, ssrmeet
                   WHERE    
                   -- a.sirasgn_pidm = f_get_pidm ( :SPRIDEN_ID) AND
                          a.sirasgn_term_code = :v_term
                         AND a.sirasgn_crn = ssbsect_crn
                         AND sirasgn_term_code = SSRMEET_term_code
                         AND ssbsect_crn = SSRMEET_crn
                         AND SSRMEET_CATAGORY = SIRASGN_CATEGORY)
         AND ssbsect.ssbsect_term_code = :v_term
         
        and  SIRDPCL_PIDM = sirasgn_pidm
                 AND SIRDPCL_TERM_CODE_EFF =
                     (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                        FROM SIRDPCL
                       WHERE SIRDPCL_PIDM = sirasgn_pidm)
                       and exists (select '1' from sfrstcr where sfrstcr_term_code=ssbsect_term_code
                 and sfrstcr_rsts_code in('RE','RW')
                 and sfrstcr_crn=ssbsect_crn)
                       
       --  AND sirasgn_pidm = f_get_pidm ( :SPRIDEN_ID)
--         AND SSBSECT_CRN NOT IN
--                 (SELECT SFRSTCR_CRN
--                    FROM sgbstdn b, SFRSTCR
--                   WHERE     b.SGBSTDN_STST_CODE IN ('AS',
--                                                     'ãÚ',
--                                                     'ãæ',
--                                                     'ÎÌ')
--                         AND (   b.SGBSTDN_STYP_CODE IN ('ä', 'Ê')
--                              OR b.SGBSTDN_LEVL_CODE IN ('ÏÚ', 'ãÌ', 'MA'))
--                         AND B.SGBSTDN_PROGRAM_1 NOT IN ('1-15022-1437',
--                                                         '2-15022-1437',
--                                                         '1-1503-1437',
--                                                         '2-1503-1437')
--                         AND b.SGBSTDN_PIDM = SFRSTCR_PIDM
--                         AND SFRSTCR_RSTS_CODE IN ('RW', 'RE')
--                         AND SFRSTCR_term_code = :v_term
--                         AND b.sgbstdn_term_code_eff =
--                             (SELECT MAX (a.sgbstdn_term_code_eff)
--                                FROM sgbstdn a
--                               WHERE     a.sgbstdn_pidm = b.sgbstdn_pidm
--                                     AND a.sgbstdn_term_code_eff <= :v_term))
         AND SCBCRSE_EFF_TERM =
             (SELECT MAX (a.SCBCRSE_EFF_TERM)
                FROM SCBCRSE a
               WHERE     a.SCBCRSE_SUBJ_CODE = b.SCBCRSE_SUBJ_CODE
                     AND a.SCBCRSE_CRSE_NUMB = b.SCBCRSE_CRSE_NUMB
                     AND a.SCBCRSE_EFF_TERM <= :v_term)
GROUP BY sirasgn_pidm ,SIRDPCL_COLL_CODE,SIRDPCL_DEPT_CODE

order by  SIRDPCL_COLL_CODE ,SIRDPCL_DEPT_CODE,sirasgn_pidm;