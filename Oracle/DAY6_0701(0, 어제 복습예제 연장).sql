-- 9번
SELECT * FROM TBL_CUSTOM WHERE AGE >= 30;
SELECT EMAIL FROM TBL_CUSTOM WHERE CUSTOM_ID = 'twice';
SELECT PNAME FROM TBL_PRODUCT WHERE CATEGORY = 'A2';
SELECT MAX(PRICE) FROM TBL_PRODUCT;		-- 최고값 조회
SELECT SUM(QUANTITY) FROM TBL_BUY WHERE PCODE = 'IPAD011';
SELECT * FROM TBL_BUY WHERE CUSTOM_ID = 'mina012';
SELECT * FROM TBL_BUY WHERE PCODE LIKE '%0%';
SELECT * FROM TBL_BUY WHERE UPPER(PCODE) LIKE '%ON%';