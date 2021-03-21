 
SELECT  
       f_get_std_id (sfrstcr_pidm) id,
       f_get_std_name (sfrstcr_pidm) name,
       scbcrse_title ,SGBSTDN_COLL_CODE_1 ,stvcoll_desc,SGBSTDN_DEPT_CODE,stvdept_desc
  FROM sfrstcr ,ssbsect, scbcrse a , sgbstdn b ,stvcoll ,stvdept
 WHERE     sfrstcr_pidm IN (SELECT GLBEXTR_KEY
                              FROM GLBEXTR
                             WHERE GLBEXTR_SELECTION = 'VOL_SERVICE2')
       AND ssbsect_term_code = sfrstcr_term_code
       AND ssbsect_crn = sfrstcr_crn
       AND ssbsect_subj_code = a.scbcrse_subj_code
       AND ssbsect_crse_numb = a.scbcrse_crse_numb
       AND a.scbcrse_eff_term =
              (SELECT MAX (scbcrse_eff_term)
                 FROM scbcrse
                WHERE     scbcrse_subj_code = a.scbcrse_subj_code
                      AND scbcrse_crse_numb = a.scbcrse_crse_numb
                      AND scbcrse_eff_term <= '143920')
       AND ssbsect_subj_code || SSBSECT_CRSE_NUMB IN
              ('11010123',
               '11010133',
               '11010143',
               '11010153',
               '11010163',
               '11010173',
               '11010183',
               '11020113',
               '11010113',
               '15030113',
               '17020113',
               '17070113')
               and b.SGBSTDN_pidm=sfrstcr_pidm
               and b.SGBSTDN_TERM_CODE_EFF=(select max(SGBSTDN_TERM_CODE_EFF) from sgbstdn where SGBSTDN_TERM_CODE_EFF<='143920' and SGBSTDN_pidm=b.SGBSTDN_pidm)
               and stvcoll_code=SGBSTDN_COLL_CODE_1
               and stvdept_code=SGBSTDN_DEPT_CODE