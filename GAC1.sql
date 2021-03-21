DECLARE
   items_t         wf_navigation.varchar_tab DEFAULT wf_navigation.empty_tab;
   items_value_t   wf_navigation.varchar_tab DEFAULT wf_navigation.empty_tab;
   attributes_t    wf_navigation.varchar_tab DEFAULT wf_navigation.empty_tab;

   l_pidm          NUMBER;
BEGIN
   items_t (1) := 'TERM';
   items_t (2) := 'CRN';
   items_t (3) := 'COLLEGE';
   items_t (4) := 'DEPARTMENT';

   items_value_t (1) := '143930';
   items_value_t (2) := '30534'; --CRN
   items_value_t (3) := '32';    --College
   items_value_t (4) := '3203';      --Departmnt

   attributes_t (1) := '';
   attributes_t (2) := '';
   attributes_t (3) := 'COLLEGE';
   attributes_t (4) := 'DEPARTMENT';

   l_pidm :=
      wf_grade_approval.wfmf_get_approver (0,
                                             2,
                                             'WF_GRADES_APPROVAL',
                                             items_t,
                                             items_value_t,
                                             attributes_t);

   DBMS_OUTPUT.put_line ('Department Head = ' || f_get_std_name(l_pidm));

   l_pidm := '';
   l_pidm :=
      wf_grade_approval.wfmf_get_approver (0,
                                           3,
                                           'WF_GRADES_APPROVAL',
                                           items_t,
                                           items_value_t,
                                           attributes_t);

   DBMS_OUTPUT.put_line ('Vice Dean = ' ||  f_get_std_name(l_pidm));

   l_pidm := '';
   l_pidm :=
      wf_grade_approval.wfmf_get_approver (0,
                                             4,
                                             'WF_GRADES_APPROVAL',
                                             items_t,
                                             items_value_t,
                                             attributes_t);

   DBMS_OUTPUT.put_line ('College Dean = ' || f_get_std_name(l_pidm));
END;
select f_get_std_name(67900) from dual 