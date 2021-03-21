--ÊÇßÏ ãä Çä ÊÇÑíÎ ÇáÇÖÇÝÉ åæ ÊÇÑíÎ ÝÊÍ ÇáÊÓÌíá Çæ Ýì äØÇÞå

DECLARE
   CURSOR get_data
   IS
      SELECT a1.sgbstdn_pidm student_pidm,
             f_getspridenid (a1.sgbstdn_pidm) "Student ID",
             a1.sgbstdn_program_1,
             shrttrm_astd_code_end_of_term,
             stvastd_desc,
             stvastd_max_reg_hours,
             ROUND (shrlgpa_gpa, 2) "Student GPA",
             c1.smbpogn_act_credits_overall "Passed Hours",
             c1.smbpogn_req_credits_overall "Program Required Hours"
        FROM sgbstdn a1,
             shrttrm b1,
             stvastd,
             shrlgpa,
             smbpogn c1,
             smbpgen d1
       WHERE     a1.sgbstdn_term_code_eff =
                    (SELECT MAX (a2.sgbstdn_term_code_eff)
                       FROM sgbstdn a2
                      WHERE a2.sgbstdn_pidm = a1.sgbstdn_pidm)
             AND a1.sgbstdn_stst_code = 'AS'
             AND a1.sgbstdn_coll_code_1 != 13
             AND b1.shrttrm_pidm = a1.sgbstdn_pidm
             AND b1.shrttrm_term_code =
                    (SELECT MAX (b2.shrttrm_term_code)
                       FROM shrttrm b2
                      WHERE b2.shrttrm_pidm = b1.shrttrm_pidm)
             AND b1.shrttrm_astd_code_end_of_term = stvastd_code
             AND shrlgpa_pidm = a1.sgbstdn_pidm
             AND shrlgpa_levl_code = a1.sgbstdn_levl_code
             AND shrlgpa_gpa_type_ind = 'O'
             AND ROUND (shrlgpa_gpa, 2) >= 1
             AND c1.smbpogn_pidm = a1.sgbstdn_pidm
             AND c1.smbpogn_request_no =
                    (SELECT MAX (c2.smbpogn_request_no)
                       FROM smbpogn c2
                      WHERE c2.smbpogn_pidm = c1.smbpogn_pidm)
             AND d1.smbpgen_program = a1.sgbstdn_program_1
             AND d1.smbpgen_term_code_eff =
                    (SELECT MAX (d2.smbpgen_term_code_eff)
                       FROM smbpgen d2
                      WHERE d2.smbpgen_program = d1.smbpgen_program)
             AND NOT EXISTS
                        (SELECT 'X'
                           FROM shrdgmr
                          WHERE     shrdgmr_pidm = a1.sgbstdn_pidm
                                AND shrdgmr_levl_code = a1.sgbstdn_levl_code
                                AND shrdgmr_degs_code = 'ÎÌ')
             AND (  NVL (c1.smbpogn_act_credits_overall, 0)
                  + 5
                  + NVL (stvastd_max_reg_hours, 0)) >=
                    c1.smbpogn_req_credits_overall
             AND (   (    a1.sgbstdn_levl_code IN ('MA', 'ÏÚ')
                      AND c1.smbpogn_req_credits_overall >= 30)
                  OR (    a1.sgbstdn_levl_code IN ('ÏÈ')
                      AND c1.smbpogn_req_credits_overall >= 60)
                  OR (    a1.sgbstdn_levl_code IN ('Ìã', 'Ì5')
                      AND c1.smbpogn_req_credits_overall >= 120))
             AND c1.smbpogn_act_credits_overall <>
                    c1.smbpogn_req_credits_overall;

   l_total_rec      NUMBER := 0;
   l_updated_rec    NUMBER := 0;
   l_inserted_rec   NUMBER := 0;
BEGIN
   FOR i IN get_data
   LOOP
      l_total_rec := l_total_rec + 1;

      UPDATE sfbetrm
         SET sfbetrm_mhrs_over = NVL (i.stvastd_max_reg_hours, 0) + 5,
             sfbetrm_activity_date = SYSDATE+1
       WHERE sfbetrm_pidm = i.student_pidm AND sfbetrm_term_code = '144210';

      IF SQL%NOTFOUND
      THEN
         INSERT INTO sfbetrm (sfbetrm_term_code,
                              sfbetrm_pidm,
                              sfbetrm_ests_code,
                              sfbetrm_ests_date,
                              sfbetrm_mhrs_over,
                              sfbetrm_ar_ind,
                              sfbetrm_assessment_date,
                              sfbetrm_add_date,
                              sfbetrm_activity_date,
                              sfbetrm_rgre_code,
                              sfbetrm_tmst_code,
                              sfbetrm_tmst_date,
                              sfbetrm_tmst_maint_ind,
                              sfbetrm_user,
                              sfbetrm_refund_date,
                              sfbetrm_data_origin,
                              sfbetrm_initial_reg_date,
                              sfbetrm_min_hrs,
                              sfbetrm_minh_srce_cde,
                              sfbetrm_maxh_srce_cde)
              VALUES ('144210',
                      i.student_pidm,
                      'EL',
                      TRUNC (SYSDATE)+1,
                      NVL (i.stvastd_max_reg_hours, 0) + 5,
                      'N',
                      '',
                      TRUNC (SYSDATE)+1,
                      SYSDATE+1,
                      '',
                      '',
                      '',
                      '',
                      USER,
                      '',
                      'Banner',
                      '',
                      0,
                      'A',
                      'A');

         l_inserted_rec := l_inserted_rec + 1;
      ELSE
         l_updated_rec := l_updated_rec + 1;
      END IF;
   END LOOP;

   UPDATE sfbetrm
      SET sfbetrm_mhrs_over = 24
    WHERE sfbetrm_term_code = '144210' AND sfbetrm_mhrs_over > 24;

   DBMS_OUTPUT.put_line ('Updated Records : ' || l_updated_rec);
   DBMS_OUTPUT.put_line ('Inserted Records : ' || l_inserted_rec);
   DBMS_OUTPUT.put_line ('Total Records : ' || l_total_rec);
END;
/
