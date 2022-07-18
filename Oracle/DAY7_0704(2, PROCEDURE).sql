-- PL/SQL
-- : PROCEDURE(절차, 순서), 기존의 단순한 SQL이 확장된 언어(SQL로 만드는 프로그램)
-- : 변수, 제어문(IF, 반복문)을 사용하여 프로그래밍 언어와 같이 SQL 실행의 흐름을 제어함.
-- !!!! 주의사항 : DBEAVER는 PROCEDURE의 DEBUG 기능이 없다.
--			디버깅을 하려면 SQL DEVELOPER를 써야 한다.

DECLARE   -- 변수 선언부  
--	VNAME VARCHAR2(20);
--	VAGE NUMBER(3,0);
	VNAME TBL_CUSTOM.NAME %TYPE;	-- 지정된 테이블의 컬럼과 동일한 형식의 변수가 선언된다.
	VAGE TBL_CUSTOM.AGE %TYPE;

BEGIN		-- 프로시저 시작
-- 프로시저 내부에는 주로 DML 명령문들을 작성.(함께 실행해야 할 여러 SQL : 트랜잭션)
	SELECT NAME, AGE 
	INTO VNAME, VAGE	-- 프로시저 구문: 검색결과를 변수에 저장
	FROM "TBL_CUSTOM" tc 
	WHERE CUSTOM_ID ='hongGD';		-- 1개 행만 결과 조회되는 조건
									-- 여러개의 행이 조회되는 조건은 다른 CURSOR 형식이 필요하다.
	
-- 변수값을 콘솔에 출력(프로시저 명령)
	DBMS_OUTPUT.PUT_LINE('고객이름 : ' || VNAME);		-- ||는 문자열 연결 연산
	DBMS_OUTPUT.PUT_LINE('고객나이 : ' || VAGE);
	EXCEPTION		-- 예외(오류)처리
	WHEN NO_DATA_FOUND THEN   -- 예외 이름은 다양하다. 현재는 예시로 NO_DATA_FOUND
		DBMS_OUTPUT.PUT_LINE('찾는 데이터가 없습니다.');
END;

-- 오라클 객체 프로시저 생성 : 검색할 값을 매개변수로 전달한다.
CREATE OR REPLACE PROCEDURE SEARCH_CUSTOM(		-- PROCEDURE 이름 설정
	C_ID IN TBL_CUSTOM.CUSTOM_ID %TYPE		-- 매개변수 IN
												-- 리턴값은 OUT으로!
)
IS 
-- 일반 변수 선언
	VNAME TBL_CUSTOM.NAME %TYPE;
	VAGE TBL_CUSTOM.AGE %TYPE;		

BEGIN 
	SELECT NAME, AGE 
	INTO VNAME, VAGE
	FROM "TBL_CUSTOM" tc 
	WHERE CUSTOM_ID = C_ID;		-- 1개 행만 결과 조회되는 조건
	
	DBMS_OUTPUT.PUT_LINE('고객이름 : ' || VNAME);
	DBMS_OUTPUT.PUT_LINE('고객나이 : ' || VAGE);
	EXCEPTION		-- 예외(오류)처리
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('찾는 데이터가 없습니다.');
END;

-- 프로시저 실행
BEGIN
	SEARCH_CUSTOM('wonder');
END;

-- 출력(리턴값)이 있는 프로시저 정의 (객체 생성)
CREATE OR REPLACE PROCEDURE SEARCH_CUSTOM2(		-- PROCEDURE 이름 설정
	C_ID IN TBL_CUSTOM.CUSTOM_ID %TYPE,		-- 매개변수 IN
	C_NAME OUT TBL_CUSTOM.NAME %TYPE		-- 리턴값 프로시저 출력 OUT
)
IS 
-- 일반 변수 선언
--	VNAME TBL_CUSTOM.NAME %TYPE;
--	VAGE TBL_CUSTOM.AGE %TYPE;		

BEGIN 
	SELECT NAME 
	INTO C_NAME
	FROM "TBL_CUSTOM" tc 
	WHERE CUSTOM_ID = C_ID;		-- 1개 행만 결과 조회되는 조건
	
	DBMS_OUTPUT.PUT_LINE('고객을 검색하였습니다.' || C_ID);
	EXCEPTION		-- 예외(오류)처리
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('찾는 데이터가 없습니다.');
		C_NAME := 'NO MATCH';		-- 대입문 := 기호 사용
END;

-- 출력(리턴값)이 있는 프로시저 실행 : 출력값 저장을 위한 변수가 필요하다.
DECLARE
	VNAME TBL_CUSTOM.NAME %TYPE;
BEGIN
	SEARCH_CUSTOM2('momo', VNAME);		-- VNAME은 프로시저 정의할 때 OUT으로 선언
--	VNAME := SEATCH_CUSTOM2('mina012');		-- 올바르지 않은 형식
	DBMS_OUTPUT.PUT_LINE('*고객 이름 : ' || VNAME);
END;

-- BEGIN ~ END 에는 하나의 트랜잭션을 구성하는 DML(INSERT, UPDATE, DELETE 위주) 명령들로 구성
-- 오류가 생기면 EXCEPTION에서 ROLLBACK; 오류가 없을 때만 COMMIT;

-- 프로시저에 쓸 수 있는 몇가지 SQL
CREATE TABLE TBL_TEMP
AS
SELECT * FROM TBL_CUSTOM WHERE CUSTOM_ID ='0';

-- SELECT한 결과를 INSERT 하기
INSERT INTO TBL_TEMP (SELECT * FROM TBL_CUSTOM WHERE CUSTOM_ID = 'wonder');

SELECT * FROM TBL_TEMP tt;


-- FUNCTION 오라클 객체와 비교
-- 오라클 함수 : UPPER, LOWER, DECODE, ROUND, TO_DATE, TO_CHAR, ...
-- FUNCTION은 사용자 함수를 정의한다. 테이블을 대상으로 하는 것이 아니라, 특정 데이터를 조작하는 동작이다.