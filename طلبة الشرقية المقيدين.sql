/* Formatted on 3/10/2020 11:34:13 AM (QP5 v5.227.12220.39754) */
SELECT distinct  f_get_std_id(sgbstdn_pidm) id ,f_get_std_name(sgbstdn_pidm) name ,SPBPERS_ssn ssn ,f_get_desc_fnc ('STVSTST', sgbstdn_stst_code, 60) status,
       f_get_desc_fnc ('STVCOLL', sgbstdn_coll_code_1, 60) college,
       f_get_desc_fnc ('STVDEPT', sgbstdn_dept_code, 60) department,
       f_get_desc_fnc ('STVCAMP', sgbstdn_camp_code, 60) campus,
       f_get_desc_fnc ('STVMAJR', sgbstdn_majr_code_1, 60) major,
f_get_desc_fnc ('STVSTYP', SGBSTDN_STYP_CODE, 60) studyType ,(
select distinct SPRTELE_INTL_ACCESS 
from SPRTELE
where SGBSTDN_PIDM=SPRTELE_PIDM(+)
and SPRTELE_TELE_CODE in ('HO','MO')
and rownum<2
) AS "ÑÞã ÇáÌæÇá" ,EDUCATION_CENTER
  FROM moe_cd, SPBPERS, sgbstdn sg  
 WHERE     SPBPERS_ssn = STUDENT_SSN
       AND EDUCATION_CENTER IN
              ('ÇáãÚåÏ ÇáÚáãí Ýí ãÍÇÝÙÉ ÍÝÑ ÇáÈÇØä - ÇáãÑÍáÉ ÇáËÇäæíÉ',
               'ÇáãÚåÏ ÇáÚáãí Ýí ãÍÇÝÙÉ ÇáÃÍÓÇÁ - ÇáãÑÍÇáÉ ÇáËÇäæíÉ',
               'ÇáãÚåÏ ÇáÚáãí Ýí ÇáÜÏãÜÜÜÜÇã - ÇáãÑÍáÉ ÇáËÇäæíÉ',
               'ÇáÅÏÇÑÉ ÇáÚÇãÉ ááÊÚáíã ÈãÍÇÝÙÉ ÇáÇÍÓÇÁ',
               'ÇáÇÏÇÑÉ ÇáÚÇãÉ ááÊÚáíã ÈÇãÍÇÝÙÉ ÇáÇÍÓÇÁ',
               'ÇáÅÏÇÑÉ ÇáÚÇãÉ ááÊÚáíã ÈÇáãäØÞÉ ÇáÔÑÞíÉ',
               'ÇáÇÏÇÑÉ ÇáÚÇãÉ ááÊÚáíã ÈãÍÇÝÙÉ ÇáÇÍÓÇÁ',
               'ÅÏÇÑÉ ÇáÊÚáíã ÈãÍÇÝÙÉ ÍÝÑ ÇáÈÇØä',
               'ÇáåíÆÉ ÇáãáßíÉ - ÇáÌÈíá',
               'ÇáÅÏÇÑÉ ÇáÚÇãÉ ááÊÚáíã ÈÇáãäØÞÉ ÇáÔÑÞíÉ.',
               'ÇáÅÏÇÑÉ ÇáÚÇãÉ ááÊÚáíã ÈÇáãäØÞÉ ÇáÔÑÞíÉ - ÇáåíÆÉ ÇáãáßíÉ ÈÇáÌÈíá')
       AND sgbstdn_pidm = SPBPERS_pidm
       AND sgbstdn_term_code_eff = (SELECT MAX (sgbstdn_term_code_eff)
                                      FROM sgbstdn
                                     WHERE sgbstdn_pidm = sg.sgbstdn_pidm
                                     and sgbstdn_term_code_eff<='144020')
       AND SGBSTDN_STST_CODE IN
              ('AS', 'ãæ', 'ãÚ', 'Øã', 'ÅÞ', 'Ýß', 'ÅÊ')
              
              order by college,department,campus
              
              
              dev_sys_parameters