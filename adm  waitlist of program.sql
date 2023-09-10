/* Formatted on 8/16/2023 2:34:43 PM (QP5 v5.371) */
SELECT  k.*,w.*,(SELECT  f_get_program_full_desc ('144510', APPLICANT_CHOICE) accepted_program 
                            FROM VW_APPLICANT_CHOICES
                           WHERE     APPLICANT_PIDM = student_PIDM
                                 AND APPLICANT_CHOICE LIKE '_F%'
                                 AND APPLICANT_DECISION = 'FA')
FROM (SELECT *
  FROM (  SELECT DISTINCT APPLICANT_PIDM PIDM , APPLICANT_RATE RATE  ,APPLICANT_CHOICE_NO PRIORTY
            FROM VW_APPLICANT_CHOICES V
           WHERE     bu_apps.f_get_applicant_rate (ADMIT_TERM,
                                                   APPLICANT_PIDM,
                                                   '1F31PHYS38') <=
                     (/*SELECT APPLICANT_RATE
                        FROM VW_APPLICANT_CHOICES A
                       WHERE     ADMIT_TERM = '144510'
                             AND APPLICANT_DECISION = 'FA'
                             AND APPLICANT_CHOICE = '1F31PHYS38'
                             AND APPLICANT_RATE =
                                 (*/SELECT MIN (APPLICANT_RATE)
                                    FROM VW_APPLICANT_CHOICES
                                   WHERE     ADMIT_TERM = '144510'
                                         AND APPLICANT_DECISION = 'FA'
                                         AND APPLICANT_CHOICE = '1F31PHYS38'
                                         --and rownum<2
                                         )--)
                 AND APPLICANT_CHOICE = '1F31PHYS38'
                 AND APPLICANT_DECISION = 'QR'
                 AND EXISTS
                         (SELECT '1'
                            FROM VW_APPLICANT_CHOICES
                           WHERE     APPLICANT_PIDM = V.APPLICANT_PIDM
                                 AND APPLICANT_CHOICE LIKE '_F%'
                                 AND APPLICANT_DECISION = 'FA')
        ORDER BY APPLICANT_RATE DESC )
        
 WHERE  ROWNUM < 11
 
 )k ,STU_MAIN_DATA_VW w  
 WHERE PIDM=STUDENT_PIDM 
   and ADMIT_TERM='144510'
   order by rate desc;
   
   
   ;
   
   
   
   
       SELECT MIN (APPLICANT_RATE)
                                    FROM VW_APPLICANT_CHOICES
                                   WHERE     ADMIT_TERM = '144510'
                                         AND APPLICANT_DECISION = 'FA'
                                         AND APPLICANT_CHOICE = '1F31PHYS38'
                                          ;