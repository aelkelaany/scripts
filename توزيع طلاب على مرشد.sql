Insert into SATURN.SGRADVR
   (SGRADVR_PIDM, SGRADVR_TERM_CODE_EFF, SGRADVR_ADVR_PIDM, SGRADVR_ADVR_CODE, SGRADVR_PRIM_IND, 
    SGRADVR_ACTIVITY_DATE)   
 select 
    distinct sgbstdn_pidm, '144010', f_get_pidm('3776'), '„—‘œ', 'Y', 
   sysdate 
   from 
   sgbstdn sg 
   where sgbstdn_stst_code   in ('„Ê','„⁄' ,'AS')
   --sgbstdn_stst_code not in ('ŒÃ','ÿ”','„”','„Œ','IS','„‰','TE','„›','ÿÌ')
   and sgbstdn_styp_code='‰'
   and SGBSTDN_TERM_CODE_EFF=(select max(SGBSTDN_TERM_CODE_EFF) from sgbstdn where sgbstdn_pidm=sg.sgbstdn_pidm)
   and sgbstdn_coll_code_1='16'
 and sgbstdn_dept_code='1601'
 and SGBSTDN_LEVL_CODE='Ã„';
 
 