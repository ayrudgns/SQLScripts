-- TABLE ����� ���, ������ ���� �׽�Ʈ

CREATE TABLE TBL_MEMBER(
	mno NUMBER,				-- �⺻ 38�ڸ�
	name NVARCHAR2(50),
	email VARCHAR2(100),
	join_date DATE);		-- ��¥ ��-��-��, �ð� ��:��:��.�и���
	
-------------- 1. DML INSERT ���� (������ �� �߰�)
-- ��� �÷��� �����͸� �����ϴ� ����, �÷����� ������ �� �ִ�. (��¥�� DATE �ڵ� ��ȯ)
INSERT INTO TBL_MEMBER VALUES (1, '����', 'momo@naver.com', '2022-03-02');

-- �Ϻ� �÷��� �����͸� �����ϰ� ���� ������, �����Ͱ� ����� �÷����� �����Ѵ�. 
INSERT INTO TBL_MEMBER (mno, name) VALUES (2, '�̳���');
----------------------------------------------------------------------------

-------------- 2. DML SELECT ���� (������ �� row ��ȸ)
-- SELECT ��ȸ�� �÷� ��� from ���̺� �̸� [where ���ǽ�]; ��� �÷��� *�� ��ü�Ѵ�.		// *�� '���ϵ�ī��'
SELECT name FROM TBL_MEMBER;
SELECT name, join_date FROM TBL_MEMBER;
SELECT * FROM TBL_MEMBER;				-- ctrl + enter�� ���� �߰����� �����ص� �ȴ�.
SELECT * FROM TBL_MEMBER WHERE name = '�ִ���';		-- ���ǽ��� �÷� �̸����� ��ȸ�� �����/����
SELECT * FROM TBL_MEMBER tm WHERE mno > 2;
SELECT * FROM TBL_MEMBER tm WHERE join_date > '2022-03-03';
SELECT name, email FROM TBL_MEMBER tm WHERE join_date > '2022-03-03';

-- null �� ��ȸ
SELECT * FROM TBL_MEMBER tm WHERE email IS NULL;
SELECT * FROM TBL_MEMBER tm WHERE email IS NOT NULL;

-- ���ڿ��� �κ� �˻� : LIKE ����
SELECT * FROM TBL_MEMBER WHERE name LIKE '%����';		-- %�� don't care, �������.
SELECT * FROM TBL_MEMBER WHERE name LIKE '����%';		-- ����. '����'���� �����ϴ� ������ ����.
SELECT * FROM TBL_MEMBER WHERE name LIKE '%����%';		-- �� ���´�. '����'�� ���⸸ �ϸ� ��.

-- OR ���� : mno���� 1 �Ǵ� 2 �Ǵ� 4
SELECT * FROM TBL_MEMBER WHERE mno = 1 OR mno = 2 OR mno = 4;
--		����Ŭ�� OR ��ü ������ : IN (���� �÷��� ���� ���ǽ��� ��)
SELECT * FROM TBL_MEMBER WHERE mno IN (1, 2, 4);
SELECT * FROM TBL_MEMBER WHERE mno NOT IN (1, 2, 4);
SELECT * FROM TBL_MEMBER WHERE name IN ('����', '�ִ���');



--------------- DATE ���� ---------------
INSERT INTO TBL_MEMBER VALUES (3, '�ִ���', 'dahy@naver.com', 
'2022-03-04 16:47');		-- ���� : ��¥ �������� �ڵ���ȯ���� ����.

-- ����Ŭ�� TO_DATE �Լ��� ���ڿ��� ��¥ �������� ��ȯ�����ش�. (�ι�° ���ڴ� ����)
INSERT INTO TBL_MEMBER VALUES (3, '�ִ���', 'dahy@naver.com', 
TO_DATE('2022-03-04 16:47', 'YYYY-MM-DD HH24:MI'));

-- TO_CHAR �Լ� : ��¥ ���Ŀ��� ���ڿ��� �����Ѵ�. (�ι�° ���ڴ� ����)
-- ==> ���� �Ǵ� �Ϻ� ���� ������ �� Ȱ���Ѵ�.
SELECT TO_CHAR(join_date, 'YYYY') FROM TBL_MEMBER; 

-- ���� �ý����� ��¥�� �ð� : SYSDATE �Լ�
INSERT INTO TBL_MEMBER VALUES (4, '����', 'aaa@gmail.com', SYSDATE);

SELECT * FROM TBL_MEMBER;

-- ó�� ���� ���̺� ���� �� mno �÷��� ���е� 5�� ��� �����ϱ�
-- ��� ������ ���� mno �÷��� ���� ����� �Ѵ�. ([null])
ALTER TABLE "C##IDEV".TBL_MEMBER MODIFY MNO NUMBER(5,0);	-- 38�ڸ��� 5�ڸ��� �ٲٰڴ�.
-- Ȯ�� ������ ���� ū ������ ����!
