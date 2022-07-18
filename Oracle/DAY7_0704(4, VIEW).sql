-- VIEW : ���� ���̺� (���������� �������� �ʰ� �������� ������� ���̺�)
--		: �������� ���̺��� �̿��ؼ� �����Ѵ�.
--		: �����(������)�� ���̺�ó�� SELECT�� ��ȸ�� �� �ִ� ���̺�
--		: ���� ���Ǵ� JOIN, GROUP BY ���� �̸� �����ؼ� ����Ѵ�.
--		: GRANT CREATE VIEW TO ������;		=> VIEW ���� ������ ���ٴ� ������ ����� �߰��� ������ �ο��ϸ� �ȴ�.

CREATE VIEW V_DEPT			-- �ʿ��� �÷��� �̾Ƽ� �̸� V_DEPT��� VIEW�� �־����
AS
SELECT D.DEPARTMENT_ID, DEPARTMENT_NAME, E.EMPLOYEE_ID, E.FIRST_NAME, E.HIRE_DATE, E.JOB_ID
FROM DEPARTMENTS d, EMPLOYEES e
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID;

SELECT * FROM V_DEPT;

SELECT * FROM V_DEPT WHERE JOB_ID = 'ST_CLERK';		-- LINE 6 ���� : �߰� ���Ǹ� WHERE�� �ٿ��� ���ϰ� ��ȸ�ϱ�




