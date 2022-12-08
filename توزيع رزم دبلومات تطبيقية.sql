/* Formatted on 11/30/2022 4:01:51 PM (QP5 v5.371) */
DECLARE
    CURSOR get_blocks IS
        SELECT COL01 sprogram, COL04 sblock, col07 blck_capacity
          FROM BU_DEV.TMP_TBL_KILANY1
         WHERE col06 IS NOT NULL AND col01 = '4M18IS44';

    CURSOR get_students (p_program VARCHAR2)
    IS
        SELECT sgbstdn_pidm pidm, sgbstdn_term_code_eff term
          FROM sgbstdn b
         WHERE     b.sgbstdn_term_code_eff =
                   (SELECT MAX (a.sgbstdn_term_code_eff)
                      FROM sgbstdn a
                     WHERE a.sgbstdn_pidm = b.sgbstdn_pidm)
               AND b.sgbstdn_program_1 = p_program
               AND EXISTS
                       (SELECT '1'
                          FROM BU_DEV.TMP_TBL_KILANY
                         WHERE col01 = b.sgbstdn_pidm AND COL06 = 'NP')
                         and SGBSTDN_BLCK_CODE is null 
                         ;

    st_cnt   NUMBER;
BEGIN
    FOR rec_block IN get_blocks
    LOOP
        DBMS_OUTPUT.put_line (
               '**** start  program'
            || rec_block.sprogram
            || ' block : '
            || rec_block.sblock);
        st_cnt := 0;

        FOR rec_student IN get_students (rec_block.sprogram)
        LOOP
            UPDATE sgbstdn b
               SET SGBSTDN_BLCK_CODE = rec_block.sblock
             WHERE     b.sgbstdn_pidm = rec_student.pidm
                   AND b.sgbstdn_term_code_eff = rec_student.term;

            st_cnt := st_cnt + 1;
            DBMS_OUTPUT.put_line (
                   st_cnt
                || ' execute  program'
                || rec_block.sprogram
                || ' block : '
                || rec_block.sblock
                || ' student '
                || rec_student.pidm);
            EXIT WHEN st_cnt = rec_block.blck_capacity;
        END LOOP;

        DBMS_OUTPUT.put_line (
               ' End  program'
            || rec_block.sprogram
            || ' block : '
            || rec_block.sblock
            || '  total student '
            || st_cnt);
    END LOOP;
END;