SET AUTOCOMMIT ON;

-- STEP 1, 테이블 & 시퀀스 만들기

CREATE TABLE BOOK_MEMBER (
MEM_IDX NUMBER(5, 0) NOT NULL,
NAME VARCHAR2(20) NOT NULL,
EMAIL VARCHAR2(20) NOT NULL,
TEL VARCHAR2(20),
PASSWORD VARCHAR2(10),
PRIMARY KEY (MEM_IDX),
UNIQUE (EMAIL, TEL)
);

CREATE TABLE TBL_BOOK (
BCODE CHAR(5) NOT NULL,
TITLE VARCHAR2(30) NOT NULL,
WRITER VARCHAR2(20),
PUBLISHER VARCHAR2(20),
PDATE DATE,
PRIMARY KEY (BCODE)
);

CREATE TABLE TBL_BOOKRENT (
RENT_NO NUMBER(5, 0) NOT NULL,
MEM_IDX NUMBER(5, 0) NOT NULL,
BCODE CHAR(5) NOT NULL,
RENT_DATE DATE NOT NULL,
EXP_DATE DATE NOT NULL,
RETURN_DATE DATE,
DELAY_DAYS NUMBER(3, 0),
PRIMARY KEY (RENT_NO),
FOREIGN KEY (MEM_IDX) REFERENCES BOOK_MEMBER (MEM_IDX),
FOREIGN KEY (BCODE) REFERENCES TBL_BOOK (BCODE)
);

CREATE SEQUENCE MEMIDX_SEQ01 START WITH 10001;
CREATE SEQUENCE RENTNO_SEQ01 START WITH 1;

-- 테이블 생성하고 나서 외래키 따로 설정하는 경우
-- ALTER TABLE TBL_BOOKRENT ADD CONSTRAINT FK1_MEM_IDX
-- FOREIGN KEY (MEM_IDX) REFERENCES BOOK_MEMBER (MEM_IDX)
-- ALTER TABLE TBL_BOOKRENT ADD CONSTRAINT FK2_BCODE
-- FOREIGN KEY (BCODE) REFERENCES BOOK_MEMBER (BCODE)


-- STEP 2, 데이터 INSERT 하기

INSERT INTO BOOK_MEMBER VALUES
(MEMIDX_SEQ01.NEXTVAL, '이하니', 'honey@naver.com', '010-9889-0567', '1122');
INSERT INTO BOOK_MEMBER VALUES
(MEMIDX_SEQ01.NEXTVAL, '이세종', 'jong@daum.net', '010-2354-6773', '2345');
INSERT INTO BOOK_MEMBER VALUES
(MEMIDX_SEQ01.NEXTVAL, '최행운', 'lucky@korea.com', '010-5467-8792', '9876');
INSERT INTO BOOK_MEMBER VALUES
(MEMIDX_SEQ01.NEXTVAL, '나길동', 'nadong@kkk.net', '010-3456-8765', '3456');
INSERT INTO BOOK_MEMBER VALUES
(MEMIDX_SEQ01.NEXTVAL, '강감찬', 'haha@korea.net', '010-3987-9087', '1234');

INSERT INTO TBL_BOOK VALUES
('A1101', '코스모스', '칼세이건', '사이언스북스', '2006-12-01');
INSERT INTO TBL_BOOK VALUES
('B1101', '해커스토익', '이해커', '해커스랩', '2018-07-10');
INSERT INTO TBL_BOOK VALUES
('C1101', '푸른사자 와니니', '이현', '창비', '2015-06-20');
INSERT INTO TBL_BOOK VALUES
('A1102', '페스트', '알베르트 까뮈', '민음사', '2011-03-01');

-- 문자열에서 날짜 타입으로 자동 캐스팅된다. 함수를 사용할 때에는 TO_DATE() 함수를 사용한다.
-- INSERT INTO TBL_BOOK VALUES
-- ('A1101', '코스모스', '칼세이건', '사이언스북스', TO_DATE('06/12/01', 'YY/MM/DD');
-- 참고 : 날짜 타입을 문자열로 변환시키는 것은 TO_CHAR() 함수이다.

-- 데이터 확인하기

SELECT * FROM BOOK_MEMBER;
SELECT * FROM TBL_BOOK;

-- STEP 2-1, 데이터 마저 INSERT 하기

INSERT INTO TBL_BOOKRENT (RENT_NO, MEM_IDX, BCODE, RENT_DATE, EXP_DATE, RETURN_DATE) VALUES
(RENTNO_SEQ01.NEXTVAL, 10001, 'B1101', '2021-09-01', '2021-09-15', '2021-09-14');

INSERT INTO TBL_BOOKRENT (RENT_NO, MEM_IDX, BCODE, RENT_DATE, EXP_DATE, RETURN_DATE) VALUES
(RENTNO_SEQ01.NEXTVAL, 10002, 'C1101', '2021-09-12', '2021-09-26', '2021-09-29');

INSERT INTO TBL_BOOKRENT (RENT_NO, MEM_IDX, BCODE, RENT_DATE, EXP_DATE, RETURN_DATE) VALUES
(RENTNO_SEQ01.NEXTVAL, 10003, 'B1101', '2021-09-03', '2021-09-17', '2021-09-17');

INSERT INTO TBL_BOOKRENT (RENT_NO, MEM_IDX, BCODE, RENT_DATE, EXP_DATE) VALUES
(RENTNO_SEQ01.NEXTVAL, 10004, 'C1101', '2022-06-30', '2022-07-14');

INSERT INTO TBL_BOOKRENT (RENT_NO, MEM_IDX, BCODE, RENT_DATE, EXP_DATE) VALUES
(RENTNO_SEQ01.NEXTVAL, 10001, 'A1101', '2022-07-04', '2022-07-18');

INSERT INTO TBL_BOOKRENT (RENT_NO, MEM_IDX, BCODE, RENT_DATE, EXP_DATE, RETURN_DATE) VALUES
(RENTNO_SEQ01.NEXTVAL, 10003, 'A1102', '2022-07-06', '2022-07-20', '2022-07-13');

-- 참고하기 : 기본적인 동작은 대여날짜 = 오늘, 반납기한 = 오늘 + 14를 기본값으로 할 수 있도록 한다.
-- ALTER TABLE "C##IDEV".TBL_BOOKRENT MODIFY RENT_DATE DATE DEFAULT SYSDATE;
-- ALTER TABLE "C##IDEV".TBL_BOOKRENT MODIFY EXP_DATE DATE DEFAULT SYSDATE + 14;
-- 예시)
-- INSERT INTO TBL_BOOKRENT (RENT_NO, MEM_IDX, BCODE)
-- VALUES (RENTNO_SEQ.NEXTVAL, 10002, 'A1102');

-- 컬럼 디폴트 값을 없애고 싶은 경우
-- ALTER TABLE "C##IDEV".TBL_BOOKRENT MODIFY RENT_DATE DATE DEFAULT NULL;

