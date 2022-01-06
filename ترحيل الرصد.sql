
DECLARE
   CURSOR crs_get_crn
   IS
      /* Formatted on 7/25/2020 8:09:03 PM (QP5 v5.360)  
SELECT DISTINCT sfrstcr_term_code term_code, sfrstcr_crn crn
  FROM sfrstcr x, ssbsect
 WHERE     ssbsect_term_code = sfrstcr_term_code
       AND ssbsect_crn = sfrstcr_crn
       AND sfrstcr_term_code = '144030'
       AND sfrstcr_grde_code IS NOT NULL
       AND sfrstcr_grde_date IS NULL
       AND SSBSECT_GRADABLE_IND = 'Y'
       AND SFRSTCR_CRN IN
               (SELECT crn.ITEM_VALUE
                  FROM request_details crn, request_details term ,request_master m
                 WHERE     crn.item_code = 'CRN'
                       AND crn.SEQUENCE_NO = 1
                       AND term.SEQUENCE_NO = 1
                       AND term.item_code = 'TERM'
                       AND term.item_value = '144030'
                       AND term.request_no = crn.request_no
                       AND m.request_no = term.request_no
                       AND m.OBJECT_CODE = 'WF_GRADE_APPROVAL'
                       AND m.REQUEST_STATUS = 'C')
       AND sfrstcr_rsts_code IN ('RE', 'RW') ;

--AND ssbsect_ptrm_code = '2';*/
/*SELECT DISTINCT sfrstcr_term_code term_code, sfrstcr_crn crn  
  FROM sfrstcr x, ssbsect
 WHERE     ssbsect_term_code = sfrstcr_term_code
  AND SSBSECT_GRADABLE_IND = 'Y'
       AND ssbsect_crn = sfrstcr_crn
       AND sfrstcr_term_code = '144030'
       AND sfrstcr_grde_code IS NOT NULL
       AND sfrstcr_grde_date IS   NULL
      
       AND SFRSTCR_CRN   IN
               (SELECT crn from gac_crn
               where term_code='144030'
              and WF_REQUEST_NO is   null
and COLL_CODE=15)
                
       AND sfrstcr_rsts_code IN ('RE', 'RW') ;
       */
       SELECT DISTINCT sfrstcr_term_code term_code, sfrstcr_crn crn
  FROM sfrstcr x, ssbsect
 WHERE     ssbsect_term_code = sfrstcr_term_code
       AND ssbsect_crn = sfrstcr_crn
       AND sfrstcr_term_code = '144030'
       AND sfrstcr_grde_code IS NOT NULL
       AND sfrstcr_grde_date IS NULL
       AND SSBSECT_GRADABLE_IND = 'Y'
       AND SFRSTCR_CRN IN
               (SELECT crn.ITEM_VALUE
                  FROM request_details  crn,
                       request_details  term,
                       request_master   m
                 WHERE     crn.item_code = 'CRN'
                       AND crn.SEQUENCE_NO = 1
                       AND term.SEQUENCE_NO = 1
                       AND term.item_code = 'TERM'
                       AND term.item_value = '144030'
                       AND term.request_no = crn.request_no
                       AND m.request_no = term.request_no
                       AND m.OBJECT_CODE = 'WF_GRADE_APPROVAL'
                       AND m.REQUEST_STATUS = 'P'
                       AND m.request_no IN
                               (SELECT request_no
                                  FROM wf_request_flow
                                 WHERE     USER_PIDM = 69851
                                       AND ACTION_CODE IS NULL
                                       AND ROLE_CODE = 'RO_COLLEGE_DEAN_GA'))
       AND sfrstcr_rsts_code IN ('RE', 'RW');

BEGIN
   FOR r IN crs_get_crn
   LOOP
      shkrols.p_do_graderoll (r.term_code,
                              r.crn,
                              'WORKFLOW',
                              '1',
                              '1',
                              'O',
                              '',
                              '',
                              '',
                              '');
   END LOOP;
END;

/*
------------************************›Ï Õ«·… —’œ «·œ—Ã«  „‰ „·› Ê —ÕÌ· «·—’œ

UPDATE bu_dev.tmp_tbl03
   SET COL02 = f_get_pidm (TRIM (COL01));

SELECT *
  FROM bu_dev.tmp_tbl03
 WHERE COL02 IS NULL;

SELECT f_get_std_id (sfrstcr_pidm), f_get_std_name (sfrstcr_pidm)
  FROM sfrstcr
 WHERE     sfrstcr_term_code = '144010'
       AND (sfrstcr_pidm, sfrstcr_crn) IN
              (SELECT COL02, COL03 FROM bu_dev.tmp_tbl03);



UPDATE SFRSTCR
   SET SFRSTCR_GRDE_CODE =
          (SELECT COL04
             FROM bu_dev.tmp_tbl03
            WHERE COL02 = sfrstcr_pidm AND COL03 = sfrstcr_crn AND ROWNUM < 2),
       SFRSTCR_GRDE_DATE = NULL,
       SFRSTCR_DATA_ORIGIN = 'BannerIT'
 WHERE     sfrstcr_term_code = '144010'
       AND (sfrstcr_pidm, sfrstcr_crn) IN
              (SELECT COL02, COL03 FROM bu_dev.tmp_tbl03);

DECLARE
   CURSOR crs_get_crn
   IS
      SELECT DISTINCT '144010' term_code, COL03 crn FROM bu_dev.tmp_tbl03;

BEGIN
   FOR r IN crs_get_crn
   LOOP
      shkrols.p_do_graderoll (r.term_code,
                              r.crn,
                              'WORKFLOW',
                              '1',
                              '1',
                              'O',
                              '',
                              '',
                              '',
                              '');
   END LOOP;
END;


-- missing students

SELECT f_get_std_id (COL02), f_get_std_name (COL02), COL03
  FROM bu_dev.tmp_tbl03
 WHERE (COL02, COL03) NOT IN (SELECT sfrstcr_pidm, sfrstcr_crn
                                FROM sfrstcr
                               WHERE sfrstcr_term_code = '144010');


/*
  -----------------****************---------------------
  -- —’œ ‰Â«Ì… «·›’· «·œ—«”Ì ··„ﬁ——«  «·€Ì— Œ«÷⁄… ··«⁄ „«œ

DECLARE
   CURSOR crs_get_crn
   IS
      SELECT DISTINCT sfrstcr_term_code term_code, sfrstcr_crn crn
        FROM sfrstcr x, ssbsect
       WHERE     ssbsect_term_code = sfrstcr_term_code
             AND ssbsect_crn = sfrstcr_crn
             AND sfrstcr_term_code = '144010'
             AND sfrstcr_grde_code IS NOT NULL
             AND sfrstcr_grde_date IS NULL
             AND SFRSTCR_CRN NOT IN
                    (SELECT DISTINCT crn.item_value
                       FROM request_details crn,
                            request_details term,
                            request_master a
                      WHERE     a.object_code = 'WF_GRADE_APPROVAL'
                            AND A.REQUEST_NO = crn.REQUEST_NO
                            AND A.REQUEST_NO = term.REQUEST_NO
                            AND TERM.SEQUENCE_NO = 1
                            AND CRN.SEQUENCE_NO = 1
                            AND CRN.ITEM_CODE = 'CRN'
                            AND TERM.ITEM_CODE = 'TERM'
                            AND TERM.ITEM_VALUE = '144010')--<<<<<<<<<term_code>>>>>>>>>>
             AND sfrstcr_rsts_code IN ('RE', 'RW', '⁄');

--AND ssbsect_ptrm_code = '2';

BEGIN
   FOR r IN crs_get_crn
   LOOP
      shkrols.p_do_graderoll (r.term_code,
                              r.crn,
                              'WORKFLOW',
                              '1',
                              '1',
                              'O',
                              '',
                              '',
                              '',
                              '');
   END LOOP;
END;

sgbstdn

*/

-- —ÕÌ· ‘⁄»… „⁄Ì‰…
DECLARE
   CURSOR crs_get_crn
   IS
SELECT DISTINCT sfrstcr_term_code term_code, sfrstcr_crn crn
  FROM sfrstcr x 
 WHERE     
         sfrstcr_term_code = '143510'
       AND sfrstcr_grde_code IS NOT NULL
       AND sfrstcr_grde_date IS NULL
       and sfrstcr_crn='10047'
       AND sfrstcr_rsts_code IN ('RE', 'RW');

BEGIN
   FOR r IN crs_get_crn
   LOOP
      shkrols.p_do_graderoll (r.term_code,
                              r.crn,
                              'WORKFLOW',
                              '1',
                              '1',
                              'O',
                              '',
                              '',
                              '',
                              '');
   END LOOP;
END;
-------------------------------------------
DECLARE
   CURSOR crs_get_crn
   IS
       
SELECT DISTINCT sfrstcr_term_code term_code, sfrstcr_crn crn
  FROM sfrstcr x, ssbsect
 WHERE     ssbsect_term_code = sfrstcr_term_code
       AND ssbsect_crn = sfrstcr_crn
       AND sfrstcr_term_code = '144310'
       AND sfrstcr_grde_code IS NOT NULL
       AND sfrstcr_grde_date IS NULL
       AND SSBSECT_GRADABLE_IND = 'Y'
       
       AND sfrstcr_rsts_code IN ('RE', 'RW') ;
 

BEGIN
   FOR r IN crs_get_crn
   LOOP
      shkrols.p_do_graderoll (r.term_code,
                              r.crn,
                              'BannerDC',
                              '1',
                              '1',
                              'O',
                              '',
                              '',
                              '',
                              '');
   END LOOP;
END;

----**************************** —ÕÌ· ⁄«œÌ
/* Formatted on 05/05/2021 19:27:45 (QP5 v5.227.12220.39754) */
DECLARE
   CURSOR crs_get_crn
   IS
      SELECT DISTINCT sfrstcr_term_code term_code, sfrstcr_crn crn
        FROM sfrstcr x, ssbsect
       WHERE     ssbsect_term_code = sfrstcr_term_code
             AND ssbsect_crn = sfrstcr_crn
             AND sfrstcr_term_code = '144310'
             AND sfrstcr_grde_code IS NOT NULL
             AND sfrstcr_grde_date IS NULL
             AND SSBSECT_GRADABLE_IND = 'Y';

BEGIN
   FOR r IN crs_get_crn
   LOOP
      shkrols.p_do_graderoll (r.term_code,
                              r.crn,
                              'WORKFLOW',
                              '1',
                              '1',
                              'O',
                              '',
                              '',
                              '',
                              '');
   END LOOP;
END;