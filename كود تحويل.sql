/* Formatted on 10/28/2019 3:24:04 PM (QP5 v5.227.12220.39754) */
/*SORLFOS
sgbstdn
SORLCUR
SORCMjR
SMRPRLE
SOBCURR
DROP TABLE TRANSFER_STUDENT_PROGRAM
 CREATE TABLE TRANSFER_STUDENT_PROGRAM ( PIDM_CD NUMBER(9) PRIMARY KEY , PROGRAM_CD VARCHAR2(12) ,DEPT_CODE VARCHAR2(4),MAJOR_CODE VARCHAR2(4),notes varchar2(150) ;
 UPDATE TRANSFER_STUDENT_PROGRAM SET PIDM_CD=F_GET_PIDM(PIDM_CD);
DELETE TRANSFER_STUDENT_PROGRAM WHERE PIDM_CD IS NULL OR PIDM_CD=0;

 delete TRANSFER_STUDENT_PROGRAM where PROGRAM_CD is null ;
 -- set dept and major code 
 update TRANSFER_STUDENT_PROGRAM a set (a.DEPT_CODE ,a.MAJOR_CODE) =
(select SORCMJR_DEPT_CODE ,SORCMJR_MAJR_CODE
from sorcmjr,sobcurr
where  
SORCMJR_CURR_RULE=SOBCURR_CURR_RULE
and SOBCURR_PROGRAM =A.PROGRAM_CD) ;
 UPDATE TRANSFER_STUDENT_PROGRAM SET PROGRAM_CD='1-3201-1438' ;
update TRANSFER_STUDENT_PROGRAM set PIDM_CD=f_get_pidm(PIDM_CD)
update TRANSFER_STUDENT_PROGRAM set PROGRAM_CD='2-1808-1433'
update TRANSFER_STUDENT_PROGRAM set dept_code='1808'
update  TRANSFER_STUDENT_PROGRAM set MAJOR_CODE=dept_code
alter table TRANSFER_STUDENT_PROGRAM add  notes varchar2(150)
------------------+++++++++++++++++++++++++++++
UPDATE TRANSFER_STUDENT_PROGRAM SET PIDM_CD=F_GET_PIDM(PIDM_CD);
DELETE TRANSFER_STUDENT_PROGRAM WHERE PIDM_CD IS NULL OR PIDM_CD=0;
 UPDATE TRANSFER_STUDENT_PROGRAM SET PROGRAM_CD='1-3201-1438' ;
 update TRANSFER_STUDENT_PROGRAM a set (a.DEPT_CODE ,a.MAJOR_CODE) =
(select SORCMJR_DEPT_CODE ,SORCMJR_MAJR_CODE
from sorcmjr,sobcurr
where  
SORCMJR_CURR_RULE=SOBCURR_CURR_RULE
and SOBCURR_PROGRAM =A.PROGRAM_CD) ;
update TRANSFER_STUDENT_PROGRAM a set A.NOTES=''
 ;
 
 exec ITRANSFER_PROC ('144030') ;
 
 UPDATE SHRDGMR S SET (S.SHRDGMR_PROGRAM,S.SHRDGMR_DEPT_CODE,S.SHRDGMR_MAJR_CODE_1)=(SELECT A.PROGRAM_CD ,a.DEPT_CODE ,a.MAJOR_CODE FROM TRANSFER_STUDENT_PROGRAM A
 WHERE A.PIDM_CD=SHRDGMR_PIDM
 AND A.PROGRAM_CD IS NOT NULL)
 WHERE
 EXISTS (SELECT '1' FROM TRANSFER_STUDENT_PROGRAM WHERE  PIDM_CD=SHRDGMR_PIDM) 
 AND
 S.SHRDGMR_SEQ_NO=(SELECT MAX(SHRDGMR_SEQ_NO) FROM SHRDGMR WHERE SHRDGMR_PIDM=S.SHRDGMR_PIDM AND SHRDGMR_DEGS_CODE='SO')
 AND S.SHRDGMR_DEGS_CODE='SO' ;
-------------------+++++++++++++++++++++++++++++
*/
exec ITRANSFER_PROC ('144010') ;
/*CREATE OR REPLACE PROCEDURE ITRANSFER_PROC (P_TERM_CODE VARCHAR2)
IS
   CURSOR GET_STU_PROG
   IS
      SELECT *
        FROM TRANSFER_STUDENT_PROGRAM
       WHERE notes is null;



   CURSOR GET_LCUR_SEQNO (P_PIDM_CD NUMBER)
   IS
      SELECT MAX (SORLCUR_SEQNO)
        FROM SORLCUR
       WHERE SORLCUR_PIDM = P_PIDM_CD;

   CURSOR GET_TERM_CODE (P_PIDM_CD NUMBER, P_MAX_SEQ NUMBER)
   IS
      SELECT SORLCUR_TERM_CODE_CTLG, SORLCUR_TERM_CODE_ADMIT
        FROM SORLCUR
       WHERE SORLCUR_PIDM = P_PIDM_CD AND SORLCUR_SEQNO = P_MAX_SEQ;

   CURSOR GET_PROGRAM_DATA (
      P_PROG_CODE VARCHAR2)
   IS
      SELECT SOBCURR_CURR_RULE,
             SORCMJR_CMJR_RULE,
             SOBCURR_CAMP_CODE,
             SOBCURR_COLL_CODE
        FROM SOBCURR, SORCMJR
       WHERE     SOBCURR_CURR_RULE = SORCMJR_CURR_RULE
             AND SOBCURR_PROGRAM = P_PROG_CODE;

   V_MAX_LCUR_SEQNO   NUMBER (4);
   V_TERM_CODE_CTLG   VARCHAR2 (8);
   V_TERM_ADMIT       VARCHAR2 (8);
   V_CURR_RULE        NUMBER (8);
   V_CMJR_RULE        NUMBER (8);
   V_CAMP_CODE        VARCHAR2 (3);
   V_COLL_CODE        VARCHAR2 (3);
   v_notes            VARCHAR2 (150);
   l_term_code        VARCHAR2 (8)
                         := f_get_param ('WORKFLOW', 'CURRENT_TERM', 1);
BEGIN
   FOR REC IN GET_STU_PROG
   LOOP
      -- fetch data
      OPEN GET_LCUR_SEQNO (REC.PIDM_CD);

      FETCH GET_LCUR_SEQNO INTO V_MAX_LCUR_SEQNO;

      CLOSE GET_LCUR_SEQNO;

      OPEN GET_TERM_CODE (REC.PIDM_CD, V_MAX_LCUR_SEQNO);

      FETCH GET_TERM_CODE
         INTO V_TERM_CODE_CTLG, V_TERM_ADMIT;

      CLOSE GET_TERM_CODE;

      OPEN GET_PROGRAM_DATA (REC.PROGRAM_CD);

      FETCH GET_PROGRAM_DATA
         INTO V_CURR_RULE, V_CMJR_RULE, V_CAMP_CODE, V_COLL_CODE;

      CLOSE GET_PROGRAM_DATA;

      --SORLCUR TABLE
      -- DEACTIVATE THE  LAST RECORD

      BEGIN
         UPDATE SORLCUR
            SET SORLCUR_CACT_CODE = 'INACTIVE',
                SORLCUR_USER_ID_UPDATE = USER,
                SORLCUR_ACTIVITY_DATE = SYSDATE,
                SORLCUR_TERM_CODE_END = P_TERM_CODE,
                SORLCUR_ACTIVITY_DATE_UPDATE = SYSDATE,
                SORLCUR_CURRENT_CDE = ''
          WHERE     SORLCUR_PIDM = REC.PIDM_CD
                AND SORLCUR_SEQNO = V_MAX_LCUR_SEQNO;

         -- ADD NEW RECORD

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
              VALUES (REC.PIDM_CD,
                      V_MAX_LCUR_SEQNO + 1,
                      'LEARNER',
                      P_TERM_CODE,
                      99,
                      1,
                      'Y',
                      'ACTIVE',
                      USER,
                      'BannerIT',
                      SYSDATE,
                      'Ã„',
                      V_COLL_CODE,
                      '»ﬂ',
                      V_TERM_CODE_CTLG,
                      NULL,
                      NULL,
                      V_TERM_ADMIT,
                      'ST',
                      V_CAMP_CODE,
                      REC.PROGRAM_CD,
                      NULL,
                      NULL,
                      V_CURR_RULE,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      USER,
                      SYSDATE,
                      NULL,
                      'Y');



         --  SORLFOS TABLE --
         -- DEACTIVATE THE  LAST RECORD
         UPDATE SORLFOS S
            SET S.SORLFOS_CSTS_CODE = 'CHANGED',
                S.SORLFOS_CACT_CODE = 'INACTIVE',
                SORLFOS_CURRENT_CDE = '',
                SORLFOS_USER_ID_UPDATE = USER,
                SORLFOS_ACTIVITY_DATE_UPDATE = SYSDATE
          WHERE     SORLFOS_PIDM = REC.PIDM_CD
                AND SORLFOS_LCUR_SEQNO = V_MAX_LCUR_SEQNO;



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
              VALUES (REC.PIDM_CD,
                      V_MAX_LCUR_SEQNO + 1,
                      1,
                      'MAJOR',
                      P_TERM_CODE,
                      1,
                      'INPROGRESS',
                      'ACTIVE',
                      'BannerIT',
                      USER,
                      SYSDATE,
                      REC.MAJOR_CODE,
                      V_TERM_CODE_CTLG,
                      NULL,
                      REC.DEPT_CODE,
                      NULL,
                      V_CMJR_RULE,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      USER,
                      SYSDATE,
                      'Y');

         -- SGBSTDN
         UPDATE sgbstdn
            SET SGBSTDN_CAMP_CODE = V_CAMP_CODE,                        --camp
                SGBSTDN_COLL_CODE_1 = V_COLL_CODE,                   --college
                SGBSTDN_MAJR_CODE_1 = REC.MAJOR_CODE,                  --major
                SGBSTDN_DEPT_CODE = REC.DEPT_CODE,                --department
                SGBSTDN_PROGRAM_1 = REC.PROGRAM_CD,                 -- PROGRAM
                SGBSTDN_TERM_CODE_CTLG_1 = V_TERM_CODE_CTLG,   -- TERM_CATALOG
                SGBSTDN_ACTIVITY_DATE = SYSDATE,
                SGBSTDN_DATA_ORIGIN = 'BannerIT',
                sgbstdn_user_id = USER
          WHERE     sgbstdn_pidm = REC.PIDM_CD
                AND sgbstdn_term_code_eff = p_term_code;

         IF SQL%NOTFOUND
         THEN
            INSERT INTO sgbstdn (SGBSTDN_PIDM,
                                 SGBSTDN_TERM_CODE_EFF,
                                 SGBSTDN_STST_CODE,
                                 SGBSTDN_LEVL_CODE,
                                 SGBSTDN_STYP_CODE,
                                 SGBSTDN_TERM_CODE_MATRIC,
                                 SGBSTDN_TERM_CODE_ADMIT,
                                 SGBSTDN_EXP_GRAD_DATE,
                                 SGBSTDN_CAMP_CODE,                     --camp
                                 SGBSTDN_FULL_PART_IND,
                                 SGBSTDN_SESS_CODE,
                                 SGBSTDN_RESD_CODE,
                                 SGBSTDN_COLL_CODE_1,                --college
                                 SGBSTDN_DEGC_CODE_1,
                                 SGBSTDN_MAJR_CODE_1,                  --major
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
                                 SGBSTDN_DEPT_CODE,               --department
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
                                 SGBSTDN_PROGRAM_1,                 -- program
                                 SGBSTDN_TERM_CODE_CTLG_1,           --catalog
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
               SELECT REC.PIDM_CD,
                      P_TERM_CODE,
                      SGBSTDN_STST_CODE,
                      SGBSTDN_LEVL_CODE,
                      SGBSTDN_STYP_CODE,
                      SGBSTDN_TERM_CODE_MATRIC,
                      SGBSTDN_TERM_CODE_ADMIT,
                      SGBSTDN_EXP_GRAD_DATE,
                      V_CAMP_CODE,                                   -- CAMPUS
                      SGBSTDN_FULL_PART_IND,
                      SGBSTDN_SESS_CODE,
                      SGBSTDN_RESD_CODE,
                      V_COLL_CODE,                                  -- COLLEGE
                      SGBSTDN_DEGC_CODE_1,
                      REC.MAJOR_CODE,                                 -- MAJOR
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
                      REC.DEPT_CODE,                             -- DEPARTMENT
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
                      REC.PROGRAM_CD,                               -- PROGRAM
                      V_TERM_CODE_CTLG,                        -- TERM_CATALOG
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
                      V_CURR_RULE,                              --CURRENT RULE
                      V_CMJR_RULE,                              --  MAJOR RULE
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
                      'BannerIT',
                      USER,
                      SGBSTDN_SCPC_CODE
                 FROM sgbstdn a
                WHERE     a.sgbstdn_pidm = REC.PIDM_CD
                      AND a.sgbstdn_term_code_eff =
                             (SELECT MAX (b.sgbstdn_term_code_eff)
                                FROM sgbstdn b
                               WHERE b.sgbstdn_pidm = a.sgbstdn_pidm);
         END IF;

         UPDATE TRANSFER_STUDENT_PROGRAM
            SET notes = 'Y'
          WHERE pidm_cd = rec.pidm_cd;
      EXCEPTION
         WHEN OTHERS
         THEN
            v_notes := SQLERRM || '--' || SQLCODE;

            UPDATE TRANSFER_STUDENT_PROGRAM
               SET notes = 'N' || v_notes
             WHERE pidm_cd = rec.pidm_cd;

            v_notes := '';
            RETURN;
      END;
   END LOOP;
END;

*/

