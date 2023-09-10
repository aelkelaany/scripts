 
SELECT SSBSECT_CRN,
       SSBSECT_SUBJ_CODE,
       SSBSECT_CRSE_NUMB,
       F_GET_DESC_FNC ('STVCAMP', SSBSECT_CAMP_CODE, 30)     CAMPUS,
       SSBSECT_CAMP_CODE ,ssbsect_enrl
  FROM ssbsect
 WHERE     ssbsect_term_code = '144510'
       AND SSBSECT_PTRM_CODE = 1
       AND SSBSECT_MAX_ENRL > 0
       AND EXISTS
               (SELECT '1'
                  FROM sfrstcr
                 WHERE     sfrstcr_term_code = ssbsect_term_code
                       AND sfrstcr_crn = ssbsect_crn
                       AND sfrstcr_rsts_code IN ('RE', 'RW'))
       AND NOT EXISTS
               (SELECT '1'
                  FROM SSRRCMP
                 WHERE     SSRRCMP_CRN = ssbsect_CRN
                       AND SSRRCMP_TERM_CODE = '144510')
       AND NOT EXISTS
               (SELECT '1'
                  FROM SSRRCol
                 WHERE     SSRRCol_CRN = ssbsect_CRN
                       AND SSRRCol_TERM_CODE = '144510')
       AND NOT EXISTS
               (SELECT '1'
                  FROM SSRRdep
                 WHERE     SSRRdep_CRN = ssbsect_CRN
                       AND SSRRdep_TERM_CODE = '144510')
                       
                       AND EXISTS
               (SELECT '1'
                  FROM sfrstcr
                 WHERE     sfrstcr_term_code = ssbsect_term_code
                       AND sfrstcr_crn = ssbsect_crn
                       AND sfrstcr_rsts_code IN ('RE', 'RW'));
                       
                       ----------------------------
                       
                       delete bu_dev.tmp_tbl_kilany2 ;
insert into bu_dev.tmp_tbl_kilany2 (col01)
SELECT SSBSECT_CRN 
  FROM ssbsect
 WHERE     ssbsect_term_code = '144510'
       AND SSBSECT_PTRM_CODE = 1
       AND SSBSECT_MAX_ENRL > 0
       AND EXISTS
               (SELECT '1'
                  FROM sfrstcr
                 WHERE     sfrstcr_term_code = ssbsect_term_code
                       AND sfrstcr_crn = ssbsect_crn
                       AND sfrstcr_rsts_code IN ('RE', 'RW'))
       AND NOT EXISTS
               (SELECT '1'
                  FROM SSRRCMP
                 WHERE     SSRRCMP_CRN = ssbsect_CRN
                       AND SSRRCMP_TERM_CODE = '144510')
       AND NOT EXISTS
               (SELECT '1'
                  FROM SSRRCol
                 WHERE     SSRRCol_CRN = ssbsect_CRN
                       AND SSRRCol_TERM_CODE = '144510')
       AND NOT EXISTS
               (SELECT '1'
                  FROM SSRRdep
                 WHERE     SSRRdep_CRN = ssbsect_CRN
                       AND SSRRdep_TERM_CODE = '144510');
                       
                       
                       UPDATE ssbsect
   SET ssbsect_max_enrl = 0,
       SSBSECT_SEATS_AVAIL = 0,
       ssbsect_enrl = 0,
       SSBSECT_REG_ONEUP = 0,
       SSBSECT_TOT_CREDIT_HRS = 0,
       SSBSECT_USER_ID = USER,
       SSBSECT_ACTIVITY_DATE = SYSDATE
 WHERE     ssbsect_term_code = '144510'
        and ssbsect_crn in (select col01 from bu_dev.tmp_tbl_kilany2);


-- delete sfrstcr records

select * from  sfrstcr where sfrstcr_term_code='144510' and 
sfrstcr_crn in (select col01 from bu_dev.tmp_tbl_kilany2) 
       AND sfrstcr_rsts_code IN ('RE', 'RW');

delete from  sfrstcr where sfrstcr_term_code='144510' and 
sfrstcr_crn in (select col01 from bu_dev.tmp_tbl_kilany2) 
       AND sfrstcr_rsts_code IN ('RE', 'RW');