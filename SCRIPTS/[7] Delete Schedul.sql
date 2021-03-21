DECLARE
   CURSOR get_crns
   IS
      SELECT ssbsect_term_code term_code,
             ssbsect_crn crn,
             ssbsect_subj_code,
             ssbsect_crse_numb,
             scbcrse_title
        FROM ssbsect, scbcrse c1
       WHERE     ssbsect_term_code = '143920' -- TERM_CODE
             AND ssbsect_subj_code = scbcrse_subj_code
             AND ssbsect_crse_numb = scbcrse_crse_numb
             AND scbcrse_eff_term =
                    (SELECT MAX (c2.scbcrse_eff_term)
                       FROM scbcrse c2
                      WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                            AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb)
             AND EXISTS
                    (SELECT 'X'
                       FROM bu_dev.temp_tbl01 -- TABLE_CODE
                      WHERE c_col01 = ssbsect_crn)
             /*AND ssbsect_subj_code LIKE '1502%'
             AND EXISTS
                    (SELECT 1
                       FROM ssrrdep
                      WHERE     ssrrdep_term_code = ssbsect_term_code
                            AND ssrrdep_crn = ssbsect_crn
                            AND ssrrdep_dept_code = '1502')
             AND NOT EXISTS
                        (SELECT 1
                           FROM ssrrdep
                          WHERE     ssrrdep_term_code = ssbsect_term_code
                                AND ssrrdep_crn = ssbsect_crn
                                AND ssrrdep_dept_code != '1502')
             AND EXISTS
                    ( (SELECT 1
                         FROM ssrrcol
                        WHERE     ssrrcol_term_code = ssbsect_term_code
                              AND ssrrcol_crn = ssbsect_crn
                              AND ssrrcol_coll_code = '15'))*/;

   l_ssrrtst   NUMBER := 0;
   l_ssrrchr   NUMBER := 0;
   l_ssrratt   NUMBER := 0;
   l_ssrrcol   NUMBER := 0;
   l_ssrrcmp   NUMBER := 0;
   l_ssrrprg   NUMBER := 0;
   l_ssrrdeg   NUMBER := 0;
   l_ssrrlvl   NUMBER := 0;
   l_ssrrcls   NUMBER := 0;
   l_ssrrmaj   NUMBER := 0;
   l_ssrrdep   NUMBER := 0;
   l_ssrblck   NUMBER := 0;
   l_ssrmeet   NUMBER := 0;
   l_sirasgn   NUMBER := 0;
   l_ssbsect   NUMBER := 0;
BEGIN
   FOR i IN get_crns
   LOOP
      DELETE FROM SSRRTST
            WHERE SSRRTST_TERM_CODE = i.term_code AND SSRRTST_crn = i.crn;

      l_SSRRTST := l_SSRRTST + SQL%ROWCOUNT;

      DELETE FROM ssrrchr
            WHERE ssrrchr_term_code = i.term_code AND ssrrchr_crn = i.crn;

      l_ssrrchr := l_ssrrchr + SQL%ROWCOUNT;

      DELETE FROM ssrratt
            WHERE ssrratt_term_code = i.term_code AND ssrratt_crn = i.crn;

      l_ssrratt := l_ssrratt + SQL%ROWCOUNT;

      DELETE FROM ssrrcol
            WHERE ssrrcol_term_code = i.term_code AND ssrrcol_crn = i.crn;

      l_ssrrcol := l_ssrrcol + SQL%ROWCOUNT;

      DELETE FROM ssrrcmp
            WHERE ssrrcmp_term_code = i.term_code AND ssrrcmp_crn = i.crn;

      l_ssrrcmp := l_ssrrcmp + SQL%ROWCOUNT;

      DELETE FROM ssrrprg
            WHERE ssrrprg_term_code = i.term_code AND ssrrprg_crn = i.crn;

      l_ssrrprg := l_ssrrprg + SQL%ROWCOUNT;

      DELETE FROM ssrrdeg
            WHERE ssrrdeg_term_code = i.term_code AND ssrrdeg_crn = i.crn;

      l_ssrrdeg := l_ssrrdeg + SQL%ROWCOUNT;

      DELETE FROM ssrrlvl
            WHERE ssrrlvl_term_code = i.term_code AND ssrrlvl_crn = i.crn;

      l_ssrrlvl := l_ssrrlvl + SQL%ROWCOUNT;

      DELETE FROM ssrrcls
            WHERE ssrrcls_term_code = i.term_code AND ssrrcls_crn = i.crn;

      l_ssrrcls := l_ssrrcls + SQL%ROWCOUNT;

      DELETE FROM ssrrmaj
            WHERE ssrrmaj_term_code = i.term_code AND ssrrmaj_crn = i.crn;

      l_ssrrmaj := l_ssrrmaj + SQL%ROWCOUNT;

      DELETE FROM ssrrdep
            WHERE ssrrdep_term_code = i.term_code AND ssrrdep_crn = i.crn;

      l_ssrrdep := l_ssrrdep + SQL%ROWCOUNT;

      DELETE FROM ssrblck
            WHERE ssrblck_term_code = i.term_code AND ssrblck_crn = i.crn;

      l_ssrblck := l_ssrblck + SQL%ROWCOUNT;

      DELETE FROM ssrmeet
            WHERE ssrmeet_term_code = i.term_code AND ssrmeet_crn = i.crn;

      l_ssrmeet := l_ssrmeet + SQL%ROWCOUNT;

      DELETE FROM sirasgn
            WHERE sirasgn_term_code = i.term_code AND sirasgn_crn = i.crn;

      l_sirasgn := l_sirasgn + SQL%ROWCOUNT;

      DELETE FROM ssbsect
            WHERE ssbsect_term_code = i.term_code AND ssbsect_crn = i.crn;

      l_ssbsect := l_ssbsect + SQL%ROWCOUNT;
   END LOOP;

   DBMS_OUTPUT.put_line ('SSRRTST rows deleted : ' || l_ssrrchr);
   DBMS_OUTPUT.put_line ('SSRRCHR rows deleted : ' || l_ssrrchr);
   DBMS_OUTPUT.put_line ('SSRRATT rows deleted : ' || l_ssrratt);
   DBMS_OUTPUT.put_line ('SSRRCOL rows deleted : ' || l_ssrrcol);
   DBMS_OUTPUT.put_line ('SSRRCMP rows deleted : ' || l_ssrrcmp);
   DBMS_OUTPUT.put_line ('SSRRPRG rows deleted : ' || l_ssrrprg);
   DBMS_OUTPUT.put_line ('SSRRDEG rows deleted : ' || l_ssrrdeg);
   DBMS_OUTPUT.put_line ('SSRRCLS rows deleted : ' || l_ssrrcls);
   DBMS_OUTPUT.put_line ('SSRRLVL rows deleted : ' || l_ssrrlvl);
   DBMS_OUTPUT.put_line ('SSRRMAJ rows deleted : ' || l_ssrrmaj);
   DBMS_OUTPUT.put_line ('SSRRDEP rows deleted : ' || l_ssrrdep);
   DBMS_OUTPUT.put_line ('SSRBLCK rows deleted : ' || l_ssrblck);
   DBMS_OUTPUT.put_line ('SSRMEET rows deleted : ' || l_ssrmeet);
   DBMS_OUTPUT.put_line ('SIRASGN rows deleted : ' || l_sirasgn);
   DBMS_OUTPUT.put_line ('SSBSECT rows deleted : ' || l_ssbsect);
END;
/