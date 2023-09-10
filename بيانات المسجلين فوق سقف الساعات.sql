/* Formatted on 8/31/2023 12:13:50 PM (QP5 v5.371) */
  SELECT f_get_std_name (sgbstdn_pidm),
         spriden_id,
         stvcoll_desc,
         stvdept_desc,
         stvmajr_desc,
         DECODE (SPBPERS_SEX,  'M', '–ﬂ—',  'F', '√‰ÀÏ',  ' ')
             Gender,
         COUNT (DISTINCT ssbsect_subj_code || ssbsect_crse_numb)
             AS "⁄œœ «·„Ê«œ",
         NVL (SUM (sfrstcr_credit_hr), 0)
             reg_hr,
         SMBPOGN_REQ_CREDITS_OVERALL
             AS "”«⁄«  «·Œÿ…",
         SMBPOGN_ACT_CREDITS_OVERALL
             AS "«·„ﬂ ”»…",
         (NVL (SMBPOGN_REQ_CREDITS_OVERALL, 0) - SMBPOGN_ACT_CREDITS_OVERALL)
             AS "««·„ »ﬁÌ…" ,(
             select   LISTAGG( m.request_no||' ' ||f_get_std_name(w.user_pidm)  ,'; ') within GROUP(ORDER BY m.request_no) AS worflow_data
from request_master m , wf_request_flow w , request_details d ,request_details d2
where m.request_no=w.request_no
and m.request_no=d.request_no
  and m.request_no=d2.request_no
and d.sequence_no=1
and d.sequence_no=d2.sequence_no
and d2.ITEM_CODE like '%TERM%'
and d2.ITEM_VALUE='144510'
and m.object_code='WF_REG_MAINTAIN'

and m.REQUEST_STATUS='C'
and d.ITEM_CODE = 'STUDENT_PIDM'
and d.ITEM_value=TO_CHAR(sgbstdn_pidm)
and w.ROLE_CODE='RO_DAR_REGISTRATION'
             ) wf_request_data
    FROM sgbstdn s1
         LEFT JOIN sfrstcr
             ON (    sgbstdn_pidm = sfrstcr_pidm
                 AND sfrstcr_term_code = '144510'
                 AND sfrstcr_rsts_code IN ('RE', 'RW'))
         LEFT JOIN ssbsect
             ON (    ssbsect_term_code = sfrstcr_term_code
                 AND ssbsect_crn = sfrstcr_crn)
         LEFT JOIN spbpers ON (spbpers_pidm = sgbstdn_pidm)
         LEFT JOIN spriden
             ON (spriden_pidm = sgbstdn_pidm AND spriden_change_ind IS NULL)
         LEFT JOIN stvcoll ON (stvcoll_code = SGBSTDN_COLL_CODE_1)
         LEFT JOIN stvdept ON (stvdept_code = SGBSTDN_DEPT_CODE)
         LEFT JOIN stvmajr ON (stvmajr_code = SGBSTDN_MAJR_CODE_1)
         LEFT JOIN smbpogn sm1
             ON (    SMBPOGN_PIDM = sgbstdn_pidm
                 AND sm1.SMBPOGN_REQUEST_NO =
                     (SELECT MAX (sm2.SMBPOGN_REQUEST_NO)
                        FROM SMBPOGN sm2
                       WHERE sm2.SMBPOGN_pidm = sm1.SMBPOGN_pidm))
   WHERE     sgbstdn_stst_code = 'AS'
          AND sgbstdn_levl_code not IN ('MA', '„Ã')
         AND s1.sgbstdn_term_code_eff =
             (SELECT MAX (s2.sgbstdn_term_code_eff)
                FROM sgbstdn s2
               WHERE     s2.sgbstdn_pidm = s1.sgbstdn_pidm
                     AND s2.sgbstdn_term_code_eff <= '144510')
GROUP BY spriden_id,
         sgbstdn_pidm,
         stvcoll_desc,
         stvdept_desc,
         stvmajr_desc,
         SPBPERS_SEX,
         SMBPOGN_REQ_CREDITS_OVERALL,
         SMBPOGN_ACT_CREDITS_OVERALL
  HAVING   SUM( NVL(sfrstcr_credit_hr , 0))  > 20;
  
   