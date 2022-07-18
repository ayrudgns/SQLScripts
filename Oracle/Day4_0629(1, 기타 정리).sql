-- DDL : CREATE, ALTER, DROP, TRUNCATE
--		(대상은 USER, TABLE, SEQUENCE, VIEW, ...)
--		단, TRUNCATE는 테이블만 사용한다.
--		TRUNCATE는 실행을 취소(ROLLBACK)할 수 없기 때문에 DDL에 속한다.
-- DML : INSERT, SELECT, UPDATE, DELETE	==> 트랜잭션으로 관리된다.
-- DCL : GRANT, COMMIT, ROLLBACK, REVOKE

DROP TABLE SCORES0 ;
DROP TABLE STUDENTS0 ;
-- 위 과정은 잘 지워진다.

DROP TABLE STUDENTS0 ;
DROP TABLE SCORES0 ;
-- 위 과정은 오류 : 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다.
-- 자식 테이블이 있으면 TABLE을 DROP할 수 없다.

-- UPDATE 형식 
-- UPDATE (테이블명) SET 컬럼명 = 값, 컬럼명 = 값, 컬럼명 = 값, ... 
--		WHERE (조건컬럼) (관계식)

-- DELETE 형식
-- DELETE FROM (테이블명) WHERE (조건컬럼) (관계식)

-- 주의 : UPDATE와 DELETE는 WHERE 없이 사용하는 것은 위험하다.
-- 조건이 없으면 모든 데이터를 싹 다 변경할 수 있기 때문에 위험함.

SELECT * FROM STUDENTS0;
-- UPDATE, DELETE, SELECT에서 WHERE의 컬럼이 기본키 컬럼으로 동등 조건이면
-- 실행되는 결과가 반영되는 ROW는 최대 1개이다. (ID나 PW 찾을 때)
-- PRIMARY KEY의 목적은 TABLE의 여러 행을 구분하고 식별하는 목적이다.
UPDATE STUDENTS0 SET AGE = 17 WHERE STUNO = 2021001;
-- WHERE 뒤의 조건식을 틀리게 써도 오류는 안나지만, UPDATE ROWS가 0이다.

------------ 트랜잭션 관리 명령 : ROLLBACK, COMMIT -------------
-- ROLLBACK, COMMIT 테스트 (데이터베이스 메뉴에서 트랜잭션 모드를 MANUAL로 변경)
UPDATE STUDENTS0 SET ADDRESS = '성북구', AGE = 16
	WHERE STUNO = 2021001;
ROLLBACK;		-- 위의 UPDATE 실행을 취소한다. '서초구', 17세로 복구
UPDATE STUDENTS0 SET ADDRESS = '성북구', AGE = 16
	WHERE STUNO = 2021001;
COMMIT;			-- 위의 UPDATE 실행을 저장한다. '성북구', 16세로 변경 확정
				-- 이미 COMMIT된 명령어는 ROLLBACK 할 수 없다.
-----------------------------------------------------------
-- DELETE 테스트
DELETE FROM SCORES0;
ROLLBACK;	-- ROLLBACK이 가능하다.
DELETE FROM SCORES0 WHERE STUNO = 2019019;
-- 현재 편집기는 트랜잭션이 수동모드이므로 콘솔 SELECT 결과에 2019019가 없다.
-- 다른 편집기에 다른 클라이언트이므로 해당 콘솔에서는 이전 상태(최종 커밋한 상태)로 보여진다.
ROLLBACK;


-- 확인
SELECT * FROM SCORES0;
SELECT * FROM STUDENTS0;

-- TRUNCATE 실행해보기
TRUNCATE TABLE SCORES0 ;	-- 모든 데이터를 지운다. (컬럼 제외)
ROLLBACK;		-- ROLLBACK 안됨. 테이블 비어있음.
-- 모든 데이터를 지우는 것이 확실한 경우,
-- 다른 것들과 섞여서 롤백되지 않게 TRUNCATE 실행.

/*
 * COMMIT과 ROLLBACK이 작동하는 예시
 * 
 * INSERT
 * DELETE
 * COMMIT;		(1) LINE 64, 65 COMMIT
 * UPDATE
 * DELETE;
 * ROLLBACK;	(2) LINE 67, 68 ROLLBACK
 * INSERT;
 * INSERT;
 * ROLLBACK;	(3) LINE 70, 71 ROLLBACK
 * INSERT
 * UPDATE;
 * COMMIT;		(4) LINE 73, 74 COMMIT
 */

