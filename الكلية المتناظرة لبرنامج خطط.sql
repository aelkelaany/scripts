SELECT stvcoll_code coll_code, stvcoll_desc coll_desc
           FROM stvcoll
          WHERE EXISTS
                   (SELECT '1'
                      FROM SYMTRCL_DEPT_MAPPING G
                     WHERE     COLL_CODE = stvcoll_code
                           AND COLL_CODE <> :l_coll
                           AND EXISTS
                                  (SELECT '1'
                                     FROM SYMTRCL_DEPT_MAPPING
                                    WHERE     GENERAL_DEPT = G.GENERAL_DEPT
                                          AND MAJOR_CODE = :l_majr));