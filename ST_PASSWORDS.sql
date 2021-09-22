
     SELECT 
   ROWID, USER_ID, USER_PWD, STATUS, 
   SEQ_ID
FROM BU_APPS.GINUCRD G 
where  

SEQ_ID=(SELECT MAX(SEQ_ID) FROM GINUCRD  WHERE USER_ID=G.USER_ID )

--and substr(USER_ID,0,3)='442'
  AND USER_ID IN ( SELECT  
         F_GET_STD_ID(SG.sgbstdn_pidm) 
     FROM SGBSTDN SG
    WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                         FROM SGBSTDN
                                        WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE IN ('AS')
          AND SGBSTDN_DEGC_CODE_1 IN ('ох')
         -- AND SGBSTDN_STYP_CODE IN ('Ц')
          AND SGBSTDN_LEVL_CODE = 'ох'
          AND NOT EXISTS
                 (SELECT '1'
                    FROM spriden
                   WHERE     spriden_pidm = SG.sgbstdn_pidm
                         AND SUBSTR (spriden_id, 1, 3) = '443'))

