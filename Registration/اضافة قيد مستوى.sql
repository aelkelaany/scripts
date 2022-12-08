/* Formatted on 8/25/2022 9:35:16 AM (QP5 v5.371) */
DECLARE
    l_term_code    VARCHAR2 (8) := '144410';
    l_ptrm_code    VARCHAR2 (1) := '4';
    l_level_code   VARCHAR2 (8) := 'MA';
    l_row_count    NUMBER (4) := 0;

    CURSOR get_crn_data IS
        SELECT ssbsect_crn     crn
          FROM ssbsect
         WHERE     ssbsect_term_code = l_term_code
               AND ssbsect_ptrm_code = l_ptrm_code
               AND SSBSECT_SSTS_CODE = 'ä'
               AND NOT EXISTS
                       (SELECT '1'
                          FROM SSRRLVL
                         WHERE     SSRRLVL_TERM_CODE = l_term_code
                               AND SSRRLVL_CRN = ssbsect_crn);
BEGIN
    FOR rec IN get_crn_data
    LOOP
        --SSRRLVL 1
        INSERT INTO SATURN.SSRRLVL (SSRRLVL_TERM_CODE,
                                    SSRRLVL_CRN,
                                    SSRRLVL_REC_TYPE,
                                    SSRRLVL_LEVL_IND,
                                    SSRRLVL_ACTIVITY_DATE)
             VALUES (l_term_code,
                     rec.crn,
                     '1',
                     'I',
                     SYSDATE);

        --SSRRLVL 2
        INSERT INTO SATURN.SSRRLVL (SSRRLVL_TERM_CODE,
                                    SSRRLVL_CRN,
                                    SSRRLVL_REC_TYPE,
                                    SSRRLVL_LEVL_CODE,
                                    SSRRLVL_ACTIVITY_DATE)
             VALUES (l_term_code,
                     rec.crn,
                     '2',
                     l_level_code,
                     SYSDATE);

        l_row_count := l_row_count + 1;
    END LOOP;

    DBMS_OUTPUT.put_line ('count of inserted rows : ' || l_row_count);
END;