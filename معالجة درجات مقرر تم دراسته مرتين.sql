/* Formatted on 06/04/2021 12:22:40 (QP5 v5.227.12220.39754) */
DECLARE
   CURSOR get_data
   IS
 
SELECT shrtckn_pidm pidm,
       col07 term_code,
       col08 crn,
       f_get_level (col02) levl_code,
       shrtckn_seq_no seq_no
  FROM BU_DEV.TMP_TBL_KILANY, shrtckn
 WHERE     col02 = shrtckn_pidm
       AND col07 = shrtckn_term_code
       AND shrtckn_crn = col08
       AND shrtckn_seq_no = col09
      ;

   l_shrtckg_count   NUMBER := 0;
   l_shrtckl_count   NUMBER := 0;
   l_shrtckn_count   NUMBER := 0;
   l_sfrstcr_count   NUMBER := 0;
BEGIN
   FOR i IN get_data
   LOOP
      /* CLEARING SHRTCKG */
      BEGIN
      insert into bu_dev.shrtckg_kilany
      select * FROM shrtckg
               WHERE     shrtckg_pidm = i.pidm
                     AND shrtckg_term_code = i.term_code
                     AND shrtckg_tckn_seq_no = i.seq_no;  
         DELETE FROM shrtckg
               WHERE     shrtckg_pidm = i.pidm
                     AND shrtckg_term_code = i.term_code
                     AND shrtckg_tckn_seq_no = i.seq_no;

         l_shrtckg_count := l_shrtckg_count + SQL%ROWCOUNT;
      END;

      /* CLEARING SHRTCKL   */
      BEGIN
      insert into bu_dev.shrtckl_kilany
      select * FROM shrtckl
               WHERE     shrtckl_pidm = i.pidm
                     AND shrtckl_term_code = i.term_code
                     AND shrtckl_tckn_seq_no = i.seq_no
                     AND shrtckl_levl_code = i.levl_code ;
                     
         DELETE FROM shrtckl
               WHERE     shrtckl_pidm = i.pidm
                     AND shrtckl_term_code = i.term_code
                     AND shrtckl_tckn_seq_no = i.seq_no
                     AND shrtckl_levl_code = i.levl_code;

         l_shrtckl_count := l_shrtckl_count + SQL%ROWCOUNT;
      END;


      /* CLEARING shrtckn   */
      BEGIN
      insert into bu_dev.shrtckn_kilany
      select * from shrtckn
               WHERE     shrtckn_pidm = i.pidm
                     AND shrtckn_term_code = i.term_code
                     AND shrtckn_crn = i.crn;
         DELETE FROM shrtckn
               WHERE     shrtckn_pidm = i.pidm
                     AND shrtckn_term_code = i.term_code
                     AND shrtckn_crn = i.crn;

         l_shrtckn_count := l_shrtckn_count + SQL%ROWCOUNT;
      END;
   /* UPDATING SFRSTCR
   BEGIN
      UPDATE sfrstcr
         SET sfrstcr_grde_date = NULL
       WHERE     sfrstcr_pidm = i.sfrstcr_pidm
             AND sfrstcr_term_code = i.sfrstcr_term_code
             AND sfrstcr_crn = i.sfrstcr_crn;

      l_sfrstcr_count := l_sfrstcr_count + SQL%ROWCOUNT;
   END;*/
   END LOOP;

   DBMS_OUTPUT.put_line ('SHRTCKG Deleted Rows : ' || l_shrtckg_count);
   DBMS_OUTPUT.put_line ('SHRTCKL Deleted Rows : ' || l_shrtckl_count);
   DBMS_OUTPUT.put_line ('SHRTCKN Deleted Rows : ' || l_shrtckn_count);
   DBMS_OUTPUT.put_line ('SFRSTCR Updated Rows : ' || l_sfrstcr_count);
END;
/


--update BU_DEV.TMP_TBL_KILANY set col02=f_get_pidm( col01) ;

create table bu_dev.shrtckg_kilany as select * from shrtckg where 1=2 ;
create table bu_dev.shrtckl_kilany as select * from shrtckl where 1=2 ;
create table bu_dev.shrtckn_kilany as select * from shrtckn where 1=2 ;




Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'GRADE_MAINTAIN', 'SAISUSR', '„⁄«·Ã… œ—Ã«  ', 'N', 
    SYSDATE, NULL);
 
 
Insert into GLBEXTR
   SELECT 'STUDENT', 'GRADE_MAINTAIN', 'SAISUSR', 'SAISUSR', PIDM, 
    SYSDATE, 'S', NULL  FROM 
(  SELECT DISTINCT COL02 PIDM
            FROM BU_DEV.TMP_TBL_KILANY
            )
 