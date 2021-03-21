select a.sgbstdn_pidm  ,f_get_std_id(a.sgbstdn_pidm) id  from sgbstdn a  where 
a.sgbstdn_term_code_eff=(select max(b.sgbstdn_term_code_eff) from sgbstdn b 
where b.sgbstdn_pidm=a.sgbstdn_pidm
and b.sgbstdn_term_code_eff<='143920'
)
and SGBSTDN_STST_CODE='ÎÌ'
and SGBSTDN_LEVL_CODE='Ìã'
and SGBSTDN_RESD_CODE='Û'
and exists (select '1' from gobintl where gobintl_pidm=sgbstdn_pidm)



SPRINTL

GOBINTL

bu_devs.tmp_tbl03

435014147