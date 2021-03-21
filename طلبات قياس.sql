SELECT sybssnl_ssn "Student SSN",
            STUDENT_FIRST_NAME_AR
         || ' '
         || STUDENT_MI_NAME_AR
         || ' '
         || STUDENT_LAST_NAME_AR
            "Student Name",
         OLD_QUDRAT_SCORE "Old Qudrat Score",
         OLD_TAHSELE_SCORE "Old Tahselee Score",
         NEW_QUDRAT_SCORE "New Qudrat Score",
         NEW_TAHSELE_SCORE "New Tahselee Score"
    FROM ADM_CHANGE_TEST_SCORE_REQUESTS a, sybssnl,MOE_CD
   WHERE     sybssnl_aidm = APPLICANT_AIDM
         AND student_ssn = sybssnl_ssn
         AND sybssnl_term_code = '144010'
         AND sybssnl_admission_type = 'U2'
         AND REQUEST_STATUS in ('N','P')
ORDER BY REQUEST_DATE desc;
----------
update ADM_CHANGE_TEST_SCORE_REQUESTS 
set REQUEST_STATUS = 'P'  , NOTES='Ã«— «· Õﬁﬁ „‰ ’Õ… «·œ—Ã«  «·„œŒ·…'
where REQUEST_STATUS = 'N';
