SELECT sgbstdn_pidm ,F_GET_STD_ID(sgbstdn_pidm),F_GET_STD_NAME(sgbstdn_pidm),SGBSTDN_PROGRAM_1
           FROM sgbstdn a
          WHERE     a.sgbstdn_term_code_eff =
                       (SELECT MAX (b.sgbstdn_term_code_eff)
                          FROM sgbstdn b
                         WHERE b.sgbstdn_pidm = a.sgbstdn_pidm
                         and b.sgbstdn_term_code_eff <= :p_term)
                AND sgbstdn_stst_code = 'AS'
                AND sgbstdn_levl_code   IN ('MA', 'ãÌ') 
                   
                          AND NOT EXISTS (
                          SELECT '1' from BNK_INVOICES WHERE 
                          STUDENT_PIDM=SGBSTDN_PIDM
                          AND TERM_CODE='144510'
                          
                          )
                          AND EXISTS (SELECT '1' FROM SFRSTCR WHERE SFRSTCR_TERM_CODE='144510'
                         
                          AND SFRSTCR_PIDM=SGBSTDN_PIDM
                          AND SFRSTCR_RSTS_CODE IN ('RE','RW')
                          )
                          AND NOT EXISTS (
                          
                          SELECT '1' FROM BU_APPS.PG_INVOICES_WAIVED_AMT
WHERE
ST_PIDM =SGBSTDN_PIDM
AND TERM_CODE='144510'
AND UPPER(NOTES) LIKE '%FULL%' )