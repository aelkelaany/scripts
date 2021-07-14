/* check admission application*/
SELECT SYBSSNL_SSN, sabnstu_pin,sabnstu_aidm,SARHEAD_APPL_COMP_IND
  FROM SYBSSNL, sabnstu ,sarhead
 WHERE     sabnstu_aidm = SYBSSNL_aidm
 and sarhead_aidm = SYBSSNL_aidm
       AND SYBSSNL_TERM_CODE = '144310'
       AND SYBSSNL_ADMISSION_TYPE = 'UG'
       --AND SYBSSNL_EMAIL = :email
       AND SYBSSNL_SSN = :ssn
       ;
  
 -- student      
 select f_get_std_id(sgbstdn_pidm) stid,f_get_std_name(sgbstdn_pidm)std_name, sg.* from sgbstdn sg,spbpers
where
sgbstdn_pidm=spbpers_pidm
and spbpers_ssn='1102403837'
 


;      
 
     --  admissionCountSummary
     
      SELECT DECODE (sybssnl_gender,
                       'M', '–ﬂ—',
                       'F', '√‰ÀÌ',
                       '€Ì— „Õœœ')
                  AS "Gender",
               DECODE (sarhead_appl_comp_ind,
                       'Y', '„ﬂ „·',
                       'N', '€Ì— „ﬂ „·',
                       '€Ì— „ﬂ „·')
                  AS "Application Status",
               COUNT (sybssnl_ssn) AS "Count"
          FROM sybssnl s, sarhead h
         WHERE     s.sybssnl_aidm = h.sarhead_aidm
               AND h.sarhead_appl_seqno = 1
               AND sybssnl_gender IS NOT NULL
               AND s.sybssnl_term_code = '144310'
               AND s.sybssnl_admission_type = 'UG'
      GROUP BY sybssnl_gender, sarhead_appl_comp_ind
      ORDER BY 2 ASC, 2 DESC;
      
      
      
      --withdraw greater than 2 years
      
      SELECT 1 FROM DUAL 
 WHERE 
   F_VALIDATE_OLD_STUDENT_2021('1102403837') = 'Y' ;
