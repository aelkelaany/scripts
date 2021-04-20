 SELECT sybssnl_ssn,
           sabiden_pidm,
           sybssnl_term_code,
           sybssnl_admission_type,
           sarhead_appl_comp_ind,
           sarhead_process_ind,
           a.spriden_first_name,
           a.spriden_mi,
           a.spriden_last_name,
           b.spriden_first_name,
           b.spriden_mi,
           b.spriden_last_name,
           spbpers_sex,
           spbpers_citz_code,
           spbpers_mrtl_code,
           'MDC',
           spbpers_birth_date,
           (SELECT GOREMAL_EMAIL_ADDRESS
              FROM goremal
             WHERE     goremal_pidm = sabiden_pidm
                   AND goremal_emal_code = 'PS'
                   AND goremal_status_ind = 'A'
                   AND GOREMAL_DATA_ORIGIN = 'PUSH')
               GOREMAL_EMAIL_ADDRESS,
           (SELECT SPRTELE_INTL_ACCESS
              FROM sprtele mobile
             WHERE     mobile.sprtele_pidm = sabiden_pidm
                   AND mobile.SPRTELE_TELE_CODE = 'MO'
                   AND mobile.SPRTELE_SEQNO =
                       (SELECT MAX (mobile2.SPRTELE_SEQNO)
                          FROM sprtele mobile2
                         WHERE     mobile.sprtele_pidm = mobile2.sprtele_pidm
                               AND mobile2.SPRTELE_TELE_CODE = 'MO'))
               mobile,
           (SELECT SPRADDR_ATYP_CODE
              FROM spraddr addr1
             WHERE     spraddr_pidm = sabiden_pidm
                   AND SPRADDR_ATYP_CODE = 'œ„'
                   AND SPRADDR_STATUS_IND IS NULL
                   AND SPRADDR_SEQNO =
                       (SELECT MAX (addr2.SPRADDR_SEQNO)
                          FROM spraddr addr2
                         WHERE     addr2.spraddr_pidm = addr1.spraddr_pidm
                               AND addr2.SPRADDR_ATYP_CODE =
                                   addr1.SPRADDR_ATYP_CODE
                               AND addr2.SPRADDR_STATUS_IND IS NULL))
               SPRADDR_ATYP_CODE,
           (SELECT SPRADDR_NATN_CODE
              FROM spraddr addr1
             WHERE     spraddr_pidm = sabiden_pidm
                   AND SPRADDR_ATYP_CODE = 'œ„'
                   AND SPRADDR_STATUS_IND IS NULL
                   AND SPRADDR_SEQNO =
                       (SELECT MAX (addr2.SPRADDR_SEQNO)
                          FROM spraddr addr2
                         WHERE     addr2.spraddr_pidm = addr1.spraddr_pidm
                               AND addr2.SPRADDR_ATYP_CODE =
                                   addr1.SPRADDR_ATYP_CODE
                               AND addr2.SPRADDR_STATUS_IND IS NULL))
               SPRADDR_NATN_CODE,
           (SELECT SPRADDR_CITY
              FROM spraddr addr1
             WHERE     spraddr_pidm = sabiden_pidm
                   AND SPRADDR_ATYP_CODE = 'œ„'
                   AND SPRADDR_STATUS_IND IS NULL
                   AND SPRADDR_SEQNO =
                       (SELECT MAX (addr2.SPRADDR_SEQNO)
                          FROM spraddr addr2
                         WHERE     addr2.spraddr_pidm = addr1.spraddr_pidm
                               AND addr2.SPRADDR_ATYP_CODE =
                                   addr1.SPRADDR_ATYP_CODE
                               AND addr2.SPRADDR_STATUS_IND IS NULL))
               SPRADDR_CITY,
           (SELECT SPRADDR_STREET_LINE1
              FROM spraddr addr1
             WHERE     spraddr_pidm = sabiden_pidm
                   AND SPRADDR_ATYP_CODE = 'œ„'
                   AND SPRADDR_STATUS_IND IS NULL
                   AND SPRADDR_SEQNO =
                       (SELECT MAX (addr2.SPRADDR_SEQNO)
                          FROM spraddr addr2
                         WHERE     addr2.spraddr_pidm = addr1.spraddr_pidm
                               AND addr2.SPRADDR_ATYP_CODE =
                                   addr1.SPRADDR_ATYP_CODE
                               AND addr2.SPRADDR_STATUS_IND IS NULL))
               SPRADDR_STREET_LINE1,
           (SELECT SPRTELE_PHONE_AREA
              FROM sprtele phone1
             WHERE     phone1.sprtele_pidm = sabiden_pidm
                   AND phone1.SPRTELE_TELE_CODE = 'HO'
                   AND phone1.SPRTELE_SEQNO =
                       (SELECT MAX (phone2.SPRTELE_SEQNO)
                          FROM sprtele phone2
                         WHERE     phone2.sprtele_pidm = phone1.sprtele_pidm
                               AND phone2.SPRTELE_TELE_CODE = 'HO'))
               phone_area,
           (SELECT SPRTELE_PHONE_NUMBER
              FROM sprtele phone_no1
             WHERE     phone_no1.sprtele_pidm = sabiden_pidm
                   AND phone_no1.SPRTELE_TELE_CODE = 'HO'
                   AND phone_no1.SPRTELE_SEQNO =
                       (SELECT MAX (phone_no2.SPRTELE_SEQNO)
                          FROM sprtele phone_no2
                         WHERE     phone_no2.sprtele_pidm =
                                   phone_no1.sprtele_pidm
                               AND phone_no2.SPRTELE_TELE_CODE = 'HO'))
               phone_number,
           (SELECT SORHSCH_DPLM_CODE
              FROM sorhsch
             WHERE sorhsch_pidm = sabiden_pidm AND sorhsch_sbgi_code = 1)
               SORHSCH_DPLM_CODE,
           (SELECT TO_CHAR (SORHSCH_GRADUATION_DATE, 'DD/MM/YYYY')
              FROM sorhsch
             WHERE sorhsch_pidm = sabiden_pidm AND sorhsch_sbgi_code = 1)
               SORHSCH_GRADUATION_DATE,
           (SELECT SORHSCH_GPA
              FROM sorhsch
             WHERE sorhsch_pidm = sabiden_pidm AND sorhsch_sbgi_code = 1)
               SORHSCH_GPA
      FROM sabiden,
           sybssnl,
           sarhead,
           spriden      a,
           dle.spriden  b,
           spbpers
     WHERE     sabiden_aidm = sybssnl_aidm
           AND sarhead_aidm = sybssnl_aidm
           AND sarhead_appl_seqno = 1
           AND a.spriden_pidm = sabiden_pidm
           AND a.spriden_change_ind IS NULL
           AND b.spriden_pidm = sabiden_pidm
           AND b.spriden_change_ind IS NULL
           AND sabiden_pidm = spbpers_pidm
          AND sybssnl_term_code =:TERM_CODE
          AND sybssnl_ssn=:SSN
            /*        (f_get_param ('ADMISSION', 'CURRENT_TERM_UG', 1),
                    f_get_param ('ADMISSION', 'CURRENT_TERM_PG', 1))*/
           AND sybssnl_admission_type IN ('UG',
                                          'U2',
                                          'DP',
                                          'PG')
                                          
                                          ;
                                          
                                            SELECT APPLICANT_CHOICE_NO,
         APPLICANT_PIDM,
         ADMIT_TERM,
         APPLICANT_CHOICE,
         f_get_program_full_desc (ADMIT_TERM, APPLICANT_CHOICE) program_desc,
         APPLICANT_DECISION,
         stvapdc_desc
    FROM (    SELECT saradap_pidm
               applicant_pidm,
           saradap_term_code_entry
               admit_term,
           saradap_appl_no
               applicant_choice_no,
           saradap_program_1
               applicant_choice,
           bu_apps.f_get_applicant_rate (saradap_term_code_entry,
                                         saradap_pidm,
                                         saradap_program_1)
               applicant_rate,
           sarappd_apdc_code
               applicant_decision
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
           AND saradap_term_code_entry = '144010'), stvapdc
   WHERE stvapdc_code = APPLICANT_DECISION
   and APPLICANT_PIDM=214346
ORDER BY 1 ;