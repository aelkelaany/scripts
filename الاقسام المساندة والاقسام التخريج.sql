/* Formatted on 3/12/2020 10:10:38 AM (QP5 v5.227.12220.39754) */
  SELECT DISTINCT
         a.SCBCRSE_COLL_CODE,
         a.SCBCRSE_DEPT_CODE,
         f_get_desc_fnc ('STVCOLL', a.SCBCRSE_COLL_CODE, 60) college,
         f_get_desc_fnc ('STVDEPT', a.SCBCRSE_DEPT_CODE, 60) department , 'ﬁ”„ „”«‰œ' ,'x'
           
    FROM scbcrse a
   WHERE     a.SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM scbcrse
                  WHERE     SCBCRSE_SUBJ_CODE = a.SCBCRSE_SUBJ_CODE
                        AND SCBCRSE_CRSE_NUMB = a.SCBCRSE_CRSE_NUMB)
         AND NOT EXISTS
                (SELECT '1'
                   FROM sgbstdn
                  WHERE sgbstdn_DEPT_CODE = a.SCBCRSE_DEPT_CODE)
         AND SCBCRSE_CSTA_CODE = 'A'
         AND a.SCBCRSE_DEPT_CODE IS NOT NULL
         and exists (select 'x' from  USERS_ATTRIBUTES
         where ATTRIBUTE_CODE='DEPARTMENT' AND ATTRIBUTE_VALUE=a.SCBCRSE_DEPT_CODE )
            and exists (select 'x' from  USERS_ATTRIBUTES
         where ATTRIBUTE_CODE='COLLEGE' AND ATTRIBUTE_VALUE=a.SCBCRSE_COLL_CODE )
         union 
          SELECT DISTINCT
    sgbstdn_coll_code_1 ,  sgbstdn_dept_code , f_get_desc_fnc ('STVCOLL', sgbstdn_coll_code_1, 60) college,
         f_get_desc_fnc ('STVDEPT', sgbstdn_dept_code, 60) department , 'ﬁ”„  Œ—ÌÃ' ,'x'
    from sgbstdn
                 WHERE exists (select 'x' from  USERS_ATTRIBUTES
         where ATTRIBUTE_CODE='COLLEGE' AND ATTRIBUTE_VALUE=sgbstdn_coll_code_1 )  
          and exists (select 'x' from  USERS_ATTRIBUTES
         where ATTRIBUTE_CODE='DEPARTMENT' AND ATTRIBUTE_VALUE=sgbstdn_dept_code ) 
              
ORDER BY 1 ,6