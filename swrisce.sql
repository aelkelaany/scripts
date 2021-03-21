/* Formatted on 9/11/2019 12:18:53 PM (QP5 v5.227.12220.39754) */
  SELECT DISTINCT
         SSRMEET_CRN || '-' || ssbsect_seq_numb SSRMEET_CRN,
         SSRMEET_BLDG_CODE || '-' || SSRMEET_ROOM_CODE SSRMEET_LOCATION,
         SSRMEET_BEGIN_TIME || ' - ' || SSRMEET_END_TIME time,
         stvdays_desc,
         stvdays_number,
         scbcrse_subj_code || '-' || scbcrse_crse_numb scbcrse_title,
         spriden_id,
            SIBINST.SIBINST_FCTG_CODE
         || '. '
         || SPRIDEN_FIRST_NAME
         || ' '
         || SPRIDEN_MI
         || ' '
         || SPRIDEN_LAST_NAME
            name,
         SSBSECT_ENRL Enrl,
         SIRDPCL_COLL_CODE,
         SIRDPCL_DEPT_CODE
    FROM ssrmeet,
         stvdays,
         scbcrse b,
         ssbsect,
         sirasgn,
         spriden,
         sirdpcl,
         sibinst
   WHERE     ssbsect_term_code = :p_term_code
         AND spriden_id BETWEEN :p_id AND :P_ID_TO
         AND NVL (SIRDPCL_COLL_CODE, '%') LIKE :P_COLL
         AND NVL (SIRDPCL_DEPT_CODE, '%') LIKE :P_DEPT
         AND SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM scbcrse
                  WHERE     SCBCRSE_EFF_TERM <= ssbsect_term_code
                        AND scbcrse_subj_code = ssbsect_subj_code
                        AND scbcrse_crse_numb = ssbsect_crse_numb)
         AND SIRDPCL_PIDM(+) = SIRASGN_PIDM
         AND SIRASGN_PIDM = SIBINST.SIBINST_PIDM
         AND NVL (SIRDPCL_TERM_CODE_EFF, 999999) =
                (SELECT NVL (MAX (SIRDPCL_TERM_CODE_EFF), '999999')
                   FROM SIRDPCL
                  WHERE SIRDPCL_PIDM = SPRIDEN_PIDM)
         AND NVL (SIRDPCL_HOME_IND, 'Y') = 'Y'
         AND ssrmeet_term_code = ssbsect_term_code
         AND ssrmeet_crn = ssbsect_crn
         AND ssbsect_subj_code = scbcrse_subj_code
         AND ssbsect_crse_numb = scbcrse_crse_numb
         AND SSBSECT_SSTS_CODE = 'ä'
         AND (   NVL (SSRMEET_SUN_DAY, '0') = stvdays_code
              OR NVL (SSRMEET_mon_DAY, '0') = stvdays_code
              OR NVL (SSRMEET_tue_DAY, '0') = stvdays_code
              OR NVL (SSRMEET_wed_DAY, '0') = stvdays_code
              OR NVL (SSRMEET_thu_DAY, '0') = stvdays_code
              OR NVL (SSRMEET_fri_DAY, '0') = stvdays_code
              OR NVL (SSRMEET_sat_DAY, '0') = stvdays_code)
         AND SSRMEET_ROOM_CODE IS NOT NULL
         AND spriden_pidm = sirasgn_pidm
         AND spriden_change_ind IS NULL
         AND sirasgn_crn = ssrmeet_crn
         AND sirasgn_term_code = ssrmeet_term_code
         AND sirasgn_category = ssrmeet_catagory
         AND SCBCRSE_EFF_TERM =
                (SELECT MAX (a.SCBCRSE_EFF_TERM)
                   FROM SCBCRSE a
                  WHERE     a.SCBCRSE_SUBJ_CODE = b.SCBCRSE_SUBJ_CODE
                        AND a.SCBCRSE_CRSE_NUMB = b.SCBCRSE_CRSE_NUMB
                        AND a.SCBCRSE_EFF_TERM <= :P_term_code)
ORDER BY spriden_id, stvdays_number, time