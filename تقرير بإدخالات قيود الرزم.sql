/* Formatted on 31/08/2021 09:57:58 (QP5 v5.371) */
  SELECT STVBLCK_CODE,
         STVBLCK_DESC,
         SYRBLKR_COLL_CODE,
         f_get_desc_fnc ('STVCOLL', SYRBLKR_COLL_CODE, 60)
             AS "«·ﬂ·Ì…",
         SYRBLKR_CAMP_CODE,
         f_get_desc_fnc ('STVCAMP', SYRBLKR_CAMP_CODE, 60)
             AS "«·›—⁄",
         SYRBLKR_MAJR_CODE,
         f_get_desc_fnc ('STVMAJR', SYRBLKR_MAJR_CODE, 60)
             AS "«· Œ’’",
         SYRBLKR_DEPT_CODE,
         f_get_desc_fnc ('STVDEPT', SYRBLKR_DEPT_CODE, 60)
             AS "«·ﬁ”„",
         SYRBLKR_PROGRAM,
         (SELECT smrprle_program_desc
            FROM smrprle
           WHERE smrprle_program = SYRBLKR_PROGRAM)
             AS "Ê’› «·»—‰«„Ã",
         SYRBLKR_CAPACITY_NO,
         SYRBLKR_CAPACITY_USED
         /*,(SELECT COUNT (applicant_pidm)
            FROM VW_APPLICANT_CHOICES
           WHERE     ADMIT_TERM = '144310'
                 AND APPLICANT_DECISION IN ('QA', 'FA')
                 AND APPLICANT_CHOICE = SYRBLKR_PROGRAM)
             "«·›⁄·Ì"*/
    FROM stvblck, syrblkr
   WHERE     SYRBLKR_BLCK_CODE = STVBLCK_CODE
         AND SYRBLKR_TERM_CODE = '144310'
         AND EXISTS
                 (SELECT 'x'
                    FROM SSRBLCK
                   WHERE     SSRBLCK_TERM_CODE = SYRBLKR_TERM_CODE
                         AND SSRBLCK_BLCK_CODE = SYRBLKR_BLCK_CODE)
         AND SYRBLKR_LEVL_CODE = 'Ã„'
         AND SYRBLKR_COLL_CODE NOT IN ('12', '35')
ORDER BY SYRBLKR_COLL_CODE, SYRBLKR_PROGRAM;


  SELECT a.*,
         b.*,
         (SELECT MAX (scbcrse_title)
            FROM scbcrse, ssbsect
           WHERE     ssbsect_term_code = '144310'
                 AND ssbsect_crn = SSRBLCK_CRN
                 AND scbcrse_subj_code || scbcrse_crse_numb =
                     ssbsect_subj_code || ssbsect_crse_numb)    title
    FROM SSRBLCK a, stvblck b
   WHERE     SSRBLCK_BLCK_CODE = stvblck_CODE
         AND SSRBLCK_TERM_CODE = '144310'
         AND NOT EXISTS
                 (SELECT '1'
                    FROM SYRBLKR
                   WHERE     SSRBLCK_TERM_CODE = SYRBLKR_TERM_CODE
                         AND SSRBLCK_BLCK_CODE = SYRBLKR_BLCK_CODE)
ORDER BY 2;

------

 SELECT  distinct stvblck_code,stvblck_desc
    FROM SSRBLCK a, stvblck b
   WHERE     SSRBLCK_BLCK_CODE = stvblck_CODE
         AND SSRBLCK_TERM_CODE = '144310'
         and stvblck_CODE not like '%PG%'
         and stvblck_desc not like '%«‰ ”«»%'
         AND   EXISTS
                 (SELECT '1'
                    FROM SYRBLKR
                   WHERE     SSRBLCK_TERM_CODE = SYRBLKR_TERM_CODE
                         AND SSRBLCK_BLCK_CODE = SYRBLKR_BLCK_CODE)
ORDER BY 1;
--------------

--DELETE FROM
    SYRBLKR
      WHERE     SYRBLKR_TERM_CODE = '144310'
            AND NOT EXISTS

(SELECT 'x'
   FROM SSRBLCK
  WHERE     SSRBLCK_TERM_CODE = SYRBLKR_TERM_CODE
        AND SSRBLCK_BLCK_CODE = SYRBLKR_BLCK_CODE);



                            ---------- «⁄œ«œ ·ﬂ· »—‰«„Ã


  SELECT COUNT (A.SGBSTDN_PIDM)                                    std_count,
         f_get_program_full_desc ('144310', sgbstdn_program_1)     description,
         sgbstdn_program_1                                         prog_code
    FROM SGBSTDN A
   WHERE     A.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                          FROM SGBSTDN
                                         WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE = 'AS'
         and SGBSTDN_levl_code='Ã„'
         AND A.SGBSTDN_STYP_CODE = '„'
         AND SGBSTDN_TERM_CODE_ADMIT = '144310'
       
     --    AND sgbstdn_program_1 LIKE '1F15E%'
      AND EXISTS
                         (SELECT '1'
                            FROM SARAPPD
                           WHERE     SARAPPD_PIDM = A.SGBSTDN_PIDM
                                 AND SARAPPD_APDC_CODE = 'FA'
                                 AND SARAPPD_TERM_CODE_ENTRY = '144310')
GROUP BY sgbstdn_program_1
ORDER BY 3;


  SELECT COUNT (A.SGBSTDN_PIDM)     std_count
    FROM SGBSTDN A
   WHERE     A.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                          FROM SGBSTDN
                                         WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE = 'AS'
         AND A.SGBSTDN_STYP_CODE = '„'
         AND SGBSTDN_TERM_CODE_ADMIT = '144310'
 
 ;
 
 -- masters
 
  SELECT a.*,
         b.*,
         (SELECT MAX (scbcrse_title)
            FROM scbcrse, ssbsect
           WHERE     ssbsect_term_code = '144310'
                 AND ssbsect_crn = SSRBLCK_CRN
                 AND scbcrse_subj_code || scbcrse_crse_numb =
                     ssbsect_subj_code || ssbsect_crse_numb)    title
    FROM SSRBLCK a, stvblck b
   WHERE     SSRBLCK_BLCK_CODE = stvblck_CODE 
         AND SSRBLCK_TERM_CODE = '144310'
--         AND NOT EXISTS
--                 (SELECT '1'
--                    FROM SYRBLKR
--                   WHERE     SSRBLCK_TERM_CODE = SYRBLKR_TERM_CODE
--                         AND SSRBLCK_BLCK_CODE = SYRBLKR_BLCK_CODE)
                         and SSRBLCK_BLCK_CODE like '%PG%'
ORDER BY  substr(SSRBLCK_BLCK_CODE,-1) asc ,SSRBLCK_BLCK_CODE;
 

select * from stvblck
where stvblck_CODE not in (select SSRBLCK_BLCK_CODE
from ssrblck
where SSRBLCK_TERM_CODE='144310' )
 and stvblck_CODE like '%PG%'; 