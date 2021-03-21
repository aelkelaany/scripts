/* Formatted on 28/02/2021 11:26:34 (QP5 v5.227.12220.39754) */
SELECT f_get_std_id (sfrstcr_pidm),f_get_std_NAME (sfrstcr_pidm) ,
       ssbsect_crn,
       scbcrse_subj_code || scbcrse_crse_numb course_code,
       scbcrse_title,
       f_get_desc_fnc ('stvcoll', sgbstdn_coll_code_1, 30) college
  FROM sfrstcr,
       ssbsect,
       scbcrse,
       sgbstdn
 WHERE     sfrstcr_term_code = '144220'
       AND sfrstcr_rsts_code IN ('RE', 'RW')
       AND sfrstcr_term_code = ssbsect_term_code
       AND sfrstcr_crn = ssbsect_crn
       AND scbcrse_subj_code || scbcrse_crse_numb =
              ssbsect_subj_code || ssbsect_crse_numb
       AND SCBCRSE_EFF_TERM =
              (SELECT MAX (SCBCRSE_EFF_TERM)
                 FROM SCBCRSE
                WHERE scbcrse_subj_code || scbcrse_crse_numb =
                         ssbsect_subj_code || ssbsect_crse_numb)
       AND sgbstdn_pidm = sfrstcr_pidm
       AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE sgbstdn_pidm = sfrstcr_pidm)
       AND sgbstdn_coll_code_1 IN ('18', '15', '17', '19', '42', '41', '16', '31')
       --AND SGBSTDN_TERM_CODE_ADMIT BETWEEN '143310' AND '143810'
       AND SGBSTDN_LEVL_CODE = 'Ã„'
       AND SGBSTDN_STYP_CODE <> '‰'
       AND (    EXISTS
                  (SELECT '1'
                     FROM SMRDOUS
                    WHERE     SMRDOUS_PIDM = sfrstcr_pidm
                          AND ssbsect_subj_code || ssbsect_crse_numb =
                                 SMRDOUS_SUBJ_CODE || SMRDOUS_CRSE_NUMB
                          AND SMRDOUS_REQUEST_NO =
                                 (SELECT MAX (SMRDOUS_REQUEST_NO)
                                    FROM SMRDOUS
                                   WHERE SMRDOUS_PIDM = sfrstcr_pidm))
            OR  EXISTS
                  (SELECT '1'
                     FROM SMRDOrq
                    WHERE     SMRDOrq_PIDM = sfrstcr_pidm
                          AND ssbsect_subj_code || ssbsect_crse_numb =
                                 SMRDORQ_SUBJ_CODE || SMRDORQ_CRSE_NUMB_LOW
                          AND SMRDOrq_REQUEST_NO =
                                 (SELECT MAX (SMRDOrq_REQUEST_NO)
                                    FROM SMRDOrq
                                   WHERE SMRDOrq_PIDM = sfrstcr_pidm)
                          AND SMRDORQ_MET_IND = 'Y'))
                          ;