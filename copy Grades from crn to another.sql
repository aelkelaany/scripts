update sfrstcr a 
set (a.SFRSTCR_GRDE_CODE,a.SFRSTCR_GRDE_CODE_MID)=(select SFRSTCR_GRDE_CODE ,SFRSTCR_GRDE_CODE_MID
from SFRSTCR
where sfrstcr_term_code='144010'
and sfrstcr_crn='14912'
and sfrstcr_pidm=a.sfrstcr_pidm
  and SFRSTCR_GRDE_CODE is not null )
where a.sfrstcr_term_code='144010'
and a.sfrstcr_crn='13524'
and a.SFRSTCR_GRDE_CODE is null 
 AND a.SFRSTCR_RSTS_CODE IN ('RE','RW')