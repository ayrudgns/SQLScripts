-- ���� ���̺� : ����_id, �̸�, ��, �̸���, ��ȭ��ȣ, �������, ����_id, �޿�, �Ŵ���_id, �μ�_id

/*
1. hire_date�� 2006�� 1�� 1�� ������ ������ �̸�, ��, �̸���

2. lastname�� 'Jones'�� ������ ��� �÷�

3. salary�� 5000 �̻��� ������ �̸�, ��, job_id ��ȸ

4. job_id�� account�� ���� ������ �̸�, ��, salary ��ȸ

5. �μ�_id�� 50, 60, 80, 90�� ������ ����_id, �̸�, �� ��ȸ
*/

-- 1. hire_date�� 2006�� 1�� 1�� ������ ������ �̸�, ��, �̸���
SELECT FIRST_NAME, LAST_NAME, EMAIL FROM EMPLOYEES WHERE HIRE_DATE < '2006-01-01' 

-- 2. lastname�� 'Jones'�� ������ ��� �÷�
SELECT * FROM EMPLOYEES WHERE LAST_NAME = 'Jones';
-- ��ҹ��� �˻�� ���ǽĿ� �����ؾ� �Ѵ�.
-- �÷����� ��ҹ��� ��ȯ �� ���ǰ� ��
SELECT * FROM EMPLOYEES WHERE UPPER(LAST_NAME) = 'Jones';	-- ��ҹ��� �����ϰ�
SELECT * FROM EMPLOYEES WHERE LOWER(LAST_NAME) = 'Jones';	-- ���ϴ� ��� �ΰ���

-- 3. salary�� 5000 �̻��� ������ �̸�, ��, job_id ��ȸ
SELECT FIRST_NAME, LAST_NAME, JOB_ID FROM EMPLOYEES WHERE SALARY >= 5000;

-- 4. job_id�� account�� ���� ������ �̸�, ��, salary ��ȸ
SELECT FIRST_NAME, LAST_NAME, SALARY FROM EMPLOYEES WHERE JOB_ID LIKE '%ACCOUNT%';

-- 5. �μ�_id�� 50, 60, 80, 90�� ������ ����_id, �̸�, �� ��ȸ : ������ Ÿ�� ��ȯ
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE DEPARTMENT_ID
IN (50, 60, 80, 90);

SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME FROM EMPLOYEES WHERE DEPARTMENT_ID
IN ('50', '60', '80', '90');
-- �̷��� �ᵵ �Ǳ� �Ǵµ�, �Ǵ� ������ �÷� ���Ŀ� �°� �ڵ� ��ȯ�� ��, ���� ����ǥ ���°� �ùٸ���.

-- ����Լ� : count, avg, max, min, sum ==> �׷��Լ���� �Ѵ�.
--			�ش� �Լ� ������� ���ϱ� ���� Ư�� �÷��� ����Ͽ� ���� �����͸� �׷�ȭ�� �� �����Ѵ�.

SELECT COUNT(*) FROM EMPLOYEES e;		-- ���̺� ��ü �������� ���� Ȯ�� : 107
SELECT MAX(SALARY) FROM EMPLOYEES e;	-- salary �÷��� �ִ� : 24000
SELECT MIN(SALARY) FROM EMPLOYEES e;	-- salary �÷��� �ּڰ� : 2100
SELECT AVG(SALARY) FROM EMPLOYEES e;	-- salary �÷��� ��հ� : 6461.83 ...  
SELECT SUM(SALARY) FROM EMPLOYEES e;	-- salary �÷��� �հ� : 691416

-- �� 5�� ����Լ��� JOB_ID = 'IT_PROG' ���� ���ǽ����� �Ȱ��� �����غ���
SELECT COUNT(*) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';	-- �������� ���� Ȯ�� : 5
SELECT MAX(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';	-- �ִ� : 9000
SELECT MIN(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';	-- �ּڰ� : 4200
SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';	-- ��հ� : 5760
SELECT SUM(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG';	-- �հ� : 28800
-- �Լ��� �ǹ̸� �ľ�����. (�� �Լ��� ��� �� �� ����?)

-- ����Լ� ����� �ٸ� �÷����� ���� ��ȸ�� �� ����. (�׷��Լ��̱� ����)
SELECT JOB_ID, COUNT(*) FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';		-- ����

-- ������ ��� : ���� ����, ���� ����, CREATE TABLE, INSERT INTO, SELECT ~ WHERE ~ �⺻ ����
-- ���� : ��Ī(ALIAS), �÷� �Ǵ� ���̺��� �̸��� �� �� ª�� �ٿ��� ���� �̸�.
SELECT * FROM EMPLOYEES e ;		-- EMPLOYEES ���̺��� ��Ī e
SELECT * FROM DEPARTMENTS d ;	-- DEPARTMENTS ���̺��� ��Ī d
-- ��������� ���� ��Ī�� �ʿ����� ������, �������� �����ϰ� ���δ�.