/*<TOAD_FILE_CHUNK>*/
 
declare 
   CURSOR get_data
   IS
      SELECT sfrstcr_pidm,
             sfrstcr_term_code,
             sfrstcr_crn,
             sfrstcr_levl_code,
             shrtckn_seq_no
        FROM sfrstcr, shrtckn
       WHERE     sfrstcr_pidm = shrtckn_pidm(+)
             AND sfrstcr_term_code = shrtckn_term_code(+)
             AND sfrstcr_crn = shrtckn_crn(+)
             AND sfrstcr_term_code = '144220'
              AND sfrstcr_crn = '24356'
          -- and sfrstcr_pidm=f_get_pidm('441015688') --
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
         DELETE FROM shrtckg
               WHERE     shrtckg_pidm = i.sfrstcr_pidm
                     AND shrtckg_term_code = i.sfrstcr_term_code
                     AND shrtckg_tckn_seq_no = i.shrtckn_seq_no;

         l_shrtckg_count := l_shrtckg_count + SQL%ROWCOUNT;
      END;

      /* CLEARING SHRTCKL   */
      BEGIN
         DELETE FROM shrtckl
               WHERE     shrtckl_pidm = i.sfrstcr_pidm
                     AND shrtckl_term_code = i.sfrstcr_term_code
                     AND shrtckl_tckn_seq_no = i.shrtckn_seq_no
                     AND shrtckl_levl_code = i.sfrstcr_levl_code;

         l_shrtckl_count := l_shrtckl_count + SQL%ROWCOUNT;
      END;


      /* CLEARING shrtckn   */
      BEGIN
         DELETE FROM shrtckn
               WHERE     shrtckn_pidm = i.sfrstcr_pidm
                     AND shrtckn_term_code = i.sfrstcr_term_code
                     AND shrtckn_crn = i.sfrstcr_crn;

         l_shrtckn_count := l_shrtckn_count + SQL%ROWCOUNT;
      END;

      /* UPDATING SFRSTCR   */
      BEGIN
         UPDATE sfrstcr
            SET sfrstcr_grde_date = NULL 
          WHERE     sfrstcr_pidm = i.sfrstcr_pidm
                AND sfrstcr_term_code = i.sfrstcr_term_code
                AND sfrstcr_crn = i.sfrstcr_crn;

         l_sfrstcr_count := l_sfrstcr_count + SQL%ROWCOUNT;
      END;
   END LOOP;

   DBMS_OUTPUT.put_line ('SHRTCKG Deleted Rows : ' || l_shrtckg_count);
   DBMS_OUTPUT.put_line ('SHRTCKL Deleted Rows : ' || l_shrtckl_count);
   DBMS_OUTPUT.put_line ('SHRTCKN Deleted Rows : ' || l_shrtckn_count);
   DBMS_OUTPUT.put_line ('SFRSTCR Updated Rows : ' || l_sfrstcr_count);
END;
/
 

 