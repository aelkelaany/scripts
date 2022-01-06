SELECT   F_GET_STD_ID(SGBSTDN_PIDM), F_GET_STD_NAME(SGBSTDN_PIDM)  
         ,stvcoll_desc,stvdept_desc,sgbstdn_program_1,f_get_program_full_desc ('144310',sgbstdn_program_1)
   ,decode(substr(sgbstdn_program_1,-1),'T','—”«·…','P','„‘—Ê⁄','·„ Ì „ «· Œ’Ì’') spec
   
             FROM SGBSTDN A  ,  stvcoll, stvdept
            WHERE     A.SGBSTDN_TERM_CODE_EFF =
                         (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                            FROM SGBSTDN
                           WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
                  AND SGBSTDN_STST_CODE IN( 'AS','„⁄','„Ê')
                    AND SGBSTDN_LEVL_CODE = 'MA' 
                     AND SGBSTDN_COLL_CODE_1 = stvcoll_code
                 AND SGBSTDN_DEPT_CODE = stvdept_code
                 and F_GET_STD_ID(SGBSTDN_PIDM) like '44%'
             ORDER BY  sgbstdn_program_1,F_GET_STD_ID(SGBSTDN_PIDM) ;