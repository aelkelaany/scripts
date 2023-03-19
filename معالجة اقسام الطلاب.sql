/* Formatted on 3/14/2023 1:04:48 PM (QP5 v5.371) */
  SELECT *
    FROM bu_dev.tmp_tbl_kilany2
ORDER BY col02;

  /*
  sobcurr
  sorcmjr
  SORLCUR
 SORLFOS
 SGBSTDN
 SHRDGMR */


--sobcurr
--  sorcmjr

DECLARE
    CURSOR get_data IS
          SELECT col01 program_code, col02 dept, col03 major
            FROM bu_dev.tmp_tbl_kilany2
        ORDER BY col02;

    l_updated_count   NUMBER := 0;
    l_updated_row     NUMBER := 0;
BEGIN
    --
    FOR rec IN get_data
    LOOP
        UPDATE sorcmjr
           SET SORCMJR_DEPT_CODE = rec.dept, SORCMJR_MAJR_CODE = rec.major
         WHERE EXISTS
                   (SELECT '1'
                      FROM sobcurr
                     WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
                           AND SOBCURR_PROGRAM = rec.program_code);

        l_updated_count := l_updated_count + SQL%ROWCOUNT;
        DBMS_OUTPUT.put_line (rec.dept || '<<-ROWS>>' || SQL%ROWCOUNT);
        l_updated_row := SQL%ROWCOUNT;

        IF l_updated_row = 1
        THEN
            UPDATE bu_dev.tmp_tbl_kilany2
               SET col04 = 'DONE'
             WHERE COL01 = REC.PROGRAM_CODE;
        ELSE
            UPDATE bu_dev.tmp_tbl_kilany2
               SET col04 = 'F'
             WHERE COL01 = REC.PROGRAM_CODE;
        END IF;

        l_updated_row := 0;
    END LOOP;

    DBMS_OUTPUT.put_line ('total updates ' || l_updated_count);
END;


-- SORLFOS
DECLARE
    CURSOR get_data IS
          SELECT col01 program_code, col02 dept, col03 major
            FROM bu_dev.tmp_tbl_kilany2
        ORDER BY col02;

    l_updated_count   NUMBER := 0;
    l_updated_row     NUMBER := 0;
BEGIN
    FOR REC IN GET_DATA
    LOOP
      --  UPDATE SORLFOS
           SET SORLFOS_DEPT_CODE = REC.DEPT, SORLFOS_MAJR_CODE = REC.MAJOR
         WHERE     EXISTS
                       (SELECT '1'
                          FROM sobcurr
                         WHERE     SOBCURR_CURR_RULE = SORLFOS_LFOS_RULE -- wrong condition
                               AND SOBCURR_PROGRAM = rec.program_code)
               AND SORLFOS_CURRENT_CDE = 'Y';

        l_updated_count := l_updated_count + SQL%ROWCOUNT;
        DBMS_OUTPUT.put_line (rec.dept || '<<-ROWS>>' || SQL%ROWCOUNT);
        l_updated_row := SQL%ROWCOUNT;

        IF l_updated_row > 1
        THEN
            UPDATE bu_dev.tmp_tbl_kilany2
               SET col05 = 'DONE'
             WHERE COL01 = REC.PROGRAM_CODE;
        ELSE
            UPDATE bu_dev.tmp_tbl_kilany2
               SET col05 = 'F'
             WHERE COL01 = REC.PROGRAM_CODE;
        END IF;

        l_updated_row := 0;
    END LOOP;
END;


---
--SGBSTDN


SELECT * FROM  SGBSTDN
        --   SET SGBSTDN_DEPT_CODE = REC.DEPT, SGBSTDN_MAJR_CODE_1 = REC.MAJOR
         WHERE     
             
                 SGBSTDN_PROGRAM_1='4F12PLEG44';
DECLARE
    CURSOR get_data IS
          SELECT col01 program_code, col02 dept, col03 major
            FROM bu_dev.tmp_tbl_kilany2
        ORDER BY col02;

    l_updated_count   NUMBER := 0;
    l_updated_row     NUMBER := 0;
BEGIN
    FOR REC IN GET_DATA
    LOOP
        UPDATE SGBSTDN
           SET SGBSTDN_DEPT_CODE = REC.DEPT, SGBSTDN_MAJR_CODE_1 = REC.MAJOR
         WHERE     
             
                 SGBSTDN_PROGRAM_1=rec.program_code;

        l_updated_count := l_updated_count + SQL%ROWCOUNT;
        DBMS_OUTPUT.put_line (rec.dept || '<<-ROWS>>' || SQL%ROWCOUNT);
        l_updated_row := SQL%ROWCOUNT;

        IF l_updated_row > 1
        THEN
            UPDATE bu_dev.tmp_tbl_kilany2
               SET col06 = 'DONE'
             WHERE COL01 = REC.PROGRAM_CODE;
        ELSE
            UPDATE bu_dev.tmp_tbl_kilany2
               SET col06 = 'F'
             WHERE COL01 = REC.PROGRAM_CODE;
        END IF;

        l_updated_row := 0;
    END LOOP;
END;