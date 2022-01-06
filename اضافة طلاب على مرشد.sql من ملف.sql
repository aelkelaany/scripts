  update BU_DEV.TMP_TBL_kilany set  COL02 =f_get_pidm(COL01);
 update BU_DEV.TMP_TBL_kilany set  COL04 =f_get_pidm('1595');
DECLARE
    CURSOR GET_STUDENTS IS SELECT COL02 PIDM, COL04 ADV FROM BU_DEV.TMP_TBL_kilany;

    l_FALIURE_COUNTER    NUMBER:=0;
    L_SUCCSESS_COUNTER   NUMBER:=0;
BEGIN
    FOR STD IN GET_STUDENTS
    LOOP
        BEGIN
            INSERT INTO SATURN.SGRADVR (SGRADVR_PIDM,
                                        SGRADVR_TERM_CODE_EFF,
                                        SGRADVR_ADVR_PIDM,
                                        SGRADVR_ADVR_CODE,
                                        SGRADVR_PRIM_IND,
                                        SGRADVR_ACTIVITY_DATE)
                 VALUES (STD.PIDM,
                         '144310',
                         STD.ADV,
                          '„—‘œ',
           'Y',
           SYSDATE );

            L_SUCCSESS_COUNTER := L_SUCCSESS_COUNTER + 1;
            update  BU_DEV.TMP_TBL_kilany
   SET COL05 = 'DONE'
   where col02=STD.PIDM ;
        EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN 
        UPDATE SATURN.SGRADVR SET SGRADVR_ADVR_PIDM=STD.ADV
        WHERE SGRADVR_PIDM=STD.PIDM;
        DBMS_OUTPUT.put_line (
        STD.PIDM || '<<-ROWS>>' || SQL%ROWCOUNT);
            WHEN OTHERS
            THEN
                l_FALIURE_COUNTER := l_FALIURE_COUNTER + 1;
        END;
    END LOOP;

    DBMS_OUTPUT.put_line (
        'S '||L_SUCCSESS_COUNTER || '<<--->>' || l_FALIURE_COUNTER||' F');
END;