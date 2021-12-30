 


-- COL02 >> SSN
DECLARE
   l_qudrat    NUMBER;
   l_tahseel   NUMBER;

   CURSOR get_std
   IS
      SELECT col02 FROM BU_DEV.TMP_TBL_KILANY;

BEGIN
   FOR rec IN get_std
   LOOP
      bu_apps.p_get_qiyas (p_ssn       => rec.col02,
                           p_diplom    => 'Ú',
                           o_qudrat    => l_qudrat,
                           o_tahseel   => l_tahseel);
      DBMS_OUTPUT.put_line ('Qudrat : ' || l_qudrat);
      DBMS_OUTPUT.put_line ('Tahssel : ' || l_tahseel);

      UPDATE BU_DEV.TMP_TBL_KILANY
         SET col12 = l_qudrat, col13 = l_tahseel
       WHERE col02 = rec.col02;
   END LOOP;
END;

 UPDATE BU_DEV.TMP_TBL_KILANY
         SET col014 = round((0.3*col04)+(0.3*col05)+(0.4*col06),2)
         
         ;
         
   /*    
Insert into SATURN.SORTEST
   (SORTEST_PIDM, SORTEST_TESC_CODE, SORTEST_TEST_DATE, SORTEST_TEST_SCORE, SORTEST_TSRC_CODE, 
    SORTEST_ACTIVITY_DATE, SORTEST_EQUIV_IND, SORTEST_USER_ID, SORTEST_DATA_ORIGIN)
 select col03, 'S3RA',sysdate, col07, 'TWEB', 
   sysdate, 'N', 'BU_APPS', 'BannerIT' 
 from BU_DEV.TMP_TBL_KILANY ;*/
 
