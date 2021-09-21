/* Formatted on 19/09/2021 14:42:07 (QP5 v5.371) */
  SELECT  
         COUNT (DISTINCT SGBSTDN_PIDM)
             all_reg_students 
         
    FROM SGBSTDN SG
   WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN
                                       WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE IN ('AS')
and  sgbstdn_coll_code_1=stvcoll_code  
    and f_get_gender (SGBSTDN_PIDM)='M'



select * from  
 ( SELECT  
             
         COUNT (DISTINCT SGBSTDN_PIDM) 
             all_males_students,
         f_get_desc_fnc ('stvcoll', sgbstdn_coll_code_1, 30)
    FROM SGBSTDN SG
   WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN
                                       WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE IN ('AS')
      
GROUP BY   sgbstdn_coll_code_1  ) a , ( SELECT  
             
         COUNT (DISTINCT SGBSTDN_PIDM) 
             all_males_students,
         f_get_desc_fnc ('stvcoll', sgbstdn_coll_code_1, 30)
    FROM SGBSTDN SG
   WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN
                                       WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE IN ('AS')
         and f_get_gender (SGBSTDN_PIDM)='M'
GROUP BY   sgbstdn_coll_code_1  ) b );



;
select stvcoll_code ,stvcoll_desc ,(SELECT  
         COUNT (DISTINCT SGBSTDN_PIDM)
             all_reg_students 
         
    FROM SGBSTDN SG
   WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN
                                       WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE IN ('AS','ãæ','ãÚ')
and  sgbstdn_coll_code_1=stvcoll_code  
    and f_get_gender (SGBSTDN_PIDM)='M')males ,(SELECT  
         COUNT (DISTINCT SGBSTDN_PIDM)
             all_reg_students 
         
    FROM SGBSTDN SG
   WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN
                                       WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE IN ('AS','ãæ','ãÚ')
and  sgbstdn_coll_code_1=stvcoll_code  
    and f_get_gender (SGBSTDN_PIDM)='F')females

from stvcoll

 ;
 
  SELECT  
         COUNT (DISTINCT SGBSTDN_PIDM)
             all_reg_students 
         
    FROM SGBSTDN SG
 WHERE     SGBSTDN_TERM_CODE_EFF =(SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                        FROM SGBSTDN
                                       WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE IN ('AS','ãæ','ãÚ')
 
   