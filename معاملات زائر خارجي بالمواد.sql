/* Formatted on 7/18/2022 9:11:21 AM (QP5 v5.371) */
  SELECT DISTINCT
         a.REQUEST_NO,
         f_get_std_id (REQUESTER_PIDM),
         f_get_std_name (REQUESTER_PIDM),
         (SELECT SPRTELE_INTL_ACCESS
            FROM saturn.sprtele
           WHERE     SPRTELE_TELE_CODE = 'MO'
                 AND sprtele_pidm = REQUESTER_PIDM
                 AND ROWNUM < 2)                          phone,
         REQUEST_STATUS,
         sgbstdn_coll_code_1                              coll,
         term.item_value                                  TERM,
         f_xml_value (CRN.item_value, 'COURSE_CODE')||' - '||
         f_xml_value (CRN.item_value, 'COURSE_TITLE') ||'( '||
         f_xml_value (CRN.item_value, 'HOURS')   ||')'  EXTERNAL_COURSE,
        -- f_xml_value (CRN.item_value, 'GRADE')            stdy_grade,
        -- f_xml_value (CRN.item_value, 'BANNER_COURSE')    banner_course,
            c1.scbcrse_subj_code
         || c1.scbcrse_crse_numb
         || ' - '
         || scbcrse_title
         || ' - ÇáÓÇÚÇÊ ('
         || GREATEST (NVL (c1.SCBCRSE_CREDIT_HR_LOW, 0),
                      NVL (c1.SCBCRSE_CREDIT_HR_HIGH, 0))
         || ')'                                           title 
          ,
         f_xml_value (CRN.item_value, 'DECISION')         dept_head_decision
    FROM request_master a,
         request_details term,
         sgbstdn        sg,
         request_details CRN,
         scbcrse        c1
   WHERE     a.object_code = 'WF_EXTERNAL_VISITOR'
         AND a.request_no = term.request_no
         AND term.SEQUENCE_NO = 1
         AND term.ITEM_CODE = 'TERM'
         AND CRN.request_no = A.request_no
         AND CRN.SEQUENCE_NO =
             (SELECT MAX (b.sequence_no)
                FROM request_details b
               WHERE     b.request_no = CRN.request_no
                     AND b.item_code = CRN.item_code)
         AND REQUEST_STATUS = 'C'
         AND SG.sgbstdn_pidm = REQUESTER_PIDM
         AND SG.SGBSTDN_TERM_CODE_EFF = (SELECT MAX (SGBSTDN_TERM_CODE_EFF)
                                           FROM SGBSTDN
                                          WHERE sgbstdn_pidm = REQUESTER_PIDM)
         AND sgbstdn_coll_code_1 = '14'
        -- AND f_xml_value (CRN.item_value, 'DECISION') = 'A'
         AND c1.scbcrse_subj_code || '~' || c1.scbcrse_crse_numb =
             f_xml_value (CRN.item_value, 'BANNER_COURSE')
         AND c1.scbcrse_eff_term =
             (SELECT MAX (c2.scbcrse_eff_term)
                FROM scbcrse c2
               WHERE     c2.scbcrse_subj_code = c1.scbcrse_subj_code
                     AND c2.scbcrse_crse_numb = c1.scbcrse_crse_numb)
ORDER BY TERM, 1;