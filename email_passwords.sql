 
INSERT INTO new_students_email ("Term Code",
                                "Name",
                                "DisplayName",
                                "GivenName",
                                "Surname",
                                "SamAccountName",
                                "UserPrincipalName",
                                "EmployeeID",
                                "AccountPassword",
                                "Enabled",
                                "Organization",
                                "Country",
                                "Path",
                                pidm,
                                batch_no)
   SELECT '144310' "Term Code",
          SPRIDEN_FIRST_NAME || ' ' || SPRIDEN_MI || ' ' || SPRIDEN_LAST_NAME
             "Name",
          SPRIDEN_FIRST_NAME || ' ' || SPRIDEN_MI || ' ' || SPRIDEN_LAST_NAME
             "DisplayName",
          SPRIDEN_FIRST_NAME || ' ' || SPRIDEN_MI "GivenName",
          SPRIDEN_LAST_NAME "Surname",
          spriden_id "SamAccountName",
          spriden_id || '@stu.bu.edu.sa' "UserPrincipalName",
          spbpers_ssn "EmployeeID",
          f_generate_password "AccountPassword",
          'yes' "Enabled",
          stvcoll_desc "Organization",
          'SA' "Country",
          'OU=AHC Users,OU=AHC,DC=BUSTU,DC=LOCAL' "Path",
          spriden_pidm,
          (select max(BATCH_NO) from new_students_email)+1
     FROM sgbstdn x,
          stvcoll,
          stvcamp,
          spriden,
          spbpers
    WHERE     sgbstdn_pidm = spriden_pidm
          AND spriden_change_ind IS NULL
          AND sgbstdn_pidm = spbpers_pidm
          AND sgbstdn_term_code_eff =
                 (SELECT MAX (sgbstdn_term_code_eff)
                    FROM sgbstdn d
                   WHERE     d.sgbstdn_pidm = x.sgbstdn_pidm
                         AND d.sgbstdn_term_code_eff <= '144320')
          AND sgbstdn_coll_code_1 = stvcoll_code
          AND sgbstdn_camp_code = stvcamp_code
          AND sgbstdn_stst_code = 'AS'
          AND sgbstdn_levl_code = 'Ìã'
          and spriden_id like '443%'
          and not exists (select '1' from new_students_email where "SamAccountName"=spriden_id)
         -- AND TRUNC (sgbstdn_activity_date) = TRUNC (SYSDATE)
          --AND spriden_id IN('443046010', '443046011', '443046012', '443046013') 
;
SELECT *
  FROM new_students_email
 WHERE BATCH_NO =(select max(BATCH_NO) from new_students_email);

DECLARE
   l_hashed_pin   VARCHAR2 (100);
   l_salt         VARCHAR2 (20) := 'CX1XSYHL';
   l_count        NUMBER := 0;

   CURSOR crs_get_data
   IS
      SELECT pidm, "SamAccountName", "EmployeeID"
        FROM new_students_email x, spriden
       WHERE     spriden_id = "SamAccountName"
             AND spriden_change_ind IS NULL
             AND NOT EXISTS
                    (SELECT 'X'
                       FROM gobansr
                      WHERE gobansr_pidm = spriden_pidm);

BEGIN
   FOR r IN crs_get_data
   LOOP
      l_hashed_pin := '';
      gspcrpt.p_saltedhash (r."EmployeeID", l_salt, l_hashed_pin);

      INSERT INTO gobansr (gobansr_pidm,
                           gobansr_num,
                           gobansr_gobqstn_id,
                           gobansr_qstn_desc,
                           gobansr_ansr_desc,
                           gobansr_ansr_salt,
                           gobansr_user_id,
                           gobansr_data_origin,
                           gobansr_activity_date)
           VALUES (r.pidm,
                   1,
                   1,
                   '',
                   l_hashed_pin,
                   l_salt,
                   'SAISUSR',
                   'Banner',
                   TRUNC (SYSDATE));

      l_count := l_count + 1;
   END LOOP;

   DBMS_OUTPUT.PUT_LINE (l_count);
   commit;
END;
/