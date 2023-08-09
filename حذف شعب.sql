/* Formatted on 7/23/2023 2:59:48 PM (QP5 v5.371) */
SELECT COUNT (*)
  FROM sfrstcr
 WHERE     sfrstcr_term_code = '144020'
       AND sfrstcr_crn IN ((SELECT CRN FROM MAHAMOUD.SYR))
       AND sfrstcr_rsts_code IN ('RE', 'RW');

CREATE TABLE SSBSECT10092019_DEL
AS
    SELECT *
      FROM SSBSECT
     WHERE     SSBSECT_term_code = '144010'
           AND SSBSECT_crn IN (SELECT col01 FROM BU_DEV.TMP_TBL03) 
           
           CREATE TABLE SSRMEET10092019_DEL AS
 SELECT      *  FROM     SSRMEET
 WHERE     SSRMEET_term_code                 = '144010'
 and   SSRMEET_crn            in
 ( select      col01      from     BU_DEV      . TMP_TBL03         )

 CREATE       TABLE      SSRRCOL10092019_DEL                    AS
 SELECT      *  FROM     SSRRCOL
 WHERE     SSRRCOL_term_code                 = '144010'
 and   SSRRCOL_crn            in
 ( select      col01      from     BU_DEV      . TMP_TBL03         );


CREATE TABLE SSRRCMP10092019_DEL
AS
    SELECT *
      FROM SSRRCMP
     WHERE     SSRRCMP_term_code = '144010'
           AND SSRRCMP_crn IN (SELECT col01 FROM BU_DEV.TMP_TBL03);

DELETE FROM
    SSRRCOL
      WHERE     SSRRCOL_term_code = '144010'
            AND SSRRCOL_crn IN (SELECT col01 FROM BU_DEV.TMP_TBL03);

DELETE FROM
    SSRRCMP
      WHERE     SSRRCMP_term_code = '144010'
            AND SSRRCMP_crn IN (SELECT col01 FROM BU_DEV.TMP_TBL03);

DELETE FROM
    SSRMEET
      WHERE     SSRMEET_term_code = '144010'
            AND SSRMEET_crn IN (SELECT col01 FROM BU_DEV.TMP_TBL03);

DELETE FROM
    SSBSECT
      WHERE     SSBSECT_term_code = '144010'
            AND SSBSECT_crn IN (SELECT col01 FROM BU_DEV.TMP_TBL03);



SSRMEET

SIRASGN

SSRRCOL


SSRRCMP

-- delete from database without backup

DELETE FROM
    SSRRCOL
      WHERE     SSRRCOL_term_code = '144020'
            AND SSRRCOL_crn IN (SELECT CRN FROM MAHAMOUD.SYR);

DELETE FROM
    SSRRCMP
      WHERE     SSRRCMP_term_code = '144020'
            AND SSRRCMP_crn IN (SELECT CRN FROM MAHAMOUD.SYR);

DELETE FROM
    SSRMEET
      WHERE     SSRMEET_term_code = '144020'
            AND SSRMEET_crn IN (SELECT CRN FROM MAHAMOUD.SYR);

DELETE FROM
    SIRASGN
      WHERE     SIRASGN_term_code = '144020'
            AND SIRASGN_crn IN (SELECT CRN FROM MAHAMOUD.SYR);

DELETE FROM
    SSRRTST
      WHERE     SSRRTST_term_code = '144020'
            AND SSRRTST_crn IN (SELECT CRN FROM MAHAMOUD.SYR);


DELETE FROM
    SSRRDEP
      WHERE     SSRRDEP_term_code = '144020'
            AND SSRRDEP_crn IN (SELECT CRN FROM MAHAMOUD.SYR);

DELETE FROM
    SSBSECT
      WHERE     SSBSECT_term_code = '144020'
            AND SSBSECT_crn IN (SELECT CRN FROM MAHAMOUD.SYR);

SELECT COUNT (*)
  FROM SSBSECT
 WHERE     SSBSECT_term_code = '144020'
       AND SSBSECT_crn IN (SELECT DISTINCT CRN
                             FROM MAHAMOUD.SYR);


--***----------------

DELETE FROM SSRRCOL
      WHERE SSRRCOL_term_code = '144020' AND SSRRCOL_crn IN ('');

DELETE FROM SSRRCMP
      WHERE SSRRCMP_term_code = '144020' AND SSRRCMP_crn IN ('');

DELETE FROM SSRMEET
      WHERE SSRMEET_term_code = '144020' AND SSRMEET_crn IN ('');

DELETE FROM SIRASGN
      WHERE SIRASGN_term_code = '144020' AND SIRASGN_crn IN ('');

DELETE FROM SSRRTST
      WHERE SSRRTST_term_code = '144020' AND SSRRTST_crn IN ('');


DELETE FROM SSRRDEP
      WHERE SSRRDEP_term_code = '144020' AND SSRRDEP_crn IN ('');

DELETE FROM SSBSECT
      WHERE SSBSECT_term_code = '144020' AND SSBSECT_crn IN ('');

SELECT COUNT (*)
  FROM SSBSECT
 WHERE SSBSECT_term_code = '144020' AND SSBSECT_crn IN ('');