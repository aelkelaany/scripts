 
  SELECT COUNT (applicant_pidm), APPLICANT_CHOICE ,smrprle_program_desc 
    FROM VW_APPLICANT_CHOICES ,smrprle
   WHERE ADMIT_TERM = '144210' AND APPLICANT_DECISION = 'WA'
   and smrprle_program=APPLICANT_CHOICE
GROUP BY APPLICANT_CHOICE ,smrprle_program_desc
order by 2