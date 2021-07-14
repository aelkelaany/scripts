/* Formatted on 12/07/2021 10:53:57 (QP5 v5.227.12220.39754) */
  SELECT *
    FROM (SELECT a1.*
            FROM STVTERM a1,
                 SOBTERM,
                 SIBINST i1,
                 STVFCST
           WHERE     a1.STVTERM_CODE LIKE NVL (:term_in, '%')
                 AND SOBTERM_TERM_CODE = a1.STVTERM_CODE
                 AND (   SOBTERM_FACSCHD_WEB_DISP_IND = 'Y'
                      OR SOBTERM_CLASLST_WEB_DISP_IND = 'Y'
                      OR SOBTERM_OVERAPP_WEB_UPD_IND = 'Y'
                      OR SOBTERM_ADD_DRP_WEB_UPD_IND = 'Y')
                 AND i1.SIBINST_TERM_CODE_EFF =
                        (SELECT MAX (B.SIBINST_TERM_CODE_EFF)
                           FROM SIBINST B
                          WHERE     B.SIBINST_TERM_CODE_EFF <=
                                       SOBTERM_TERM_CODE
                                AND B.SIBINST_PIDM = f_get_pidm ('2282'))
                 AND i1.SIBINST_PIDM = f_get_pidm ('2282')
                 AND i1.SIBINST_FCST_CODE = STVFCST_CODE
                 AND STVFCST_ACTIVE_IND = 'A'
                 AND SOBTERM_DYNAMIC_SCHED_TERM_IND = 'Y'
          UNION
          SELECT a2.*
            FROM STVTERM a2,
                 SOBPTRM,
                 SIBINST i2,
                 STVFCST,
                 SOBTERM
           WHERE     a2.STVTERM_CODE LIKE NVL (:term_in, '%')
                 AND SOBPTRM_TERM_CODE = a2.STVTERM_CODE
                 AND SOBPTRM_TERM_CODE = SOBTERM_TERM_CODE
                 AND (   SOBPTRM_MGRD_WEB_UPD_IND = 'Y'
                      OR SOBPTRM_FGRD_WEB_UPD_IND = 'Y'
                      OR SOBPTRM_WAITLST_WEB_DISP_IND = 'Y')
                 AND i2.SIBINST_TERM_CODE_EFF =
                        (SELECT MAX (D.SIBINST_TERM_CODE_EFF)
                           FROM SIBINST D
                          WHERE     D.SIBINST_TERM_CODE_EFF <=
                                       SOBPTRM_TERM_CODE
                                AND D.SIBINST_PIDM = f_get_pidm ('2282'))
                 AND i2.SIBINST_PIDM = f_get_pidm ('2282')
                 AND i2.SIBINST_FCST_CODE = STVFCST_CODE
                 AND STVFCST_ACTIVE_IND = 'A'
                 AND SOBTERM_DYNAMIC_SCHED_TERM_IND = 'Y')
   WHERE    EXISTS
               (SELECT 1
                  FROM SORFTRM
                 WHERE     TRUNC (SYSDATE) BETWEEN TRUNC (SORFTRM_START_DATE)
                                               AND TRUNC (SORFTRM_END_DATE)
                       AND STVTERM_CODE = SORFTRM_TERM_CODE
                       AND SORFTRM_TERM_IND = 'Y')
         OR NOT EXISTS
                   (SELECT 1
                      FROM SORFTRM
                     WHERE     STVTERM_CODE = SORFTRM_TERM_CODE
                           AND SORFTRM_TERM_IND = 'Y')
ORDER BY 1 DESC