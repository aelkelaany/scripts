select f_get_std_id (sfrstcr_PIDM),f_get_std_name(sfrstcr_PIDM) ,sum(SFRSTCR_CREDIT_HR) ,COUNT(1)
from 
sfrstcr,sgbstdn A 
where sfrstcr_PIDM=sgbstdn_pidm
AND sgbstdn_TERM_CODE_EFF = (SELECT MAX(sgbstdn_TERM_CODE_EFF) FROM sgbstdn WHERE sgbstdn_pidm=A.sgbstdn_pidm AND sgbstdn_TERM_CODE_EFF<='143920' )
AND SGBSTDN_STST_CODE='AS'
and sfrstcr_term_code='143920'
and SGBSTDN_COLL_CODE_1='14'
and SFRSTCR_RSTS_CODE in ('RE','RW')
HAVING sum(SFRSTCR_CREDIT_HR)  <12
group by sfrstcr_PIDM
ORDER BY 3 ,1