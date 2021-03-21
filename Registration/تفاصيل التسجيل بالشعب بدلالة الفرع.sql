/* Formatted on 5/27/2020 8:31:59 AM (QP5 v5.360) */
SELECT --,
        DISTINCT
       ssbsect_crn,
       scbcrse_subj_code,
       scbcrse_crse_numb,
       scbcrse_title, f_get_desc_fnc ('STVSCHD', SSBSECT_SCHD_CODE, 60) as "‰Ê⁄ «·ÃœÊ·" ,SSBSECT_CREDIT_HRS , decode(SSBSECT_GRADABLE_IND,'Y','Œ«÷⁄ ·· ﬁÌÌ„','€Ì— Œ«÷⁄ ·· ﬁÌÌ„') , 
        f_get_desc_fnc ('STVCOLL', scbcrse_coll_code, 60)
           AS "«·ﬂ·Ì…",
       f_get_desc_fnc ('STVDEPT', scbcrse_dept_code, 60)
           AS "«·ﬁ”„", 
          f_get_desc_fnc ('STVCAMP', SSBSECT_CAMP_CODE, 60) as "«·›—⁄" , SSBSECT_CAMP_CODE ,
       ssbsect_max_enrl ,ssbsect_enrl ,SSBSECT_SEATS_AVAIL
  FROM ssbsect, scbcrse
 WHERE     ssbsect_term_code = '144030'
       AND scbcrse_subj_code = ssbsect_subj_code
       AND scbcrse_crse_numb = ssbsect_crse_numb
AND SCBCRSE_EFF_TERM =
             (SELECT MAX (SCBCRSE_EFF_TERM)
                FROM SCBCRSE
               WHERE     scbcrse_subj_code = ssbsect_subj_code
                     AND scbcrse_crse_numb = ssbsect_crse_numb)
         AND SSBSECT_SSTS_CODE = '‰'
         AND EXISTS
                 (SELECT '1'
                    FROM SFRSTCR
                   WHERE     sfrstcr_term_code = ssbsect_term_code
                         AND sfrstcr_crn = ssbsect_crn
                         AND sfrstcr_rsts_code IN ('RE', 'RW'))
 AND scbcrse_coll_code NOT IN ('15')
--AND scbcrse_DEPT_code = '1502'
AND SSBSECT_CAMP_CODE='16'

order by 9
--  group by sfrstcr_crn ,scbcrse_coll_code ,scbcrse_dept_code