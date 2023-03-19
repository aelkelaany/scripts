/* Formatted on 1/31/2023 11:49:15 AM (QP5 v5.371) */
  SELECT *
    FROM bu_dev.samy_tbl
--WHERE reg_count <6
ORDER BY room_capacity DESC;

SELECT (REMANING_SEATS)
  FROM bu_dev.samy_tbl
 WHERE REMANING_SEATS > 8;

-- 


UPDATE bu_dev.samy_tbl
   SET REMANING_SEATS = max_enrl - reg_count,
       PERCENTAGE = ROUND ((reg_count / max_enrl) * 100);



SELECT a.*,
       CASE
           WHEN reg_count BETWEEN 4 AND 10 THEN 10
           WHEN reg_count BETWEEN 11 AND 15 THEN 15
           WHEN reg_count BETWEEN 16 AND 20 THEN 20
           WHEN reg_count BETWEEN 21 AND 25 THEN 25
           WHEN reg_count BETWEEN 26 AND 30 THEN 30
           WHEN reg_count BETWEEN 31 AND 35 THEN 35
           WHEN reg_count BETWEEN 36 AND 40 THEN 40
           WHEN reg_count BETWEEN 41 AND 45 THEN 45
           WHEN reg_count BETWEEN 46 AND 50 THEN 50
           ELSE reg_count
       END    "act"
  FROM bu_dev.samy_tbl a
 --SET max_enrl = reg_count + 3
 WHERE REMANING_SEATS BETWEEN 5 AND 12                       --AND ROWNUM < 90
;
UPDATE bu_dev.samy_tbl a
   SET max_enrl =
           CASE
               WHEN reg_count BETWEEN 4 AND 10 THEN 10
               WHEN reg_count BETWEEN 11 AND 15 THEN 15
               WHEN reg_count BETWEEN 16 AND 20 THEN 20
               WHEN reg_count BETWEEN 21 AND 25 THEN 25
               WHEN reg_count BETWEEN 26 AND 30 THEN 30
               WHEN reg_count BETWEEN 31 AND 35 THEN 35
               WHEN reg_count BETWEEN 36 AND 40 THEN 40
               WHEN reg_count BETWEEN 41 AND 45 THEN 45
               WHEN reg_count BETWEEN 46 AND 50 THEN 50
               ELSE reg_count
           END
 WHERE REMANING_SEATS BETWEEN 5 AND 12;



UPDATE bu_dev.samy_tbl
   SET max_enrl = reg_count + 3
 WHERE REMANING_SEATS > 12 AND ROWNUM < 90;


SELECT max_enrl,
       bldg,
       room,
       room_capacity
  FROM bu_dev.samy_tbl a
 WHERE max_enrl < 4;

UPDATE bu_dev.samy_tbl a
   SET room = 'OFC', room_capacity = 4
 WHERE max_enrl < 4;

  --

SELECT *
  FROM bu_dev.samy_tbl
 WHERE (bldg, room) IN (SELECT bldg, room
                          FROM bu_dev.samy_tbl a
                         WHERE room_capacity > 100);

  --

SELECT mx
  FROM (  SELECT bldg, room, MAX (max_enrl) mx
            FROM (SELECT max_enrl,
                         bldg,
                         room,
                         room_capacity
                    FROM bu_dev.samy_tbl a
                   WHERE room_capacity > 100)
        GROUP BY bldg, room)
 WHERE bldg = 'γδΟή5' AND room = 'F7';

UPDATE bu_dev.samy_tbl a
   SET room_capacity =
           (SELECT MAX (max_enrl)
              FROM bu_dev.samy_tbl
             WHERE     a.BLDG = bu_dev.samy_tbl.BLDG
                   AND a.ROOM = bu_dev.samy_tbl.ROOM)
 WHERE room_capacity > 100;


                   --

  SELECT bldg, room, COUNT (DISTINCT room_capacity)
    FROM bu_dev.samy_tbl a
  HAVING COUNT (DISTINCT room_capacity) > 1
GROUP BY bldg, room
ORDER BY 3 DESC;


UPDATE bu_dev.samy_tbl a
   SET room_capacity =
           (SELECT MAX (room_capacity)
              FROM bu_dev.samy_tbl
             WHERE     a.BLDG = bu_dev.samy_tbl.BLDG
                   AND a.ROOM = bu_dev.samy_tbl.ROOM)
 WHERE bldg || room IN ('Ϊήνή12601',
                        'Ϊήνή1G401',
                        'Ϊήνή21512',
                        'Ϊήνή12402',
                        'Ϊήνή12501',
                        'Ϊήνή1G408',
                        'Ϊήνή21403',
                        'Ϊήνή12403',
                        'Ϊήνή1G407',
                        'Ϊήνή1G409',
                        'Ϊήνή12401',
                        'Ϊήνή1G406',
                        'Ϊήνή1G402');

  SELECT distinct bldg, room, room_capacity
    FROM bu_dev.samy_tbl
   WHERE bldg || room IN ('Ϊήνή12601',
                          'Ϊήνή1G401',
                          'Ϊήνή21512',
                          'Ϊήνή12402',
                          'Ϊήνή12501',
                          'Ϊήνή1G408',
                          'Ϊήνή21403',
                          'Ϊήνή12403',
                          'Ϊήνή1G407',
                          'Ϊήνή1G409',
                          'Ϊήνή12401',
                          'Ϊήνή1G406',
                          'Ϊήνή1G402')
ORDER BY 1, 2;