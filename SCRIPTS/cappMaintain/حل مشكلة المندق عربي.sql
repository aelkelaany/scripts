/* Formatted on 24/03/2021 10:47:11 (QP5 v5.227.12220.39754) */
SELECT *
  FROM bu_dev.tmp_tbl_kilany
 WHERE EXISTS
          (SELECT '1'
             FROM sgbstdn sg
            WHERE     sgbstdn_pidm = f_get_pidm (col01)
                  AND SGBSTDN_TERM_CODE_EFF =
                         (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                            FROM sgbstdn
                           WHERE sgbstdn_pidm = sg.sgbstdn_pidm)
                  AND sgbstdn_program_1 IN ('1F19ARAB38', '1M19ARAB38'));


UPDATE SFRSTCR
   SET SFRSTCR_RSTS_CODE = 'RE'
 WHERE     SFRSTCR_TERM_CODE = '144220'
       AND SFRSTCR_RSTS_CODE = 'DD'
       AND (SFRSTCR_PIDM, SFRSTCR_CRN) IN
              (SELECT F_GET_PIDM (COL01), COL03
                 FROM bu_dev.tmp_tbl_kilany
                WHERE EXISTS
                         (SELECT '1'
                            FROM sgbstdn sg
                           WHERE     sgbstdn_pidm = f_get_pidm (col01)
                                 AND SGBSTDN_TERM_CODE_EFF =
                                        (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                           FROM sgbstdn
                                          WHERE sgbstdn_pidm =
                                                   sg.sgbstdn_pidm)
                                 AND sgbstdn_program_1 IN
                                        ('1F19ARAB38', '1M19ARAB38')));

UPDATE SMRSSUB
   SET SMRSSUB_ATTR_CODE_REQ = 'BLHS'
 WHERE (SMRSSUB_PIDM, SMRSSUB_SUBJ_CODE_REQ || SMRSSUB_CRSE_NUMB_REQ) IN
          (SELECT F_GET_PIDM (COL01), COL04
             FROM bu_dev.tmp_tbl_kilany
            WHERE EXISTS
                     (SELECT '1'
                        FROM sgbstdn sg
                       WHERE     sgbstdn_pidm = f_get_pidm (col01)
                             AND SGBSTDN_TERM_CODE_EFF =
                                    (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                       FROM sgbstdn
                                      WHERE sgbstdn_pidm = sg.sgbstdn_pidm)
                             AND sgbstdn_program_1 IN
                                    ('1F19ARAB38', '1M19ARAB38')));