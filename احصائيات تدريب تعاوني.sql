select  count(1) "«⁄œ«œ «·Œ—ÌÃÌ‰", decode(SPBPERS_SEX,'M','–ﬂ—','√‰ÀÏ') "«·Ã‰”",to_char(SHRDGMR_GRAD_DATE,'YYYY') "«·⁄«„" from
shrdgmr,spbpers
where SHRDGMR_DEGS_CODE='ŒÃ'
and to_char(SHRDGMR_GRAD_DATE,'YYYY') in('2019','2020','2021')
and SHRDGMR_LEVL_CODE='Ã„'
and SHRDGMR_DEGC_CODE='»ﬂ'
and (SHRDGMR_COLL_CODE_1 in ('13','14','16','32','33','55') or SHRDGMR_DEPT_CODE in (select DEPT_CODE from symtrcl_dept_mapping
where GENERAL_DEPT in ('IDES','FASH','NUTR')
)) 
and spbpers_pidm=shrdgmr_pidm
group by SPBPERS_SEX ,to_char(SHRDGMR_GRAD_DATE,'YYYY')
order by 3


;

select  count(distinct shrdgmr_pidm) "«⁄œ«œ «·Œ—ÌÃÌ‰" ,to_char(SHRDGMR_GRAD_DATE,'YYYY') "«·⁄«„" from
shrdgmr 
where SHRDGMR_DEGS_CODE='ŒÃ'
and to_char(SHRDGMR_GRAD_DATE,'YYYY') in('2019','2020','2021')
and SHRDGMR_LEVL_CODE='Ã„'
and SHRDGMR_DEGC_CODE='»ﬂ'
  
 
group by    to_char(SHRDGMR_GRAD_DATE,'YYYY')
order by 2




