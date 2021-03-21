/* Formatted on 8/25/2019 11:03:29 AM (QP5 v5.227.12220.39754) */
SELECT distinct a.STUDENT_SSN,f_get_std_id(a.STUDENT_PIDM) ,
       ADMISSION_TYPE,
       FIRST_NAME_AR || ' ' || MIDDLE_NAME_AR || ' ' || LAST_NAME_AR name,
       GENDER,
       MOBILE,
         
       ADDRESS_CITY,
       ADDRESS_STREET,
      decode( DPLM_TYPE,'œ','√œ»Ì','⁄','⁄·„Ì') diplome_type ,
       GPA ,   TEST_SCORE_2  tripple ,   TEST_SCORE_3  doublee ,choise , sgbstdn_program_1 , smrprle_program_desc current_major 
  FROM adm_housing_tmp, stu_main_data_vw a ,moe_cd b ,sgbstdn ,smrprle 
 WHERE ssn = a.STUDENT_SSN
 and ssn=b.STUDENT_SSN
 and a.STUDENT_PIDM=sgbstdn_pidm 
 and  sgbstdn_program_1= smrprle_program
 AND   EXISTS
                         (SELECT '1'
                            FROM SARAPPD
                           WHERE     SARAPPD_PIDM =  a.STUDENT_PIDM
                                 AND SARAPPD_APDC_CODE = 'FA'
                                 AND SARAPPD_TERM_CODE_ENTRY = '144010')
                                 
                             /*    and b.STUDENT_SSN not in ( select STUDENT_SSN from stu_main_data_vw where STUDENT_PIDM in ( select SARAPPD_pidm  FROM SARAPPD
                           WHERE     
                                    SARAPPD_APDC_CODE = 'FA' ) )
 and a.STUDENT_PIDM in ( select sgbstdn_pidm from  sgbstdn 
 
 )*/
 order by GENDER ,TEST_SCORE_3 ,a.STUDENT_SSN ;
 
  create table adm_housing_tmp (ssn varchar2(11),pidm number(6))