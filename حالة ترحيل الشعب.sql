-----��� �� ��� ����� �����
select f_get_desc_fnc('stvcoll',scbcrse_coll_code,30) coll ,f_get_desc_fnc('stvdept',scbcrse_dept_code,30) dept ,
   ssbsect_crn ,A.SCBCRSE_SUBJ_CODE ,A.SCBCRSE_CRSE_NUMB ,scbcrse_title ,ssbsect_ptrm_code  ,SSBSECT_SCHD_CODE ,wf_withdraw_course.get_INSTRUCTOR_NAME ( ssbsect_crn  ,ssbsect_term_code) instr
   , f_get_desc_fnc('stvcamp',ssbsect_camp_code,30) camp
   from scbcrse a  , ssbsect
   where   A.SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM SCBCRSE
                  WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                        AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                        AND SCBCRSE_EFF_TERM <= '144410')
                        and A.SCBCRSE_SUBJ_CODE=ssbsect_subj_code
                        and A.SCBCRSE_CRSE_NUMB=ssbsect_crse_numb
                        and ssbsect_term_code='144410'
                        and SSBSECT_GRADABLE_IND='Y'
                        and SSBSECT_SSTS_CODE='�'
                        and SSBSECT_ENRL>0
                        and exists (select  'a' from sfrstcr x 
       WHERE     ssbsect_term_code = sfrstcr_term_code
             AND ssbsect_crn = sfrstcr_crn
             AND sfrstcr_term_code = '144410'
             AND sfrstcr_grde_code IS    NULL
            AND sfrstcr_grde_date IS     NULL
             AND sfrstcr_rsts_code IN ('RE', 'RW')) 
              and exists (select  'x' from sfrstcr x 
       WHERE     ssbsect_term_code = sfrstcr_term_code
             AND ssbsect_crn = sfrstcr_crn
             AND sfrstcr_term_code = '144410'
              
             AND sfrstcr_rsts_code IN ('RE', 'RW')) 
           and not exists (select  'a' from sfrstcr x 
       WHERE     ssbsect_term_code = sfrstcr_term_code
             AND ssbsect_crn = sfrstcr_crn
             AND sfrstcr_term_code = '144410'
             AND sfrstcr_grde_code IS not   NULL
             AND sfrstcr_rsts_code IN ('RE', 'RW'))
              and SSBSECT_SCHD_CODE in ('�','�')
 --and SCBCRSE_COLL_CODE  NOT in ('11','00')
 --and  SSBSECT_PTRM_CODE=1;
                        ;
                        --��� �� ��� ����� �������
                        select f_get_desc_fnc('stvcoll',scbcrse_coll_code,30) coll ,f_get_desc_fnc('stvdept',scbcrse_dept_code,30) dept  ,
   ssbsect_crn ,A.SCBCRSE_SUBJ_CODE ,A.SCBCRSE_CRSE_NUMB ,scbcrse_title ,ssbsect_ptrm_code ,wf_withdraw_course.get_INSTRUCTOR_NAME ( ssbsect_crn  ,ssbsect_term_code) instr
   from scbcrse a  , ssbsect
   where   A.SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM SCBCRSE
                  WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                        AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                        AND SCBCRSE_EFF_TERM <= '144410')
                        and A.SCBCRSE_SUBJ_CODE=ssbsect_subj_code
                        and A.SCBCRSE_CRSE_NUMB=ssbsect_crse_numb
                        and ssbsect_term_code='144410'
                        and SSBSECT_GRADABLE_IND='Y'
                        and SSBSECT_ENRL>0
                        and exists (select  'a' from sfrstcr x 
       WHERE     ssbsect_term_code = sfrstcr_term_code
             AND ssbsect_crn = sfrstcr_crn
             AND sfrstcr_term_code = '144410'
             AND sfrstcr_grde_code IS    NULL
            AND sfrstcr_grde_date IS     NULL
             AND sfrstcr_rsts_code IN ('RE', 'RW')) 
            and  exists (select  'a' from sfrstcr x 
       WHERE     ssbsect_term_code = sfrstcr_term_code
             AND ssbsect_crn = sfrstcr_crn
             AND sfrstcr_term_code = '144410'
             AND sfrstcr_grde_code IS not   NULL
             AND sfrstcr_rsts_code IN ('RE', 'RW')) 
 --and SCBCRSE_COLL_CODE  NOT in ('11','00')
 and  SSBSECT_PTRM_CODE=1;
                  -----��� �� ����� ������� ��� ��� �������
select scbcrse_coll_code , scbcrse_dept_code ,
   ssbsect_crn ,A.SCBCRSE_SUBJ_CODE ,A.SCBCRSE_CRSE_NUMB ,scbcrse_title
   from scbcrse a  , ssbsect
   where   A.SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM SCBCRSE
                  WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                        AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                        AND SCBCRSE_EFF_TERM <= '144410')
                        and A.SCBCRSE_SUBJ_CODE=ssbsect_subj_code
                        and A.SCBCRSE_CRSE_NUMB=ssbsect_crse_numb
                        and ssbsect_term_code='144410'
                        and SSBSECT_GRADABLE_IND='Y'
                        and SSBSECT_ENRL>0
                        and not exists (select  'a' from sfrstcr x 
       WHERE     ssbsect_term_code = sfrstcr_term_code
             AND ssbsect_crn = sfrstcr_crn
             AND sfrstcr_term_code = '144410'
             AND sfrstcr_grde_code IS    NULL
             
             AND sfrstcr_rsts_code IN ('RE', 'RW')) 
              and exists (select  'a' from sfrstcr x 
       WHERE     ssbsect_term_code = sfrstcr_term_code
             AND ssbsect_crn = sfrstcr_crn
             AND sfrstcr_term_code = '144410'
             AND sfrstcr_grde_code IS not  NULL
            AND sfrstcr_grde_date IS     NULL
             AND sfrstcr_rsts_code IN ('RE', 'RW')) 
            -- and SCBCRSE_COLL_CODE 
 --and SCBCRSE_COLL_CODE   in ('11','00')
                        ;      
                        -------------������� ��� ������� 
                        SELECT crn.ITEM_VALUE crn ,m.REQUEST_STATUS  STATUS,crn.request_no
                  FROM request_details crn, request_details term ,request_master m
                 WHERE     crn.item_code = 'CRN'
                       AND crn.SEQUENCE_NO = 1
                       AND term.SEQUENCE_NO = 1
                       AND term.item_code = 'TERM'
                       AND term.item_value = '144410'
                       AND term.request_no = crn.request_no
                       AND m.request_no = term.request_no
                       AND m.OBJECT_CODE = 'WF_GRADE_APPROVAL'
                        AND m.REQUEST_STATUS = 'P' 
--                       and crn.ITEM_VALUE IN ('17571',
--                         '17572',
--                         '17573',
--                         '17574',
--                         '17576',
--                         '17577')
                       ;
                       
                       ----------------- ������� �� �������� 
                       SELECT count(distinct crn.ITEM_VALUE)
                  FROM request_details crn, request_details term ,request_master m
                 WHERE     crn.item_code = 'CRN'
                       AND crn.SEQUENCE_NO = 1
                       AND term.SEQUENCE_NO = 1
                       AND term.item_code = 'TERM'
                       AND term.item_value = '144410'
                       AND term.request_no = crn.request_no
                       AND m.request_no = term.request_no
                       AND m.OBJECT_CODE = 'WF_GRADE_APPROVAL'
                       AND m.REQUEST_STATUS = 'C' ;
                       
                       -------------------- ������� ������ ����� 
                       SELECT DISTINCT sfrstcr_term_code term_code, sfrstcr_crn crn
  FROM sfrstcr x, ssbsect
 WHERE     ssbsect_term_code = sfrstcr_term_code
  AND SSBSECT_GRADABLE_IND = 'Y'
       AND ssbsect_crn = sfrstcr_crn
       AND sfrstcr_term_code = '144410'
       AND sfrstcr_grde_code IS NOT NULL
       AND sfrstcr_grde_date IS not NULL
      
       AND SFRSTCR_CRN IN
               (SELECT crn.ITEM_VALUE
                  FROM request_details crn, request_details term ,request_master m
                 WHERE     crn.item_code = 'CRN'
                       AND crn.SEQUENCE_NO = 1
                       AND term.SEQUENCE_NO = 1
                       AND term.item_code = 'TERM'
                       AND term.item_value = '144410'
                       AND term.request_no = crn.request_no
                       AND m.request_no = term.request_no
                       AND m.OBJECT_CODE = 'WF_GRADE_APPROVAL'
                       AND m.REQUEST_STATUS = 'C')
       AND sfrstcr_rsts_code IN ('RE', 'RW') ;
       
       -------------- ������� ������ ��� ����
       SELECT DISTINCT sfrstcr_term_code term_code, sfrstcr_crn crn
  FROM sfrstcr x, ssbsect
 WHERE     ssbsect_term_code = sfrstcr_term_code
  AND SSBSECT_GRADABLE_IND = 'Y'
       AND ssbsect_crn = sfrstcr_crn
       AND sfrstcr_term_code = '144410'
       AND sfrstcr_grde_code IS NOT NULL
       AND sfrstcr_grde_date IS   NULL
      
       AND SFRSTCR_CRN IN
               (SELECT crn.ITEM_VALUE
                  FROM request_details crn, request_details term ,request_master m
                 WHERE     crn.item_code = 'CRN'
                       AND crn.SEQUENCE_NO = 1
                       AND term.SEQUENCE_NO = 1
                       AND term.item_code = 'TERM'
                       AND term.item_value = '144410'
                       AND term.request_no = crn.request_no
                       AND m.request_no = term.request_no
                       AND m.OBJECT_CODE = 'WF_GRADE_APPROVAL'
                       AND m.REQUEST_STATUS = 'C')
       AND sfrstcr_rsts_code IN ('RE', 'RW') ;
                       ------------��� ������ ��� ���� ��� ����� ��������
 SELECT DISTINCT sfrstcr_term_code term_code, sfrstcr_crn crn ,ssbsect_subj_code||ssbsect_crse_numb subject
  FROM sfrstcr x, ssbsect
 WHERE     ssbsect_term_code = sfrstcr_term_code
  AND SSBSECT_GRADABLE_IND = 'Y'
       AND ssbsect_crn = sfrstcr_crn
       AND sfrstcr_term_code = '144410'
       AND sfrstcr_grde_code IS NOT NULL
       AND sfrstcr_grde_date IS   NULL
      
       AND SFRSTCR_CRN not IN
               (SELECT crn from gac_crn
               where term_code='144410')
       AND sfrstcr_rsts_code IN ('RE', 'RW') ;
       
       