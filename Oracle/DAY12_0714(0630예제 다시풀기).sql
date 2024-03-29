-- 1
CREATE TABLE TBL_CUSTOM (
CUSTOM_ID VARCHAR2(20),
NAME NVARCHAR2(20) NOT NULL,
EMAIL NVARCHAR2(20) NOT NULL,
AGE NUMBER(3),
REG_DATE DATE DEFAULT SYSDATE,
PRIMARY KEY (CUSTOM_ID)
);

CREATE TABLE TBL_PRODUCT (
PCODE VARCHAR2(20),
CATEGORY CHAR(2) NOT NULL,
PNAME NVARCHAR2(20) NOT NULL,
PRICE NUMBER(9) NOT NULL,
PRIMARY KEY (PCODE)
);

CREATE TABLE TBL_BUY (
CUSTOM_ID VARCHAR2(20) NOT NULL,
PCODE VARCHAR2(20) NOT NULL,
QUANTITY NUMBER(5) NOT NULL,
BUY_DATE DATE DEFAULT SYSDATE
);

-- 2
INSERT INTO TBL_CUSTOM (CUSTOM_ID, NAME, EMAIL, AGE, REG_DATE) VALUES
	('mina012', '김미나', 'kimm@gmail.com', 20, 
	TO_DATE('2022-03-10 14:23:25', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_CUSTOM (CUSTOM_ID, NAME, EMAIL, AGE, REG_DATE) VALUES
	('honGD', '홍길동', 'gil@korea.com', 32, '2022-03-10');

UPDATE TBL_CUSTOM SET REG_DATE = '2021-10-21', CUSTOM_ID = 'hongGD' WHERE NAME = '홍길동';

INSERT INTO TBL_CUSTOM (CUSTOM_ID, NAME, EMAIL, AGE, REG_DATE) VALUES
	('twice', '박모모', 'momo@daum.net', 29, '2021-12-25');

INSERT INTO TBL_CUSTOM (CUSTOM_ID, NAME, EMAIL, AGE) VALUES
	('wonder', '이나나', 'lee@naver.com', 40);
--
INSERT INTO TBL_PRODUCT (PCODE, CATEGORY, PNAME, PRICE) VALUES
	('IPAD011', 'A1', '아이패드10', 880000);

INSERT INTO TBL_PRODUCT (PCODE, CATEGORY, PNAME, PRICE) VALUES
	('DOWON123a', 'B1', '동원참치선물세트', 54000);

INSERT INTO TBL_PRODUCT (PCODE, CATEGORY, PNAME, PRICE) VALUES
	('dk_143', 'A2', '모션데스크', 234500);
--
INSERT INTO TBL_BUY (CUSTOM_ID, PCODE, QUANTITY, BUY_DATE) VALUES
	('mina012', 'IPAD011', 1, '2022-02-06');

INSERT INTO TBL_BUY (CUSTOM_ID, PCODE, QUANTITY, BUY_DATE) VALUES
	('hongGD', 'IPAD011', 2, 
	TO_DATE('2022-06-29 20:37:47', 'YYYY-MM-DD HH24:MI:SS'));

INSERT INTO TBL_BUY (CUSTOM_ID, PCODE, QUANTITY, BUY_DATE) VALUES
	('wonder', 'DOWON123a', 3, '2022-02-06');

INSERT INTO TBL_BUY (CUSTOM_ID, PCODE, QUANTITY) VALUES
	('mina012', 'dk_143', 1);

INSERT INTO TBL_BUY (CUSTOM_ID, PCODE, QUANTITY, BUY_DATE) VALUES
	('twice', 'DOWON123a', 2, 
	TO_DATE('2022-02-09 08:49:55', 'YYYY-MM-DD HH24:MI:SS'));

-- 3
ALTER TABLE TBL_BUY ADD BUYNO NUMBER(8);

-- 4
CREATE SEQUENCE BUYNO_SEQ START WITH 1001;

UPDATE TBL_BUY SET BUYNO = BUYNO_SEQ.NEXTVAL
	WHERE CUSTOM_ID = 'mina012' AND PCODE = 'IPAD011';

UPDATE TBL_BUY SET BUYNO = BUYNO_SEQ.NEXTVAL
	WHERE CUSTOM_ID = 'hongGD';

UPDATE TBL_BUY SET BUYNO = BUYNO_SEQ.NEXTVAL
	WHERE CUSTOM_ID = 'wonder';

UPDATE TBL_BUY SET BUYNO = BUYNO_SEQ.NEXTVAL
	WHERE CUSTOM_ID = 'mina012' AND PCODE = 'dk_143';

UPDATE TBL_BUY SET BUYNO = BUYNO_SEQ.NEXTVAL
	WHERE CUSTOM_ID = 'twice';

-- 5
ALTER TABLE TBL_BUY ADD CONSTRAINT TBL_BUY_PK_BUYNO
	PRIMARY KEY (BUYNO);

SELECT CUSTOM_ID FROM TBL_BUY MINUS SELECT CUSTOM_ID FROM TBL_CUSTOM;
-- 6
ALTER TABLE TBL_BUY ADD CONSTRAINT TBL_BUY_FK1__CUSTOM_ID
	FOREIGN KEY (CUSTOM_ID) REFERENCES TBL_CUSTOM (CUSTOM_ID);

ALTER TABLE TBL_BUY ADD CONSTRAINT TBL_BUY_FK2__PCODE
	FOREIGN KEY (PCODE) REFERENCES TBL_PRODUCT (PCODE);

-- 7 pass

-- 8
INSERT INTO TBL_BUY (CUSTOM_ID, PCODE, QUANTITY, BUY_DATE, BUYNO) VALUES
	('wonder', 'IPAD011', 1, '2022-05-15', BUYNO_SEQ.NEXTVAL);

-- 9
SELECT * FROM TBL_CUSTOM WHERE AGE >= 30;

SELECT EMAIL FROM TBL_CUSTOM tc WHERE CUSTOM_ID = 'twice';

SELECT PNAME FROM TBL_PRODUCT tp WHERE CATEGORY = 'A2';

SELECT MAX(PRICE) FROM TBL_PRODUCT tp; 

SELECT SUM(QUANTITY) FROM TBL_BUY tb WHERE PCODE = 'IPAD011'; 

SELECT * FROM TBL_BUY tb WHERE CUSTOM_ID = 'mina012';

SELECT * FROM TBL_BUY tb WHERE PCODE LIKE '%0%';

SELECT * FROM TBL_BUY tb WHERE UPPER(PCODE) LIKE '%ON%';

-- 예제를 위해 상품 추가하기
INSERT INTO TBL_PRODUCT VALUES ('GALAXYs22', 'A1', '갤럭시S22', 555600);

-- 10
SELECT EMAIL, PNAME FROM TBL_CUSTOM tc, TBL_PRODUCT tp, TBL_BUY tb
	WHERE tb.PCODE = tp.PCODE AND tb.CUSTOM_ID = tc.CUSTOM_ID;

-- 이게 서브쿼리구나!
SELECT PCODE FROM TBL_BUY WHERE CUSTOM_ID = 
	(SELECT CUSTOM_ID FROM TBL_CUSTOM WHERE AGE >= 40);
-- PCODE를 뽑아올거야 TBL_BUY 테이블에서 근데 조건은 CUSTOM_ID가 내부쿼리 결과랑 같아야 해
-- 내부쿼리에서는 CUSTOM_ID를 뽑아올거야 TBL_CUSTOM 테이블에서 단, 조건은 AGE가 40 이상이어야 해
-- 그리고 나는 서브쿼리 앞에 = 연산이 있으니까 1개의 행만 출력할 수 있어

SELECT PCODE, CUSTOM_ID FROM TBL_BUY tb WHERE PCODE IN
	(SELECT PCODE FROM TBL_PRODUCT tp WHERE CATEGORY LIKE '%A%'); 

SELECT PNAME, CUSTOM_ID FROM TBL_BUY tb, TBL_PRODUCT tp 
	WHERE tb.PCODE = tp.PCODE;

SELECT * FROM TBL_BUY tb
	JOIN TBL_PRODUCT tp
	ON tb.PCODE = tp.PCODE;

SELECT * FROM TBL_BUY tb		-- 부모테이블
	LEFT OUTER JOIN TBL_PRODUCT tp
	ON tb.PCODE = tp.PCODE;

SELECT * FROM TBL_BUY tb
	RIGHT OUTER JOIN TBL_PRODUCT tp		-- 부모테이블
	ON tb.PCODE = tp.PCODE;
--
DROP SEQUENCE BUYNO_SEQ;
DROP TABLE TBL_BUY;
DROP TABLE TBL_CUSTOM;
DROP TABLE TBL_PRODUCT;
