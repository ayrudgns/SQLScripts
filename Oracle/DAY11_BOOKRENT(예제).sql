-- 회원은 하루에 1개의 책만 대여할 수 있다.
-- RETURN_DATE가 NULL이면 대여중, NULL이 아니면 반납된 도서

-- 1. 도서 추가하기 ‘B1102’ , ‘스트라이크 던지기’, ‘박철순’ ,’KBO’ , ‘2020-11-10’
INSERT INTO TBL_BOOK VALUES ('B1102', '스트라이크 던지기', '박철순', 'KBO', '2020-11-10');

-- 2. 반납된 도서의 연체일수를 계산하여 delay_days 컬럼값 update하기
UPDATE TBL_BOOKRENT SET DELAY_DAYS = (RETURN_DATE - EXP_DATE) WHERE RETURN_DATE IS NOT NULL;
SELECT * FROM TBL_BOOKRENT;

-- 3. 대출 중인 도서의 연체 일수 계산해서 회원IDX, 도서코드, 연체일수 조회하기
-- SYSDATE는 연월일 패턴이 지정되지 않았기 때문에 LONG 값으로 계산된다.
SELECT MEM_IDX, BCODE, TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD')) - EXP_DATE
FROM TBL_BOOKRENT tb WHERE RETURN_DATE IS NULL;
-- 또는
SELECT MEM_IDX, BCODE, TRUNC(SYSDATE) - EXP_DATE	-- TRUNC(SYSDATE)는 SYSDATE의 시간 부분을 버린다. 
FROM TBL_BOOKRENT tb WHERE RETURN_DATE IS NULL;

-- 4. 현재 연체 중인 회원의 이름, 전화번호 검색하기. 오늘 날짜 SYSDATE를 기준으로 확인하기
-- 현재 기준으로 연체 중인 것은 반납기한 < 현재날짜
SELECT NAME, TEL FROM BOOK_MEMBER bm, TBL_BOOKRENT tb
WHERE bm.MEM_IDX = tb.MEM_IDX
AND SYSDATE > EXP_DATE AND RETURN_DATE IS NULL;

-- 5. 현재 대출 중인 도서의 도서코드와 도서명 검색하기
SELECT tb.BCODE, TITLE FROM TBL_BOOK tb JOIN TBL_BOOKRENT tb2
ON tb.BCODE = tb2.BCODE AND RETURN_DATE IS NULL;

-- 6. 현재 도서를 대여한 회원의 회원IDX와 회원이름 검색하기
SELECT tb.MEM_IDX, NAME FROM BOOK_MEMBER bm JOIN TBL_BOOKRENT tb
ON bm.MEM_IDX = tb.MEM_IDX AND RETURN_DATE IS NULL;

-- 7. 대출 중인 도서의 회원 이름, 도서명, 반납기한 검색하기
SELECT NAME, TITLE, EXP_DATE FROM TBL_BOOK tb, TBL_BOOKRENT tb2, BOOK_MEMBER bm
WHERE tb.BCODE = tb2.BCODE AND tb2.MEM_IDX = bm.MEM_IDX
AND RETURN_DATE IS NULL;
-- 또는
SELECT NAME, TITLE, EXP_DATE FROM TBL_BOOK tb
JOIN TBL_BOOKRENT tb2 ON tb.BCODE = tb2.BCODE
JOIN BOOK_MEMBER bm ON bm.MEM_IDX = tb2.MEM_IDX 
AND RETURN_DATE IS NULL;

-- 8. 현재 연체 중인 도서의 회원IDX, 도서코드, 반납기한 검색하기
SELECT MEM_IDX, BCODE, EXP_DATE FROM TBL_BOOKRENT tb
WHERE SYSDATE > EXP_DATE;

-- 9. 회원 IDX ‘10002’는 도서 대출이 가능한지 확인하는 프로시저 작성하기
DECLARE
	VCNT NUMBER;
BEGIN

	SELECT COUNT(*)
	INTO VCNT		-- SELECT 조회 결과를 저장할 변수 / 여러개를 ,(콤마)로 나열할 수 있음.
	FROM TBL_BOOKRENT tb
	WHERE MEM_IDX = 10002 AND RETURN_DATE IS NULL;		-- vcnt가 0일 때만 대여 가능.	
	IF (VCNT = 0) THEN 			-- IF에는 THEN과 END IF;가 필요하다.
		DBMS_OUTPUT.PUT_LINE('책 대여 가능합니다.');
	ELSE
		DBMS_OUTPUT.PUT_LINE('대여 중인 책을 반납해야 가능합니다.');
	END IF;
END;

-- 위 내용을 자바의 메소드처럼 메소드 이름을 붙여서 구현하기
	CREATE OR REPLACE PROCEDURE CHECK_MEMBER(
		ARG_MEM IN BOOK_MEMBER.MEM_IDX %TYPE,		-- 프로시저 실행할 때 값을 받을 매개변수
		isOK OUT VARCHAR2		-- 자바의 리턴값에 해당하는 부분
	)
	IS
		VCNT NUMBER;
		VNAME VARCHAR2(100);
	BEGIN
		-- 추가) 입력 매개변수가 없는 회원인지를 확인하는 SQL과 EXCEPTION 처리
		-- ARG_MEM으로 회원 테이블에서 NAME 조회하기
		-- 없으면 EXCEPTION 처리하기
		SELECT NAME INTO VNAME
		FROM BOOK_MEMBER bm WHERE MEM_IDX = ARG_MEM;
		
		-- 원래 있던 코드
		SELECT COUNT(*) INTO VCNT
		FROM TBL_BOOKRENT tb
		WHERE MEM_IDX = ARG_MEM AND RETURN_DATE IS NULL;		-- rcnt가 0일 때만 대여 가능.	
		IF (VCNT = 0) THEN 			-- IF에는 THEN과 END IF;가 필요하다.
			DBMS_OUTPUT.PUT_LINE('책 대여 가능합니다.');
			isOK := '가능';
		ELSE
			DBMS_OUTPUT.PUT_LINE('대여 중인 책을 반납해야 가능합니다.');
			isOK := '불가능';
		END IF;
		EXCEPTION
		WHEN NO_DATA_FOUND THEN 
			DBMS_OUTPUT.PUT_LINE('회원이 아닙니다.');
			ISOK := 'NO MATCH';
		
	END;

	-- 프로시저 실행하기
	DECLARE
		VRESULT VARCHAR2(20);
	BEGIN
		CHECK_MEMBER(10001, VRESULT);
		DBMS_OUTPUT.PUT_LINE('결과 : ' || VRESULT);
	END;

-- 10. 도서명에 ‘페스트’ 라는 도서가 대출이 가능한지 확인하는 프로시저 작성하기 / 프로시저 이름은 CHECK_BOOK으로!
DECLARE
	V_BCODE VARCHAR2(100);
	V_CNT NUMBER;
BEGIN
	SELECT BCODE INTO V_BCODE		-- V_BCODE는 'A1102'
	FROM TBL_BOOK tb WHERE TITLE = '페스트';
	SELECT COUNT(*) INTO V_CNT		-- V_CNT의 값이 1이면 V_BCODE 책은 대출 중
	FROM TBL_BOOKRENT tb2
	WHERE BCODE = V_BCODE AND RETURN_DATE IS NULL;
	IF(V_CNT = 1) THEN
		DBMS_OUTPUT.PUT_LINE('대여 중인 책입니다.');
	ELSE
		DBMS_OUTPUT.PUT_LINE('책 대여 가능합니다.');
	END IF;
END;

-- 프로시저 메소드처럼 만들기
	CREATE OR REPLACE PROCEDURE CHECK_BOOK (
		ARG_BOOK IN TBL_BOOK.TITLE %TYPE,
		ISOK OUT VARCHAR2
	)
	IS
	V_BCODE VARCHAR2(100);
	V_CNT NUMBER;
	BEGIN
		SELECT BCODE INTO V_BCODE		-- V_BCODE는 'A1102'
		FROM TBL_BOOK tb WHERE TITLE = ARG_BOOK;
		-- 없는 책 이름을 입력하면 오류, BCODE 값 검색이 안된다. => EXCEPTION 처리
		SELECT COUNT(*) INTO V_CNT		-- V_CNT의 값이 1이면 V_BCODE 책은 대출 중
		FROM TBL_BOOKRENT tb2
		WHERE BCODE = V_BCODE AND RETURN_DATE IS NULL;
		IF(V_CNT = 1) THEN
			DBMS_OUTPUT.PUT_LINE('대여 중인 책입니다.');
			ISOK := 'FALSE';
		ELSE
			DBMS_OUTPUT.PUT_LINE('책 대여 가능합니다.');
			ISOK := 'TRUE';
		END IF;
		EXCEPTION
		WHEN NO_DATA_FOUND THEN 
			DBMS_OUTPUT.PUT_LINE('찾는 데이터가 없습니다.');
			ISOK := 'NO MATCH';
	END;

-- 프로시저 실행하기
	DECLARE
		VRESULT VARCHAR2(100);
	BEGIN
		CHECK_BOOK('페스트', VRESULT);
		DBMS_OUTPUT.PUT_LINE('결과 : ' || VRESULT);
	END;
	
	

