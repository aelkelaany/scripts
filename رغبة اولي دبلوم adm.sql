/* Formatted on 1/3/2023 10:32:47 AM (QP5 v5.371) */
  SELECT COUNT (saradap_pidm)                                             applicant_pidm,
         saradap_program_1                                                applicant_choice,
         BU_APPS.f_get_program_full_desc ('144410', saradap_program_1)    descf
    FROM saradap, sarappd o
   WHERE     saradap_pidm = sarappd_pidm
         AND saradap_term_code_entry = sarappd_term_code_entry
         AND saradap_appl_no = sarappd_appl_no
         AND sarappd_seq_no =
             (SELECT MAX (sarappd_seq_no)
                FROM sarappd i
               WHERE     i.sarappd_pidm = o.sarappd_pidm
                     AND i.sarappd_term_code_entry = o.sarappd_term_code_entry
                     AND i.sarappd_appl_no = o.sarappd_appl_no)
         AND saradap_term_code_entry = '144410'
         AND SARADAP_LEVL_CODE = 'ох'
         AND SARADAP_APPL_NO = 1
GROUP BY saradap_program_1
order by 2;