/* Formatted on 12/4/2022 9:39:28 AM (QP5 v5.371) */
DECLARE
    l_subjCode           VARCHAR2 (5) := 'ENGL';
    l_crseNumb           VARCHAR (5) := '1001';
    l_credit_hrs         NUMBER (2) := 0;
    l_desc               VARCHAR2 (30) := 'English Language 1';
    REPLY_CODE           VARCHAR2 (50);
    REPLY_message        VARCHAR2 (500);
    l_row_count          NUMBER := 0;

    CURSOR GET_TRNS_HEADER IS
          SELECT DISTINCT COL05     STD_PIDM
            FROM bu_dev.tmp_tbl_kilany2
           WHERE /* COL01 IN ('439002219',
                            '439004175',
                            '439015751',
                            '443032749')
              AND */
                     NOT EXISTS
                         (SELECT '1'
                            FROM SHRTRCE
                           WHERE     SHRTRCE_PIDM = COL05
                                 AND SHRTRCE_SUBJ_CODE || SHRTRCE_CRSE_NUMB =
                                     'ENGL1001')
                  --  AND COL05=199880
                 --AND ROWNUM < 51
        ORDER BY 1;



    L_TRIT_SEQ_NO        SHRTRIT.SHRTRIT_SEQ_NO%TYPE;
    L_TRAM_SEQ_NO        SHRTRAM.SHRTRAM_SEQ_NO%TYPE;
    L_TRCR_SEQ_NO        SHRTRCR.SHRTRCR_SEQ_NO%TYPE;
    L_TRCE_SEQ_NO        SHRTRCR.SHRTRCR_SEQ_NO%TYPE;

    CURSOR CHECK_CURRENT_UNI (P_STD_PIDM NUMBER)
    IS
        SELECT SHRTRIT_SEQ_NO
          FROM SHRTRIT
         WHERE     SHRTRIT_SBGI_CODE =
                   F_GET_PARAM ('GENERAL', 'SBGI_CODE', 1)
               AND SHRTRIT_PIDM = P_STD_PIDM;

    L_CHECK_UNI          SHRTRIT.SHRTRIT_SEQ_NO%TYPE;
    L_EARNED_HRS         NUMBER (3);
    l_level              VARCHAR2 (20);
    l_term               VARCHAR2 (20);
    L_STD_PIDM           NUMBER (9);

    CURSOR GET_CRD_HR_SUM IS
        SELECT SUM (SHRTRCE_CREDIT_HOURS)     EARNED_HRS
          FROM SHRTRCE
         WHERE     SHRTRCE_PIDM = L_STD_PIDM
               AND SHRTRCE_TRIT_SEQ_NO = L_TRIT_SEQ_NO
               AND SHRTRCE_TRAM_SEQ_NO = L_TRAM_SEQ_NO
               AND SHRTRCE_TERM_CODE_EFF = l_term;


    L_TGPA_TRAM_SEQ_NO   SHRTGPA.SHRTGPA_TRAM_SEQ_NO%TYPE := '';

    CURSOR CHECK_CURRENT_TRNS_REC IS
        SELECT SHRTGPA_TRAM_SEQ_NO
          FROM SHRTGPA
         WHERE     SHRTGPA_PIDM = L_STD_PIDM
               AND SHRTGPA_TERM_CODE = L_TERM
               AND SHRTGPA_GPA_TYPE_IND = 'T'
               AND SHRTGPA_LEVL_CODE = l_level
               AND SHRTGPA_TRIT_SEQ_NO = L_TRIT_SEQ_NO;
BEGIN
    FOR H_REC IN GET_TRNS_HEADER
    LOOP
        L_CHECK_UNI := NULL;

        BEGIN
            OPEN CHECK_CURRENT_UNI (H_REC.STD_PIDM);

            FETCH CHECK_CURRENT_UNI INTO L_CHECK_UNI;

            CLOSE CHECK_CURRENT_UNI;

            IF L_CHECK_UNI IS NOT NULL
            THEN
                L_TRIT_SEQ_NO := L_CHECK_UNI;
            ELSE
                SELECT NVL (MAX (SHRTRIT_SEQ_NO), 0) + 1
                  INTO L_TRIT_SEQ_NO
                  FROM SHRTRIT
                 WHERE SHRTRIT_PIDM = H_REC.STD_PIDM;

                INSERT INTO SATURN.SHRTRIT (SHRTRIT_PIDM,
                                            SHRTRIT_SEQ_NO,
                                            SHRTRIT_SBGI_CODE,
                                            SHRTRIT_SBGI_DESC,
                                            SHRTRIT_OFFICIAL_TRANS_IND,
                                            SHRTRIT_TRANS_DATE_RCVD,
                                            SHRTRIT_ACTIVITY_DATE)
                     VALUES (H_REC.STD_PIDM,
                             L_TRIT_SEQ_NO,
                             F_GET_PARAM ('GENERAL', 'SBGI_CODE', 1),
                             '',
                             'Y',
                             SYSDATE,
                             SYSDATE);
            END IF;


            L_TRAM_SEQ_NO := L_TRIT_SEQ_NO + 0;

            ---- hash here for multiple courses on the same process id  /*

            BEGIN
                INSERT INTO SHRTRAM (SHRTRAM_PIDM,
                                     SHRTRAM_TRIT_SEQ_NO,
                                     SHRTRAM_SEQ_NO,
                                     SHRTRAM_LEVL_CODE,
                                     SHRTRAM_ATTN_PERIOD,
                                     SHRTRAM_TERM_CODE_ENTERED,
                                     SHRTRAM_DEGC_CODE,
                                     SHRTRAM_TERM_TYPE,
                                     SHRTRAM_ACCEPTANCE_DATE,
                                     SHRTRAM_ACTIVITY_DATE,
                                     SHRTRAM_ATTN_BEGIN_DATE,
                                     SHRTRAM_ATTN_END_DATE)
                     VALUES (H_REC.STD_PIDM,
                             L_TRIT_SEQ_NO,
                             L_TRAM_SEQ_NO,
                             F_GET_LEVEL (H_REC.STD_PIDM),
                             1,
                             F_GET_PARAM ('GENERAL', 'CURRENT_TERM', 1),
                             F_GET_DEGREE (H_REC.STD_PIDM),
                             '',
                             SYSDATE,
                             SYSDATE,
                             '',
                             '');
            EXCEPTION
                WHEN DUP_VAL_ON_INDEX
                THEN
                    NULL;
            END;

            -- end here ....  */


            SELECT NVL (MAX (SHRTRCR_SEQ_NO), 0) + 1
              INTO L_TRCR_SEQ_NO
              FROM SHRTRCR A, SHRTRIT B, SHRTRAM C
             WHERE     SHRTRCR_PIDM = H_REC.STD_PIDM
                   AND A.SHRTRCR_PIDM = B.SHRTRIT_PIDM
                   AND A.SHRTRCR_PIDM = C.SHRTRAM_PIDM
                   AND A.SHRTRCR_TRIT_SEQ_NO = L_TRIT_SEQ_NO -- B.SHRTRIT_SEQ_NO
                   AND A.SHRTRCR_TRAM_SEQ_NO = L_TRAM_SEQ_NO --C.SHRTRAM_SEQ_NO
                                                            ;



            INSERT INTO SHRTRCR (SHRTRCR_PIDM,
                                 SHRTRCR_TRIT_SEQ_NO,
                                 SHRTRCR_TRAM_SEQ_NO,
                                 SHRTRCR_SEQ_NO,
                                 SHRTRCR_TRANS_COURSE_NAME,
                                 SHRTRCR_TRANS_COURSE_NUMBERS,
                                 SHRTRCR_TRANS_CREDIT_HOURS,
                                 SHRTRCR_TRANS_GRADE,
                                 SHRTRCR_TRANS_GRADE_MODE,
                                 SHRTRCR_ACTIVITY_DATE,
                                 SHRTRCR_LEVL_CODE,
                                 SHRTRCR_TERM_CODE,
                                 SHRTRCR_GROUP,
                                 SHRTRCR_ART_IND,
                                 SHRTRCR_PROGRAM,
                                 SHRTRCR_GROUP_PRIMARY_IND,
                                 SHRTRCR_DUPLICATE,
                                 SHRTRCR_TCRSE_TITLE)
                 VALUES (H_REC.STD_PIDM,
                         L_TRIT_SEQ_NO,
                         L_TRAM_SEQ_NO,
                         L_TRCR_SEQ_NO,
                         l_desc,
                         '',
                         l_credit_hrs,
                         '60',
                         '',
                         SYSDATE,
                         F_GET_LEVEL (H_REC.STD_PIDM),
                         F_GET_PARAM ('GENERAL', 'CURRENT_TERM', 1),
                         '',
                         'O',
                         '......',
                         '',
                         '',
                         '');


            INSERT INTO SATURN.SHRTRCE (SHRTRCE_PIDM,
                                        SHRTRCE_TRIT_SEQ_NO,
                                        SHRTRCE_TRAM_SEQ_NO,
                                        SHRTRCE_SEQ_NO,
                                        SHRTRCE_TRCR_SEQ_NO,
                                        SHRTRCE_TERM_CODE_EFF,
                                        SHRTRCE_LEVL_CODE,
                                        SHRTRCE_SUBJ_CODE,
                                        SHRTRCE_CRSE_NUMB,
                                        SHRTRCE_CRSE_TITLE,
                                        SHRTRCE_CREDIT_HOURS,
                                        SHRTRCE_GRDE_CODE,
                                        SHRTRCE_GMOD_CODE,
                                        SHRTRCE_COUNT_IN_GPA_IND,
                                        SHRTRCE_ACTIVITY_DATE,
                                        SHRTRCE_REPEAT_COURSE,
                                        SHRTRCE_REPEAT_SYS)
                     VALUES (
                                H_REC.STD_PIDM,
                                L_TRIT_SEQ_NO,
                                L_TRAM_SEQ_NO,
                                L_TRCR_SEQ_NO,
                                L_TRCR_SEQ_NO,
                                F_GET_PARAM ('GENERAL', 'CURRENT_TERM', 1),
                                F_GET_LEVEL (H_REC.STD_PIDM),
                                l_subjCode,
                                l_crseNumb,
                                CAPP_MANIPULATION_FUNCTIONAL.F_GET_CRSE_TITLE (
                                    l_subjCode,
                                    l_crseNumb),
                                l_credit_hrs,
                                'ук',
                                'Э',
                                'Y',
                                SYSDATE,
                                NULL,
                                NULL);

            REPLY_CODE := '0';
            REPLY_MESSAGE := 'OK';

            DBMS_OUTPUT.PUT_LINE (
                'REPLY_CODE' || REPLY_CODE || '    >>' || H_REC.STD_PIDM);
            l_row_count := l_row_count + 1;
        EXCEPTION
            WHEN OTHERS
            THEN
                REPLY_CODE := 90;
                REPLY_MESSAGE := SQLERRM || '--'; --|| REC.STD_PIDM || '***' || REC.SEQNO;
                DBMS_OUTPUT.PUT_LINE (
                       'REPLY_CODE'
                    || REPLY_CODE
                    || '*-L_TRIT_SEQ_NO#'
                    || L_TRIT_SEQ_NO
                    || '*-*L_TRAM_SEQ_NO#'
                    || L_TRAM_SEQ_NO
                    || SQLERRM
                    || '>>'
                    || H_REC.STD_PIDM);
        END;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE ('affected rows ' || l_row_count);
END;