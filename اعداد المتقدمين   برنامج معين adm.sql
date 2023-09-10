select COUNT(1) ,APPLICANT_CHOICE from  vw_applicant_choices
where ADMIT_TERM='144510'
and APPLICANT_CHOICE_NO=1
and APPLICANT_CHOICE  in ('1M33NURS38','1F33NURS38')
GROUP BY APPLICANT_CHOICE ;
;


SELECT COUNT( DISTINCT saradap_pidm)  ,saradap_program_1 ,saradap_term_code_entry
           
      FROM saradap, sarappd o
     WHERE     saradap_pidm = sarappd_pidm
           AND saradap_term_code_entry = sarappd_term_code_entry
           AND saradap_appl_no = sarappd_appl_no
           AND sarappd_seq_no =
               (SELECT MAX (sarappd_seq_no)
                  FROM sarappd i
                 WHERE     i.sarappd_pidm = o.sarappd_pidm
                       AND i.sarappd_term_code_entry =
                           o.sarappd_term_code_entry
                       AND i.sarappd_appl_no = o.sarappd_appl_no)
           AND saradap_term_code_entry = '144310'
          -- AND saradap_appl_no=1
           and SARAPPD_APDC_CODE in ('QA','FA')
           AND saradap_program_1 in ('1-3301-1433','2-3301-1433')
           GROUP BY saradap_term_code_entry ,saradap_program_1 ; 