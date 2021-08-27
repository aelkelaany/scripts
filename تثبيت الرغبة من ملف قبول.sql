/* Validation */
DECLARE
   l_reply_code            VARCHAR (100);
   l_reply_message         VARCHAR (100);
   l_APPLICANT_CHOICE_NO   NUMBER;

   CURSOR get_std
   IS
      SELECT col01 pidm
        FROM BU_DEV.TMP_TBL_KILANY_adm
       WHERE col04 = 'CU' and col05 is null;

BEGIN
   FOR rec IN get_std
   LOOP
   -- check there is no any cancel update decision exist
   BEGIN 
      
      
      
         SELECT 'x'
           INTO l_reply_message
           FROM VW_APPLICANT_CHOICES
          WHERE APPLICANT_PIDM = rec.pidm AND APPLICANT_DECISION = 'CU'
          and rownum<2;
          if l_reply_message is not null then 
           DBMS_OUTPUT.put_line (' ''' || rec.pidm||'''');
           end if ; 
          

         
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
           DBMS_OUTPUT.put_line ('OK '|| rec.pidm);
          null;
      END;
      
      BEGIN -- check there is a QA is exist
      
      
      
         SELECT APPLICANT_CHOICE_NO
           INTO l_APPLICANT_CHOICE_NO
           FROM VW_APPLICANT_CHOICES
          WHERE APPLICANT_PIDM = rec.pidm AND APPLICANT_DECISION = 'QA';

         
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            DBMS_OUTPUT.put_line ('No data  ' || rec.pidm);
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
        FROM BU_DEV.TMP_TBL_KILANY_adm
       WHERE col04 = 'CU' and col05 is null;

BEGIN
   FOR rec IN get_std
   LOOP
      BEGIN
         SELECT APPLICANT_CHOICE_NO
           INTO l_APPLICANT_CHOICE_NO
           FROM VW_APPLICANT_CHOICES
          WHERE APPLICANT_PIDM = rec.pidm AND APPLICANT_DECISION = 'QA';

         DELETE FROM adm_student_confirmation
               WHERE ADMIT_TERM = '144310' AND APPLICANT_PIDM = rec.pidm;

         pg_quota.p_add_decision ('144310',
                                  rec.pidm,
                                  l_APPLICANT_CHOICE_NO,
                                  'CU',
                                  l_reply_code,
                                  l_reply_message);
         DBMS_OUTPUT.put_line (l_reply_code);
         DBMS_OUTPUT.put_line (l_reply_message);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            DBMS_OUTPUT.put_line ('No data  ' || rec.pidm);
      END;
   END LOOP;
END;

---------check--------------

SELECT 
  a.*
FROM BU_APPS.VW_APPLICANT_CHOICES a
WHERE
ADMIT_TERM = '144310'
 AND APPLICANT_PIDM in (select col01 from BU_DEV.TMP_TBL_KILANY_adm where col04='CU')
 and applicant_decision='QA'
 and exists (select 'x'   FROM BU_APPS.VW_APPLICANT_CHOICES
WHERE
ADMIT_TERM = '144310' and APPLICANT_PIDM=a.APPLICANT_PIDM
and APPLICANT_CHOICE_NO<a.APPLICANT_CHOICE_NO
and applicant_decision!='CU')
 order by 1,3 ;
 
 
 select * from BU_DEV.TMP_TBL_KILANY_adm

where col01   in (select applicant_pidm from adm_student_confirmation
) ;

select * from  BU_DEV.TMP_TBL_KILANY_adm
where  not exists (select '1' from VW_APPLICANT_CHOICES where APPLICANT_DECISION='QA' and APPLICANT_PIDM=col01  ) ;

select * from  BU_DEV.TMP_TBL_KILANY_adm
where (select count(*) from VW_APPLICANT_CHOICES where APPLICANT_DECISION='QA'  and APPLICANT_PIDM=col01)>1 ;