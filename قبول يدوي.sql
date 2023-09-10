 
DECLARE
    v_ID            VARCHAR2 (100);
    v_FIRST_NAME    VARCHAR2 (100);
    v_SECOND_NAME   VARCHAR2 (100);
    v_THIRD_NAME    VARCHAR2 (100);
    v_FAMILY_NAME   VARCHAR2 (100);
    v_SSN           VARCHAR2 (100);
    v_GENDER        VARCHAR2 (100);
    V_BDAY          DATE;
    V_PHONE         VARCHAR2 (100);
    v_pidm          NUMBER (9);

    CURSOR get_data IS
        SELECT col01     ssn,
               col02     FIRST_NAME,
               col03     SECOND_NAME,
               col04     THIRD_NAME,
               col06     GENDER,
               col07     PHONE,
               col08     program_cd,
               col09     dept,
               col10     major,
               col11     BLCK_CODE,
               col12     master_pidm
               
          FROM bu_dev.tmp_tbl_kilany_qadm
          where col13 is null
         -- and col01='2457479422'
         -- AND COL11='MKT2'
          ;
BEGIN
    FOR rec IN get_data
    LOOP
        v_id := gb_common.f_generate_id;
        v_pidm := gb_common.f_generate_pidm;
        v_ssn := rec.ssn;
        v_FIRST_NAME := rec.FIRST_NAME;
        v_SECOND_NAME := rec.SECOND_NAME;
        v_THIRD_NAME := rec.THIRD_NAME;
        v_GENDER := rec.GENDER;
        v_PHONE := rec.PHONE;



        INSERT INTO SATURN.SPRIDEN (SPRIDEN_PIDM,
                                    SPRIDEN_ID,
                                    SPRIDEN_LAST_NAME,
                                    SPRIDEN_FIRST_NAME,
                                    SPRIDEN_MI,
                                    SPRIDEN_ENTITY_IND,
                                    SPRIDEN_ACTIVITY_DATE,
                                    SPRIDEN_USER,
                                    SPRIDEN_SEARCH_LAST_NAME,
                                    SPRIDEN_SEARCH_FIRST_NAME,
                                    SPRIDEN_SEARCH_MI,
                                    SPRIDEN_CREATE_USER,
                                    SPRIDEN_CREATE_DATE,
                                    SPRIDEN_DATA_ORIGIN)
             VALUES (v_pidm,
                     v_id,
                     v_THIRD_NAME,
                     v_FIRST_NAME,
                     v_SECOND_NAME,
                     'P',
                     SYSDATE,
                     'BU_APPS',
                     v_THIRD_NAME,
                     v_FIRST_NAME,
                     v_SECOND_NAME,
                     'BU_APPS',
                     SYSDATE,
                     'Banner');



        INSERT INTO SATURN.SPBPERS (SPBPERS_PIDM,
                                    SPBPERS_SSN,
                                    SPBPERS_MRTL_CODE,
                                    SPBPERS_RELG_CODE,
                                    SPBPERS_SEX,
                                    SPBPERS_CONFID_IND,
                                    SPBPERS_ACTIVITY_DATE,
                                    SPBPERS_CITZ_CODE,
                                    SPBPERS_DATA_ORIGIN,
                                    SPBPERS_USER_ID,
                                    SPBPERS_ARMED_SERV_MED_VET_IND)
             VALUES (v_pidm,
                     v_SSN,
                     '',
                     '',
                     v_GENDER,
                     'N',
                     SYSDATE,
                     '',
                     'Banner',
                     'BU_APPS',
                     'N');



        INSERT INTO SATURN.SPRTELE (SPRTELE_PIDM,
                                    SPRTELE_SEQNO,
                                    SPRTELE_TELE_CODE,
                                    SPRTELE_ACTIVITY_DATE,
                                    SPRTELE_ATYP_CODE,
                                    SPRTELE_INTL_ACCESS,
                                    SPRTELE_DATA_ORIGIN,
                                    SPRTELE_USER_ID)
             VALUES (v_pidm,
                     1,
                     'MO',
                     SYSDATE,
                     'Ïã',
                     '966' || v_phone,
                     'Banner',
                     'BU_APPS');



        UPDATE bu_dev.tmp_tbl_kilany_qadm
           SET col13 = v_pidm
         WHERE col01 = v_ssn;



        DBMS_OUTPUT.PUT_LINE ('Added Successfully with pidm' || v_pidm);



        -- sgbstdn
 
        INSERT INTO sgbstdn (SGBSTDN_PIDM,
                             SGBSTDN_TERM_CODE_EFF,
                             SGBSTDN_STST_CODE,
                             SGBSTDN_LEVL_CODE,
                             SGBSTDN_STYP_CODE,
                             SGBSTDN_TERM_CODE_MATRIC,
                             SGBSTDN_TERM_CODE_ADMIT,
                             SGBSTDN_EXP_GRAD_DATE,
                             SGBSTDN_CAMP_CODE,                         --camp
                             SGBSTDN_FULL_PART_IND,
                             SGBSTDN_SESS_CODE,
                             SGBSTDN_RESD_CODE,
                             SGBSTDN_COLL_CODE_1,                    --college
                             SGBSTDN_DEGC_CODE_1,
                             SGBSTDN_MAJR_CODE_1,                      --major
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
                             SGBSTDN_DEPT_CODE,                   --department
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
                             SGBSTDN_PROGRAM_1,                     -- program
                             SGBSTDN_TERM_CODE_CTLG_1,               --catalog
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
            SELECT v_pidm,
                   SGBSTDN_TERM_CODE_EFF,
                   SGBSTDN_STST_CODE,
                   SGBSTDN_LEVL_CODE,
                   SGBSTDN_STYP_CODE,
                   SGBSTDN_TERM_CODE_MATRIC,
                   SGBSTDN_TERM_CODE_ADMIT,
                   SGBSTDN_EXP_GRAD_DATE,
                   SGBSTDN_CAMP_CODE,                                   --camp
                   SGBSTDN_FULL_PART_IND,
                   SGBSTDN_SESS_CODE,
                   SGBSTDN_RESD_CODE,
                   SGBSTDN_COLL_CODE_1,                              --college
                   SGBSTDN_DEGC_CODE_1,
                   SGBSTDN_MAJR_CODE_1,                                --major
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
                   rec.BLCK_CODE,
                   SGBSTDN_TERM_CODE_GRAD,
                   SGBSTDN_ACYR_CODE,
                   SGBSTDN_DEPT_CODE,                             --department
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
                   SGBSTDN_PROGRAM_1,                               -- program
                   SGBSTDN_TERM_CODE_CTLG_1,                         --catalog
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
                   SGBSTDN_SCPC_CODE
              FROM sgbstdn a
             WHERE a.sgbstdn_pidm = rec.master_pidm;


        ---- sorlcur

        INSERT INTO SORLCUR (SORLCUR_PIDM,
                             SORLCUR_SEQNO,
                             SORLCUR_LMOD_CODE,
                             SORLCUR_TERM_CODE,
                             SORLCUR_KEY_SEQNO,
                             SORLCUR_PRIORITY_NO,
                             SORLCUR_ROLL_IND,
                             SORLCUR_CACT_CODE,
                             SORLCUR_USER_ID,
                             SORLCUR_DATA_ORIGIN,
                             SORLCUR_ACTIVITY_DATE,
                             SORLCUR_LEVL_CODE,
                             SORLCUR_COLL_CODE,
                             SORLCUR_DEGC_CODE,
                             SORLCUR_TERM_CODE_CTLG,
                             SORLCUR_TERM_CODE_END,
                             SORLCUR_TERM_CODE_MATRIC,
                             SORLCUR_TERM_CODE_ADMIT,
                             SORLCUR_ADMT_CODE,
                             SORLCUR_CAMP_CODE,
                             SORLCUR_PROGRAM,
                             SORLCUR_START_DATE,
                             SORLCUR_END_DATE,
                             SORLCUR_CURR_RULE,
                             SORLCUR_ROLLED_SEQNO,
                             SORLCUR_STYP_CODE,
                             SORLCUR_RATE_CODE,
                             SORLCUR_LEAV_CODE,
                             SORLCUR_LEAV_FROM_DATE,
                             SORLCUR_LEAV_TO_DATE,
                             SORLCUR_EXP_GRAD_DATE,
                             SORLCUR_TERM_CODE_GRAD,
                             SORLCUR_ACYR_CODE,
                             SORLCUR_SITE_CODE,
                             SORLCUR_APPL_SEQNO,
                             SORLCUR_APPL_KEY_SEQNO,
                             SORLCUR_USER_ID_UPDATE,
                             SORLCUR_ACTIVITY_DATE_UPDATE,
                             SORLCUR_GAPP_SEQNO,
                             SORLCUR_CURRENT_CDE)
            SELECT v_pidm,
                   SORLCUR_SEQNO,
                   SORLCUR_LMOD_CODE,
                   SORLCUR_TERM_CODE,
                   SORLCUR_KEY_SEQNO,
                   SORLCUR_PRIORITY_NO,
                   SORLCUR_ROLL_IND,
                   SORLCUR_CACT_CODE,
                   SORLCUR_USER_ID,
                   SORLCUR_DATA_ORIGIN,
                   SORLCUR_ACTIVITY_DATE,
                   SORLCUR_LEVL_CODE,
                   SORLCUR_COLL_CODE,
                   SORLCUR_DEGC_CODE,
                   SORLCUR_TERM_CODE_CTLG,
                   SORLCUR_TERM_CODE_END,
                   SORLCUR_TERM_CODE_MATRIC,
                   SORLCUR_TERM_CODE_ADMIT,
                   SORLCUR_ADMT_CODE,
                   SORLCUR_CAMP_CODE,
                   SORLCUR_PROGRAM,
                   SORLCUR_START_DATE,
                   SORLCUR_END_DATE,
                   SORLCUR_CURR_RULE,
                   SORLCUR_ROLLED_SEQNO,
                   SORLCUR_STYP_CODE,
                   SORLCUR_RATE_CODE,
                   SORLCUR_LEAV_CODE,
                   SORLCUR_LEAV_FROM_DATE,
                   SORLCUR_LEAV_TO_DATE,
                   SORLCUR_EXP_GRAD_DATE,
                   SORLCUR_TERM_CODE_GRAD,
                   SORLCUR_ACYR_CODE,
                   SORLCUR_SITE_CODE,
                   SORLCUR_APPL_SEQNO,
                   SORLCUR_APPL_KEY_SEQNO,
                   SORLCUR_USER_ID_UPDATE,
                   SORLCUR_ACTIVITY_DATE_UPDATE,
                   SORLCUR_GAPP_SEQNO,
                   SORLCUR_CURRENT_CDE
              FROM SORLCUR
             WHERE SORLCUR_PIDM = rec.master_pidm;

        -- sorlfos

        INSERT INTO SORLFOS (SORLFOS_PIDM,
                             SORLFOS_LCUR_SEQNO,
                             SORLFOS_SEQNO,
                             SORLFOS_LFST_CODE,
                             SORLFOS_TERM_CODE,
                             SORLFOS_PRIORITY_NO,
                             SORLFOS_CSTS_CODE,
                             SORLFOS_CACT_CODE,
                             SORLFOS_DATA_ORIGIN,
                             SORLFOS_USER_ID,
                             SORLFOS_ACTIVITY_DATE,
                             SORLFOS_MAJR_CODE,
                             SORLFOS_TERM_CODE_CTLG,
                             SORLFOS_TERM_CODE_END,
                             SORLFOS_DEPT_CODE,
                             SORLFOS_MAJR_CODE_ATTACH,
                             SORLFOS_LFOS_RULE,
                             SORLFOS_CONC_ATTACH_RULE,
                             SORLFOS_START_DATE,
                             SORLFOS_END_DATE,
                             SORLFOS_TMST_CODE,
                             SORLFOS_ROLLED_SEQNO,
                             SORLFOS_USER_ID_UPDATE,
                             SORLFOS_ACTIVITY_DATE_UPDATE,
                             SORLFOS_CURRENT_CDE)
            SELECT v_pidm,
                   SORLFOS_LCUR_SEQNO,
                   SORLFOS_SEQNO,
                   SORLFOS_LFST_CODE,
                   SORLFOS_TERM_CODE,
                   SORLFOS_PRIORITY_NO,
                   SORLFOS_CSTS_CODE,
                   SORLFOS_CACT_CODE,
                   SORLFOS_DATA_ORIGIN,
                   SORLFOS_USER_ID,
                   SORLFOS_ACTIVITY_DATE,
                   SORLFOS_MAJR_CODE,
                   SORLFOS_TERM_CODE_CTLG,
                   SORLFOS_TERM_CODE_END,
                   SORLFOS_DEPT_CODE,
                   SORLFOS_MAJR_CODE_ATTACH,
                   SORLFOS_LFOS_RULE,
                   SORLFOS_CONC_ATTACH_RULE,
                   SORLFOS_START_DATE,
                   SORLFOS_END_DATE,
                   SORLFOS_TMST_CODE,
                   SORLFOS_ROLLED_SEQNO,
                   SORLFOS_USER_ID_UPDATE,
                   SORLFOS_ACTIVITY_DATE_UPDATE,
                   SORLFOS_CURRENT_CDE
              FROM SORLFOS
             WHERE SORLFOS_pidm = rec.master_pidm;
    END LOOP;
    exception
    when others then 
     DBMS_OUTPUT.PUT_LINE(sqlerrm);
    
END;

DECLARE
   CURSOR get_new_std
   IS
      SELECT sgbstdn_pidm,
             spriden_id,
             spbpers_ssn,
             SUBSTR (spbpers_ssn, 5) sabnstu_pin
        FROM sgbstdn s1, spriden, spbpers
       WHERE     sgbstdn_pidm = spriden_pidm
             AND spriden_change_ind IS NULL
             AND sgbstdn_pidm = spbpers_pidm
             AND sgbstdn_term_code_eff =
                    (SELECT MAX (s2.sgbstdn_term_code_eff)
                       FROM sgbstdn s2
                      WHERE s2.sgbstdn_pidm = s1.sgbstdn_pidm)
             AND sgbstdn_pidm in (select col13 from bu_dev.tmp_tbl_kilany_qadm);

   l_hashed_pwd   VARCHAR2 (150);
BEGIN
   FOR i IN get_new_std
   LOOP
      l_hashed_pwd := '';
      gspcrpt.p_saltedhash_md5 (i.sabnstu_pin, l_hashed_pwd);

      UPDATE gobtpac
         SET gobtpac_pin = l_hashed_pwd,
             gobtpac_activity_date = SYSDATE,
             gobtpac_user = 'BU_APPS',
             gobtpac_data_origin = 'Banner_ADM',
             gobtpac_salt = ''
       WHERE gobtpac_pidm = i.sgbstdn_pidm;

      IF SQL%NOTFOUND
      THEN
         INSERT INTO gobtpac (gobtpac_pidm,
                              gobtpac_pin_disabled_ind,
                              gobtpac_usage_accept_ind,
                              gobtpac_activity_date,
                              gobtpac_user,
                              gobtpac_pin,
                              gobtpac_pin_exp_date,
                              gobtpac_external_user,
                              gobtpac_question,
                              gobtpac_response,
                              gobtpac_insert_source,
                              gobtpac_ldap_user,
                              gobtpac_data_origin,
                              gobtpac_salt)
              VALUES (i.sgbstdn_pidm,
                      'N',
                      'N',
                      SYSDATE,
                      'BU_APPS',
                      l_hashed_pwd,
                      SYSDATE,
                      '',
                      '',
                      '',
                      'ADMIN',
                      '',
                      'Banner_ADM',
                      '');
      END IF;

      INSERT INTO gorpaud (gorpaud_pidm,
                           gorpaud_activity_date,
                           gorpaud_user,
                           gorpaud_pin,
                           gorpaud_external_user,
                           gorpaud_chg_ind,
                           gorpaud_salt)
           VALUES (i.sgbstdn_pidm,
                   SYSDATE,
                   'Banner_ADM',
                   l_hashed_pwd,
                   '',
                   'P',
                   '');
   END LOOP;
END;

/


Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'ADM_MANUAL_451' , 'SAISUSR', 'ÑÒã ÞÈæá íÏæí', 'N', 
    SYSDATE, NULL);
    
    
  
    
    Insert into GLBEXTR
   SELECT 'STUDENT', 'ADM_ISCLR_45', 'SAISUSR', 'SAISUSR',  PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT   col13  PIDM
            from bu_dev.tmp_tbl_kilany_qadm
           WHERE      col13 IS NOT NULL) ;