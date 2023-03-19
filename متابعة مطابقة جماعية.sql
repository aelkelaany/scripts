select count(1) from SMRRQCM
where to_char(SMRRQCM_REQUEST_DATE,'dd-mm-yyyy')='05-03-2023'
and SMRRQCM_PROCESS_IND='Y' ;

 