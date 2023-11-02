select count(1) from SMRRQCM
where to_char(SMRRQCM_REQUEST_DATE,'dd-mm-yyyy')='31-10-2023'
and SMRRQCM_PROCESS_IND='Y' ;

 