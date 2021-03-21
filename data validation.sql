/* Formatted on 12/12/2018 10:51:23 AM (QP5 v5.227.12220.39754) */
--College Deans : no problem

SELECT a.*, f_format_name (dean_pidm, 'FML') name
  FROM bu_dev.college_deans a
 WHERE college IN ('31', '32', '33', '41', '16', '15', '55', '10');

--Vice Deans : no problem

SELECT a.*, f_format_name (vice_pidm, 'FML') name
  FROM bu_dev.college_vice_dean a
 WHERE college IN ('31', '32', '33', '41', '16', '15', '55', '10');

/*******************************************************************************/
--6 Departments no manager defined

SELECT *
  FROM bu_dev.dept_managers
 WHERE     college IN ('31', '32', '33', '41', '16', '15', '55', '10')
       AND DEPARTMENT != '0'
       AND MANAGER_PIDM IS NULL;

--38 Courses : Department not defined

  SELECT college,
         subject,
         course,
         title
    FROM bu_dev.courses
   WHERE     college IN ('31', '32', '33', '41', '16', '15', '55', '10')
         AND NEW_DEPARTMENT IS NULL
ORDER BY 4;


--17 Department : Department Head Not Defined(3101)

  SELECT DISTINCT
         new_department,
         f_get_desc_fnc ('STVDEPT', new_department, 60) dept_desc
    FROM bu_dev.courses a
   WHERE     a.college IN ('31', '32', '33', '41', '16', '15', '55', '10')
         AND NEW_DEPARTMENT IS NOT NULL
         AND NEW_DEPARTMENT != '3101'
         AND (   NOT EXISTS
                    (SELECT 1
                       FROM bu_dev.dept_managers b
                      WHERE a.new_department = b.department)
              OR EXISTS
                    (SELECT 1
                       FROM bu_dev.dept_managers c
                      WHERE     a.new_department = c.department
                            AND c.MANAGER_PIDM IS NULL))
ORDER BY 1;



/*****************************************************************************/

  SELECT DISTINCT
         new_department,
         f_get_desc_fnc ('STVDEPT', new_department, 60) dept_desc
    FROM bu_dev.courses a
   WHERE     a.college IN ('31', '32', '33', '41', '16', '15', '55', '10')
         AND NEW_DEPARTMENT IS NOT NULL
         AND NEW_DEPARTMENT != '3101'
         AND (   NOT EXISTS
                    (SELECT 1
                       FROM bu_dev.dept_managers b
                      WHERE a.new_department = b.department)
              OR EXISTS
                    (SELECT 1
                       FROM bu_dev.dept_managers c
                      WHERE     a.new_department = c.department
                            AND c.MANAGER_PIDM IS NULL))
         AND EXISTS
                (SELECT 1
                   FROM sfrstcr, ssbsect
                  WHERE     ssbsect_term_code = sfrstcr_term_code
                        AND ssbsect_crn = sfrstcr_crn
                        AND a.subject = ssbsect_subj_code
                        AND a.course = ssbsect_crse_numb
                        AND sfrstcr_term_code = '143910'
                        AND sfrstcr_rsts_code IN ('RE', 'RW'))
ORDER BY 1;