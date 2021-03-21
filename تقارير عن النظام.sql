/* Formatted on 7/8/2020 12:20:46 PM (QP5 v5.360) */
  SELECT ROW_NUMBER ()
             OVER (PARTITION BY object_type ORDER BY OBJECT_DESC DESC)
             AS ROW_NUM,
         OBJECT_DESC,
         DECODE (object_type,
                 'W', 'Œœ„… –« Ì…',
                 ' ﬁ—Ì— «·ﬂ —Ê‰Ì'),
         DECODE (WEB_DISPLAY_IND, 'Y', '„› ÊÕ…  ', '„€·ﬁ…')
             status
    FROM object_definition a
ORDER BY object_type DESC;