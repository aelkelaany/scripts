/* Formatted on 3/14/2023 11:59:14 AM (QP5 v5.371) */
DECLARE
    CURSOR get_reg_std IS
        SELECT SYBSTDC_PIDM     pidm,
               SYBSTDC_CRN      crn,
               ssbsect_subj_code,
               ssbsect_crse_numb
          FROM sybstdc, ssbsect
         WHERE     SYBSTDC_TERM_CODE = :p_term
               AND SYBSTDC_DISCONNECTED = 'Y'
               AND f_get_styp (SYBSTDC_PIDM) <> 'д'
                AND f_GET_STATUS (SYBSTDC_PIDM)='AS'
               AND ssbsect_term_code = :p_term
               -- and ssbsect_ptrm_code in ('5','1')
               AND ssbsect_crn = SYBSTDC_CRN
               AND EXISTS
                       (SELECT '1'
                          FROM sfrstcr
                         WHERE     sfrstcr_term_code = SYBSTDC_TERM_CODE
                               AND sfrstcr_crn = SYBSTDC_CRN
                               AND sfrstcr_pidm = SYBSTDC_PIDM
                               AND sfrstcr_grde_code IS NULL);

    l_count_sfrstcr     NUMBER := 0;
    l_sgbstdn_sfrstcr   NUMBER := 0;

    CURSOR get_dc_students IS
        SELECT DISTINCT sfrstcr_pidm     pidm
          FROM sfrstcr s
         WHERE     SFRSTCR_TERM_CODE = :p_term
               AND SFRSTCR_GRDE_CODE = 'гд'
               AND SFRSTCR_RSTS_CODE IN ('RE', 'RW')
               AND NOT EXISTS
                       (SELECT '1'
                          FROM sfrstcr
                         WHERE     SFRSTCR_TERM_CODE = :p_term
                               AND NVL (SFRSTCR_GRDE_CODE, '0') <> 'гд'
                               AND SFRSTCR_RSTS_CODE IN ('RE', 'RW')
                               AND SFRSTCR_PIDM = s.SFRSTCR_PIDM)
               AND EXISTS
                       (SELECT '1'
                          FROM sgbstdn
                         WHERE     sgbstdn_term_code_eff =
                                   (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE sgbstdn_pidm = sfrstcr_pidm)
                               AND sgbstdn_pidm = sfrstcr_pidm
                               AND sgbstdn_stst_code != 'гд')
--                                AND  NOT  EXISTS
--               (SELECT '1'
--                  FROM sfrstcr
--                 WHERE     sfrstcr_pidm = s.sfrstcr_pidm
--                       AND sfrstcr_term_code = '144430'
--                       AND SFRSTCR_RSTS_CODE IN ('RE', 'RW'))
                               
                               ;
BEGIN
 
    FOR rec IN get_reg_std
    LOOP
        UPDATE sfrstcr
           SET SFRSTCR_GRDE_CODE = 'гд',
               SFRSTCR_GRDE_CODE_MID = '0',
               SFRSTCR_DATA_ORIGIN = 'Banner DC',
               sfrstcr_activity_date = SYSDATE
         WHERE     SFRSTCR_TERM_CODE = :p_term
               AND SFRSTCR_PIDM = rec.pidm
               AND SFRSTCR_RSTS_CODE IN ('RE', 'RW')
               AND SFRSTCR_GRDE_CODE IS NULL
               AND sfrstcr_crn IN
                       (SELECT ssbsect_crn
                          FROM ssbsect
                         WHERE     ssbsect_term_code = :p_term
                               AND ssbsect_subj_code = rec.ssbsect_subj_code
                               AND ssbsect_crse_numb = rec.ssbsect_crse_numb);

        l_count_sfrstcr := l_count_sfrstcr + 1;
    END LOOP;

    DBMS_OUTPUT.put_line ('SFRSTCR updated rows =' || l_count_sfrstcr);
 
    --change student status >>
    FOR rec2 IN get_dc_students
    LOOP
        p_update_std_status (rec2.pidm,
                             :p_term,
                             'гд',
                             'Banner DC');
        l_sgbstdn_sfrstcr := l_sgbstdn_sfrstcr + 1;
    END LOOP;

    DBMS_OUTPUT.put_line ('SGBSTDN updated rows =' || l_sgbstdn_sfrstcr);
END;