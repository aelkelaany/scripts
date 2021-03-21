DROP PACKAGE BU_APPS.SYKCMPG;

--
-- SYKCMPG  (Package) 
--
CREATE OR REPLACE PACKAGE BU_APPS.sykcmpg
IS
    i_process_id    NUMBER := 0;
    reply_code      VARCHAR2 (30);
    reply_message   VARCHAR2 (400);

    FUNCTION gjbprun_prm_value (v_job      gjbprun.gjbprun_job%TYPE,
                                v_prm_no   gjbprun.gjbprun_number%TYPE)
        RETURN VARCHAR2;

    PROCEDURE sypcmpg;

    PROCEDURE sypcmpg (p_program         VARCHAR2,
                       p_term_code_eff   VARCHAR2,
                       p_mode            CHAR ,P_PIDM NUMBER DEFAULT NULL);

    PROCEDURE check_log_equation_fit (
        p_program         VARCHAR2,
        p_term_code_eff   VARCHAR2,
        p_std_pidm        NUMBER,
        p_subj_code       VARCHAR2,
        p_crse_numb       VARCHAR2,
        p_seqno           NUMBER,
        p_required_ind    CHAR,
        equv_crse_rec     capp_manipulation_functional.capp_eqvlnt_cur%ROWTYPE);
END;
/
DROP PACKAGE BODY BU_APPS.SYKCMPG;

--
-- SYKCMPG  (Package Body) 
--
CREATE OR REPLACE PACKAGE BODY BU_APPS.SYKCMPG
IS
   FUNCTION GJBPRUN_PRM_VALUE (V_JOB       GJBPRUN.GJBPRUN_JOB%TYPE,
                               V_PRM_NO    GJBPRUN.GJBPRUN_NUMBER%TYPE)
      RETURN VARCHAR2
   IS
      CURSOR GJBPRUN_C (P_JOB         GENERAL.GJBPRUN.GJBPRUN_JOB%TYPE,
                        P_PARAM_NO    VARCHAR2)
      IS
         SELECT                                                      /*LOWER*/
               GJBPRUN_VALUE
           FROM GENERAL.GJBPRUN
          WHERE     GJBPRUN_JOB = P_JOB
                AND GJBPRUN_ONE_UP_NO = (SELECT MAX (GJBPRUN_ONE_UP_NO)
                                           FROM GENERAL.GJBPRUN T
                                          WHERE T.GJBPRUN_JOB = P_JOB)
                AND GJBPRUN_NUMBER = P_PARAM_NO;

      V_PRM_VALUE   GJBPRUN.GJBPRUN_VALUE%TYPE;
   BEGIN
      OPEN GJBPRUN_C (V_JOB, V_PRM_NO);

      FETCH GJBPRUN_C INTO V_PRM_VALUE;

      CLOSE GJBPRUN_C;

      RETURN V_PRM_VALUE;
   END GJBPRUN_PRM_VALUE;

   PROCEDURE SYPCMPG
   IS
      LOG_MAIN_REC   CAPP_MNPL_LOG_MAIN%ROWTYPE;
      L_PIDM         NUMBER (8);
   BEGIN
      --fetch new process_id
      I_PROCESS_ID := capp_manipulation_functional.get_new_process_id;
      LOG_MAIN_REC.PROCESS_ID := I_PROCESS_ID;
      DBMS_OUTPUT.PUT_LINE ('processID' || I_PROCESS_ID);
      LOG_MAIN_REC.PROCESS_PURPOSE_IND := GJBPRUN_PRM_VALUE ('SYPCMPG', '03');
      LOG_MAIN_REC.RUNNING_DATE := SYSDATE;
      LOG_MAIN_REC.USER_ID := USER;
      LOG_MAIN_REC.PROCESS_TERMINATION_STATUS := 'R';
      LOG_MAIN_REC.PROGRAM_CODE := GJBPRUN_PRM_VALUE ('SYPCMPG', '01');
      LOG_MAIN_REC.PROGRAM_TERM_CODE_EFF :=
      GJBPRUN_PRM_VALUE ('SYPCMPG', '02');
      CAPP_MANIPULATION_FUNCTIONAL.LOG_MAIN_INSERT (LOG_MAIN_REC,
                                                    REPLY_CODE,
                                                    REPLY_MESSAGE);
      DBMS_OUTPUT.PUT_LINE (
         'LOG MAIN' || REPLY_CODE || '-----' || REPLY_MESSAGE);

      IF REPLY_CODE = '0'
      THEN
         SYPCMPG (GJBPRUN_PRM_VALUE ('SYPCMPG', '01'),
                  GJBPRUN_PRM_VALUE ('SYPCMPG', '02'),
                  GJBPRUN_PRM_VALUE ('SYPCMPG', '03'),
                  NVL(F_GET_PIDM (GJBPRUN_PRM_VALUE ('SYPCMPG', '04')),0));
      END IF;
   END SYPCMPG;

   PROCEDURE SYPCMPG (P_PROGRAM          VARCHAR2,
                      P_TERM_CODE_EFF    VARCHAR2,
                      P_MODE             CHAR,
                      P_PIDM             NUMBER DEFAULT NULL)
   IS
      L_SEQNO   NUMBER (3) := 1;
   BEGIN
      DBMS_OUTPUT.PUT_LINE (
            'parameters'
         || I_PROCESS_ID
         || '-----'
         || P_PROGRAM
         || '-----'
         || P_TERM_CODE_EFF);
      CAPP_MANIPULATION_FUNCTIONAL.FETCH_PROGRAMS_DATA (I_PROCESS_ID,
                                                        P_PROGRAM,
                                                        P_TERM_CODE_EFF,P_PIDM,
                                                        REPLY_CODE,
                                                        REPLY_MESSAGE);
      DBMS_OUTPUT.PUT_LINE (
         'AFTER LOG HEADER' || REPLY_CODE || '-----' || REPLY_MESSAGE);

      -- stop process if error has been occured
      IF REPLY_CODE <> 0
      THEN
         UPDATE CAPP_MNPL_LOG_MAIN
            SET PROCESS_TERMINATION_STATUS = 'E',
                PROCESS_TERMINATION_message = REPLY_MESSAGE
          WHERE PROCESS_ID = i_PROCESS_ID;

         RETURN;
      END IF;

      -- start getting logged students (PROGRAM_CODE, PROGRAM_TERM_CODE_EFF,STD_PIDM )
      FOR STUDENT_REC
         IN CAPP_MANIPULATION_FUNCTIONAL.GET_LOGGED_PIDMS (I_PROCESS_ID)
      LOOP
        <<STUDENT>>
         L_SEQNO := 1;

         --STUDENT_REC.STD_PIDM
         FOR PROG_CRSE_REC
            IN CAPP_MANIPULATION_FUNCTIONAL.CAPP_COURSES_CUR (
                  STUDENT_REC.PROGRAM_CODE,
                  STUDENT_REC.PROGRAM_TERM_CODE_EFF)
         LOOP
           <<PROGRAM_CRSE>>
            --,REQUIRED_IND

            --GET EQVI_CORSES (SEQ_NO ,EQUV_SUBJ_CODE, EQUV_CRSE_NUMB, EQUV_HR, JOIN_OPERATOR, RIGHT_BRACKET, LEFT_BRACKET, ACTIVITY_DATE, USER_ID)
            DBMS_OUTPUT.PUT_LINE (
                  'parameters 2: '
               || STUDENT_REC.PROGRAM_CODE
               || '-----'
               || STUDENT_REC.PROGRAM_TERM_CODE_EFF
               || '-----'
               || PROG_CRSE_REC.AREA_CODE
               || '-----'
               || PROG_CRSE_REC.SUBJ_CODE
               || '-----'
               || PROG_CRSE_REC.CRSE_NUMB);

            --   l_seqno := 1;

            FOR EQUV_CRSE_REC IN CAPP_MANIPULATION_FUNCTIONAL.CAPP_EQVLNT_CUR (
                                    STUDENT_REC.PROGRAM_CODE,
                                    STUDENT_REC.PROGRAM_TERM_CODE_EFF,
                                    PROG_CRSE_REC.AREA_CODE,
                                    PROG_CRSE_REC.SUBJ_CODE,
                                    PROG_CRSE_REC.CRSE_NUMB)
            LOOP
              <<EQUV_CRSE>>
               DBMS_OUTPUT.PUT_LINE (
                     'parameters 3: '
                  || PROG_CRSE_REC.SUBJ_CODE
                  || '-----'
                  || PROG_CRSE_REC.CRSE_NUMB
                  || '-----eqiv'
                  || EQUV_CRSE_REC.EQUV_SUBJ_CODE
                  || '-'
                  || EQUV_CRSE_REC.EQUV_CRSE_NUMB
                  || '-'
                  || L_SEQNO);
               CHECK_LOG_EQUATION_FIT (STUDENT_REC.PROGRAM_CODE,
                                       STUDENT_REC.PROGRAM_TERM_CODE_EFF,
                                       STUDENT_REC.STD_PIDM,
                                       PROG_CRSE_REC.SUBJ_CODE,
                                       PROG_CRSE_REC.CRSE_NUMB,
                                       L_SEQNO,
                                       PROG_CRSE_REC.REQUIRED_IND,
                                       EQUV_CRSE_REC);
               L_SEQNO := L_SEQNO + 1;

               -- stop process if error has been occured
               IF REPLY_CODE <> 0
               THEN
                  UPDATE CAPP_MNPL_LOG_MAIN
                     SET PROCESS_TERMINATION_STATUS = 'E',
                         PROCESS_TERMINATION_message = REPLY_MESSAGE
                   WHERE PROCESS_ID = i_PROCESS_ID;

                  RETURN;
               END IF;
            END LOOP;
         END LOOP;
      END LOOP;

      --if process mode is updating continue ...
      IF P_MODE = 'U'
      THEN
         FOR CAPP_MNPL_LOG_DET_REC
            IN CAPP_MANIPULATION_FUNCTIONAL.GET_IEQ_FIT_DATA_CUR (
                  I_PROCESS_ID)
         LOOP
           <<INTERNAL_EQUATION>>
            CAPP_MANIPULATION_FUNCTIONAL.VALIDATE_INSERT_SMRSSUB (
               CAPP_MNPL_LOG_DET_REC,
               REPLY_CODE,
               REPLY_MESSAGE);

            DBMS_OUTPUT.PUT_LINE (
                  'parameters 4: '
               || CAPP_MNPL_LOG_DET_REC.STD_PIDM
               || '-----'
               || CAPP_MNPL_LOG_DET_REC.LHS_SUBJ_CODE
               || CAPP_MNPL_LOG_DET_REC.LHS_CRSE_NUMB
               || '-----eqiv'
               || CAPP_MNPL_LOG_DET_REC.RHS_SUBJ_CODE
               || CAPP_MNPL_LOG_DET_REC.RHS_CRSE_NUMB
               || '-----'
               || CAPP_MNPL_LOG_DET_REC.RHS_EQVLNT_HR
               || '-----'
               || REPLY_CODE
               || '***'
               || REPLY_MESSAGE);

            -- stop process if error has been occured
            IF REPLY_CODE <> 0
            THEN
               UPDATE CAPP_MNPL_LOG_MAIN
                  SET PROCESS_TERMINATION_STATUS = 'E',
                      PROCESS_TERMINATION_message = REPLY_MESSAGE
                WHERE PROCESS_ID = i_PROCESS_ID;

               RETURN;
            END IF;
         END LOOP;

         --ALSO TREAT WITH TRANSFER COURSE
         CAPP_MANIPULATION_FUNCTIONAL.VALIDATE_INSERT_SHRTRCE (I_PROCESS_ID,
                                                               REPLY_CODE,
                                                               REPLY_MESSAGE);
         DBMS_OUTPUT.PUT_LINE (
               'parameters 5: SHRTRCE '
            || REPLY_CODE
            || '-----'
            || REPLY_MESSAGE
            || '-----eqiv');

         -- stop process if error has been occured
         IF REPLY_CODE <> 0
         THEN
            UPDATE CAPP_MNPL_LOG_MAIN
               SET PROCESS_TERMINATION_STATUS = 'E',
                   PROCESS_TERMINATION_message = REPLY_MESSAGE
             WHERE PROCESS_ID = i_PROCESS_ID;

            RETURN;
         END IF;

         -- LOG PASSED AND NOT USED COURSES
         CAPP_MANIPULATION_FUNCTIONAL.LOG_NOT_USED_INSERT (I_PROCESS_ID,
                                                           REPLY_CODE,
                                                           REPLY_MESSAGE);
         DBMS_OUTPUT.PUT_LINE (
               'parameters 7: NOT_USED '
            || REPLY_CODE
            || '-----'
            || REPLY_MESSAGE);

         -- stop process if error has been occured
         IF REPLY_CODE <> 0
         THEN
            UPDATE CAPP_MNPL_LOG_MAIN
               SET PROCESS_TERMINATION_STATUS = 'E',
                   PROCESS_TERMINATION_message = REPLY_MESSAGE
             WHERE PROCESS_ID = i_PROCESS_ID;

            RETURN;
         END IF;
      --START REPLACING TO NEW PROGRAM
      /* CAPP_MANIPULATION_FUNCTIONAL.REPLACE_PROGRAM (I_PROCESS_ID,
                                                     REPLY_CODE,
                                                     REPLY_MESSAGE);
       DBMS_OUTPUT.PUT_LINE (
              'parameters 8: REPLACE_PROGRAM '
           || REPLY_CODE
           || '-----'
           || REPLY_MESSAGE
            );*/
      END IF;
   --
   END SYPCMPG;

   PROCEDURE CHECK_LOG_EQUATION_FIT (
      P_PROGRAM          VARCHAR2,
      P_TERM_CODE_EFF    VARCHAR2,
      P_STD_PIDM         NUMBER,
      P_SUBJ_CODE        VARCHAR2,
      P_CRSE_NUMB        VARCHAR2,
      P_SEQNO            NUMBER,
      P_REQUIRED_IND     CHAR,
      EQUV_CRSE_REC      CAPP_MANIPULATION_FUNCTIONAL.CAPP_EQVLNT_CUR%ROWTYPE)
   IS
      L_RESULT         CHAR (4);
      LOG_DETAIL_REC   CAPP_MNPL_LOG_DETAIL%ROWTYPE;
      L_SUB_VALUE      VARCHAR2 (20);
      l_prv_fit        VARCHAR2 (30) := '';
   BEGIN
      DBMS_OUTPUT.PUT_LINE (
            'PROCESS_ID'
         || I_PROCESS_ID
         || '  , P_STD_PIDM'
         || P_STD_PIDM
         || '  ,P_SEQNO'
         || P_SEQNO);
      LOG_DETAIL_REC.PROCESS_ID := I_PROCESS_ID;
      LOG_DETAIL_REC.STD_PIDM := P_STD_PIDM;
      LOG_DETAIL_REC.SEQNO := P_SEQNO;
      LOG_DETAIL_REC.LHS_SUBJ_CODE := P_SUBJ_CODE;
      LOG_DETAIL_REC.LHS_CRSE_NUMB := P_CRSE_NUMB;
      DBMS_OUTPUT.PUT_LINE (
            'CREDIT_HR'
         || CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_CREDIT_HR (P_SUBJ_CODE,
                                                               P_CRSE_NUMB));
      LOG_DETAIL_REC.LHS_CREDIT_HR :=
         CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_CREDIT_HR (P_SUBJ_CODE,
                                                            P_CRSE_NUMB);
      LOG_DETAIL_REC.REQUIRED_IND := P_REQUIRED_IND;
      LOG_DETAIL_REC.RHS_SUBJ_CODE := EQUV_CRSE_REC.EQUV_SUBJ_CODE;
      LOG_DETAIL_REC.RHS_CRSE_NUMB := EQUV_CRSE_REC.EQUV_CRSE_NUMB;
      LOG_DETAIL_REC.RHS_SEQNO := 0;
      LOG_DETAIL_REC.RHS_EQVLNT_HR := EQUV_CRSE_REC.EQUV_HR;
      LOG_DETAIL_REC.DATA_TARGET := '';
      --


      L_RESULT :=
         CAPP_MANIPULATION_FUNCTIONAL.CHECK_COURSE_FIT (
            P_STD_PIDM,
            EQUV_CRSE_REC.EQUV_SUBJ_CODE,
            EQUV_CRSE_REC.EQUV_CRSE_NUMB);
      DBMS_OUTPUT.PUT_LINE ('L_RESULT' || L_RESULT);

      IF L_RESULT = 'P'
      THEN -- since the course is already passed , check if it's not passed before in earlier iteration
         l_prv_fit :=
            CAPP_MANIPULATION_FUNCTIONAL.check_previous_fit (
               i_process_id,
               P_STD_PIDM,
               EQUV_CRSE_REC.EQUV_SUBJ_CODE,
               EQUV_CRSE_REC.EQUV_CRSE_NUMB);

         IF l_prv_fit != 'N'
         THEN
            LOG_DETAIL_REC.MAPPING_SUCCESS_IND := 'V';
            LOG_DETAIL_REC.GRDE_CODE_FINAL :=
               CAPP_MANIPULATION_FUNCTIONAL.F_GET_FINAL_GRADE (
                  P_STD_PIDM,
                  EQUV_CRSE_REC.EQUV_SUBJ_CODE,
                  EQUV_CRSE_REC.EQUV_CRSE_NUMB);
            LOG_DETAIL_REC.FAILURE_MESSAGE :=
               'Has Been Fit Before' || l_prv_fit;
         ELSE
            LOG_DETAIL_REC.MAPPING_SUCCESS_IND := 'Y';
            LOG_DETAIL_REC.GRDE_CODE_FINAL :=
               CAPP_MANIPULATION_FUNCTIONAL.F_GET_FINAL_GRADE (
                  P_STD_PIDM,
                  EQUV_CRSE_REC.EQUV_SUBJ_CODE,
                  EQUV_CRSE_REC.EQUV_CRSE_NUMB);
            LOG_DETAIL_REC.FAILURE_MESSAGE := 'Passed The Course';
         END IF;
      ELSIF L_RESULT = 'N'
      THEN
         --CHECK IF THE COURSE IS SUBSTITUDED [INTERNAL]
         L_SUB_VALUE :=
            CAPP_MANIPULATION_FUNCTIONAL.F_CHECK_CRSE_SUB_INT (
               EQUV_CRSE_REC.PROGRAM_CODE,
               EQUV_CRSE_REC.TERM_CODE_EFF,
               P_STD_PIDM,
               EQUV_CRSE_REC.EQUV_SUBJ_CODE,
               EQUV_CRSE_REC.EQUV_CRSE_NUMB);

         IF L_SUB_VALUE = 'N'
         THEN
            --CHECK IF THE COURSE IS SUBSTITUDED [EXTERNAL]
            L_SUB_VALUE :=
               CAPP_MANIPULATION_FUNCTIONAL.F_CHECK_CRSE_SUB_EXT (
                  P_STD_PIDM,
                  EQUV_CRSE_REC.EQUV_SUBJ_CODE,
                  EQUV_CRSE_REC.EQUV_CRSE_NUMB);

            IF L_SUB_VALUE = 'Y'
            THEN
               LOG_DETAIL_REC.MAPPING_SUCCESS_IND := 'Y';
               LOG_DETAIL_REC.GRDE_CODE_FINAL := 'ãÚ';
               LOG_DETAIL_REC.FAILURE_MESSAGE := 'Transfer Course';
            ELSE
               LOG_DETAIL_REC.MAPPING_SUCCESS_IND := 'N';
               LOG_DETAIL_REC.GRDE_CODE_FINAL := '';
               LOG_DETAIL_REC.FAILURE_MESSAGE := 'Not Studied';
            END IF;
         ELSE
            LOG_DETAIL_REC.MAPPING_SUCCESS_IND := 'Y';
            LOG_DETAIL_REC.GRDE_CODE_FINAL := 'ãÏ';
            LOG_DETAIL_REC.FAILURE_MESSAGE := L_SUB_VALUE;
         END IF;
      ELSE
         LOG_DETAIL_REC.MAPPING_SUCCESS_IND := 'N';
         LOG_DETAIL_REC.GRDE_CODE_FINAL :=
            CAPP_MANIPULATION_FUNCTIONAL.F_GET_FINAL_GRADE (
               P_STD_PIDM,
               EQUV_CRSE_REC.EQUV_SUBJ_CODE,
               EQUV_CRSE_REC.EQUV_CRSE_NUMB);
         LOG_DETAIL_REC.FAILURE_MESSAGE := 'Did Not Pass The Course';
      END IF;

      CAPP_MANIPULATION_FUNCTIONAL.LOG_DETAIL_INSERT (LOG_DETAIL_REC,
                                                      REPLY_CODE,
                                                      REPLY_MESSAGE);
      DBMS_OUTPUT.PUT_LINE (
            'PARAMETERS 4: '
         || EQUV_CRSE_REC.EQUV_SUBJ_CODE
         || '-----'
         || EQUV_CRSE_REC.EQUV_CRSE_NUMB
         || '-----'
         || P_SEQNO
         || '-----'
         || L_RESULT
         || '-----'
         || REPLY_CODE
         || '-----'
         || REPLY_MESSAGE);
   END CHECK_LOG_EQUATION_FIT;
END;
/
