/* Formatted on 5/27/2020 8:31:59 AM (QP5 v5.360) */
SELECT --,
        DISTINCT
       ssbsect_crn,
       scbcrse_subj_code,
       scbcrse_crse_numb,
       scbcrse_title, f_get_desc_fnc ('STVSCHD', SSBSECT_SCHD_CODE, 60) as "äæÚ ÇáÌÏæá" ,SSBSECT_CREDIT_HRS , decode(SSBSECT_GRADABLE_IND,'Y','ÎÇÖÚ ááÊÞííã','ÛíÑ ÎÇÖÚ ááÊÞííã') , 
       f_get_desc_fnc ('STVCOLL', scbcrse_coll_code, 60)
           AS "ÇáßáíÉ",
       f_get_desc_fnc ('STVDEPT', scbcrse_dept_code, 60)
           AS "ÇáÞÓã",
       ssbsect_max_enrl ,ssbsect_enrl ,SSBSECT_SEATS_AVAIL
  FROM ssbsect, scbcrse
 WHERE     ssbsect_term_code = '144210'
       AND scbcrse_subj_code = ssbsect_subj_code
       AND scbcrse_crse_numb = ssbsect_crse_numb
      -- and ssbsect_ptrm_code=3
--and SSBSECT_SSTS_CODE='ä'
--and SSBSECT_SEATS_AVAIL>0
and ssbsect_max_enrl=0
   and ssbsect_enrl=0
order by 5,6
--  group by sfrstcr_crn ,scbcrse_coll_code ,scbcrse_dept_code