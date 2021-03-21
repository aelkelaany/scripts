/* Formatted on 4/12/2020 4:03:04 PM (QP5 v5.354) */
 /*
 DROP TABLE CRSE_EQV
CREATE TABLE CRSE_EQV (
LHS_SUBJ_CODE VARCHAR2(4) ,
LHS_CRSE_NUMB VARCHAR2(5),
RHS_SUBJ_CODE VARCHAR2(4) ,
RHS_CRSE_NUMB VARCHAR2(4)  ,EQUV_HR NUMBER(1))
*/

DECLARE
    CURSOR GET_HEADER IS
        SELECT DISTINCT PROGRAM_CODE,
                        TERM_CODE_EFF,
                        AREA_CODE,
                        AREA_PRIORITY,
                        SUBJ_CODE,
                        CRSE_NUMB
          FROM PROGRAM_COURSES;

    CURSOR GET_DETAILS (P_SUB_CODE VARCHAR2, P_CRSE_NUMB VARCHAR2)
    IS
        SELECT DISTINCT RHS_SUBJ_CODE, RHS_CRSE_NUMB
          FROM CRSE_EQV
         WHERE LHS_SUBJ_CODE = P_SUB_CODE AND LHS_CRSE_NUMB = P_CRSE_NUMB;

    L_SEQ_NO   NUMBER (3);
BEGIN
    FOR HEADER_REC IN GET_HEADER
    LOOP
       <<HEADER>>
        L_SEQ_NO := 1;

        FOR DETAIL_REC IN GET_DETAILS
        LOOP
           <<DETAILS>>
            BEGIN
                INSERT INTO PROGRAM_EQUV_COURSES (PROGRAM_CODE,
                                                  TERM_CODE_EFF,
                                                  AREA_CODE,
                                                  COURSE_SUBJ_CODE,
                                                  COURSE_CRSE_NUMB,
                                                  SEQ_NO,
                                                  EQUV_SUBJ_CODE,
                                                  EQUV_CRSE_NUMB,
                                                  EQUV_HR,
                                                  JOIN_OPERATOR,
                                                  RIGHT_BRACKET,
                                                  LEFT_BRACKET,
                                                  ACTIVITY_DATE,
                                                  USER_ID)
                     VALUES (HEADER_REC.PROGRAM_CODE,
                             HEADER_REC.TERM_CODE_EFF,
                             HEADER_REC.AREA_CODE,
                             HEADER_REC.COURSE_SUBJ_CODE,
                             HEADER_REC.COURSE_CRSE_NUMB,
                             L_SEQ_NO,
                             DETAIL_REC.RT_SUBJ_CODE,
                             DETAIL_REC.RT_CRSE_NUMB,
                             DETAIL_REC.EQUV_HR,
                             'OR',
                             '',
                             '',
                             SYSDATE,
                             'SAISUSR');

                L_SEQ_NO := L_SEQ_NO + 1;
            EXCEPTION
                WHEN OTHERS
                THEN
                    DBMS_OUTPUT.put_line (SQLERRM || '-----' || SQLCODE);
                    RETURN;
            END;
        END LOOP;
    END LOOP;
END;