/* Formatted on 8/22/2023 11:26:55 AM (QP5 v5.371) */
/*  ⁄—Ì› «·»«’« */

INSERT INTO TRANS_BUS
    SELECT '144510',
           BUS_NO,
           BUS_CAPACITY,
           PLATE_NO,
           BUS_DRIVER,
           CONTACT_NUMBER,
           NOTES,
           USER,
           SYSDATE
      FROM BU_APPS.TRANS_BUS m
     WHERE     TERM_CODE = '144410'
           AND NOT EXISTS
                   (SELECT '1'
                      FROM BU_APPS.TRANS_BUS
                     WHERE TERM_CODE = '144510' AND BUS_NO = m.bus_no);

------------------ ROUTES 


INSERT INTO TRANS_ROUTE
    SELECT '144510',
           ROUTE_NO,
           ROUTE_DESCRIPTION,
           NOTES,
           USER,
           SYSDATE
      FROM BU_APPS.TRANS_ROUTE
     WHERE TERM_CODE = '144410';



INSERT INTO TRANS_ROUTE_PATH
    SELECT '144510',
           ROUTE_NO,
           BUS_NO,
           MEETING_POINT,
           MEET_TIME,
           NOTES,
           USER,
           SYSDATE
      FROM TRANS_ROUTE_PATH
     WHERE TERM_CODE = '144410';