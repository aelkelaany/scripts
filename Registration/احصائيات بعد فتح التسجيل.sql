/* Formatted on 07/06/2021 09:56:21 (QP5 v5.227.12220.39754) */
-- »‰«¡ ⁄ «·‰Ê⁄ Ê«·œ›⁄« 

  SELECT SUBSTR (f_get_std_id (sfrstcr_pidm), 1, 3),
         DECODE (f_get_gender (sfrstcr_pidm), 'M', 'ÿ«·»', 'ÿ«·»…')
            sex,
         COUNT (DISTINCT sfrstcr_pidm) all_reg_students
    FROM sfrstcr
   WHERE sfrstcr_term_code = '144310' AND sfrstcr_rsts_code IN ('RW', 'RE')
GROUP BY SUBSTR (f_get_std_id (sfrstcr_pidm), 1, 3),
         DECODE (f_get_gender (sfrstcr_pidm), 'M', 'ÿ«·»', 'ÿ«·»…')
ORDER BY 1;

-- ·ﬂ· ÿ·«» «·’Ì›Ì «·„ Œ’’Ì‰

SELECT COUNT (DISTINCT sfrstcr_pidm) all_reg_students
  FROM sfrstcr
 WHERE     sfrstcr_term_code = '144310'
       AND sfrstcr_rsts_code IN ('RW', 'RE')
       AND NOT EXISTS
              (SELECT '1'
                 FROM bu_dev.summer_reg_list
                WHERE pidm = sfrstcr_pidm);



-- ﬂ· «·ÿ·«» «·„”Ã·Ì‰

SELECT COUNT (DISTINCT sfrstcr_pidm) all_reg_students
  FROM sfrstcr
 WHERE sfrstcr_term_code = '144310' AND sfrstcr_rsts_code IN ('RW', 'RE');

  -- web ﬂ· «·ÿ·«» «·„”Ã·Ì‰

SELECT COUNT (DISTINCT sfrstcr_pidm) all_reg_students
  FROM sfrstcr
 WHERE sfrstcr_term_code = '144310' AND sfrstcr_rsts_code IN ('RW');
 --all reg crn
SELECT COUNT (DISTINCT sfrstcr_crn) all_reg_crn
  FROM sfrstcr
 WHERE sfrstcr_term_code = '144310' AND sfrstcr_rsts_code IN ('RW', 'RE');
  -- empty crn

  SELECT SSBSECT_CRN,
         ssbsect_subj_code,
         ssbsect_crse_numb,
         scbcrse_title,
         SSBSECT_MAX_ENRL,
         SSBSECT_ENRL,
         SSBSECT_SEATS_AVAIL
    FROM ssbsect, scbcrse c1
   WHERE     ssbsect_subj_code = scbcrse_subj_code
         AND ssbsect_crse_numb = scbcrse_crse_numb
         AND scbcrse_eff_term =
                (SELECT MAX (c2.scbcrse_eff_term)
                   FROM scbcrse c2
                  WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                        AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb
                        AND c2.scbcrse_eff_term <= '144310')
         AND ssbsect_term_code = '144310'
         AND SSBSECT_MAX_ENRL > 0
         AND SSBSECT_SEATS_AVAIL = SSBSECT_MAX_ENRL
         AND SSBSECT_SSTS_CODE = '‰'
ORDER BY 1;

--zeros crns

  SELECT SSBSECT_CRN,
         ssbsect_subj_code,
         ssbsect_crse_numb,
         scbcrse_title,
         SSBSECT_MAX_ENRL,
         SSBSECT_ENRL,
         SSBSECT_SEATS_AVAIL
    FROM ssbsect, scbcrse c1
   WHERE     ssbsect_subj_code = scbcrse_subj_code
         AND ssbsect_crse_numb = scbcrse_crse_numb
         AND scbcrse_eff_term =
                (SELECT MAX (c2.scbcrse_eff_term)
                   FROM scbcrse c2
                  WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                        AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb
                        AND c2.scbcrse_eff_term <= '144310')
         AND ssbsect_term_code = '144310'
         AND SSBSECT_MAX_ENRL = 0
         AND SSBSECT_SEATS_AVAIL = 0
         AND SSBSECT_SSTS_CODE = '‰'
ORDER BY 1;

       --NOT available ie full capacity

  SELECT SSBSECT_CRN,
         ssbsect_subj_code,
         ssbsect_crse_numb,
         scbcrse_title,
         SSBSECT_MAX_ENRL,
         SSBSECT_ENRL,
         SSBSECT_SEATS_AVAIL
    FROM ssbsect, scbcrse c1
   WHERE     ssbsect_subj_code = scbcrse_subj_code
         AND ssbsect_crse_numb = scbcrse_crse_numb
         AND scbcrse_eff_term =
                (SELECT MAX (c2.scbcrse_eff_term)
                   FROM scbcrse c2
                  WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                        AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb
                        AND c2.scbcrse_eff_term <= '144310')
         AND ssbsect_term_code = '144310'
         AND SSBSECT_MAX_ENRL > 0
         AND SSBSECT_SEATS_AVAIL = 0
         AND SSBSECT_SSTS_CODE = '‰'
ORDER BY 1;

-- availabe crns  for registeration

  SELECT SSBSECT_CRN,
         ssbsect_subj_code,
         ssbsect_crse_numb,
         scbcrse_title,
         SSBSECT_MAX_ENRL,
         SSBSECT_ENRL,
         SSBSECT_SEATS_AVAIL
    FROM ssbsect, scbcrse c1
   WHERE     ssbsect_subj_code = scbcrse_subj_code
         AND ssbsect_crse_numb = scbcrse_crse_numb
         AND scbcrse_eff_term =
                (SELECT MAX (c2.scbcrse_eff_term)
                   FROM scbcrse c2
                  WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                        AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb
                        AND c2.scbcrse_eff_term <= '144310')
         AND ssbsect_term_code = '144310'
         AND SSBSECT_MAX_ENRL > 0
         AND SSBSECT_SEATS_AVAIL > 0
         AND SSBSECT_SSTS_CODE = '‰'
ORDER BY 1;

-- registetered crn

  SELECT SSBSECT_CRN,
         ssbsect_subj_code,
         ssbsect_crse_numb,
         scbcrse_title,
         SSBSECT_MAX_ENRL,
         SSBSECT_ENRL,
         SSBSECT_SEATS_AVAIL
    FROM ssbsect, scbcrse c1
   WHERE     ssbsect_subj_code = scbcrse_subj_code
         AND ssbsect_crse_numb = scbcrse_crse_numb
         AND scbcrse_eff_term =
                (SELECT MAX (c2.scbcrse_eff_term)
                   FROM scbcrse c2
                  WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                        AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb
                        AND c2.scbcrse_eff_term <= '144310')
         AND ssbsect_term_code = '144310'
         AND SSBSECT_ENRL > 0
         AND SSBSECT_SSTS_CODE = '‰'
ORDER BY 1;

--count of registered CRN(S)

SELECT COUNT (DISTINCT sfrstcr_crn) all_records
  FROM sfrstcr
 WHERE sfrstcr_term_code = '144310' AND sfrstcr_rsts_code IN ('RW', 'RE');

 ---«Ã„«·Ì «·„ﬁ«⁄œ «·„ »ﬁÌ…

  SELECT SUM (SSBSECT_SEATS_AVAIL)
    FROM ssbsect, scbcrse c1
   WHERE     ssbsect_subj_code = scbcrse_subj_code
         AND ssbsect_crse_numb = scbcrse_crse_numb
         AND scbcrse_eff_term =
                (SELECT MAX (c2.scbcrse_eff_term)
                   FROM scbcrse c2
                  WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                        AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb
                        AND c2.scbcrse_eff_term <= '144310')
         AND ssbsect_term_code = '144310'
         AND SSBSECT_MAX_ENRL > 0
         AND SSBSECT_SEATS_AVAIL > 0
         AND SSBSECT_SSTS_CODE = '‰'
ORDER BY 1;

SELECT COUNT (DISTINCT sfrstcr_pidm) males_41
  FROM sfrstcr, spbpers
 WHERE     sfrstcr_term_code = '144310'
       AND sfrstcr_pidm = spbpers_pidm
       AND f_get_std_id (sfrstcr_pidm) LIKE '441%'
       AND SPBPERS_SEX = 'M'
       AND sfrstcr_rsts_code IN ('RW', 'RE');

SELECT COUNT (DISTINCT sfrstcr_pidm) females_41
  FROM sfrstcr, spbpers
 WHERE     sfrstcr_term_code = '144310'
       AND sfrstcr_pidm = spbpers_pidm
       AND f_get_std_id (sfrstcr_pidm) LIKE '441%'
       --and SPBPERS_SEX='F'
       AND sfrstcr_rsts_code IN ('RW', 'RE');

SELECT COUNT (DISTINCT SGBSTDN_PIDM) total_taregt
  FROM SGBSTDN SG
 WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
       AND SGBSTDN_STST_CODE IN ('AS')
       AND SGBSTDN_DEGC_CODE_1 IN ('»ﬂ')
       AND SGBSTDN_STYP_CODE IN ('„', ' ');


SELECT COUNT (DISTINCT SGBSTDN_PIDM) cohort_41
  FROM SGBSTDN SG
 WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
       AND SGBSTDN_STST_CODE IN ('AS')
       AND SGBSTDN_DEGC_CODE_1 IN ('»ﬂ', '»ﬂ  ', '000000', '„Ã', 'MA')
       AND SGBSTDN_STYP_CODE IN ('„', ' ')
       AND SG.SGBSTDN_TERM_CODE_ADMIT = '144010';

                       /*  update sfbetrm
                         set  SFBETRM_ADD_DATE=to_date('12-01-2020','dd-mm-yyyy')
                          where SFBETRM_TERM_CODE='144310'
                          and to_char(SFBETRM_ADD_DATE,'dd-mm-yyyy')='09-01-2020'*/



  SELECT DISTINCT SSBSECT_CRN
    FROM ssbsect
   WHERE ssbsect_term_code = '144310' AND SSBSECT_SSTS_CODE = '‰'
ORDER BY 1;


  SELECT DISTINCT ssbsect_subj_code, ssbsect_crse_numb, scbcrse_title
    FROM ssbsect, scbcrse c1
   WHERE     ssbsect_subj_code = scbcrse_subj_code
         AND ssbsect_crse_numb = scbcrse_crse_numb
         AND scbcrse_eff_term =
                (SELECT MAX (c2.scbcrse_eff_term)
                   FROM scbcrse c2
                  WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                        AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb
                        AND c2.scbcrse_eff_term <= '144310')
         AND ssbsect_term_code = '144310'
         AND SSBSECT_SSTS_CODE = '‰'
ORDER BY 1;

--‘⁄» ·„œ—” „⁄Ì‰

  SELECT DISTINCT ssbsect_subj_code,
                  ssbsect_crse_numb,
                  scbcrse_title,
                  SSBSECT_MAX_ENRL,
                  SSBSECT_ENRL,
                  SSBSECT_SEATS_AVAIL
    FROM ssbsect, scbcrse c1, sirasgn
   WHERE     ssbsect_subj_code = scbcrse_subj_code
         AND ssbsect_crse_numb = scbcrse_crse_numb
         AND scbcrse_eff_term =
                (SELECT MAX (c2.scbcrse_eff_term)
                   FROM scbcrse c2
                  WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                        AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb
                        AND c2.scbcrse_eff_term <= '144310')
         AND ssbsect_term_code = '144310'
         AND SSBSECT_SSTS_CODE = '‰'
         AND SIRASGN_TERM_CODE = ssbsect_term_code
         AND ssbsect_crn = SIRASGN_crn
         AND SIRASGN_pidm = f_get_pidm ('6590')
ORDER BY 1;