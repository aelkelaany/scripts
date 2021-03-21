declare 
 
cursor get_crn is select distinct crn  crn  from mahamoud.syr_del    ;
crn_counter number:=0;
begin

 for crn_rec in get_crn loop
 update ssbsect set SSBSECT_MAX_ENRL=0 , SSBSECT_ENRL=0 ,SSBSECT_SEATS_AVAIL=0,SSBSECT_TOT_CREDIT_HRS=0
where ssbsect_term_code='144020' and ssbsect_crn=crn_rec.crn;

delete sfrstcr 
where crn_rec.crn=sfrstcr_crn and sfrstcr_term_code='144020';
crn_counter:=crn_counter+1;
dbms_output.put_line(crn_rec.crn||'---->>>crns');
end loop; 
dbms_output.put_line(crn_counter||'updated crns');


end ; 