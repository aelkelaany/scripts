SELECT f_get_std_id (sgbstdn_pidm)       stdid,
       f_get_std_name (sgbstdn_pidm)     stdname 
       , f_get_desc_fnc('stvcoll',SGBSTDN_coll_code_1,30) coll ,
       f_get_desc_fnc('stvdept',SGBSTDN_dept_code,30) dept,SMRPRLE_PROGRAM_DESC,
         f_get_desc_fnc('stvcamp',SGBSTDN_camp_code,30) campus
  FROM sgbstdn,smrprle
 WHERE     SGBSTDN_TERM_CODE_EFF = '144410'
       AND SGBSTDN_STST_CODE = 'гд'
       and SMRPRLE_PROGRAM=sgbstdn_program_1
       AND EXISTS
               (SELECT '1'
                  FROM sfrstcr
                 WHERE     SFRSTCR_TERM_CODE = SGBSTDN_TERM_CODE_EFF
                       AND NVL (SFRSTCR_GRDE_CODE, '0') = 'гд'
                       AND SFRSTCR_RSTS_CODE IN ('RE', 'RW')
                       AND SFRSTCR_PIDM = sgbstdn_pidm)
                       order by 3,4,5,2;