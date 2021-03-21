
  SELECT 
  --COUNT(DISTINCT  sfrstcr_pidm) COUNT,
  DISTINCT
        f_get_std_id (sfrstcr_pidm)  id,
         f_get_std_name (sfrstcr_pidm)     name,
         f_get_desc_fnc ('STVCOLL', sgbstdn_coll_code_1, 60) AS "ÇáßáíÉ",

       f_get_desc_fnc ('STVDEPT', sgbstdn_dept_code, 60) AS "ÇáÞÓã" ,
DECODE(SPBPERS_SEX,'M','ØÇáÈ','F','ØÇáÈÉ') AS "ÇáäæÚ"
       
 
    FROM sfrstcr,sgbstdn ,SPBPERS
   WHERE sgbstdn_pidm=sfrstcr_pidm
   AND SPBPERS_pidm=sfrstcr_pidm
   AND SGBSTDN_LEVL_CODE='Ìã'
     
   AND  SGBSTDN_STST_CODE='AS'
   and   SGBSTDN_TERM_CODE_EFF =(select max(SGBSTDN_TERM_CODE_EFF) from sgbstdn where sgbstdn_pidm=sfrstcr_pidm)
   and sfrstcr_term_code = '144030'
         AND sfrstcr_rsts_code IN  ('RE','RW')
         and sgbstdn_dept_code='1502'
        -- AND (SELECT SUM(SFRSTCR_CREDIT_HR) FROM SFRSTCR WHERE sfrstcr_term_code='144020' AND sfrstcr_pidm=sgbstdn_pidm)>0
       --  AND f_get_styp (sfrstcr_pidm) IN ( 'ã','È','Ê')
 --GROUP BY  sgbstdn_coll_code_1,sgbstdn_dept_code,SPBPERS_SEX
--ORDER BY 6,4,5,3 desc