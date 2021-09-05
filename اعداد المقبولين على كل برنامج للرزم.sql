/* Formatted on 29/08/2021 10:06:36 (QP5 v5.371) */
  SELECT COUNT (applicant_pidm), APPLICANT_CHOICE, smrprle_program_desc
    FROM VW_APPLICANT_CHOICES, smrprle
   WHERE     ADMIT_TERM = '144310'
         AND APPLICANT_DECISION = 'WA'
         AND smrprle_program = APPLICANT_CHOICE
GROUP BY APPLICANT_CHOICE, smrprle_program_desc
ORDER BY 2;
-- accpeted
  SELECT COUNT (applicant_pidm),APPLICANT_CHOICE ,
         f_get_program_full_desc ('144310', APPLICANT_CHOICE)     description
    FROM VW_APPLICANT_CHOICES
   WHERE ADMIT_TERM = '144310' AND APPLICANT_DECISION = 'QA'
GROUP BY APPLICANT_CHOICE
ORDER BY 2