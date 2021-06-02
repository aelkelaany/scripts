 select * from (
SELECT stid,
       PIDM,
       stname,
       TERM_CODE,
       SHRTTRM_ASTD_CODE_END_OF_TERM ASTD_CODE,
       ASATD,
       (SELECT ROUND (SUM (SHRTGPA_QUALITY_POINTS) / SUM (SHRTGPA_GPA_HOURS),
                      2)
          FROM shrtgpa
         WHERE     SHRTGPA_TERM_CODE <= TERM_CODE
               AND SHRTGPA_LEVL_CODE = '��'
               AND SHRTGPA_PIDM = PIDM)
          cgpa
  FROM (  SELECT DISTINCT
                 SHRDGMR_PIDM PIDM,
                 f_get_std_id (SHRDGMR_PIDM) stid,
                 f_get_std_name (SHRDGMR_PIDM) stname,
                 SHRTTRM_TERM_CODE TERM_CODE,
                 f_get_desc_fnc ('STVASTD', SHRTTRM_ASTD_CODE_END_OF_TERM, 60)
                    ASATD,
                 SHRTTRM_ASTD_CODE_END_OF_TERM
            FROM shrdgmr, shrttrm, SHRLGPA
           WHERE     SHRDGMR_COLL_CODE_1 = '35'
                 AND SHRDGMR_TERM_CODE_GRAD = '144220'
                 AND SHRDGMR_DEGS_CODE = '��'
                 AND SHRTTRM_PIDM = SHRDGMR_PIDM
                 AND SHRLGPA_PIDM = SHRDGMR_PIDM
                 AND SHRLGPA_GPA_TYPE_IND = 'O'
        --  AND SHRTTRM_TERM_CODE = '144220'
        --  AND shrdgmr_pidm = f_get_pidm ('441018359')
        ORDER BY stid, SHRTTRM_TERM_CODE ASC)
        )
        where cgpa between 3.50 and 4.00
         and ASATD not like '�����'
        
        
        --441018318    216382    ��� ��� ���� ���� ������    144020
        --439015997    197811    ��� ��� ���� ������
        --441017463    215576    ���� ���� ��������    144020
        --441017547    215660    ���� ��� �������    144210
        --441017749    215862    ��� ����� ���� ��������    144020
        --441017755    215868    ���� ���� ������    144020
        --441017774    215887    ��� ��� ���� �� �����    144020
        --441017817    215930    ����� ��� ��������� ���    144020
        --441017974    216087    ���� ��� ���� �������    144220