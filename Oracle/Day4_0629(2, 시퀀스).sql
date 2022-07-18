-- ����Ŭ�� �������� �̿��Ͽ� �ڵ� �����Ǵ� ���� ����� ���̺��� �÷� ������ INSERT �Ѵ�.
-- (mySQL�� �ٸ� ����� �̿�)

CREATE SEQUENCE TEST_SEQ1;		-- ������ �̸��� �ĺ��� (���� ���̺���� ����ؼ� �ۼ�)

-- DUAL�� ����, �Լ� ��� ���� Ȯ���� �� ����ϴ� �ӽ� ���̺��̴�.
SELECT 2 + 3 FROM DUAL;

-- �������� ���� ������ ����
SELECT TEST_SEQ1.NEXTVAL FROM DUAL;
-- �� ó�� NEXTVAL�� �����ؾ� CURRVAL ���� ����
-- �������� ���簪 Ȯ��
SELECT TEST_SEQ1.CURRVAL FROM DUAL;

CREATE TABLE TBL_SEQ (
	TNO NUMBER(7),
	NAME NVARCHAR2(10)
);
-- ������ ���ϰ� ���� �� SEQUENCE�� ����.
INSERT INTO TBL_SEQ(TNO, NAME) VALUES (TEST_SEQ1.NEXTVAL, '���');
INSERT INTO TBL_SEQ(TNO, NAME) VALUES (TEST_SEQ1.NEXTVAL, '����');
INSERT INTO TBL_SEQ(TNO, NAME) VALUES (TEST_SEQ1.NEXTVAL, '����');
INSERT INTO TBL_SEQ(TNO, NAME) VALUES (TEST_SEQ1.NEXTVAL, '����');
INSERT INTO TBL_SEQ(TNO, NAME) VALUES (TEST_SEQ1.NEXTVAL, '��ȿ');

SELECT * FROM TBL_SEQ;

CREATE SEQUENCE TEST_SEQ2
	INCREMENT BY 2			-- ���� ����
	START WITH 20001;		-- ���۰� ����
-- 20001���� �����ؼ� 2�� �����Ѵ�.
-- MAXVALUE�� �ִ��� ������ �� �ְ�, MINVALUE�� �ִ� ���� �� ��ȯ�ϴ� �ּڰ�
	
SELECT TEST_SEQ2.NEXTVAL FROM DUAL;
SELECT TEST_SEQ2.CURRVAL FROM DUAL;