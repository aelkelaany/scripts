declare
cursor get_intsab_crns is select ssbsect_crn crn from ssbsect where SSBSECT_TERM_CODE='143920'
and SSBSECT_PTRM_CODE=2 and ssbsect_crn not in  ( SELECT C.ITEM_VALUE
  FROM request_details a, request_master b, request_details C ,ssbsect 
 WHERE     b.request_no = a.request_no
       AND b.oBject_code = 'WF_GRADE_APPROVAL'
       AND A.ITEM_CODE = 'TERM'
       AND A.ITEM_VALUE = '143920'
       AND b.request_no = C.request_no
       AND C.ITEM_CODE = 'CRN'
       AND A.SEQUENCE_NO = 1
       AND C.SEQUENCE_NO = 1
       and C.ITEM_VALUE=ssbsect_crn
       and SSBSECT_TERM_CODE='143920'
       and SSBSECT_PTRM_CODE<>2-- intsab = 2 
       )
       and SSBSECT_GRADABLE_IND='Y'
        
       and exists (select '1' from sfrstcr where SFRSTCR_TERM_CODE='143920' and SFRSTCR_crn=ssbsect_crn and SFRSTCR_RSTS_CODE in ('RE','RW') /*and SFRSTCR_GRDE_DATE is null*/ )
         ;
begin

for rec in get_intsab_crns loop
shkrols.p_do_graderoll ('143920',
                                 rec.crn,
                                 'BANNER',
                                 '1',
                                 '1',
                                 'O',
                                 '',
                                 '',
                                 '',
                                 '');
                                 end loop ; 
end;