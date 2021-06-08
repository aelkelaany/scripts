
Insert into GLBSLCT
   (GLBSLCT_APPLICATION, GLBSLCT_SELECTION, GLBSLCT_CREATOR_ID, GLBSLCT_DESC, GLBSLCT_LOCK_IND, 
    GLBSLCT_ACTIVITY_DATE, GLBSLCT_TYPE_IND)
 Values
   ('STUDENT', 'COMP16', 'SAISUSR', '„ÿ«»ﬁ«  ', 'N', 
    SYSDATE, NULL);
Insert into GLBEXTR
   SELECT DISTINCT 'STUDENT', 'COMP16', 'SAISUSR', 'SAISUSR', PIDM, 
    SYSDATE, 'S', NULL  FROM 
( 
select distinct SMRDOUS_PIDM PIDM ,f_get_std_id(SMRDOUS_PIDM) id  from smrdous m
where 
smrdous_request_no=(select max(smrdous_request_no) from smrdous where smrdous_pidm=m.smrdous_pidm )
and SMRDOUS_GRDE_CODE in ('Õ',' ','€','Â‹'));


select COUNT( distinct SMRDOUS_PIDM  )    from smrdous m
where 
smrdous_request_no=(select max(smrdous_request_no) from smrdous where smrdous_pidm=m.smrdous_pidm )
and SMRDOUS_GRDE_CODE in ('Õ',' ','€','Â‹') ;


select  distinct SMRDOUS_PROGRAM       from smrdous m
where 
smrdous_request_no=(select max(smrdous_request_no) from smrdous where smrdous_pidm=m.smrdous_pidm )
and SMRDOUS_GRDE_CODE in ('Õ',' ','€','Â‹') ;

select  distinct SMRDOUS_PROGRAM  ,f_get_std_id(SMRDOUS_PIDM) id       from smrdous m
where 
smrdous_request_no=(select max(smrdous_request_no) from smrdous where smrdous_pidm=m.smrdous_pidm )
and SMRDOUS_GRDE_CODE in ('Õ',' ','€','Â‹') ;

SMBAGEN