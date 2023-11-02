 
SELECT TERM_CODE,
       CRN,
       COLL_CODE,
       f_get_desc_fnc ('stvcoll', coll_code, 30)     coll_desc,
       DEPT_CODE,
       f_get_desc_fnc ('stvdept', dept_code, 30)     dept_desc,
       SUBJ_CODE,
       CRSE_NUMB,
       SCBCRSE_TITLE,
       f_get_std_id (DEPT_PIDM)                      hod_id,
       f_get_std_name (DEPT_PIDM)                    hod_name,
       f_get_std_id (VICE_PIDM)                      vice_id,
       f_get_std_name (VICE_PIDM)                    vice_name,
       f_get_std_id (DEAN_PIDM)                      dean_id,
       f_get_std_name (DEAN_PIDM)                    dean_name,
       WF_REQUEST_NO,
       CAMP_CODE,
       f_get_desc_fnc ('stvcamp', CAMP_CODE, 30)     camp_desc,
       PTERM_CODE
  FROM gac_crn
 WHERE term_code = '144510';