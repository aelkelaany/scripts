/* Formatted on 9/10/2019 2:59:36 PM (QP5 v5.227.12220.39754) */
SELECT M.QUOTA_PROGRAM 
       ,
       (SELECT NVL (a.sorcmjr_desc, stvmajr_desc) major_desc
          FROM stvmajr,
               sorcmjr a,
               sormcrl b,
               sobcurr,
               stvwapp
         WHERE     stvmajr_code = a.sorcmjr_majr_code
               AND stvmajr_valid_major_ind = 'Y'
               AND stvwapp_code = 'UG'
               AND a.sorcmjr_curr_rule = sobcurr_curr_rule
               AND b.sormcrl_curr_rule = sobcurr_curr_rule
               --AND sobcurr_levl_code = stvwapp_levl_code
               AND b.sormcrl_adm_ind = 'Y'
               AND a.sorcmjr_disp_web_ind = 'Y'
               AND a.sorcmjr_adm_ind = 'Y'
               AND b.sormcrl_term_code_eff =
                      (SELECT MAX (sormcrl_term_code_eff)
                         FROM sormcrl
                        WHERE     sormcrl_curr_rule = b.sormcrl_curr_rule
                              AND sormcrl_adm_ind = 'Y'
                              AND sormcrl_term_code_eff <= QUOTA_TERM)
               AND a.sorcmjr_term_code_eff =
                      (SELECT MAX (x.sorcmjr_term_code_eff)
                         FROM sorcmjr x
                        WHERE     x.sorcmjr_curr_rule = a.sorcmjr_curr_rule
                              AND x.sorcmjr_term_code_eff <= QUOTA_TERM)
               AND SOBCURR_PROGRAM = M.QUOTA_PROGRAM)
          PRG_DESC , M.QUOTA_AVAILABLE_SEATS , (SELECT COUNT(*) FROM SGBSTDN  A
WHERE A.SGBSTDN_TERM_CODE_EFF =(SELECT MAX(SGBSTDN_TERM_CODE_EFF) FROM SGBSTDN
WHERE SGBSTDN_PIDM=A.SGBSTDN_PIDM
and SGBSTDN_TERM_CODE_EFF<='144010'
 )
AND SGBSTDN_STST_CODE='AS'
AND A.SGBSTDN_STYP_CODE ='ã'
 AND A.SGBSTDN_PROGRAM_1=M.QUOTA_PROGRAM
AND SUBSTR(F_GET_STD_ID(A.SGBSTDN_PIDM),1,3)='441'
 ) REAL_SEATS
  FROM BU_APPS.ADM_QUOTA_RULE_SEQ M
 WHERE QUOTA_TERM = '144010' AND QUOTA_RUN_SEQUENCE = 3
 ORDER BY SUBSTR(M.QUOTA_PROGRAM,2)