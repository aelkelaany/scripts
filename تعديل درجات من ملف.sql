/* Formatted on 6/15/2022 11:55:56 AM (QP5 v5.371) */
--col03>>student id 
-- col01 >> crn
-- term_code='144320'
--col05 >> mid
--col06>> final

DECLARE
    CURSOR get_data IS
          SELECT f_get_pidm (col03)     pidm,
                 col01                  crn,
                 col05                  midGrade,
                 col06                  finalGrade
            FROM BU_DEV.TMP_TBL_KILANY
           WHERE col03 IS NOT NULL  
        ORDER BY col01;

    l_term_code     VARCHAR2 (8) := '144320';
    count_of_rows   NUMBER := 0;
BEGIN
    FOR rec IN get_data
    LOOP
        UPDATE sfrstcr
           SET SFRSTCR_GRDE_CODE_MID = rec.midGrade,
               SFRSTCR_GRDE_CODE = rec.finalGrade
         WHERE     sfrstcr_term_code = l_term_code
               AND sfrstcr_crn = rec.crn
               AND sfrstcr_pidm = rec.pidm;

        count_of_rows := count_of_rows + SQL%ROWCOUNT;
    END LOOP;

    DBMS_OUTPUT.put_line ('All of updated rows =' || count_of_rows);
END;