-- MIN_SALARY �÷��� 10000 �̻��� JOB_TITLE ��ȸ
	SELECT JOB_TITLE FROM JOBS WHERE MIN_SALARY >= 10000;

-- JOB_TITLE �÷��� PROGRAMMER�� ���� ��� �÷� ��ȸ
	SELECT * FROM JOBS WHERE JOB_TITLE = 'Programmer';

-- MAX_SALARY �ʵ尪�� �ִ� ��ȸ
	SELECT MAX(MAX_SALARY) FROM JOBS; 

-- CITY �÷��� LONDON�� POSTAL_CODE ��ȸ
	SELECT POSTAL_CODE FROM LOCATIONS WHERE CITY = 'London'; 

-- LOCATIONAL_ID �÷��� 1700, 2700, 2500�� �ƴϰ� CITY �÷��� Tokyo�� ���� ��� �÷� ��ȸ
	SELECT * FROM LOCATIONS WHERE LOCATION_ID NOT IN (1700, 2700, 2500) AND CITY = 'Tokyo';

-- Jonathon Taylor�� �ٹ� �̷� Ȯ���ϱ�
	SELECT * FROM EMPLOYEES e JOIN JOB_HISTORY jh ON E.EMPLOYEE_ID = JH.EMPLOYEE_ID
		AND FIRST_NAME = 'Jonathon' AND LAST_NAME = 'Taylor';

-- MIN_SALARY�� ��պ��� ���� JOB�� ���� ���� ��ȸ�ϱ�
	SELECT JOB_ID, JOB_TITLE, MIN_SALARY FROM JOBS j
		WHERE MIN_SALARY < (SELECT AVG(MIN_SALARY) FROM JOBS j);
	
------------------------------------ ���⼭���� ���� -----------------------------------------

-- ���� ������ �ʿ��� ���� : ������ ���̺� ���
-- JOB_ID�� 'IT_PROG'�̸鼭 �ּ� �޿��� �޴� ����� FIRST_NAME, LAST_NAME �÷� ��ȸ�ϱ�
	SELECT FIRST_NAME, LAST_NAME, SALARY FROM EMPLOYEES e
	WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES e WHERE JOB_ID = 'IT_PROG');

-- '���� �ʴ�'�� ǥ���ϴ� ���, WHERE �÷��� <> '����'; �Ǵ� WHERE NOT �÷��� = '����';
	
-- �μ��� ��� �޿��� ��ȸ�ϱ�. ������ ��� �޿� ������������ �μ�_ID, �μ���, ��� �޿� (�Ҽ��� 1�ڸ��� �ݿø�)
-- �Ҽ��� ���� �Լ� : ROUND(�ݿø�), TRUNC(����), CEIL(����)
-- �׷��Լ��� ��ȸ�� ��, GROUP BY�� ��� GROUP BY�� �� �÷��� SELECT�� ��ȸ�� �� �ִ�.
-- GROUP BY�� ���� �÷� �ܿ� �ٸ� �÷��� SELECT�� �� ����. => �̷��� ���, JOIN�̳� ���������� ó���Ѵ�.

-- 1�ܰ� : ����� �׷��Լ� �����ϱ�
	SELECT DEPARTMENT_ID, AVG(SALARY) FROM EMPLOYEES e
	GROUP BY DEPARTMENT_ID;
-- 2�ܰ�	: JOIN �ϱ�
	SELECT * FROM DEPARTMENTS d JOIN (SELECT DEPARTMENT_ID, AVG(SALARY) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
	ON D.DEPARTMENT_ID = TAVG.DEPARTMENT_ID; 
-- 3�ܰ� : �÷� �����ϱ�
	SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, ROUND(TAVG.CAVG, 1) FROM DEPARTMENTS d
	JOIN (SELECT DEPARTMENT_ID, AVG(SALARY) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
	ON D.DEPARTMENT_ID = TAVG.DEPARTMENT_ID 	
	ORDER BY TAVG.CAVG DESC;
-- 4�ܰ� : ������ ����� Ư�� ��ġ �����ϱ�, FIRST N�� ���� N���� ��ȸ�Ѵ�.
	SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, ROUND(TAVG.CAVG, 1) FROM DEPARTMENTS d
	JOIN (SELECT DEPARTMENT_ID, AVG(SALARY) cavg FROM EMPLOYEES e GROUP BY DEPARTMENT_ID) tavg
	ON D.DEPARTMENT_ID = TAVG.DEPARTMENT_ID 	
	ORDER BY TAVG.CAVG DESC
	FETCH FIRST 1 ROWS ONLY;	-- ������ �ุ ��ȸ�Ѵ�. (TOP'N' ��ȸ�� �� ����.)
								-- FETCH�� ����Ŭ 12C �������� ��� �����ϴ�.
								-- 11 ������ ROWNUM�� ����ؾ� ��.

-- ROWNUM�� ������ (�ӽ÷� ����)�÷�����, ��ȸ�� ����� ���������� ����Ŭ�� �ο��ϴ� ���̴�.
-- ���� �÷� ����� ���� JOIN�� �ѹ� �� �ʿ��ϴ�.
	SELECT ROWNUM, TCNT.* FROM
	(SELECT DEPARTMENT_ID, COUNT(*) CNT FROM EMPLOYEES GROUP BY DEPARTMENT_ID ORDER BY CNT DESC) TCNT
	WHERE ROWNUM = 1;

	SELECT ROWNUM, TCNT.* FROM
	(SELECT DEPARTMENT_ID, COUNT(*) CNT FROM EMPLOYEES GROUP BY DEPARTMENT_ID ORDER BY CNT DESC) TCNT
	WHERE ROWNUM < 6;

-- ROWNUM ����� ��, ��� Ȯ���� ���� �ʴ� ���� : ROWNUM�� 1���� �����ؼ� ã�ư� �� �ִ� ���ǽĸ� �����ϴ�.
-- WHERE ROWNUM = 3; => 1���� �������� �ʰ� 3�� �ٷ� ã����� �ϴϱ� �ȵȴ�.
-- WHERE ROWNUM > 5; => 5���� ū ������ �����϶�� �ϴϱ� �ȵȴ�.
	
-- �Ǵ� ��� : ROWNUM�� ������ ��ȸ ����� �ѹ� �� SELECT�ϱ� (�̶�, ROWNUM�� ��Ī�� �ٿ��ֱ�)
	SELECT * FROM
	(SELECT ROWNUM rn, TCNT.* FROM
	(SELECT DEPARTMENT_ID, COUNT(*) CNT FROM EMPLOYEES GROUP BY DEPARTMENT_ID ORDER BY CNT DESC) TCNT)
	WHERE RN BETWEEN 4 AND 8;

