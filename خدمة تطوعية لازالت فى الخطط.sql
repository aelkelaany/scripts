/* Formatted on 30/03/2021 11:03:42 (QP5 v5.227.12220.39754) */
SELECT *
  FROM (SELECT smbpgen_program,
               smbpgen_term_code_eff,
               smrprle_program_desc,
               smbpgen_req_credits_overall,
               smbpgen_req_courses_overall,
               smrpaap_area_priority,
               smracaa_area,
               smralib_area_desc,
               smbagen_req_credits_overall,
               smbagen_req_courses_overall,
               CASE WHEN smracaa_rule IS NULL THEN 'Y' ELSE 'N' END
                  required_flag,
               NVL (smracaa_subj_code, SMRARUL_SUBJ_CODE),
               NVL (smracaa_crse_numb_low, SMRARUL_crse_numb_low),
               (SELECT a.scbcrse_title
                  FROM scbcrse a
                 WHERE     a.scbcrse_subj_code =
                              NVL (smracaa_subj_code, SMRARUL_SUBJ_CODE)
                       AND a.scbcrse_crse_numb =
                              NVL (smracaa_crse_numb_low,
                                   SMRARUL_crse_numb_low)
                       AND scbcrse_eff_term =
                              (SELECT MAX (scbcrse_eff_term)
                                 FROM scbcrse
                                WHERE     scbcrse_subj_code =
                                             NVL (smracaa_subj_code,
                                                  SMRARUL_SUBJ_CODE)
                                      AND scbcrse_crse_numb =
                                             NVL (smracaa_crse_numb_low,
                                                  SMRARUL_crse_numb_low)
                                      AND scbcrse_eff_term <=
                                             smbpgen_term_code_eff))
                  title,
               smracaa_rule,
               smbarul_desc,
               smbarul_req_credits,
               smbarul_req_courses
          FROM smrprle,
               smbpgen pgenx,
               smrpaap paapx,
               smralib,
               smbagen agenx,
               smracaa acaax,
               smbarul arulx,
               smrarul rarulx
         WHERE     smbpgen_program = smrprle_program
               AND smrpaap_program = smbpgen_program
               AND SMBPGEN_ACTIVE_IND = 'Y'
               AND smrpaap_term_code_eff = smbpgen_term_code_eff
               AND smrpaap_area = smralib_area
               AND smbagen_area = smrpaap_area
               AND smbagen_term_code_eff = smrpaap_term_code_eff
               AND smracaa_area = smbagen_area
               AND smracaa_term_code_eff = smbagen_term_code_eff
               AND smbarul_area(+) = smracaa_area
               AND smbarul_key_rule(+) = smracaa_rule
               AND smbarul_term_code_eff(+) = smracaa_term_code_eff
               AND smrarul_area(+) = smbarul_area
               AND smrarul_key_rule(+) = smbarul_key_rule
               AND smrarul_term_code_eff(+) = smracaa_term_code_eff
               AND SMRPRLE_LEVL_CODE = 'Ìã'
               AND EXISTS
                      (SELECT '1'
                         FROM sgbstdn A
                        WHERE     A.SGBSTDN_TERM_CODE_EFF =
                                     (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN
                                       WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
                                       and sgbstdn_stst_code='AS'
                                       and sgbstdn_styp_code='ã'
                              AND a.sgbstdn_program_1 = SMBPGEN_PROGRAM))
 WHERE title LIKE '%ÊØæÚí%';