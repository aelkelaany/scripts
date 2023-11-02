/* Formatted on 9/17/2023 11:02:47 AM (QP5 v5.371) */
SELECT * FROM bu_dev.tmp_tbl_kilany;

UPDATE bu_dev.tmp_tbl_kilany
   SET col04 = f_get_pidm (col02);

SELECT *
  FROM bu_dev.tmp_tbl_kilany
 WHERE col04 IS NULL;

DECLARE
    CURSOR GET_DATA IS
        SELECT COL01 CRN, COL04 PIDM
          FROM bu_dev.tmp_tbl_kilany
         WHERE col04 IS NOT NULL;

    CURSOR GET_DATA_crn IS
        SELECT DISTINCT COL01     CRN
          FROM bu_dev.tmp_tbl_kilany
         WHERE col01 IS NOT NULL;

    l_sfrstcr_count   NUMBER (3) := 0;
    l_ssbsect_count   NUMBER (3) := 0;
    L_TERM_CODE       VARCHAR2 (8) := '144510';
BEGIN
    FOR REC IN GET_DATA
    LOOP
        UPDATE SFRSTCR
           SET SFRSTCR_RSTS_CODE = 'DD',
               SFRSTCR_BILL_HR = 0,
               SFRSTCR_WAIV_HR = 0,
               SFRSTCR_CREDIT_HR = 0,
               SFRSTCR_BILL_HR_HOLD = 0,
               SFRSTCR_CREDIT_HR_HOLD = 0,
               SFRSTCR_ACTIVITY_DATE = SYSDATE,
               SFRSTCR_USER = USER
         WHERE     SFRSTCR_TERM_CODE = L_TERM_CODE
               AND SFRSTCR_PIDM = REC.PIDM
               AND SFRSTCR_CRN = REC.CRN
               AND SFRSTCR_RSTS_CODE IN ('RE', 'RW');

        l_sfrstcr_count := l_sfrstcr_count + SQL%ROWCOUNT;
    END LOOP;

    DBMS_OUTPUT.put_line ('SFRSTCR Updated Rows : ' || l_sfrstcr_count);

    FOR rec IN get_data_crn
    LOOP
        UPDATE ssbsect
           SET (SSBSECT_ENRL, SSBSECT_TOT_CREDIT_HRS) =
                   (SELECT COUNT (sfrstcr_pidm), SUM (SFRSTCR_CREDIT_HR)
                      FROM sfrstcr
                     WHERE     sfrstcr_term_code = ssbsect_term_code
                           AND sfrstcr_crn = ssbsect_crn
                           AND SFRSTCR_RSTS_CODE IN ('RE', 'RW')),
               SSBSECT_SEATS_AVAIL =
                     SSBSECT_MAX_ENRL
                   - (SELECT COUNT (sfrstcr_pidm)
                        FROM sfrstcr
                       WHERE     sfrstcr_term_code = ssbsect_term_code
                             AND sfrstcr_crn = ssbsect_crn
                             AND SFRSTCR_RSTS_CODE IN ('RE', 'RW'))
         WHERE ssbsect_term_code = l_term_code AND ssbsect_crn = rec.crn;

        l_ssbsect_count := l_ssbsect_count + SQL%ROWCOUNT;
    END LOOP;

    DBMS_OUTPUT.put_line ('SSBSECT Updated Rows : ' || l_ssbsect_count);
END;