  SELECT DISTINCT
ssbsect_term_code term_code ,
         sirasgn_crn                               crn,
         scbcrse_title||' ~ '||ssbsect_subj_code||ssbsect_crse_numb                           title,
         f_get_std_id (sirasgn_pidm)               instr_id,
         f_get_std_name (sirasgn_pidm)             instr_name,
         DECODE (xwlkstdc.is_submitted (ssbsect_term_code, sirasgn_crn),
                 'P', 'ÊÍÊ ÇáÅÌÑÇÁ',
                 'S', 'Êã ÇáÑÕÏ',
                 'N', 'áã íÊã ÇáÑÕÏ')    crn_status
,F_GET_DESC_FNC ('STVcoll',scbcrse_coll_code , 30) college
,F_GET_DESC_FNC ('STVdept', scbcrse_dept_code , 30) dept ,sirasgn_pidm
    FROM ssbsect,
         sirasgn,
         scbcrse
   WHERE     sirasgn_term_code = :p_TERM_code
         AND ssbsect_term_code = sirasgn_term_code
         AND ssbsect_crn = sirasgn_crn
         AND ssbsect_subj_code = scbcrse_subj_code
         AND ssbsect_crse_numb = scbcrse_crse_numb
         AND SCBCRSE_EFF_TERM =
             (SELECT MAX (SCBCRSE_EFF_TERM)
                FROM scbcrse
               WHERE     ssbsect_subj_code = scbcrse_subj_code
                     AND ssbsect_crse_numb = scbcrse_crse_numb)
         AND ssbsect_gradable_ind = 'Y'
         AND ssbsect_enrl > 0
         AND scbcrse_dept_code like :p_dept_code
         AND scbcrse_coll_code like :p_coll_code
    and ssbsect_camp_code like :p_cammp_code
        and xwlkstdc.is_submitted (ssbsect_term_code, sirasgn_crn)like :p_crn_status
and ssbsect_ptrm_code!=2
ORDER BY 7,8,instr_id;