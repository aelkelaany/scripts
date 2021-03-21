/* Formatted on 02/12/2020 14:20:54 (QP5 v5.227.12220.39754) */
DECLARE
   CURSOR MAIN_CUR
   IS
        SELECT DISTINCT
               SCRRTST_SUBJ_CODE || SCRRTST_CRSE_NUMB MAIN_COURSE,
               MAIN.SCBCRSE_TITLE MAIN_TITLE,
               SCRRTST_SUBJ_CODE_PREQ || SCRRTST_CRSE_NUMB_PREQ PREQ_COURSE,
               PREQ.SCBCRSE_TITLE PREQ_TITLE
          FROM SCRRTST, SCBCRSE MAIN, SCBCRSE PREQ
         WHERE     EXISTS
                      (SELECT '1'
                         FROM scbcrse
                        WHERE     scbcrse_SUBJ_CODE || scbcrse_CRSE_NUMB =
                                        --  SCRRTST_SUBJ_CODE || SCRRTST_CRSE_NUMB
                                        SCRRTST_SUBJ_CODE_PREQ
                                     || SCRRTST_CRSE_NUMB_PREQ
                              AND scbcrse_dept_code IN
                                     ('CS',
                                      'ENGL',
                                      'BIO',
                                      'ACC',
                                      'BUS',
                                      'ARAB',
                                      'MATH',
                                      'ISLM',
                                      'CHEM',
                                      'PHYS',
                                      'NUTR',
                                      'FASH',
                                      'LAW',
                                      'MIS',
                                      'MKT',
                                      'IT',
                                      'IS',
                                      'IDES'))
               AND SCRRTST_SUBJ_CODE || SCRRTST_CRSE_NUMB =
                      MAIN.scbcrse_SUBJ_CODE || MAIN.scbcrse_CRSE_NUMB
               AND SCRRTST_SUBJ_CODE_PREQ || SCRRTST_CRSE_NUMB_PREQ =
                      PREQ.scbcrse_SUBJ_CODE || PREQ.scbcrse_CRSE_NUMB
      ORDER BY 1;

   CURSOR EQV_CUR (
      P_COURSE    VARCHAR2,
      M_COURSE    VARCHAR2)
   IS
      SELECT DISTINCT EQUV_SUBJ_CODE || EQUV_CRSE_NUMB MISSING ,SCBCRSE_TITLE MISSING_TITLE
        FROM PROGRAM_EQUV_COURSES ,SCBCRSE
       WHERE     COURSE_SUBJ_CODE || COURSE_CRSE_NUMB = P_COURSE
             AND TERM_CODE_EFF IN ('143810')
             AND    scbcrse_SUBJ_CODE ||  scbcrse_CRSE_NUMB=EQUV_SUBJ_CODE || EQUV_CRSE_NUMB
             AND SCBCRSE_EFF_TERM=(SELECT MAX(SCBCRSE_EFF_TERM) FROM SCBCRSE WHERE scbcrse_SUBJ_CODE ||  scbcrse_CRSE_NUMB=EQUV_SUBJ_CODE || EQUV_CRSE_NUMB)
             AND NOT EXISTS
                        (SELECT '1'
                           FROM SCRRTST
                          WHERE     SCRRTST_SUBJ_CODE || SCRRTST_CRSE_NUMB =
                                       M_COURSE
                                AND    SCRRTST_SUBJ_CODE_PREQ
                                    || SCRRTST_CRSE_NUMB_PREQ =
                                       EQUV_SUBJ_CODE || EQUV_CRSE_NUMB);

BEGIN
   DBMS_OUTPUT.put_line ('MAIN COURSE ,MAIN TITLE, PREQ COURSE ,PREQ TITLE, MISSING ,MISSING_TITLE');


   FOR M IN MAIN_CUR
   LOOP
      FOR Q IN EQV_CUR (M.PREQ_COURSE, M.MAIN_COURSE)
      LOOP
         /*DBMS_OUTPUT.put_line (
               'MAIN COURSE : '
            || M.MAIN_COURSE
            || ' PREQ COURSE :'
            || M.PREQ_COURSE
            || ' MISSING :'
            || Q.MISSING);*/
         DBMS_OUTPUT.put_line (
            M.MAIN_COURSE || ' ,'|| M.MAIN_TITLE || ' ,'|| M.PREQ_COURSE || ' ,' ||M.PREQ_TITLE||' ,' || Q.MISSING ||' ,'|| Q.MISSING_TITLE);
      END LOOP;
   END LOOP;
END;