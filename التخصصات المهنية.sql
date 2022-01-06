/* Formatted on 04/01/2022 08:36:14 (QP5 v5.371) */
SELECT COL01,
       COL02,
       COL03,
       COL04,
       COL05,
       COL06,
       COL07,
       COL08,
       COL09
  FROM bu_dev.tmp_tbl_kilany a;

CREATE TABLE MOE_MAJORS
(
    MOE_LEVEL_CODE    VARCHAR2 (10),
    MOE_MAJOR_CODE    VARCHAR2 (10),
    MOE_mAJOR_DESC    VARCHAR2 (200),
    BU_MAJOR_CODE     VARCHAR2 (4),
    ACTIVITY_DATE     DATE,
    USERID            VARCHAR2 (50)
);

GRANT SELECT ON BU_APPS.MOE_MAJORS TO PUBLIC;
CREATE PUBLIC SYNONYM MOE_MAJORS FOR BU_APPS.MOE_MAJORS;
--truncate table MOE_MAJORS ;

INSERT INTO MOE_MAJORS
    SELECT COL07,
           COL04,
           COL05,
           NVL (col09, COL08),
           SYSDATE,
           USER
      FROM bu_dev.tmp_tbl_kilany
-- WHERE COL07 = '544'
;
SELECT *
  FROM bu_dev.tmp_tbl_kilany
 WHERE col04 NOT IN (SELECT MOE_MAJOR_CODE FROM MOE_MAJORS);

CREATE OR REPLACE FUNCTION get_moe_major (p_major      VARCHAR2,
                                          p_language   VARCHAR2)
    RETURN VARCHAR2
IS
    r_value   VARCHAR2 (300);

    CURSOR get_major IS
        SELECT    stvmajr_desc
               || '. '
               || MOE_major_CODE
               || '\'
               || MOE_LEVEL_CODE
               || ''
          FROM moe_majors, stvmajr
         WHERE     stvmajr_code = bu_major_code
               AND bu_major_code = p_major
               AND p_language = 'AR'
        UNION
        SELECT stvmajr_desc
          FROM stvmajr
         WHERE     stvmajr_code = p_major
               AND NOT EXISTS
                       (SELECT '1'
                          FROM moe_majors
                         WHERE bu_major_code = p_major)
               AND p_language = 'AR'
        UNION
        SELECT    stvmajr_desc
               || ' '
               || MOE_LEVEL_CODE
               || '/'
               || MOE_major_CODE
               || ''
          FROM moe_majors, dle.stvmajr
         WHERE     stvmajr_code = bu_major_code
               AND bu_major_code = p_major
               AND p_language = 'EN'
        UNION
        SELECT stvmajr_desc
          FROM DLE.stvmajr
         WHERE     stvmajr_code = p_major
               AND NOT EXISTS
                       (SELECT '1'
                          FROM moe_majors
                         WHERE bu_major_code = p_major)
               AND p_language = 'EN';
BEGIN
    OPEN get_major;

    FETCH get_major INTO r_value;

    CLOSE get_major;

    RETURN NVL (r_value, ' ');
END;

GRANT EXECUTE ON bu_apps.get_moe_major TO PUBLIC;
CREATE PUBLIC SYNONYM get_moe_major FOR bu_apps.get_moe_major;



CREATE OR REPLACE FUNCTION RETURN_ARABIC_DIGITS (P_DIGITS VARCHAR2)
    RETURN VARCHAR2
IS
    CURSOR GET_DATA IS
            SELECT REPLACE (
                       SYS_CONNECT_BY_PATH (
                           UNISTR ('\066' || SUBSTR (P_DIGITS, LEVEL, 1)),
                           '~'),
                       '~')    translated_digits
              FROM DUAL
             WHERE CONNECT_BY_ISLEAF = 1
        CONNECT BY LEVEL <= LENGTH (P_DIGITS);

    R_VALUE   VARCHAR2 (50);
BEGIN
    OPEN GET_DATA;

    FETCH GET_DATA INTO R_VALUE;

    CLOSE GET_DATA;

    RETURN R_VALUE;
END;


SELECT RETURN_ARABIC_DIGITS ('12536558') FROM DUAL;


SELECT get_moe_major (stvmajr_code, 'AR')     arabic,
       get_moe_major (stvmajr_code, 'EN'),
       stvmajr_code,
       stvmajr_desc,
       MOE_MAJOR_DESC
  FROM stvmajr, moe_majorS
 WHERE BU_MAJOR_CODE = stvmajr_code;