
-- before running 
update bu_dev.tmp_tbl_kilany1 
set col03=f_get_pidm(col04) ;

-- set grade
update bu_dev.tmp_tbl_kilany1 
set col04='До' ;

 select col03, f_get_std_id(col03),f_get_std_name(col03) from bu_dev.tmp_tbl_kilany1 
 where not  exists 
 (select '1' from shrtckn where SHRTCKN_PIDM=col03 and SHRTCKN_TERM_CODE=col01 and SHRTCKN_CRN=col02 ) ;


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
             AND shrgrds_gmod_code_student = 'м'
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
      SELECT col01 term,
             col02 crn,
             col03 student_pidm,
             '4' change_reason,
             col04 grade
        FROM bu_dev.tmp_tbl_kilany1
         where COL03!= '176736'
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
            l_grade_mode := 'Ц';
         EXCEPTION
            WHEN OTHERS
            THEN
               l_grade_mode := 'м';
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
                      l_grade_mode,                                     --'Ц',
                      l_credit_hr,
                      l_grade_reason,
                      SYSDATE,
                      'BannerIT',
                      SYSDATE,
                      l_credit_hr);

         OPEN get_std_level (l_student_pidm);

         FETCH get_std_level INTO l_level;

         CLOSE get_std_level;

         IF l_grade_mode = 'Ц'
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
                            'м',
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


-- -RECLACULATE GPA , AND RUNNING COMPLIANCE 
Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'GRD_CHNG_001' , 'SAISUSR', 'GRD_CHNG_001 ', 'N', 
    SYSDATE, NULL);
    
    
  
    
    Insert into GLBEXTR
   SELECT 'STUDENT', 'GRD_CHNG_001', 'SAISUSR', 'SAISUSR',  PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT   col03  PIDM
            from bu_dev.tmp_tbl_kilany1
           WHERE      col03 IS NOT NULL) ;