/* Formatted on 4/26/2022 5:43:41 PM (QP5 v5.365) */
SELECT *
  FROM sgbstdn
 WHERE     SGBSTDN_TERM_CODE_EFF = '144510'
       AND SGBSTDN_STST_CODE = 'гЪ'
       AND EXISTS
               (SELECT '1'
                  FROM sfrstcr
                 WHERE     sfrstcr_term_code = '144510'
                       AND sfrstcr_pidm = sgbstdn_pidm
                       AND sfrstcr_grde_code = 'гд');
                       
                       
                       SELECT *
  FROM sgbstdn
 WHERE     SGBSTDN_TERM_CODE_EFF = '144510'
       AND SGBSTDN_STST_CODE = 'гд'
       AND EXISTS
               (SELECT '1'
                  FROM sfrstcr
                 WHERE     sfrstcr_term_code = '144510'
                       AND sfrstcr_pidm = sgbstdn_pidm
                       AND sfrstcr_grde_code = 'К');




---------

SELECT sfrstcr_pidm,
       f_get_std_id (sfrstcr_pidm),
       f_get_std_name (sfrstcr_pidm)
  FROM sfrstcr
 WHERE     sfrstcr_term_code = '144510'
       AND sfrstcr_grde_code = 'гд'
       AND EXISTS
               (SELECT '1'
                  FROM sgbstdn
                 WHERE     SGBSTDN_TERM_CODE_EFF = '144510'
                       AND SGBSTDN_STST_CODE = 'гЪ'
                       AND sfrstcr_pidm = sgbstdn_pidm);

                       -----

  SELECT sfrstcr_pidm,
         f_get_std_id (sfrstcr_pidm),
         f_get_std_name (sfrstcr_pidm),
         COUNT (*)
    FROM sfrstcr
   WHERE     sfrstcr_term_code = '144510'
         AND sfrstcr_grde_code = 'гд'
         AND EXISTS
                 (SELECT '1'
                    FROM sgbstdn
                   WHERE     SGBSTDN_TERM_CODE_EFF = '144510'
                         AND SGBSTDN_STST_CODE = 'гЪ'
                         AND sfrstcr_pidm = sgbstdn_pidm)
GROUP BY sfrstcr_pidm;

----
--processing
------
DECLARE
    CURSOR get_data IS
        SELECT sfrstcr_pidm,
               sfrstcr_term_code,
               sfrstcr_crn,
               sfrstcr_levl_code,
               shrtckn_seq_no,
               sfrstcr_grde_code
          FROM sfrstcr, shrtckn
         WHERE     sfrstcr_pidm = shrtckn_pidm(+)
               AND sfrstcr_term_code = shrtckn_term_code(+)
               AND sfrstcr_crn = shrtckn_crn(+)
               AND SFRSTCR_GRDE_CODE = 'гд'
               AND sfrstcr_term_code = '144510'
               -- AND sfrstcr_crn in ( '12068'/*,'15130','15034','15149','15091'*/)
               ---
               AND sfrstcr_pidm IN
                       (SELECT sgbstdn_pidm
                          FROM sgbstdn
                         WHERE     SGBSTDN_TERM_CODE_EFF = '144510'
                               AND SGBSTDN_STST_CODE = 'гЪ'
                               AND EXISTS
                                       (SELECT '1'
                                          FROM sfrstcr
                                         WHERE     sfrstcr_term_code =
                                                   '144510'
                                               AND sfrstcr_pidm =
                                                   sgbstdn_pidm
                                               AND sfrstcr_grde_code = 'гд'))
               AND SFRSTCR_GRDE_CODE IS NOT NULL
               AND SFRSTCR_GRDE_date IS NOT NULL;
               --

    l_shrtckg_count   NUMBER := 0;
    l_shrtckl_count   NUMBER := 0;
    l_shrtckn_count   NUMBER := 0;
    l_sfrstcr_count   NUMBER := 0;
BEGIN
    FOR i IN get_data
    LOOP
        /* CLEARING SHRTCKG */
        BEGIN
            DELETE FROM
                shrtckg
                  WHERE     shrtckg_pidm = i.sfrstcr_pidm
                        AND shrtckg_term_code = i.sfrstcr_term_code
                        AND shrtckg_tckn_seq_no = i.shrtckn_seq_no;

            l_shrtckg_count := l_shrtckg_count + SQL%ROWCOUNT;
        END;

        /* CLEARING SHRTCKL   */
        BEGIN
            DELETE FROM
                shrtckl
                  WHERE     shrtckl_pidm = i.sfrstcr_pidm
                        AND shrtckl_term_code = i.sfrstcr_term_code
                        AND shrtckl_tckn_seq_no = i.shrtckn_seq_no
                        AND shrtckl_levl_code = i.sfrstcr_levl_code;

            l_shrtckl_count := l_shrtckl_count + SQL%ROWCOUNT;
        END;


        /* CLEARING shrtckn   */
        BEGIN
            DELETE FROM
                shrtckn
                  WHERE     shrtckn_pidm = i.sfrstcr_pidm
                        AND shrtckn_term_code = i.sfrstcr_term_code
                        AND shrtckn_crn = i.sfrstcr_crn;

            l_shrtckn_count := l_shrtckn_count + SQL%ROWCOUNT;
        END;

        /* UPDATING SFRSTCR   */
        BEGIN
            UPDATE sfrstcr
               SET sfrstcr_grde_date = NULL, sfrstcr_grde_code = NULL
             WHERE     sfrstcr_pidm = i.sfrstcr_pidm
                   AND sfrstcr_term_code = i.sfrstcr_term_code
                   AND sfrstcr_crn = i.sfrstcr_crn;

            l_sfrstcr_count := l_sfrstcr_count + SQL%ROWCOUNT;
        END;
    END LOOP;

    DBMS_OUTPUT.put_line ('SHRTCKG Deleted Rows : ' || l_shrtckg_count);
    DBMS_OUTPUT.put_line ('SHRTCKL Deleted Rows : ' || l_shrtckl_count);
    DBMS_OUTPUT.put_line ('SHRTCKN Deleted Rows : ' || l_shrtckn_count);
    DBMS_OUTPUT.put_line ('SFRSTCR Updated Rows : ' || l_sfrstcr_count);
END;