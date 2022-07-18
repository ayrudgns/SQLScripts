-- TABLE 만드는 명령, 데이터 형식 테스트

CREATE TABLE TBL_MEMBER(
	mno NUMBER,				-- 기본 38자리
	name NVARCHAR2(50),
	email VARCHAR2(100),
	join_date DATE);		-- 날짜 년-월-일, 시간 시:분:초.밀리초
	
-------------- 1. DML INSERT 형식 (데이터 행 추가)
-- 모든 컬럼에 데이터를 저장하는 형식, 컬럼명을 생략할 수 있다. (날짜는 DATE 자동 변환)
INSERT INTO TBL_MEMBER VALUES (1, '김모모', 'momo@naver.com', '2022-03-02');

-- 일부 컬럼에 데이터를 저장하고 싶을 때에는, 데이터가 저장될 컬럼명을 나열한다. 
INSERT INTO TBL_MEMBER (mno, name) VALUES (2, '이나나');
----------------------------------------------------------------------------

-------------- 2. DML SELECT 형식 (데이터 행 row 조회)
-- SELECT 조회할 컬럼 목록 from 테이블 이름 [where 조건식]; 모든 컬럼은 *로 대체한다.		// *은 '와일드카드'
SELECT name FROM TBL_MEMBER;
SELECT name, join_date FROM TBL_MEMBER;
SELECT * FROM TBL_MEMBER;				-- ctrl + enter는 문장 중간에서 실행해도 된다.
SELECT * FROM TBL_MEMBER WHERE name = '최다현';		-- 조건식은 컬럼 이름으로 조회할 관계식/논리식
SELECT * FROM TBL_MEMBER tm WHERE mno > 2;
SELECT * FROM TBL_MEMBER tm WHERE join_date > '2022-03-03';
SELECT name, email FROM TBL_MEMBER tm WHERE join_date > '2022-03-03';

-- null 값 조회
SELECT * FROM TBL_MEMBER tm WHERE email IS NULL;
SELECT * FROM TBL_MEMBER tm WHERE email IS NOT NULL;

-- 문자열의 부분 검색 : LIKE 연산
SELECT * FROM TBL_MEMBER WHERE name LIKE '%다현';		-- %는 don't care, 상관없다.
SELECT * FROM TBL_MEMBER WHERE name LIKE '다현%';		-- 없음. '다현'으로 시작하는 데이터 없음.
SELECT * FROM TBL_MEMBER WHERE name LIKE '%다현%';		-- 잘 나온다. '다현'이 들어가기만 하면 됨.

-- OR 연산 : mno값이 1 또는 2 또는 4
SELECT * FROM TBL_MEMBER WHERE mno = 1 OR mno = 2 OR mno = 4;
--		오라클의 OR 대체 연산자 : IN (동일 컬럼에 대한 조건식일 때)
SELECT * FROM TBL_MEMBER WHERE mno IN (1, 2, 4);
SELECT * FROM TBL_MEMBER WHERE mno NOT IN (1, 2, 4);
SELECT * FROM TBL_MEMBER WHERE name IN ('김모모', '최다현');



--------------- DATE 형식 ---------------
INSERT INTO TBL_MEMBER VALUES (3, '최다현', 'dahy@naver.com', 
'2022-03-04 16:47');		-- 오류 : 날짜 형식으로 자동변환되지 않음.

-- 오라클의 TO_DATE 함수는 문자열을 날짜 형식으로 변환시켜준다. (두번째 인자는 패턴)
INSERT INTO TBL_MEMBER VALUES (3, '최다현', 'dahy@naver.com', 
TO_DATE('2022-03-04 16:47', 'YYYY-MM-DD HH24:MI'));

-- TO_CHAR 함수 : 날짜 형식에서 문자열로 변경한다. (두번째 인자는 패턴)
-- ==> 연도 또는 일부 값만 추출할 때 활용한다.
SELECT TO_CHAR(join_date, 'YYYY') FROM TBL_MEMBER; 

-- 현재 시스템의 날짜와 시간 : SYSDATE 함수
INSERT INTO TBL_MEMBER VALUES (4, '쯔위', 'aaa@gmail.com', SYSDATE);

SELECT * FROM TBL_MEMBER;

-- 처음 만든 테이블 구조 중 mno 컬럼을 정밀도 5로 축소 변경하기
-- 축소 변경할 때는 mno 컬럼에 값이 없어야 한다. ([null])
ALTER TABLE "C##IDEV".TBL_MEMBER MODIFY MNO NUMBER(5,0);	-- 38자리를 5자리로 바꾸겠다.
-- 확대 변경할 때는 큰 문제가 없다!
