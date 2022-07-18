-- VIEW : 가상 테이블 (물리적으로 존재하지 않고 논리적으로 만들어진 테이블)
--		: 물리적인 테이블을 이용해서 생성한다.
--		: 사용자(개발자)가 테이블처럼 SELECT를 조회할 수 있는 테이블
--		: 자주 사용되는 JOIN, GROUP BY 등을 미리 생성해서 사용한다.
--		: GRANT CREATE VIEW TO 계정명;		=> VIEW 생성 권한이 없다는 오류가 생기면 추가로 권한을 부여하면 된다.

CREATE VIEW V_DEPT			-- 필요한 컬럼만 뽑아서 미리 V_DEPT라는 VIEW에 넣어놓기
AS
SELECT D.DEPARTMENT_ID, DEPARTMENT_NAME, E.EMPLOYEE_ID, E.FIRST_NAME, E.HIRE_DATE, E.JOB_ID
FROM DEPARTMENTS d, EMPLOYEES e
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID;

SELECT * FROM V_DEPT;

SELECT * FROM V_DEPT WHERE JOB_ID = 'ST_CLERK';		-- LINE 6 연장 : 추가 조건만 WHERE로 붙여서 편하게 조회하기




