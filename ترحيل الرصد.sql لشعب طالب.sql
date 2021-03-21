
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
     --  AND SSBSECT_GRADABLE_IND = 'Y'
        and sfrstcr_pidm=f_get_pidm('441007402') ;

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

 