/* Formatted on 4/21/2019 2:33:26 PM (QP5 v5.227.12220.39754) */
  SELECT f_get_std_id (B.SGBSTDN_PIDM),f_get_std_name(B.SGBSTDN_PIDM),
         f_get_desc_fnc ('STVCOLL', b.SGBSTDN_COLL_CODE_1, 30),a.SMBPGEN_PROGRAM,
         SMRPRLE_PROGRAM_DESC,
            least(round(SUM (SHRTGPA_HOURS_EARNED) /(a.SMBPGEN_REQ_CREDITS_OVERALL)*100,2),100) sum_req   
         
         
     
    FROM SMBPGEN a,
         sgbstdn b,
         spriden s,
         smrprle,
         shrtgpa
   WHERE     shrtgpa_PIDM = b.sgbstdn_pidm
         AND a.SMBPGEN_PROGRAM = b.SGBSTDN_PROGRAM_1
         AND SGBSTDN_STST_CODE = 'AS'
         AND sgbstdn_term_code_eff =
                (SELECT MAX (a.sgbstdn_term_code_eff)
                   FROM sgbstdn a
                  WHERE     a.sgbstdn_pidm = b.sgbstdn_pidm
                        AND a.sgbstdn_term_code_eff <= '143920')
         AND S.SPRIDEN_PIDM = b.sgbstdn_pidm
         AND S.SPRIDEN_CHANGE_IND IS NULL
         AND S.SPRIDEN_ID LIKE '439%'
         AND SMRPRLE_PROGRAM = a.SMBPGEN_PROGRAM
         AND A.SMBPGEN_TERM_CODE_EFF =
                (SELECT MAX (SMBPGEN_TERM_CODE_EFF)
                   FROM SMBPGEN
                  WHERE     SMBPGEN_PROGRAM = A.SMBPGEN_PROGRAM
                        AND SMBPGEN_TERM_CODE_EFF <= '143910')
GROUP BY b.SGBSTDN_COLL_CODE_1, SMRPRLE_PROGRAM_DESC, a.SMBPGEN_PROGRAM ,a.SMBPGEN_REQ_CREDITS_OVERALL ,B.SGBSTDN_PIDM
ORDER BY  3,4

 