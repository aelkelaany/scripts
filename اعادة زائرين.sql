/* Formatted on 1/12/2020 2:19:30 PM (QP5 v5.227.12220.39754) */
DECLARE
   term                 VARCHAR2 (8) := '144020';

   data_origin          VARCHAR2 (50) := 'Banner IT';
   l_updated_counter    NUMBER := 0;
   l_inserted_counter   NUMBER := 0;

   CURSOR get_std
   IS
      SELECT DISTINCT SGBSTDN_PIDM pidm
        FROM SGBSTDN SG
       WHERE     SGBSTDN_TERM_CODE_EFF =
                    (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                       FROM SGBSTDN
                      WHERE SGBSTDN_PIDM = SG.SGBSTDN_PIDM)
             AND SGBSTDN_STST_CODE IN ('AS')
             AND SGBSTDN_STYP_CODE = 'È';

BEGIN
   FOR rec IN get_std
   LOOP
      BEGIN
         UPDATE sgbstdn
            SET SGBSTDN_STYP_CODE = 'ã',
                SGBSTDN_ACTIVITY_DATE = SYSDATE,
                SGBSTDN_DATA_ORIGIN = data_origin,
                sgbstdn_user_id = USER
          WHERE sgbstdn_pidm = rec.pidm AND sgbstdn_term_code_eff = term;

         l_updated_counter := l_updated_counter + 1;

         IF SQL%NOTFOUND
         THEN
            l_updated_counter := l_updated_counter - 1;

            INSERT INTO sgbstdn (SGBSTDN_PIDM,
                                 SGBSTDN_TERM_CODE_EFF,
                                 SGBSTDN_STST_CODE,
                                 SGBSTDN_LEVL_CODE,
                                 SGBSTDN_STYP_CODE,
                                 SGBSTDN_TERM_CODE_MATRIC,
                                 SGBSTDN_TERM_CODE_ADMIT,
                                 SGBSTDN_EXP_GRAD_DATE,
                                 SGBSTDN_CAMP_CODE,
                                 SGBSTDN_FULL_PART_IND,
                                 SGBSTDN_SESS_CODE,
                                 SGBSTDN_RESD_CODE,
                                 SGBSTDN_COLL_CODE_1,
                                 SGBSTDN_DEGC_CODE_1,
                                 SGBSTDN_MAJR_CODE_1,
                                 SGBSTDN_MAJR_CODE_MINR_1,
                                 SGBSTDN_MAJR_CODE_MINR_1_2,
                                 SGBSTDN_MAJR_CODE_CONC_1,
                                 SGBSTDN_MAJR_CODE_CONC_1_2,
                                 SGBSTDN_MAJR_CODE_CONC_1_3,
                                 SGBSTDN_COLL_CODE_2,
                                 SGBSTDN_DEGC_CODE_2,
                                 SGBSTDN_MAJR_CODE_2,
                                 SGBSTDN_MAJR_CODE_MINR_2,
                                 SGBSTDN_MAJR_CODE_MINR_2_2,
                                 SGBSTDN_MAJR_CODE_CONC_2,
                                 SGBSTDN_MAJR_CODE_CONC_2_2,
                                 SGBSTDN_MAJR_CODE_CONC_2_3,
                                 SGBSTDN_ORSN_CODE,
                                 SGBSTDN_PRAC_CODE,
                                 SGBSTDN_ADVR_PIDM,
                                 SGBSTDN_GRAD_CREDIT_APPR_IND,
                                 SGBSTDN_CAPL_CODE,
                                 SGBSTDN_LEAV_CODE,
                                 SGBSTDN_LEAV_FROM_DATE,
                                 SGBSTDN_LEAV_TO_DATE,
                                 SGBSTDN_ASTD_CODE,
                                 SGBSTDN_TERM_CODE_ASTD,
                                 SGBSTDN_RATE_CODE,
                                 SGBSTDN_ACTIVITY_DATE,
                                 SGBSTDN_MAJR_CODE_1_2,
                                 SGBSTDN_MAJR_CODE_2_2,
                                 SGBSTDN_EDLV_CODE,
                                 SGBSTDN_INCM_CODE,
                                 SGBSTDN_ADMT_CODE,
                                 SGBSTDN_EMEX_CODE,
                                 SGBSTDN_APRN_CODE,
                                 SGBSTDN_TRCN_CODE,
                                 SGBSTDN_GAIN_CODE,
                                 SGBSTDN_VOED_CODE,
                                 SGBSTDN_BLCK_CODE,
                                 SGBSTDN_TERM_CODE_GRAD,
                                 SGBSTDN_ACYR_CODE,
                                 SGBSTDN_DEPT_CODE,
                                 SGBSTDN_SITE_CODE,
                                 SGBSTDN_DEPT_CODE_2,
                                 SGBSTDN_EGOL_CODE,
                                 SGBSTDN_DEGC_CODE_DUAL,
                                 SGBSTDN_LEVL_CODE_DUAL,
                                 SGBSTDN_DEPT_CODE_DUAL,
                                 SGBSTDN_COLL_CODE_DUAL,
                                 SGBSTDN_MAJR_CODE_DUAL,
                                 SGBSTDN_BSKL_CODE,
                                 SGBSTDN_PRIM_ROLL_IND,
                                 SGBSTDN_PROGRAM_1,
                                 SGBSTDN_TERM_CODE_CTLG_1,
                                 SGBSTDN_DEPT_CODE_1_2,
                                 SGBSTDN_MAJR_CODE_CONC_121,
                                 SGBSTDN_MAJR_CODE_CONC_122,
                                 SGBSTDN_MAJR_CODE_CONC_123,
                                 SGBSTDN_SECD_ROLL_IND,
                                 SGBSTDN_TERM_CODE_ADMIT_2,
                                 SGBSTDN_ADMT_CODE_2,
                                 SGBSTDN_PROGRAM_2,
                                 SGBSTDN_TERM_CODE_CTLG_2,
                                 SGBSTDN_LEVL_CODE_2,
                                 SGBSTDN_CAMP_CODE_2,
                                 SGBSTDN_DEPT_CODE_2_2,
                                 SGBSTDN_MAJR_CODE_CONC_221,
                                 SGBSTDN_MAJR_CODE_CONC_222,
                                 SGBSTDN_MAJR_CODE_CONC_223,
                                 SGBSTDN_CURR_RULE_1,
                                 SGBSTDN_CMJR_RULE_1_1,
                                 SGBSTDN_CCON_RULE_11_1,
                                 SGBSTDN_CCON_RULE_11_2,
                                 SGBSTDN_CCON_RULE_11_3,
                                 SGBSTDN_CMJR_RULE_1_2,
                                 SGBSTDN_CCON_RULE_12_1,
                                 SGBSTDN_CCON_RULE_12_2,
                                 SGBSTDN_CCON_RULE_12_3,
                                 SGBSTDN_CMNR_RULE_1_1,
                                 SGBSTDN_CMNR_RULE_1_2,
                                 SGBSTDN_CURR_RULE_2,
                                 SGBSTDN_CMJR_RULE_2_1,
                                 SGBSTDN_CCON_RULE_21_1,
                                 SGBSTDN_CCON_RULE_21_2,
                                 SGBSTDN_CCON_RULE_21_3,
                                 SGBSTDN_CMJR_RULE_2_2,
                                 SGBSTDN_CCON_RULE_22_1,
                                 SGBSTDN_CCON_RULE_22_2,
                                 SGBSTDN_CCON_RULE_22_3,
                                 SGBSTDN_CMNR_RULE_2_1,
                                 SGBSTDN_CMNR_RULE_2_2,
                                 SGBSTDN_PREV_CODE,
                                 SGBSTDN_TERM_CODE_PREV,
                                 SGBSTDN_CAST_CODE,
                                 SGBSTDN_TERM_CODE_CAST,
                                 SGBSTDN_DATA_ORIGIN,
                                 SGBSTDN_USER_ID,
                                 SGBSTDN_SCPC_CODE)
               SELECT rec.pidm,
                      term,
                      SGBSTDN_STST_CODE,
                      SGBSTDN_LEVL_CODE,
                      'ã',
                      SGBSTDN_TERM_CODE_MATRIC,
                      SGBSTDN_TERM_CODE_ADMIT,
                      SGBSTDN_EXP_GRAD_DATE,
                      SGBSTDN_CAMP_CODE,
                      SGBSTDN_FULL_PART_IND,
                      SGBSTDN_SESS_CODE,
                      SGBSTDN_RESD_CODE,
                      SGBSTDN_COLL_CODE_1,
                      SGBSTDN_DEGC_CODE_1,
                      SGBSTDN_MAJR_CODE_1,
                      SGBSTDN_MAJR_CODE_MINR_1,
                      SGBSTDN_MAJR_CODE_MINR_1_2,
                      SGBSTDN_MAJR_CODE_CONC_1,
                      SGBSTDN_MAJR_CODE_CONC_1_2,
                      SGBSTDN_MAJR_CODE_CONC_1_3,
                      SGBSTDN_COLL_CODE_2,
                      SGBSTDN_DEGC_CODE_2,
                      SGBSTDN_MAJR_CODE_2,
                      SGBSTDN_MAJR_CODE_MINR_2,
                      SGBSTDN_MAJR_CODE_MINR_2_2,
                      SGBSTDN_MAJR_CODE_CONC_2,
                      SGBSTDN_MAJR_CODE_CONC_2_2,
                      SGBSTDN_MAJR_CODE_CONC_2_3,
                      SGBSTDN_ORSN_CODE,
                      SGBSTDN_PRAC_CODE,
                      SGBSTDN_ADVR_PIDM,
                      SGBSTDN_GRAD_CREDIT_APPR_IND,
                      SGBSTDN_CAPL_CODE,
                      SGBSTDN_LEAV_CODE,
                      SGBSTDN_LEAV_FROM_DATE,
                      SGBSTDN_LEAV_TO_DATE,
                      SGBSTDN_ASTD_CODE,
                      SGBSTDN_TERM_CODE_ASTD,
                      SGBSTDN_RATE_CODE,
                      SYSDATE,
                      SGBSTDN_MAJR_CODE_1_2,
                      SGBSTDN_MAJR_CODE_2_2,
                      SGBSTDN_EDLV_CODE,
                      SGBSTDN_INCM_CODE,
                      SGBSTDN_ADMT_CODE,
                      SGBSTDN_EMEX_CODE,
                      SGBSTDN_APRN_CODE,
                      SGBSTDN_TRCN_CODE,
                      SGBSTDN_GAIN_CODE,
                      SGBSTDN_VOED_CODE,
                      SGBSTDN_BLCK_CODE,
                      SGBSTDN_TERM_CODE_GRAD,
                      SGBSTDN_ACYR_CODE,
                      SGBSTDN_DEPT_CODE,
                      SGBSTDN_SITE_CODE,
                      SGBSTDN_DEPT_CODE_2,
                      SGBSTDN_EGOL_CODE,
                      SGBSTDN_DEGC_CODE_DUAL,
                      SGBSTDN_LEVL_CODE_DUAL,
                      SGBSTDN_DEPT_CODE_DUAL,
                      SGBSTDN_COLL_CODE_DUAL,
                      SGBSTDN_MAJR_CODE_DUAL,
                      SGBSTDN_BSKL_CODE,
                      SGBSTDN_PRIM_ROLL_IND,
                      SGBSTDN_PROGRAM_1,
                      SGBSTDN_TERM_CODE_CTLG_1,
                      SGBSTDN_DEPT_CODE_1_2,
                      SGBSTDN_MAJR_CODE_CONC_121,
                      SGBSTDN_MAJR_CODE_CONC_122,
                      SGBSTDN_MAJR_CODE_CONC_123,
                      SGBSTDN_SECD_ROLL_IND,
                      SGBSTDN_TERM_CODE_ADMIT_2,
                      SGBSTDN_ADMT_CODE_2,
                      SGBSTDN_PROGRAM_2,
                      SGBSTDN_TERM_CODE_CTLG_2,
                      SGBSTDN_LEVL_CODE_2,
                      SGBSTDN_CAMP_CODE_2,
                      SGBSTDN_DEPT_CODE_2_2,
                      SGBSTDN_MAJR_CODE_CONC_221,
                      SGBSTDN_MAJR_CODE_CONC_222,
                      SGBSTDN_MAJR_CODE_CONC_223,
                      SGBSTDN_CURR_RULE_1,
                      SGBSTDN_CMJR_RULE_1_1,
                      SGBSTDN_CCON_RULE_11_1,
                      SGBSTDN_CCON_RULE_11_2,
                      SGBSTDN_CCON_RULE_11_3,
                      SGBSTDN_CMJR_RULE_1_2,
                      SGBSTDN_CCON_RULE_12_1,
                      SGBSTDN_CCON_RULE_12_2,
                      SGBSTDN_CCON_RULE_12_3,
                      SGBSTDN_CMNR_RULE_1_1,
                      SGBSTDN_CMNR_RULE_1_2,
                      SGBSTDN_CURR_RULE_2,
                      SGBSTDN_CMJR_RULE_2_1,
                      SGBSTDN_CCON_RULE_21_1,
                      SGBSTDN_CCON_RULE_21_2,
                      SGBSTDN_CCON_RULE_21_3,
                      SGBSTDN_CMJR_RULE_2_2,
                      SGBSTDN_CCON_RULE_22_1,
                      SGBSTDN_CCON_RULE_22_2,
                      SGBSTDN_CCON_RULE_22_3,
                      SGBSTDN_CMNR_RULE_2_1,
                      SGBSTDN_CMNR_RULE_2_2,
                      SGBSTDN_PREV_CODE,
                      SGBSTDN_TERM_CODE_PREV,
                      SGBSTDN_CAST_CODE,
                      SGBSTDN_TERM_CODE_CAST,
                      data_origin,
                      USER,
                      SGBSTDN_SCPC_CODE
                 FROM sgbstdn a
                WHERE     a.sgbstdn_pidm = rec.pidm
                      AND a.sgbstdn_term_code_eff =
                             (SELECT MAX (b.sgbstdn_term_code_eff)
                                FROM sgbstdn b
                               WHERE b.sgbstdn_pidm = a.sgbstdn_pidm);

            l_inserted_counter := l_inserted_counter + 1;
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line (
                  'Error: in stdudent  '
               || f_get_std_id (rec.pidm)
               || 'error'
               || SQLERRM);
      END;
   END LOOP;


   DBMS_OUTPUT.put_line ('Updated Records : ' || to_char(l_updated_counter,'9999'));
   DBMS_OUTPUT.put_line ('Inserted Records : ' || TO_CHAR (l_inserted_counter, '9999'));
   DBMS_OUTPUT.put_line (
      'Total Records : ' || to_char(l_inserted_counter + l_updated_counter,'9999'));
END;