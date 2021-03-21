
  SELECT DISTINCT
         f_get_std_id (sfrstcr_pidm) id,
         f_get_std_name (sfrstcr_pidm) name,
        /* f_get_desc_fnc ('STVSTST', SGBSTDN_STST_CODE, 60)
            AS "Õ«·… «·ÿ«·»",*/
         f_get_desc_fnc ('STVSTYP', SGBSTDN_STYP_CODE, 60)
            AS "‰Ê⁄ «·œ—«”…",
         f_get_desc_fnc ('STVCOLL', sgbstdn_coll_code_1, 60) AS "«·ﬂ·Ì…",
         f_get_desc_fnc ('STVDEPT', sgbstdn_dept_code, 60) AS "«·ﬁ”„",
         f_get_desc_fnc ('STVCAMP', sgbstdn_camp_code, 60) AS "«·›—⁄",
         f_get_desc_fnc ('STVMAJR', sgbstdn_majr_code_1, 60) AS "«· Œ’’"
    FROM sfrstcr, sgbstdn , SSBSECT 
   WHERE     sgbstdn_pidm = sfrstcr_pidm
         AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM sgbstdn
                                       WHERE sgbstdn_pidm = sfrstcr_pidm)
         AND sfrstcr_term_code = '144020'
         AND sfrstcr_rsts_code IN ('RE', 'RW')
         AND  SGBSTDN_STST_CODE IN ('AS')
         AND F_GET_LEVEL(sgbstdn_pidm)='Ã„'
         AND SSBSECT_TERM_CODE='144020'
         AND SSBSECT_CRN=SFRSTCR_CRN
         AND SSBSECT_GRADABLE_IND='Y'
GROUP BY sfrstcr_pidm,
         sgbstdn_coll_code_1,
         sgbstdn_dept_code,
         sgbstdn_camp_code,
         sgbstdn_majr_code_1 ,SGBSTDN_STST_CODE ,SGBSTDN_STYP_CODE
  HAVING SUM (NVL(SFRSTCR_GRDE_CODE_MID,1)) = 0
ORDER BY 6,
         4,
         5,
         3 DESC