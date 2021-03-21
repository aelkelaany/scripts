 
  SELECT f_get_std_id (sgbstdn_pidm) std_id,
         f_get_std_name (sgbstdn_pidm) std_name,
         sgbstdn_program_1 prog_code,
         SMRPRLE_PROGRAM_DESC prog_descr,
         CASE
            WHEN SGBSTDN_TERM_CODE_CTLG_1 < 143810 THEN 'ÎØÉ 33'
            ELSE 'ÎØÉ 38'
         END
            prog_ctlg,
         f_get_std_id (SGRADVR_ADVR_PIDM) ACD_ADVR_id,
         f_get_std_name (SGRADVR_ADVR_PIDM) ACD_ADVR_name,
         SGRADVR_TERM_CODE_EFF ACTIVE_FROM_TERM
    FROM sgbstdn a, SMRPRLE, SGRADVR B
   WHERE     A.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                          FROM SGBSTDN
                                         WHERE SGBSTDN_PIDM = A.SGBSTDN_PIDM)
         AND SGBSTDN_STST_CODE = 'AS'
         AND sgbstdn_program_1 = SMRPRLE_PROGRAM
         AND SGRADVR_PIDM = sgbstdn_pidm
         AND B.SGRADVR_TERM_CODE_EFF =
                (SELECT MAX (SGRADVR_TERM_CODE_EFF)
                   FROM SGRADVR
                  WHERE     SGRADVR_PIDM = B.SGRADVR_PIDM
                        AND SGRADVR_TERM_CODE_EFF <= :P_TERM_CODE)
                        AND  f_get_std_id (SGRADVR_ADVR_PIDM)=:FAC_ID 
ORDER BY STD_ID