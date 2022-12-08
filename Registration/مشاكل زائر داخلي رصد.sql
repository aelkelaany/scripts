/* Formatted on 8/28/2022 3:04:33 PM (QP5 v5.371) */
SELECT F_GET_STD_ID (SGBSTDN_PIDM)     ST_ID,
       SGBSTDN_STST_CODE,
       SGBSTDN_PIDM,
       SGBSTDN_MAJR_CODE_1,
       SGBSTDN_COLL_CODE_1,
       SGBSTDN_DEPT_CODE,
       SGBSTDN_PROGRAM_1
  FROM sgbstdn sg
 WHERE     SGBSTDN_STYP_CODE = 'ã'
       AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
       AND EXISTS
               (SELECT '1'
                  FROM request_master
                 WHERE     object_code = 'WF_INTERNAL_VISITOR'
                       AND REQUESTER_PIDM = SG.SGBSTDN_PIDM
                       AND REQUEST_STATUS = 'C')
       AND SGBSTDN_STST_CODE  = 'AS'
       AND NOT EXISTS
               (SELECT '1'
                  FROM sovlfos s
                 WHERE     sovlfos_pidm = SG.SGBSTDN_PIDM
                       AND SOVLFOS_LCUR_SEQNO =
                           (SELECT MAX (SOVLFOS_LCUR_SEQNO)
                              FROM sovlfos
                             WHERE sovlfos_pidm = SG.SGBSTDN_PIDM)
                        
                       AND SOVLFOS_MAJR_CODE = sg.sgbstdn_majr_code_1)
       AND not EXISTS
               (SELECT '1'
                  FROM sfrstcr
                 WHERE     sfrstcr_pidm = SG.SGBSTDN_PIDM
                       AND sfrstcr_term_code = '144410'
                       AND sfrstcr_rsts_code  in ('RE', 'RW'))
                       
                      -- and sgbstdn_pidm=185577
                       ;