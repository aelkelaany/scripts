/* Formatted on 8/31/2022 9:04:26 AM (QP5 v5.371) */
SELECT v.*, real_student - students_block remainig_students
  FROM (  SELECT COUNT (a.sgbstdn_pidm)
                     students_block,
                 (SELECT COUNT (b.sgbstdn_pidm)
                    FROM sgbstdn b
                   WHERE     b.SGBSTDN_TERM_CODE_EFF =
                             (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN
                               WHERE     SGBSTDN_PIDM = b.SGBSTDN_PIDM
                                     AND SGBSTDN_TERM_CODE_EFF <= '144410')
                         AND SGBSTDN_TERM_CODE_ADMIT = '144410'
                         AND b.sgbstdn_program_1 = a.sgbstdn_program_1)
                     real_student,
                 sgbstdn_program_1,
                 SMRPRLE_PROGRAM_DESC,
                 sgbstdn_blck_code,
                 f_get_desc_fnc ('STVBLCK', A.sgbstdn_blck_code, 30)
                     block_desc,
                 (SELECT MIN (SSBSECT_MAX_ENRL)
                    FROM SSRBLCK, ssbsect
                   WHERE     SSRBLCK_TERM_CODE = ssbsect_term_code
                         AND ssbsect_crn = SSRBLCK_crn
                         AND SSRBLCK_TERM_CODE = '144410'
                         AND SSRBLCK_BLCK_CODE = sgbstdn_blck_code)
                     crn_capacity,
                 (SELECT MIN (SYRBLKR_CAPACITY_NO)
                    FROM SYRBLKR
                   WHERE     SYRBLKR_TERM_CODE = '144410'
                         AND SYRBLKR_BLCK_CODE = A.sgbstdn_blck_code/*AND SYRBLKR_PROGRAM = A.sgbstdn_program_1*/
                                                                    )
                     BLOCK_CPACITY
            FROM sgbstdn a, SMRPRLE
           WHERE     A.SGBSTDN_TERM_CODE_EFF =
                     (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                        FROM SGBSTDN
                       WHERE     SGBSTDN_PIDM = A.SGBSTDN_PIDM
                             AND SGBSTDN_TERM_CODE_EFF <= '144410')
                 AND SGBSTDN_TERM_CODE_ADMIT = '144410'
                 AND SMRPRLE_PROGRAM = SGBSTDN_PROGRAM_1
                 /*AND EXISTS ( select '1' from GLBEXTR where  GLBEXTR_SELECTION='BLOCKS_REGS_144210'
and GLBEXTR_KEY=A.SGBSTDN_PIDM )*/
                 AND NOT EXISTS
                         (SELECT '1'
                            FROM spriden
                           WHERE     spriden_pidm = A.SGBSTDN_PIDM
                                 AND spriden_id LIKE '4449%')
                 AND A.SGBSTDN_levl_code = 'Ìã'
                 AND EXISTS
                         (SELECT '1'
                            FROM SARAPPD
                           WHERE     SARAPPD_PIDM = A.SGBSTDN_PIDM
                                 AND SARAPPD_APDC_CODE = 'FA'
                                 AND SARAPPD_TERM_CODE_ENTRY = '144410')
        -- AND sgbstdn_blck_code LIKE 'L%'
        GROUP BY sgbstdn_program_1,
                 sgbstdn_blck_code,
                 SMRPRLE_PROGRAM_DESC,
                 f_get_desc_fnc ('STVBLCK', A.sgbstdn_blck_code, 30)
        ORDER BY                                        /*sgbstdn_program_1,*/
                 sgbstdn_blck_code) V;