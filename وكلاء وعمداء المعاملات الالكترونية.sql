/* Formatted on 18/04/2021 10:35:53 (QP5 v5.227.12220.39754) */
  SELECT DISTINCT
         stvcoll_CODE AS "—„“ «·ﬂ·Ì…",
         B.STVCOLL_DESC AS "«·ﬂ·Ì…",
         DECODE (F_GET_STD_ID (D.USER_PIDM), 0, '', F_GET_STD_ID (D.USER_PIDM))
            AS "College Dean ID",
         DECODE (F_GET_STD_NAME (D.USER_PIDM),
                 '0', '',
                 F_GET_STD_NAME (D.USER_PIDM))
            AS "College Dean Name",
        
         DECODE (F_GET_STD_ID (e.USER_PIDM), 0, '', F_GET_STD_ID (e.USER_PIDM))
            AS "Vice Dean  ID",
         DECODE (F_GET_STD_NAME (e.USER_PIDM),
                 '0', '',
                 F_GET_STD_NAME (e.USER_PIDM))
            AS "Vice Dean Name" 
         
    FROM STVCOLL B, USERS_ATTRIBUTES D, USERS_ATTRIBUTES e
   WHERE     --stvCOLL_CODE NOT IN ('00', '34', '44', '39', '11', '12', '22')AND
          B.STVCOLL_CODE = D.ATTRIBUTE_VALUE
         AND NVL (D.ATTRIBUTE_CODE, 'COLLEGE') = 'COLLEGE'
         AND d.ROLE_CODE = 'RO_COLLEGE_DEAN'
         AND EXISTS
                (SELECT '1'
                   FROM ROLE_USERS
                  WHERE     USER_PIDM = D.USER_PIDM
                        AND ROLE_CODE = 'RO_COLLEGE_DEAN'
                        AND ACTIVE = 'Y')
         AND B.STVCOLL_CODE = E.ATTRIBUTE_VALUE
         AND NVL (E.ATTRIBUTE_CODE, 'COLLEGE') = 'COLLEGE'
         AND e.ROLE_CODE = 'RO_VICE_DEAN'
         AND EXISTS
                (SELECT '1'
                   FROM ROLE_USERS
                  WHERE     USER_PIDM = E.USER_PIDM
                        AND ROLE_CODE = 'RO_VICE_DEAN'
                        AND ACTIVE = 'Y')
ORDER BY 1, 3