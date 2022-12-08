sabiden (SABIDEN_AIDM, SABIDEN_PIDM); getting pidm by aidm 
sarhead (SARHEAD_AIDM, SARHEAD_APPL_SEQNO, SARHEAD_APPL_COMP_IND) application header 

  gb_common.f_generate_pidm; generate pidm
         l_id := gb_common.f_generate_id generate id 
         
         adm_health_vw --disabilities 

adm_main_data_vw all application data 

saradap choices 
sarappd choices header 

 admission tables 
 sybssnl --Main login information 
sabnstu --Password table
moe_cd   moe_cd from MOE
sarhead --Application header
sarpers  ,adm_english_names--personal data
sarhsch --high school
sarhsum --School GPA
sartest --Test Scores
saretry --Desires
sarefos --Desires
STU_MAIN_DATA_VW
sarappd
saradap
ADM_DispTestScoreRequests
---BU
adm_push_log
adm_push_result

VW_APPLICANT_CHOICES 
admissionCountSummary


ADM_RECONFIRM_ADM_REQUEST ≈⁄«œ… «· √ﬂÌœ

ADM_CHANGE_CAMP_REQUEST  ÕÊÌ· „ﬁ— «·œ—«”…
ADM_CHNG_CAMP_REQ_DETAILS



------------

SELECT student_graduation_year, COUNT (1)
    FROM moe_cd cd
   WHERE EXISTS
            (SELECT 1
               FROM adm_choices_vw vw
              WHERE     vw.STUDENT_SSN = cd.STUDENT_SSN
                    AND ADMIT_TERM = '144410'
                    AND ADMISSION_TYPE = 'UG'
                    AND PROGRAM_CODE IN
                           ('1F14MED38',
                            '1M14MED38',
                            '1M25DENT38',
                            '1F55PHCL38',
                            '1M55PHCL38',
                            '1F33LABM38',
                            '1F33NURS38',
                            '1F33PUBH38',
                            '1M33DH38',
                            '1M33LABM38',
                            '1M33NURS38',
                            '1M33PUBH38'))
GROUP BY student_graduation_year
ORDER BY 2 DESC;


------------------------ delete entire applcation by aidm
;
 exec p_delete_adm_application(327215) ;