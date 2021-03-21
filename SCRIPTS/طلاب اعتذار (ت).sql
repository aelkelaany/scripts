select f_get_std_id(sfrstcr_pidm) ,f_get_std_name(sfrstcr_pidm),sfrstcr_crn ,SFRSTCR_RSTS_CODE   from sfrstcr
where sfrstcr_term_code='143920'
and SFRSTCR_GRDE_CODE='Í' 
and SFRSTCR_RSTS_CODE in ('RE','RW')
order by 1 