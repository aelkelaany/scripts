CREATE TABLE bu_dev.scbcrse_13122018
AS
   SELECT * FROM saturn.scbcrse;

/***************************************************************************/
  --1216 total
  --435
  -- After Update 185
  SELECT scbcrse_eff_term,
         scbcrse_subj_code,
         scbcrse_crse_numb,
         scbcrse_coll_code,
         scbcrse_dept_code,         
         scbcrse_activity_date,
         scbcrse_user_id
    FROM scbcrse a
   WHERE     a.scbcrse_eff_term =
                (SELECT MAX (b.scbcrse_eff_term)
                   FROM scbcrse b
                  WHERE     b.scbcrse_subj_code = a.scbcrse_subj_code
                        AND b.scbcrse_crse_numb = a.scbcrse_crse_numb)
         AND scbcrse_dept_code IS NULL
         AND scbcrse_coll_code IN
                ('31', '32', '33', '41', '16', '15', '55', '10')
ORDER BY 6 DESC;

/**************************************************************************/

UPDATE scbcrse a
   SET scbcrse_dept_code =
          (SELECT DISTINCT new_department
                  /*DECODE (new_department,
                          --'10', '',
                          --'11', '',
                          new_department)*/
             FROM bu_dev.courses
            WHERE SUBJECT = scbcrse_subj_code AND COURSE = scbcrse_crse_numb)
 WHERE     a.scbcrse_eff_term =
              (SELECT MAX (b.scbcrse_eff_term)
                 FROM scbcrse b
                WHERE     b.scbcrse_subj_code = a.scbcrse_subj_code
                      AND b.scbcrse_crse_numb = a.scbcrse_crse_numb)
       AND scbcrse_subj_code || scbcrse_crse_numb != '19082402'
       and scbcrse_coll_code != '11';

/****************************************************************************/

  SELECT SUBJECT, COURSE, COUNT (*)
    FROM bu_dev.courses
GROUP BY SUBJECT, COURSE;
