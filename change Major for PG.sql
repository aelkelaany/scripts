/* Formatted on 6/18/2022 6:55:15 PM (QP5 v5.371) */
DECLARE
    l_program_code    VARCHAR2 (12) := '6M16BADM42';
    l_major_code      VARCHAR2 (4) := '1651';

    CURSOR get_std IS
        SELECT DISTINCT sgbstdn_pidm            pidm,
                        sgbstdn_dept_code       dept,
                        SGBSTDN_CMJR_RULE_1_1,
                        SGBSTDN_MAJR_CODE_1     old_major
          FROM sgbstdn
         WHERE SGBSTDN_PROGRAM_1 = l_program_code;

    lfos_count        NUMBER (2);
    l_shrdgmr_count   NUMBER (2);
    l_sgbstdn_count   NUMBER (2);

    l_tot_students    NUMBER (3) := 0;
BEGIN
    FOR rec IN get_std
    LOOP
        lfos_count := 0;
        l_sgbstdn_count := 0;
        l_tot_students := l_tot_students + 1;

        --sorlfos
        UPDATE sorlfos a
           SET a.SORLFOS_MAJR_CODE = l_major_code,
               a.SORLFOS_DATA_ORIGIN = 'BannerIT',
               SORLFOS_ACTIVITY_DATE = SYSDATE
         WHERE     sorlfos_pidm = rec.pidm
               AND a.SORLFOS_DEPT_CODE = rec.dept
               AND SORLFOS_LFOS_RULE = rec.SGBSTDN_CMJR_RULE_1_1
               AND SORLFOS_MAJR_CODE = rec.old_major;

        lfos_count := SQL%ROWCOUNT;


        UPDATE SHRDGMR
           SET SHRDGMR_MAJR_CODE_1 = l_major_code
         WHERE     shrdgmr_pidm = rec.pidm
               AND shrdgmr_program = l_program_code
               AND SHRDGMR_MAJR_CODE_1 = rec.old_major;

        lfos_count := SQL%ROWCOUNT;

        UPDATE sgbstdn a
           SET a.SGBSTDN_MAJR_CODE_1 = l_major_code,
               a.SGBSTDN_DATA_ORIGIN = 'BannerIT',
               SGBSTDN_ACTIVITY_DATE = SYSDATE
         WHERE     sgbstdn_pidm = rec.pidm
               AND sgbstdn_program_1 = l_program_code
               AND SGBSTDN_MAJR_CODE_1 = rec.old_major;

        l_sgbstdn_count := SQL%ROWCOUNT;

        DBMS_OUTPUT.put_line (
               f_get_std_id (rec.pidm)
            || '*** lfos '
            || lfos_count
            || ' shrdgmr '
            || l_shrdgmr_count
            || ' sgbstdn '
            || l_sgbstdn_count);
    END LOOP;

    DBMS_OUTPUT.put_line ('total processed students are  ' || l_tot_students);
END;