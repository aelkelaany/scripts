UPDATE sfbetrm
         SET sfbetrm_mhrs_over = 24,
             sfbetrm_activity_date = SYSDATE 
       WHERE   sfbetrm_term_code = '144310'
       and sfbetrm_pidm in (SELECT DISTINCT SGBSTDN_PIDM 
  FROM SGBSTDN SG
 WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
       AND SGBSTDN_STST_CODE IN ('AS')
       AND SGBSTDN_STYP_CODE IN ('ä'))
       and sfbetrm_mhrs_over<>24 
;

DECLARE
   CURSOR get_data
   IS
     SELECT DISTINCT SGBSTDN_PIDM student_pidm
  FROM SGBSTDN SG
 WHERE     SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                      FROM SGBSTDN
                                     WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
       AND SGBSTDN_STST_CODE IN ('AS')
       AND SGBSTDN_STYP_CODE IN ('ä')
       and not exists (select '1' from sfbetrm where sfbetrm_term_code='144310' and sfbetrm_pidm=sg.sgbstdn_pidm);

   
   l_inserted_rec   NUMBER := 0;
BEGIN
   FOR i IN get_data
   LOOP
   
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
              VALUES ('144310',
                      i.student_pidm,
                      'EL',
                      TRUNC (SYSDATE) ,
                      24,
                      'N',
                      '',
                      TRUNC (SYSDATE) ,
                      SYSDATE ,
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
      
   END LOOP;
 
   DBMS_OUTPUT.put_line ('Inserted Records : ' || l_inserted_rec);
    
END;
        