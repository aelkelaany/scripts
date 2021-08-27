/* Formatted on 09/08/2021 09:22:13 (QP5 v5.227.12220.39754) */
/* Validation */

DECLARE
   l_reply_code            VARCHAR (100);
   l_reply_message         VARCHAR (100);
   l_APPLICANT_CHOICE_NO   NUMBER;

   CURSOR get_std
   IS
      SELECT col01 pidm
        FROM BU_DEV.TMP_TBL_KILANY_adm
       WHERE col04 = 'CNT' and col05 is null;

BEGIN
   FOR rec IN get_std
   LOOP
      -- check there is cancel update decision exist
      BEGIN
         SELECT APPLICANT_CHOICE_NO
           INTO l_reply_message
           FROM VW_APPLICANT_CHOICES
          WHERE     APPLICANT_PIDM = rec.pidm
                AND APPLICANT_DECISION = 'CU'
              and rownum<2 ;

         IF l_reply_message IS NOT NULL
         THEN
          DBMS_OUTPUT.put_line ('OK '||l_reply_message ||'**'|| rec.pidm);
          null;
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            DBMS_OUTPUT.put_line ('CU  NOT found  '||l_reply_message||'**' || rec.pidm);
      END;

      BEGIN                                    -- check there is a QA is exist
         SELECT APPLICANT_CHOICE_NO
           INTO l_APPLICANT_CHOICE_NO
           FROM VW_APPLICANT_CHOICES
          WHERE APPLICANT_PIDM = rec.pidm AND APPLICANT_DECISION = 'QA';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            DBMS_OUTPUT.put_line ('No data  ' || rec.pidm);
      END;
      BEGIN                                    -- check there is a QA is exist
         SELECT '0'
           INTO l_APPLICANT_CHOICE_NO
           FROM  adm_student_confirmation
          WHERE ADMIT_TERM='144310' and APPLICANT_PIDM = rec.pidm  ;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            DBMS_OUTPUT.put_line ('No Confirmation  ' || rec.pidm);
      END;
   END LOOP;
END;
-------************-------------**************------------************----------************
/* õExecution procedure */

DECLARE
   l_reply_code            VARCHAR (100);
   l_reply_message         VARCHAR (100);
   l_APPLICANT_CHOICE_NO   NUMBER;

   CURSOR get_std
   IS
      SELECT col01 pidm
        FROM ccccc
       WHERE col04 = 'CNT' and col05 is null ;
l_cntrow number ;
BEGIN
   FOR rec IN get_std
   LOOP
      BEGIN
         DELETE SARAPPD
          WHERE SARAPPD_APDC_CODE = 'CU' AND SARAPPD_pidm = rec.pidm;
          l_cntrow:=sql%rowcount ;
           DBMS_OUTPUT.put_line ('PIDM : '||rec.pidm ||'Deleted rows '||l_cntrow);
           l_cntrow:=-1;
      END;
   END LOOP;
END;

--cehck 

select * from  BU_DEV.TMP_TBL_KILANY_adm
where   exists (select '1' from VW_APPLICANT_CHOICES where APPLICANT_DECISION='QA' ) ;

select * from  BU_DEV.TMP_TBL_KILANY_adm
where (select count(*) from VW_APPLICANT_CHOICES where APPLICANT_DECISION='QA'  and APPLICANT_PIDM=col01)>1 ;

 select * from BU_DEV.TMP_TBL_KILANY_adm

where col01   in (select applicant_pidm from adm_student_confirmation
) ;