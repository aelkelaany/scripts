/* Formatted on 11/3/2022 2:48:27 PM (QP5 v5.371) */
  SELECT crn,
         SCBCRSE_SUBJ_CODE || SCBCRSE_CRSE_NUMB        CRSE_CODE,
         title,
         f_get_desc_fnc ('stvcoll', coll, 30)          coll,
         f_get_desc_fnc ('stvdept', dept, 30)          dept,
         f_get_desc_fnc ('stvcamp', camp, 30)          camp,
         f_get_desc_fnc ('stvcoll', std_coll, 30)      std_coll,
         f_get_desc_fnc ('stvmajr', std_major, 30)     std_major,
         f_get_std_id (instr_pidm)                     instr_id,
         f_get_std_name (instr_pidm)                   instr_name
    FROM (SELECT DISTINCT ssbsect_CRN                               crn,
                          C.SCBCRSE_SUBJ_CODE,
                          c.SCBCRSE_CRSE_NUMB,
                          (SELECT sirasgn_pidm
                             FROM saturn.sirasgn
                            WHERE     sirasgn_term_code = '144410'
                                  AND sirasgn_crn = ssbsect_crn
                                  AND sirasgn_primary_ind = 'Y')    instr_pidm,
                          SCBCRSE_TITLE                             title,
                          SCBCRSE_COLL_CODE                         coll,
                          SCBCRSE_DEPT_CODE                         dept,
                          ssbsect_camp_code                         camp,
                          f_std_college (sfrstcr_pidm)              std_coll,
                          F_GET_MAJOR (sfrstcr_pidm)                std_major
            FROM SSBSECT, SCBCRSE c, sfrstcr
           WHERE     ssbsect_term_code = '144410'
                 AND c.SCBCRSE_EFF_TERM =
                     (SELECT MAX (SCBCRSE_EFF_TERM)
                        FROM SCBCRSE
                       WHERE     SCBCRSE_SUBJ_CODE = c.SCBCRSE_SUBJ_CODE
                             AND SCBCRSE_CRSE_NUMB = c.SCBCRSE_CRSE_NUMB
                             AND SCBCRSE_EFF_TERM <= '144410')
                 AND c.SCBCRSE_CRSE_NUMB = ssbsect_crse_numb
                 AND scbcrse_subj_code = ssbsect_subj_code
                 AND sfrstcr_term_code = ssbsect_term_code
                 AND sfrstcr_crn = ssbsect_CRN)
ORDER BY crn, std_coll, std_major;