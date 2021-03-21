select count(  sgbstdn_pidm) counts ,'all_std'
 
  from sgbstdn sg
where  
  SGBSTDN_TERM_CODE_EFF=(select max(SGBSTDN_TERM_CODE_EFF) from sgbstdn where sgbstdn_pidm=sg.sgbstdn_pidm )
and SGBSTDN_STST_CODE='AS'
and SGBSTDN_STYP_CODE='ä' 
union 
select count(  distinct sfrstcr_pidm) ,'all_regs'
from sfrstcr
where sfrstcr_term_code='144210' 
and sfrstcr_rsts_code in ('RW','RE')
and exists (select '1' from sgbstdn
where sgbstdn_pidm=sfrstcr_pidm
and SGBSTDN_TERM_CODE_EFF=(select max(SGBSTDN_TERM_CODE_EFF) from sgbstdn where sgbstdn_pidm=sfrstcr_pidm)
and SGBSTDN_STST_CODE='AS'
and SGBSTDN_STYP_CODE='ä')