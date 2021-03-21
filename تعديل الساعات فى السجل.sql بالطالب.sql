 
DECLARE
   CURSOR get_std
   IS
      SELECT col01,
             col02 pidm,
             col03 TermCode,
             col04 crn
        FROM bu_dev.tmp_tbl03;

   Cr_Hrs          NUMBER (2) := 3;
   old_cr_hrs      NUMBER (2) := 2;
   sfrstcr_count   NUMBER (2);
   shatckn_count   NUMBER (2);
BEGIN
   FOR rec IN get_std
   LOOP
      sfrstcr_count := 0;
      shatckn_count := 0;

      UPDATE SFRSTCR
         SET SFRSTCR_CREDIT_HR = Cr_Hrs, SFRSTCR_CREDIT_HR_HOLD = Cr_Hrs
       WHERE     SFRSTCR_TERM_CODE = rec.TermCode
             AND SFRSTCR_CRN = rec.CRN
             AND sfrstcr_pidm = rec.pidm
             AND SFRSTCR_CREDIT_HR = old_cr_hrs;

      sfrstcr_count := SQL%ROWCOUNT;

      IF sfrstcr_count > 1
      THEN
         DBMS_OUTPUT.put_line (
               '***************************************Sfrstcr_updated rows '
            || sfrstcr_count
            || ' for> '
            || rec.col01);
      ELSE
         DBMS_OUTPUT.put_line (
            'Sfrstcr_updated rows ' || sfrstcr_count || ' for> ' || rec.col01);
      END IF;

      --3.------- Update SHRTCKG ----------------


      UPDATE SHRTCKG G1
         SET SHRTCKG_CREDIT_HOURS = Cr_Hrs, SHRTCKG_HOURS_ATTEMPTED = Cr_Hrs
       WHERE     SHRTCKG_TERM_CODE = rec.TermCode
             AND G1.SHRTCKG_PIDM = rec.pidm
             AND SHRTCKG_TCKN_SEQ_NO =
                    (SELECT SHRTCKN_SEQ_NO
                       FROM SHRTCKN
                      WHERE     SHRTCKN_PIDM = SHRTCKG_PIDM
                            AND SHRTCKN_TERM_CODE = rec.TermCode
                            AND SHRTCKN_CRN = rec.CRN)
             AND SHRTCKG_CREDIT_HOURS = old_cr_hrs;

      shatckn_count := SQL%ROWCOUNT;

      IF shatckn_count > 2
      THEN
         DBMS_OUTPUT.put_line (
               '************************************Shatckn_updated rows '
            || shatckn_count
            || ' for> '
            || rec.col01);
      ELSE
         DBMS_OUTPUT.put_line (
            'Shatckn_updated rows ' || shatckn_count || ' for> ' || rec.col01);
      END IF;
   END LOOP;
END;