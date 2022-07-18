-- 제약조건 설정은 CREATE TABLE, ALTER TABLE에서 한다.
-- 관계형 데이터베이스에서 굉장히 중요한 내용이다.

-- 제약조건 1) NOT NULL : COL2 컬럼은 반드시 값을 저장해야 한다.
CREATE TABLE TBL# (
	COL1 VARCHAR2(10),
	COL2 NUMBER(3) NOT NULL
);

INSERT INTO TBL#(COL2) VALUES (98);
INSERT INTO TBL#(COL1) VALUES ('korean');	-- 오류 : COL2 컬럼의 NOT NULL 제약조건 위반
INSERT INTO TBL# VALUES ('korean', 78);
INSERT INTO TBL# VALUES ('korean', 88);

-- 확인
SELECT * FROM TBL#;

-------- 새로운 컬럼 생성 --------------

-- 새로운 제약조건을 갖는 COL3, 제약조건 2) UNIQUE를 갖는 COL3
ALTER TABLE TBL# ADD COL3 VARCHAR2(10) UNIQUE;		-- 해당 컬럼에서 유일한 값이어야 한다.
-- 다음 INSERT를 순서대로 실행할 때, 오류가 발생하는 INSERT 찾기.
INSERT INTO TBL#(COL1) VALUES ('english');	-- 오류 : COL2 값이 없다. (NOT NULL 위반)
INSERT INTO TBL#(COL2) VALUES (77);
INSERT INTO TBL#(COL3) VALUES ('english');	-- 오류 : COL2 값이 없다. (NOT NULL 위반)
INSERT INTO TBL#(COL1, COL2) VALUES ('english', 88);
INSERT INTO TBL#(COL2, COL3) VALUES (88, 'science');
INSERT INTO TBL#(COL1, COL3) VALUES ('science', 88);	-- 오류 : COL2 값이 없다. (NOT NULL 위반)
INSERT INTO TBL#(COL1, COL2, COL3) VALUES ('english', 89, 'science');
-- 오류 : 무결성 제약 조건(UNIQUE)에 위배됩니다. (같은 값 중복 불가능)
-- 'SCIENCE'값이 COL3에 있는데, 'SCIENCE'값을 또 넣으면 오류 발생
INSERT INTO TBL#(COL1, COL2, COL3) VALUES ('english', 89, 'math');
-- 얘는 잘됨.
-- 체크 사항 : UNIQUE 컬럼에 NULL은 허용된다.

-- 제약조건 3) 기본키(PRIMARY KEY)는 NOT NULL과 UNIQUE 제약조건이다.
-- 즉, NULL도 허용하지 않고 같은 값 중복도 허용하지 않는다.
CREATE TABLE TBL2# (
	TNO NUMBER(3) PRIMARY KEY,
	TID NUMBER(3) UNIQUE
);

-- 확인
SELECT * FROM TBL2#;

INSERT INTO TBL2# (TNO) VALUES (123);
INSERT INTO TBL2# (TNO) VALUES (123);	-- 오류 : TNO의 PRIMARY KEY 중 UNIQUE 위반
INSERT INTO TBL2# (TID) VALUES (123);	-- 오류 : TNO의 PRIMARY KEY 중 NOT NULL 위반
-- 무결성 제약 조건(pk 기본키 컬럼, 유일한 값이면서 NOT NULL이어야 함)에 위배됩니다.
-- 데이터 저장할 때 아이디나 비밀번호 중복되는 경우에 쓰이는건가?
-- NOT NULL은 선택사항일 때 쓰이겠군..

-- 제약조건 4) CHECK : 컬럼 값에 조건을 설정, AGE 컬럼 값은 16 ~ 80, NULL은 허용
ALTER TABLE TBL2# ADD AGE NUMBER(3) CHECK (AGE BETWEEN 16 AND 80);
-- BETWEEN 연산자 이용, 적힌 숫자 포함!

-- 확인
SELECT * FROM TBL2#;

INSERT INTO TBL2#(TNO, TID, AGE) VALUES (222, 123, 20);
INSERT INTO TBL2#(TNO, TID, AGE) VALUES (223, 124, 90);
-- 오류 : 체크 제약조건(AGE값이 80 초과)이 위배되었습니다.

-- GENDER 컬럼 추가 (M 또는 F)
ALTER TABLE "TBL2#" ADD GENDER CHAR(1) CHECK (GENDER IN ('M', 'F'));

INSERT INTO "TBL2#" (TNO, GENDER) VALUES (224, 'F');
INSERT INTO "TBL2#" (TNO, GENDER) VALUES (225, 'M');
INSERT INTO "TBL2#" (TNO, GENDER) VALUES (226, 'm');
-- 오류 : 체크 제약조건(소문자 m)이 위배되었습니다.

-- GENDER 컬럼의 제약조건 변경
-- ALTER TABLE "TBL2#" MODIFY GENDER CHAR(1) CHECK (GENDER IN ('M', 'F', 'm', 'f'));
-- 오류 : 현재 GENDER 컬럼의 제약조건만 변경하는 경우에는 다른 명령어로 해야한다.

-- ALTER TABLE ~ DROP CONSTRAINTS로 기존의 제약조건 삭제하고 ADD 해야한다.
ALTER TABLE "TBL2#" DROP CONSTRAINTS TBL2__CHK_GENDER;
ALTER TABLE "TBL2#" ADD CONSTRAINTS TBL2__CHK_GENDER2
CHECK (GENDER IN ('M', 'F', 'm', 'f'));

INSERT INTO "TBL2#" (TNO, GENDER) VALUES (226, 'm');
INSERT INTO "TBL2#" (TNO, GENDER) VALUES (227, 'f');
INSERT INTO "TBL2#" (TNO, GENDER) VALUES (228, 'm');
INSERT INTO "TBL2#" (TNO, GENDER) VALUES (229, 'f');
