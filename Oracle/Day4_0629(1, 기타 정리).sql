-- DDL : CREATE, ALTER, DROP, TRUNCATE
--		(����� USER, TABLE, SEQUENCE, VIEW, ...)
--		��, TRUNCATE�� ���̺� ����Ѵ�.
--		TRUNCATE�� ������ ���(ROLLBACK)�� �� ���� ������ DDL�� ���Ѵ�.
-- DML : INSERT, SELECT, UPDATE, DELETE	==> Ʈ��������� �����ȴ�.
-- DCL : GRANT, COMMIT, ROLLBACK, REVOKE

DROP TABLE SCORES0 ;
DROP TABLE STUDENTS0 ;
-- �� ������ �� ��������.

DROP TABLE STUDENTS0 ;
DROP TABLE SCORES0 ;
-- �� ������ ���� : �ܷ� Ű�� ���� �����Ǵ� ����/�⺻ Ű�� ���̺� �ֽ��ϴ�.
-- �ڽ� ���̺��� ������ TABLE�� DROP�� �� ����.

-- UPDATE ���� 
-- UPDATE (���̺��) SET �÷��� = ��, �÷��� = ��, �÷��� = ��, ... 
--		WHERE (�����÷�) (�����)

-- DELETE ����
-- DELETE FROM (���̺��) WHERE (�����÷�) (�����)

-- ���� : UPDATE�� DELETE�� WHERE ���� ����ϴ� ���� �����ϴ�.
-- ������ ������ ��� �����͸� �� �� ������ �� �ֱ� ������ ������.

SELECT * FROM STUDENTS0;
-- UPDATE, DELETE, SELECT���� WHERE�� �÷��� �⺻Ű �÷����� ���� �����̸�
-- ����Ǵ� ����� �ݿ��Ǵ� ROW�� �ִ� 1���̴�. (ID�� PW ã�� ��)
-- PRIMARY KEY�� ������ TABLE�� ���� ���� �����ϰ� �ĺ��ϴ� �����̴�.
UPDATE STUDENTS0 SET AGE = 17 WHERE STUNO = 2021001;
-- WHERE ���� ���ǽ��� Ʋ���� �ᵵ ������ �ȳ�����, UPDATE ROWS�� 0�̴�.

------------ Ʈ����� ���� ��� : ROLLBACK, COMMIT -------------
-- ROLLBACK, COMMIT �׽�Ʈ (�����ͺ��̽� �޴����� Ʈ����� ��带 MANUAL�� ����)
UPDATE STUDENTS0 SET ADDRESS = '���ϱ�', AGE = 16
	WHERE STUNO = 2021001;
ROLLBACK;		-- ���� UPDATE ������ ����Ѵ�. '���ʱ�', 17���� ����
UPDATE STUDENTS0 SET ADDRESS = '���ϱ�', AGE = 16
	WHERE STUNO = 2021001;
COMMIT;			-- ���� UPDATE ������ �����Ѵ�. '���ϱ�', 16���� ���� Ȯ��
				-- �̹� COMMIT�� ��ɾ�� ROLLBACK �� �� ����.
-----------------------------------------------------------
-- DELETE �׽�Ʈ
DELETE FROM SCORES0;
ROLLBACK;	-- ROLLBACK�� �����ϴ�.
DELETE FROM SCORES0 WHERE STUNO = 2019019;
-- ���� ������� Ʈ������� ��������̹Ƿ� �ܼ� SELECT ����� 2019019�� ����.
-- �ٸ� �����⿡ �ٸ� Ŭ���̾�Ʈ�̹Ƿ� �ش� �ֿܼ����� ���� ����(���� Ŀ���� ����)�� ��������.
ROLLBACK;


-- Ȯ��
SELECT * FROM SCORES0;
SELECT * FROM STUDENTS0;

-- TRUNCATE �����غ���
TRUNCATE TABLE SCORES0 ;	-- ��� �����͸� �����. (�÷� ����)
ROLLBACK;		-- ROLLBACK �ȵ�. ���̺� �������.
-- ��� �����͸� ����� ���� Ȯ���� ���,
-- �ٸ� �͵�� ������ �ѹ���� �ʰ� TRUNCATE ����.

/*
 * COMMIT�� ROLLBACK�� �۵��ϴ� ����
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

