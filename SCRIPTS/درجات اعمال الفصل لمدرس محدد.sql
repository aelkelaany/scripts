select f_get_std_id(sfrstcr_pidm)id, f_get_std_name(sfrstcr_pidm) name ,SFRSTCR_GRDE_CODE_MID ,sfrstcr_crn ,scbcrse_title
from
sfrstcr,ssbsect,scbcrse,sirasgn
where sfrstcr_term_code='144020'
and sfrstcr_rsts_code in ('RE','RW')
 and sfrstcr_term_code=ssbsect_term_code
 and sfrstcr_term_code=sirasgn_term_code
 and sfrstcr_crn=ssbsect_crn
 and sfrstcr_crn=sirasgn_crn
 and scbcrse_subj_code||scbcrse_crse_numb=ssbsect_subj_code||ssbsect_crse_numb
 and SCBCRSE_EFF_TERM=(select max(SCBCRSE_EFF_TERM) from scbcrse where scbcrse_subj_code||scbcrse_crse_numb=ssbsect_subj_code||ssbsect_crse_numb)
 and sirasgn_pidm=f_get_pidm('3743')
 and SIRASGN_PRIMARY_IND='Y'
 order by sfrstcr_crn ,f_get_std_name(sfrstcr_pidm);