/* Formatted on 15/04/2021 12:39:24 (QP5 v5.227.12220.39754) */
--create table bu_dev.not_used_crses as

SELECT f_get_std_id (SMRDOCN_PIDM) std_id,
       f_get_std_name (SMRDOCN_PIDM) std_name,
       SMRDOCN_TERM_CODE,
       SMRDOCN_CRN,
       SMRDOCN_SUBJ_CODE,
       SMRDOCN_CRSE_NUMB,
       SMRDOCN_CRSE_TITLE,
       SMRDOCN_PROGRAM,
       SMRPRLE_PROGRAM_DESC,
       SMRDOCN_GRDE_CODE,
       SMRDOCN_CREDIT_HOURS,
       SMRDOCN_CAMP_CODE,
       f_get_desc_fnc ('stvcamp', SMRDOCN_CAMP_CODE, 30) campus,
       SMRDOCN_COLL_CODE,
       f_get_desc_fnc ('stvcoll', SMRDOCN_COLL_CODE, 30) college,
       SMRDOCN_DEPT_CODE,
       f_get_desc_fnc ('stvdept', SMRDOCN_DEPT_CODE, 30) department,
       F_GET_STD_ID (SGRADVR_ADVR_PIDM) ADV_ID,
       F_GET_STD_NAME (SGRADVR_ADVR_PIDM) ADV_NAME
  FROM SATURN.SMRDOCN m,
       smrprle,
       SGRADVR,
       spriden
 WHERE --    SMRDOCN_PIDM = f_get_pidm ('436000782')     AND                     --
      SMRDOCN_REQUEST_NO = (SELECT MAX (SMRDOCN_REQUEST_NO)
                              FROM SMRDOCN
                             WHERE SMRDOCN_PIDM = m.SMRDOCN_PIDM)           --
       AND spriden_pidm = m.SMRDOCN_PIDM
       AND SUBSTR (spriden_id, 1, 3) >= '433'
       AND SUBSTR (spriden_id, 1, 3) < '438'
       AND NOT EXISTS
                  (SELECT '1'
                     FROM smrdous
                    WHERE     smrdous_request_no = SMRDOCN_REQUEST_NO
                          AND smrdous_pidm = SMRDOCN_PIDM
                          AND SMRDOUS_SUBJ_CODE || SMRDOUS_CRSE_NUMB =
                                 SMRDOCN_SUBJ_CODE || SMRDOCN_CRSE_NUMB)
       AND SGRADVR_PIDM = SMRDOCN_PIDM(+)
       AND SGRADVR_ADVR_CODE = '„—‘œ'
       AND SGRADVR_TERM_CODE_EFF = (SELECT MAX (SGRADVR_TERM_CODE_EFF)
                                      FROM SGRADVR
                                     WHERE SGRADVR_PIDM = SMRDOCN_PIDM)
              AND EXISTS
                     (SELECT 1
                        FROM SHRGRDE R1
                       WHERE     SHRGRDE_CODE = SMRDOCN_GRDE_CODE
                             AND SHRGRDE_LEVL_CODE = SMRDOCN_LEVL_CODE
                             AND SHRGRDE_TERM_CODE_EFFECTIVE =
                                    (SELECT MAX (R2.SHRGRDE_TERM_CODE_EFFECTIVE)
                                       FROM SHRGRDE R2
                                      WHERE     R1.SHRGRDE_CODE = R2.SHRGRDE_CODE
                                            AND R1.SHRGRDE_LEVL_CODE =
                                                   R2.SHRGRDE_LEVL_CODE)
                             AND SHRGRDE_PASSED_IND = 'Y')
       AND SMRDOCN_CREDIT_HOURS > 0
        AND f_get_status (SMRDOCN_PIDM) = 'AS'
       --  AND F_GET_STYP (SMRDOCN_PIDM) = '„'
       AND SMRPRLE_PROGRAM = SMRDOCN_PROGRAM
       AND SMRDOCN_LEVL_CODE = 'Ã„'
       AND EXISTS
              (SELECT '1'
                 FROM CAPP_PROGRAM_MAPPING
                WHERE program_code = SMRPRLE_PROGRAM);