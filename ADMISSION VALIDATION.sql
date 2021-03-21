SELECT a.*, rule_code
  FROM sybssnl a, ADM_REGISTRATION_RULES b
WHERE     ADMISSION_TYPE = sybssnl_admission_type
       AND sybssnl_term_code = admission_term_code
       AND sybssnl_term_code = '144020'
       AND sybssnl_admission_type = 'UG'
       AND ACTIVE_IND = 'Y'
       AND f_check_rule (sybssnl_ssn, rule_code) = 'N';
SELECT *
  FROM (SELECT sybssnl.*,
               SOBCURR_PROGRAM,
               rule_code,
               f_check_rule (sybssnl_aidm, rule_code) rule_avilabilty
          FROM sybssnl,
               saretry,
               sobcurr,
               ADM_PROGRAMS_RULES
         WHERE     sybssnl_aidm = saretry_aidm
               AND SOBCURR_CURR_RULE = SARETRY_CURR_RULE
               AND TERM_CODE = sybssnl_term_code
               AND PROGRAM_CODE = SOBCURR_PROGRAM
               AND WAPP_CODE = 'UG'
               AND saretry_appl_seqno = 1
               AND sybssnl_term_code = '144210'
               AND sybssnl_admission_type = 'UG')
WHERE rule_avilabilty = 'N';


--moe_cd