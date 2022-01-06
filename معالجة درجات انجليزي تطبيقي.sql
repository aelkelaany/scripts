/* REPORT AND FILL THE TABLE */
truncate table bu_dev.tmp_tbl_kilany ;
insert into bu_dev.tmp_tbl_kilany (COL01, COL02, COL03, COL04, COL05, COL06)
  SELECT SFRSTCR_PIDM,
         f_get_std_id (SFRSTCR_PIDM)      stid,
         f_get_std_name (SFRSTCR_PIDM)    name,
         SFRSTCR_CRN,
         SFRSTCR_GRDE_CODE,
         CASE
             WHEN SFRSTCR_GRDE_CODE < '60' THEN 'NF'
             WHEN SFRSTCR_GRDE_CODE = 'гд' THEN 'NF'
             WHEN SFRSTCR_GRDE_CODE = 'Н' THEN 'NF'
              WHEN SFRSTCR_GRDE_CODE = 'Ы' THEN 'Ы'
             WHEN SFRSTCR_GRDE_CODE >= '60' THEN 'NP'
         END                              buGrade
    FROM SATURN.SFRSTCR
   WHERE     SFRSTCR_TERM_CODE = '144310'
         AND SFRSTCR_crn IN (17571,
                             17572,
                             17573,
                             17574,
                             17576,
                             17577)
         AND sfrstcr_rsts_code IN ('RE', 'RW')
ORDER BY SFRSTCR_crn, SFRSTCR_PIDM ; 


------------
------------ FIRST TO TRANSIT MARKS TO TRANSCRPIT
------------
DECLARE
   CURSOR crs_get_crn
   IS
SELECT DISTINCT sfrstcr_term_code term_code, sfrstcr_crn crn
  FROM sfrstcr x 
 WHERE     
         sfrstcr_term_code = '144310'
       AND sfrstcr_grde_code IS NOT NULL
       AND sfrstcr_grde_date IS NULL
       and sfrstcr_crn IN (
                             17572,
                             17573,
                             17574,
                             17576,
                             17577)
         AND sfrstcr_rsts_code IN ('RE', 'RW');

BEGIN
   FOR r IN crs_get_crn
   LOOP
      shkrols.p_do_graderoll (r.term_code,
                              r.crn,
                              'WORKFLOW',
                              '1',
                              '1',
                              'O',
                              '',
                              '',
                              '',
                              '');
   END LOOP;
END;


-------
-------- PROCEDURE TO MAINTAIN 
------------

/* Formatted on 04/05/2021 14:57:00 (QP5 v5.227.12220.39754) */
DECLARE
   reply_code        NUMBER;

   CURSOR shrtcknc (
      cp_pidm    shrtckn.shrtckn_pidm%TYPE,
      cp_term    shrtckn.shrtckn_term_code%TYPE,
      cp_crn     shrtckn.shrtckn_crn%TYPE)
   IS
      SELECT shrtckn_seq_no, sfrstcr_credit_hr
        FROM shrtckn, sfrstcr
       WHERE     sfrstcr_pidm = shrtckn_pidm
             AND sfrstcr_term_code = shrtckn_term_code
             AND sfrstcr_crn = shrtckn_crn
             AND shrtckn_pidm = cp_pidm
             AND shrtckn_term_code = cp_term
             AND shrtckn_crn = cp_crn;

   CURSOR get_std_level (
      cp_pidm sgbstdn.sgbstdn_pidm%TYPE)
   IS
      SELECT sgbstdn_levl_code
        FROM sgbstdn x
       WHERE     sgbstdn_pidm = cp_pidm
             AND sgbstdn_term_code_eff =
                    (SELECT MAX (y.sgbstdn_term_code_eff)
                       FROM sgbstdn y
                      WHERE y.sgbstdn_pidm = x.sgbstdn_pidm);

   CURSOR get_grade_c (
      cp_term     VARCHAR2,
      cp_level    VARCHAR2,
      cp_grade    VARCHAR2)
   IS
      SELECT shrgrds_grde_code_substitute
        FROM shrgrde g1, shrgrds
       WHERE     shrgrds_grde_code = shrgrde_code
             AND shrgrds_levl_code = shrgrde_levl_code
             AND shrgrds_term_code_effective = shrgrde_term_code_effective
             AND shrgrds_gmod_code_student = 'Н'
             AND g1.shrgrde_levl_code = cp_level
             AND g1.shrgrde_numeric_value = cp_grade
             AND g1.shrgrde_term_code_effective =
                    (SELECT MAX (g2.shrgrde_term_code_effective)
                       FROM shrgrde g2
                      WHERE     g2.shrgrde_code = g1.shrgrde_code
                            AND g2.shrgrde_levl_code = g1.shrgrde_levl_code
                            AND g2.shrgrde_term_code_effective <= cp_term);

   l_term            VARCHAR2 (100);
   l_crn             VARCHAR2 (100);
   l_student_pidm    VARCHAR2 (100);
   l_change_reason   VARCHAR2 (100);
   l_grade           VARCHAR2 (100);

   CURSOR get_data
   IS
      SELECT '144310' term,
             col04 crn,
             col01 student_pidm,
             '4' change_reason,
             col06 grade
        FROM bu_dev.tmp_tbl_kilany
         where COL04 != '17571'
         and col06<>'Ы'
       ;

   l_tckn_seq_no     shrtckn.shrtckn_seq_no%TYPE;
   l_credit_hr       sfrstcr.sfrstcr_credit_hr%TYPE;
   l_tckg_seq_no     shrtckg.shrtckg_seq_no%TYPE;
   l_grade_reason    VARCHAR2 (30);
   l_level           sgbstdn.sgbstdn_levl_code%TYPE;
   l_alpha_grade     shrgrds.shrgrds_grde_code_substitute%TYPE;
   l_grade_mode      VARCHAR2 (1);
   l_number          NUMBER;
BEGIN
   FOR rec IN get_data
   LOOP
      BEGIN
         l_term := rec.term;
         l_crn := rec.crn;
         l_student_pidm := rec.student_pidm;
         l_change_reason := '';
         l_grade := rec.grade;


         BEGIN
            l_number := TO_NUMBER (l_grade);
            l_grade_mode := 'г';
         EXCEPTION
            WHEN OTHERS
            THEN
               l_grade_mode := 'Н';
         END;

         OPEN shrtcknc (l_student_pidm, l_term, l_crn);

         FETCH shrtcknc
            INTO l_tckn_seq_no, l_credit_hr;

         CLOSE shrtcknc;

         SELECT NVL (MAX (shrtckg_seq_no), 0) + 1
           INTO l_tckg_seq_no
           FROM shrtckg
          WHERE     shrtckg_pidm = l_student_pidm
                AND shrtckg_term_code = l_term
                AND shrtckg_tckn_seq_no = l_tckn_seq_no;

         l_grade_reason := '4';
 
         INSERT INTO saturn.shrtckg (shrtckg_pidm,
                                     shrtckg_term_code,
                                     shrtckg_tckn_seq_no,
                                     shrtckg_seq_no,
                                     shrtckg_grde_code_final,
                                     shrtckg_gmod_code,
                                     shrtckg_credit_hours,
                                     shrtckg_gchg_code,
                                     shrtckg_final_grde_chg_date,
                                     shrtckg_final_grde_chg_user,
                                     shrtckg_activity_date,
                                     shrtckg_hours_attempted)
              VALUES (l_student_pidm,
                      l_term,
                      l_tckn_seq_no,
                      l_tckg_seq_no,
                      l_grade,
                      l_grade_mode,                                     --'г',
                      l_credit_hr,
                      l_grade_reason,
                      SYSDATE,
                      'BannerIT',
                      SYSDATE,
                      l_credit_hr);

         OPEN get_std_level (l_student_pidm);

         FETCH get_std_level INTO l_level;

         CLOSE get_std_level;

         IF l_grade_mode = 'г'
         THEN
            OPEN get_grade_c (l_term, l_level, l_grade);

            FETCH get_grade_c INTO l_alpha_grade;

            IF get_grade_c%FOUND
            THEN
               INSERT INTO saturn.shrtckg (shrtckg_pidm,
                                           shrtckg_term_code,
                                           shrtckg_tckn_seq_no,
                                           shrtckg_seq_no,
                                           shrtckg_grde_code_final,
                                           shrtckg_gmod_code,
                                           shrtckg_credit_hours,
                                           shrtckg_gchg_code,
                                           shrtckg_final_grde_chg_date,
                                           shrtckg_final_grde_chg_user,
                                           shrtckg_activity_date,
                                           shrtckg_hours_attempted)
                    VALUES (l_student_pidm,
                            l_term,
                            l_tckn_seq_no,
                            l_tckg_seq_no + 1,
                            l_alpha_grade,
                            'Н',
                            l_credit_hr,
                            l_grade_reason,
                            SYSDATE,
                            'BannerIT',
                            SYSDATE,
                            l_credit_hr);
            END IF;

            CLOSE get_grade_c;
         END IF;

         reply_code := '00';

         DBMS_OUTPUT.put_line ('reply code : ' || reply_code);
      EXCEPTION
         WHEN OTHERS
         THEN
            reply_code := '90';

            DBMS_OUTPUT.put_line ('reply code : ' || reply_code ||' ~~~ '||rec.student_pidm||' @ '||rec.crn||' # '||rec.term);
      END;
   END LOOP;
END;