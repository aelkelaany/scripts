 
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
   SELECT '144510' "Term Code",
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
                          )
          AND sgbstdn_coll_code_1 = stvcoll_code
          AND sgbstdn_camp_code = stvcamp_code
          AND sgbstdn_stst_code = 'AS'
         -- AND sgbstdn_levl_code = 'Ã„'
          and spriden_id like '445%'
          and not exists (select '1' from new_students_email where "SamAccountName"=spriden_id)
         -- AND TRUNC (sgbstdn_activity_date) = TRUNC (SYSDATE)
          --AND spriden_id IN('443046010', '443046011', '443046012', '443046013') 
;
SELECT *
  FROM new_students_email
 WHERE BATCH_NO =(select max(BATCH_NO) from new_students_email);
 
 update 
 new_students_email set "AccountPassword"
 =(select col08 from bu_dev.tmp_tbl_kilany4
 where col05="SamAccountName" and COL07="EmployeeID")
 where 
 BATCH_NO=12 ;
 
-------- transfer password to banner 

DECLARE
   l_pin            VARCHAR2 (30);
   l_hashed_pin     VARCHAR2 (500);
   l_update_count   NUMBER := 0;
BEGIN
   FOR i
      IN (SELECT spriden_pidm, "SamAccountName", "AccountPassword" pwd
            FROM NEW_STUDENTS_EMAIL, sgbstdn s1, spriden
           WHERE     spriden_id = "SamAccountName"
                 AND spriden_pidm = sgbstdn_pidm
                 AND spriden_change_ind IS NULL
                 AND sgbstdn_term_code_eff =
                        (SELECT MAX (s2.sgbstdn_term_code_eff)
                           FROM sgbstdn s2
                          WHERE s2.sgbstdn_pidm = s1.sgbstdn_pidm)
                          and "BATCH_NO"=12
                          )
   LOOP
      l_hashed_pin := NULL;
      gspcrpt.p_saltedhash_md5 (i.pwd, l_hashed_pin);

      UPDATE gobtpac
         SET gobtpac_pin = l_hashed_pin,
             gobtpac_salt = '',
             gobtpac_activity_date = SYSDATE,
             gobtpac_user = USER,
             gobtpac_data_origin = 'Update Banner PWD to LDAP PWD',
             GOBTPAC_PIN_EXP_DATE = SYSDATE - 7
       WHERE gobtpac_pidm = i.spriden_pidm;

      l_update_count := l_update_count + SQL%ROWCOUNT;
   END LOOP;

   DBMS_OUTPUT.put_line ('Update Count :' || l_update_count);
END; 
 
 
 
 
 
 
 
 
 

 
/*
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
*/
select count(distinct STUDENT_PIDM) from
log_success_login
where  exists(select '1' from spriden where spriden_pidm= STUDENT_PIDM and spriden_id like '445%') ;

select * from spriden 
where spriden_id like '445%'
and not exists (select '1' from log_success_login where spriden_pidm=STUDENT_PIDM)
and exists (select '1' from sgbstdn where sgbstdn_pidm=spriden_pidm) ;