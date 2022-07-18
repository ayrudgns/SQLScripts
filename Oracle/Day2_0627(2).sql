-- 문자열 타입
-- CHAR(길이) : 고정 길이, 단위는 바이트 
-- VARCHAR(길이) : 오라클에서 존재하지만 사용하지 않는 예비 자료형.
-- VARCHAR2(길이) : 가변형 길이, 단위는 바이트, 길이는 최대 길이이고 실제로 메모리는 데이터 크기만큼 사용한다.
--				   최대 2000바이트이고, UTF-8 인코딩에서 한글은 3바이트, 영문/숫자/기호는 1바이트이다.

CREATE TABLE TBL_STRING (
	acol CHAR(10),			-- 10바이트 고정 길이
	bcol VARCHAR2(10),		-- 10바이트 가변 길이
	ccol NCHAR(10),			-- 문자 개수 10개 고정 길이
	dcol NVARCHAR2(10));	-- 문자 개수 10개 가변 길이

-- CHAR 타입 
INSERT INTO TBL_STRING(acol) VALUES ('abcdefghij');
INSERT INTO TBL_STRING(acol) VALUES ('abcdef');		-- acol은 고정 길이 타입 : 공백 4개 추가됨.
INSERT INTO TBL_STRING(acol) VALUES ('abcdefghijklm');	-- 오류 : 길이 초과

-- INSERT 확인
SELECT * FROM TBL_STRING;

-- 한글 확인 : UTF-8 인코딩에서 한글은 3바이트
INSERT INTO TBL_STRING(acol) VALUES ('가나다');		-- 고정 길이 타입 : 공백 1개 추가됨.
INSERT INTO TBL_STRING(acol) VALUES ('가나다라');		-- 오류 : 열에 대한 값이 너무 큼(실제: 12, 최대값: 10)
INSERT INTO TBL_STRING(acol) VALUES ('가나');			-- 고정 길이 타입 : 공백 4개 추가됨.

-- VARCHAR2 타입  : bcol은 가변 길이 10바이트
INSERT INTO TBL_STRING(bcol) VALUES ('abcdefghij');
INSERT INTO TBL_STRING(bcol) VALUES ('abcdef');		-- bcol은 가변 길이 타입, 공백 추가 없음
INSERT INTO TBL_STRING(bcol) VALUES ('abcdefghijklm');	-- 오류 : 길이 초과

-- INSERT 확인
SELECT * FROM TBL_STRING;

-- 한글 확인 : UTF-8 인코딩에서 한글은 3바이트
INSERT INTO TBL_STRING(bcol) VALUES ('가나다');		-- 공백 추가 없음
INSERT INTO TBL_STRING(bcol) VALUES ('가나다라');		-- 오류 : 열에 대한 값이 너무 큼(실제: 12, 최대값: 10)
INSERT INTO TBL_STRING(bcol) VALUES ('가나');			-- 공백 추가 없음

-- CHAR과 VARCHAR2는 바이트 단위이다. NCHAR과 NVARCHAR2는 문자 개수 단위이다.
-- 따라서 NCHAR과 NVARCHAR2는 다국어 문자가 많이 포함되는 컬럼에 적절하다.

-- NCHAR 타입
INSERT INTO TBL_STRING(ccol) VALUES ('가나다');		-- 공백 7개 추가
INSERT INTO TBL_STRING(ccol) VALUES ('가나다라');		-- 공백 6개 추가
INSERT INTO TBL_STRING(ccol) VALUES ('가나');			-- 공백 8개 추가
INSERT INTO TBL_STRING(ccol) VALUES ('가나다라마바사아자차카');			-- 오류 : 길이 초과

-- INSERT 확인
SELECT * FROM TBL_STRING;

-- NVARCHAR2 타입
INSERT INTO TBL_STRING(dcol) VALUES ('가나다');		-- 공백 추가 없음
INSERT INTO TBL_STRING(dcol) VALUES ('가나다라');		-- 공백 추가 없음
INSERT INTO TBL_STRING(dcol) VALUES ('가나');			-- 공백 추가 없음
INSERT INTO TBL_STRING(dcol) VALUES ('가나다라마바사아자차카');			-- 오류 : 길이 초과

-- INSERT 확인
SELECT * FROM TBL_STRING;


