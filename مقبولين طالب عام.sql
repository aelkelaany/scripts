/*  «⁄œ«œ */
  SELECT COUNT (DISTINCT A.SGBSTDN_PIDM),
         stvcoll_desc,
         stvdept_desc,
         STVCOLL_VR_MSG_NO
    FROM SGBSTDN A,
         SPRIDEN S,
         stvcoll,
         stvdept
   WHERE     A.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                          FROM SGBSTDN
                                         WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE = 'AS'
         AND A.SGBSTDN_STYP_CODE = '„'
         AND SGBSTDN_TERM_CODE_ADMIT = '144510'
         AND SPRIDEN_PIDM = SGBSTDN_PIDM
         AND SPRIDEN_ID LIKE '445%'
         --                   AND SGBSTDN_COLL_CODE_1='12'
         --                    AND SGBSTDN_LEVL_CODE = 'œ»'
         AND SGBSTDN_COLL_CODE_1 = stvcoll_code
         AND SGBSTDN_DEPT_CODE = stvdept_code
GROUP BY stvcoll_desc, stvdept_desc, STVCOLL_VR_MSG_NO
ORDER BY STVCOLL_VR_MSG_NO ASC;
/* »Ì«‰« */


SELECT  A.SGBSTDN_PIDM ,spbpers_ssn,spriden_id,SPRIDEN_FIRST_NAME||' '||SPRIDEN_MI||' '|| SPRIDEN_LAST_NAME stu_name , 
         stvcoll_desc,
         stvdept_desc,
         STVCOLL_VR_MSG_NO ,SGBSTDN_LEVL_CODE ,SGBSTDN_camp_CODE ,f_get_program_full_desc ('144510', sgbstdn_program_1)     description
         ,f_get_desc_fnc('stvcamp',SGBSTDN_camp_CODE,30) campus ,(SELECT sprtele_intl_access
                  FROM sprtele
                 WHERE     sprtele_pidm = A.SGBSTDN_PIDM 
                       AND sprtele_tele_code = 'MO'
                       AND ROWNUM = 1)     Mobile_NO 
    FROM SGBSTDN A,
         SPRIDEN S,
         stvcoll,
         stvdept ,spbpers 
   WHERE     A.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                          FROM SGBSTDN
                                         WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE = 'AS'
         AND A.SGBSTDN_STYP_CODE = '„'
         AND SGBSTDN_TERM_CODE_ADMIT = '144510'
         AND SPRIDEN_PIDM = SGBSTDN_PIDM
         and spbpers_pidm=SGBSTDN_PIDM
         AND SPRIDEN_ID LIKE '445%'
         and sgbstdn_levl_code!='MA'
         --AND SPRIDEN_ID not LIKE '4459%'
and spbpers_sex='F'
         AND SGBSTDN_COLL_CODE_1 = stvcoll_code
         AND SGBSTDN_DEPT_CODE = stvdept_code
order BY   STVCOLL_VR_MSG_NO ,stvdept_code
 ;



SELECT COUNT (DISTINCT A.SGBSTDN_PIDM) ,SGBSTDN_LEVL_CODE ,spbpers_sex
          
          
    FROM SGBSTDN A,
         SPRIDEN S,spbpers 
   WHERE     A.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                          FROM SGBSTDN
                                         WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
       --  AND SGBSTDN_STST_CODE = 'AS'
         --AND A.SGBSTDN_STYP_CODE = '„'
         AND SGBSTDN_TERM_CODE_ADMIT = '144510'
         AND SPRIDEN_PIDM = SGBSTDN_PIDM
         and spbpers_pidm=SGBSTDN_PIDM
         AND SPRIDEN_ID LIKE '445%'
         and exists ( SELECT '1'
    FROM VW_APPLICANT_CHOICES
   WHERE ADMIT_TERM = '144510' AND APPLICANT_DECISION = 'FA'
   and applicant_pidm=sgbstdn_pidm
   and spbpers_sex='M'
   
   )
         --                   AND SGBSTDN_COLL_CODE_1='12'
         --                    AND SGBSTDN_LEVL_CODE = 'œ»'
       
GROUP BY SGBSTDN_LEVL_CODE ,spbpers_sex  
ORDER BY SGBSTDN_LEVL_CODE ,spbpers_sex ASC;





  SELECT COUNT (DISTINCT A.SGBSTDN_PIDM),
         sgbstdn_program_1,
         f_get_program_full_desc ('144510', sgbstdn_program_1)     description
    FROM SGBSTDN A, spriden
   WHERE     A.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                          FROM SGBSTDN
                                         WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE = 'AS'
         AND A.SGBSTDN_STYP_CODE = '„'
         AND SGBSTDN_TERM_CODE_ADMIT = '144510'
         AND SPRIDEN_PIDM = SGBSTDN_PIDM
         AND SPRIDEN_ID LIKE '445%'
         and sgbstdn_program_1 like '1_13VA%'
        --  and  sgbstdn_program_1 not in ('1M16LAW38')
--
GROUP BY sgbstdn_program_1
ORDER BY 2 ASC;