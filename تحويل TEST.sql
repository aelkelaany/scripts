-- common rule 

select f_get_pidm(:stdId) from dual  ;
SELECT 1 FROM DUAL 
 WHERE 
   F_GET_STATUS(:pidm) IN ('AS','„Ê','„⁄') 
 AND  F_GET_STYP(:pidm) NOT IN ('‰',' ') 
 AND  F_GET_GPA(:pidm) >= 1 
 AND  F_ALLOW_TRANSFER_REQUEST(:pidm) = 'Y' 
 AND (( F_GET_3_ID_DIGIT(:pidm) IN ('443','444') 
 AND  F_GET_LEVEL(:pidm) = 'Ã„' )
 OR ( F_GET_3_ID_DIGIT(:pidm) = '444' 
 AND  F_GET_LEVEL(:pidm) = 'œ»' ))
 ;
 
 --- college
 
 SELECT coll_code code, stvcoll_desc description
        FROM trn_college_rules, stvcoll
       WHERE     COLL_CODE = stvcoll_code
             AND term_code = '144440'
             AND f_check_rule (:pidm, rule_code) = 'Y'
             AND allow_transfer_type IN ('I', 'B')
             AND (gender = 'F' OR gender = 'B')
             AND coll_code != '14'
            -- AND p_transfer_type = 'COLLEGE'
             ;
    -- majors 
      SELECT majr_code, stvmajr_desc
        FROM trn_major_rules, stvmajr
       WHERE     MAJR_CODE = stvmajr_code
             AND TERM_CODE = '144440'
            AND COLL_CODE  in (SELECT coll_code code 
        FROM trn_college_rules, stvcoll
       WHERE     COLL_CODE = stvcoll_code
             AND term_code = '144440'
             AND f_check_rule (:pidm, rule_code) = 'Y'
             AND allow_transfer_type IN ('I', 'B')
             AND (gender = 'F' OR gender = 'B')
            )
             AND f_check_rule (:pidm, rule_code) = 'Y'
             AND allow_transfer_type IN ('I', 'B')
             AND (gender = 'F' OR gender = 'B')
            -- AND majr_code != '1801'
            -- AND p_transfer_type = 'MAJOR'
      ORDER BY 1;
 


