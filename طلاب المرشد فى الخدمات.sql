SELECT sgradvr_pidm std_pidm,
                   f_getspridenid (sgradvr_pidm)
                || ' - '
                || f_format_name (sgradvr_pidm, 'FML')
                   std_name ,sgbstdn_dept_code ,f_get_std_name(sgradvr_advr_pidm) advisor_name ,sgbstdn_stst_code
           FROM sgradvr, sgbstdn a, sirdpcl x
          WHERE     sgradvr_advr_pidm = F_GET_PIDM(:ADVR_ID)
                AND sgradvr_pidm = sgbstdn_pidm
                AND a.sgbstdn_term_code_eff =
                       (SELECT MAX (b.sgbstdn_term_code_eff)
                          FROM sgbstdn b
                         WHERE     b.sgbstdn_pidm = a.sgbstdn_pidm
                               AND b.sgbstdn_term_code_eff <=
                                      f_get_param ('GENERAL',
                                                   'CURRENT_TERM',
                                                   1))
                AND sirdpcl_pidm = sgradvr_advr_pidm
                AND x.sirdpcl_term_code_eff =
                       (SELECT MAX (SIRDPCL_TERM_CODE_EFF)
                          FROM sirdpcl y
                         WHERE y.sirdpcl_pidm = x.sirdpcl_pidm)
                AND sgbstdn_dept_code = SIRDPCL_DEPT_CODE
                AND sgbstdn_coll_code_1 = SIRDPCL_COLL_CODE
                and sgbstdn_stst_code   in ('AS','ãæ','ãÚ');

