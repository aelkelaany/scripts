DECLARE
   items_t         wf_navigation.varchar_tab DEFAULT wf_navigation.empty_tab;
   items_value_t   wf_navigation.varchar_tab DEFAULT wf_navigation.empty_tab;
   attributes_t    wf_navigation.varchar_tab DEFAULT wf_navigation.empty_tab;

   l_pidm          NUMBER;
   cursor get_crns is select scbcrse_coll_code , scbcrse_dept_code ,
   ssbsect_crn ,A.SCBCRSE_SUBJ_CODE ,A.SCBCRSE_CRSE_NUMB ,scbcrse_title
   from scbcrse a  , ssbsect
   where   A.SCBCRSE_EFF_TERM =
                (SELECT MAX (SCBCRSE_EFF_TERM)
                   FROM SCBCRSE
                  WHERE     SCBCRSE_SUBJ_CODE = A.SCBCRSE_SUBJ_CODE
                        AND SCBCRSE_CRSE_NUMB = A.SCBCRSE_CRSE_NUMB
                        AND SCBCRSE_EFF_TERM <= '144210')
                        and A.SCBCRSE_SUBJ_CODE=ssbsect_subj_code
                        and A.SCBCRSE_CRSE_NUMB=ssbsect_crse_numb
                        and ssbsect_term_code='144210'
                        and SSBSECT_GRADABLE_IND='Y'
                        and SSBSECT_ENRL>0
                       --  and SCBCRSE_COLL_CODE   not in ('11','00')
                        and ssbsect_crn not in (SELECT DISTINCT crn.item_value
                       FROM request_details crn,
                            request_details term,
                            request_master a
                      WHERE     a.object_code = 'WF_GRADE_APPROVAL'
                            AND A.REQUEST_NO = crn.REQUEST_NO
                            AND A.REQUEST_NO = term.REQUEST_NO
                            AND TERM.SEQUENCE_NO = 1
                            AND CRN.SEQUENCE_NO = 1
                            AND CRN.ITEM_CODE = 'CRN'
                            AND TERM.ITEM_CODE = 'TERM'
                            AND TERM.ITEM_VALUE = '144210'
                              and a.REQUEST_STATUS='C')
                          
                        ;
   l_vice_pidm number ;
   l_dept_pidm number ;
   l_dean_pidm number ;
BEGIN
delete from GAC_CRN where term_code='144210';
   items_t (1) := 'TERM';
   items_t (2) := 'CRN';
   items_t (3) := 'COLLEGE';
   items_t (4) := 'DEPARTMENT';
for rec in get_crns loop 
   items_value_t (1) := '144210';
   items_value_t (2) := rec.ssbsect_crn; --CRN
   items_value_t (3) :=  rec.scbcrse_coll_code;    --College
   items_value_t (4) := rec.scbcrse_dept_code;      --Departmnt

   attributes_t (1) := '';
   attributes_t (2) := '';
   attributes_t (3) := 'COLLEGE';
   attributes_t (4) := 'DEPARTMENT';

   l_dept_pidm :=
      wf_grade_approval.wfmf_get_approver (0,
                                             2,
                                             'WF_GRADES_APPROVAL',
                                             items_t,
                                             items_value_t,
                                             attributes_t);

  -- DBMS_OUTPUT.put_line ('Department Head = ' || f_get_std_name(l_pidm));

    
   l_vice_pidm :=
      wf_grade_approval.wfmf_get_approver (0,
                                           3,
                                           'WF_GRADES_APPROVAL',
                                           items_t,
                                           items_value_t,
                                           attributes_t);

  -- DBMS_OUTPUT.put_line ('Vice Dean = ' ||  f_get_std_name(l_pidm));

    
   l_dean_pidm :=
      wf_grade_approval.wfmf_get_approver (0,
                                             4,
                                             'WF_GRADES_APPROVAL',
                                             items_t,
                                             items_value_t,
                                             attributes_t);

   --DBMS_OUTPUT.put_line ('College Dean = ' || f_get_std_name(l_pidm));
   insert into GAC_CRN values ('144210',rec.ssbsect_crn,rec.scbcrse_coll_code , rec.scbcrse_dept_code,rec.SCBCRSE_SUBJ_CODE ,rec.SCBCRSE_CRSE_NUMB,rec.scbcrse_title,l_dept_pidm,l_vice_pidm,l_dean_pidm,0);
   
   
   end loop ; 
   
 UPDATE GAC_CRN
   SET wf_request_no =
          (SELECT MAX (crn.request_no)
             FROM request_details crn, request_details term, request_master a
            WHERE     a.object_code = 'WF_GRADE_APPROVAL'
                  AND A.REQUEST_NO = crn.REQUEST_NO
                  AND A.REQUEST_NO = term.REQUEST_NO
                  AND TERM.SEQUENCE_NO = 1
                  AND CRN.SEQUENCE_NO = 1
                  AND CRN.ITEM_CODE = 'CRN'
                  AND TERM.ITEM_CODE = 'TERM'
                  AND TERM.ITEM_VALUE = '144210'
                  AND crn.item_value = GAC_CRN.crn)
 WHERE     term_code = '144210'
       AND NOT EXISTS
                  (SELECT '1'
                     FROM sfrstcr
                    WHERE     sfrstcr_term_code = '144210'
                          AND SFRSTCR_GRDE_CODE IS NULL
                          and sfrstcr_crn=GAC_CRN.crn );
                            commit ;
--                                and  crn   in (SELECT DISTINCT crn.item_value
--                       FROM request_details crn,
--                            request_details term,
--                            request_master a
--                      WHERE     a.object_code = 'WF_GRADE_APPROVAL'
--                            AND A.REQUEST_NO = crn.REQUEST_NO
--                            AND A.REQUEST_NO = term.REQUEST_NO
--                            AND TERM.SEQUENCE_NO = 1
--                            AND CRN.SEQUENCE_NO = 1
--                            AND CRN.ITEM_CODE = 'CRN'
--                            AND TERM.ITEM_CODE = 'TERM'
--                            AND TERM.ITEM_VALUE = '144010')
commit ; 
END;  
--drop table  GAC_CRN;
--  create table GAC_CRN ( term_code varchar2(8) , crn varchar2(8) ,coll_code varchar2(8) , dept_code varchar2(8),SUBJ_CODE varchar2(8),CRSE_NUMB varchar2(8), scbcrse_title varchar2(150), dept_pidm number , vice_pidm number ,dean_pidm number ,wf_request_no number(9)); ;

BU_APPS.GRADES_APPROVAL_EXECLUDED_CRN