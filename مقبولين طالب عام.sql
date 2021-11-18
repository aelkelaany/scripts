SELECT COUNT (DISTINCT A.SGBSTDN_PIDM) ,stvcoll_desc,
         stvdept_desc,STVCOLL_VR_MSG_NO
             FROM SGBSTDN A ,SPRIDEN S,  stvcoll, stvdept
            WHERE     A.SGBSTDN_TERM_CODE_EFF =
                         (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                            FROM SGBSTDN
                           WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
                  AND SGBSTDN_STST_CODE = 'AS'
                  AND A.SGBSTDN_STYP_CODE = 'Ц'
                  AND SGBSTDN_TERM_CODE_ADMIT = '144310'
                  AND SPRIDEN_PIDM=SGBSTDN_PIDM
                  AND SPRIDEN_ID LIKE '443%'
                   AND SGBSTDN_COLL_CODE_1='12'
                    AND SGBSTDN_LEVL_CODE = 'ох' 
                     AND SGBSTDN_COLL_CODE_1 = stvcoll_code
                 AND SGBSTDN_DEPT_CODE = stvdept_code
                 GROUP BY stvcoll_desc, stvdept_desc, STVCOLL_VR_MSG_NO
                 ORDER BY STVCOLL_VR_MSG_NO ASC;