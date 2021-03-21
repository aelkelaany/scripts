 
SELECT DISTINCT f_get_std_id (shrdgmr_pidm)
  FROM shrdgmr, sgbstdn sg
 WHERE     sg.sgbstdn_pidm = shrdgmr_pidm
       AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
       AND SGBSTDN_STST_CODE = 'ŒÃ'
       AND SHRDGMR_DEGS_CODE = 'ŒÃ'
       AND SHRDGMR_TERM_CODE_GRAD = '144010'
       and SHRDGMR_MAJR_CODE_1<>sgbstdn_MAJR_CODE_1
       and SGBSTDN_LEVL_CODE='Ã„'
        ;
       select F_WFR_POSTPONE_TERM(f_get_pidm('441007768')) from dual ;
       
       