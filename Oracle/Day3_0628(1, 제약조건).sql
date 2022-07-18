-- �������� ������ CREATE TABLE, ALTER TABLE���� �Ѵ�.
-- ������ �����ͺ��̽����� ������ �߿��� �����̴�.

-- �������� 1) NOT NULL : COL2 �÷��� �ݵ�� ���� �����ؾ� �Ѵ�.
CREATE TABLE TBL# (
	COL1 VARCHAR2(10),
	COL2 NUMBER(3) NOT NULL
);

INSERT INTO TBL#(COL2) VALUES (98);
INSERT INTO TBL#(COL1) VALUES ('korean');	-- ���� : COL2 �÷��� NOT NULL �������� ����
INSERT INTO TBL# VALUES ('korean', 78);
INSERT INTO TBL# VALUES ('korean', 88);

-- Ȯ��
SELECT * FROM TBL#;

-------- ���ο� �÷� ���� --------------

-- ���ο� ���������� ���� COL3, �������� 2) UNIQUE�� ���� COL3
ALTER TABLE TBL# ADD COL3 VARCHAR2(10) UNIQUE;		-- �ش� �÷����� ������ ���̾�� �Ѵ�.
-- ���� INSERT�� ������� ������ ��, ������ �߻��ϴ� INSERT ã��.
INSERT INTO TBL#(COL1) VALUES ('english');	-- ���� : COL2 ���� ����. (NOT NULL ����)
INSERT INTO TBL#(COL2) VALUES (77);
INSERT INTO TBL#(COL3) VALUES ('english');	-- ���� : COL2 ���� ����. (NOT NULL ����)
INSERT INTO TBL#(COL1, COL2) VALUES ('english', 88);
INSERT INTO TBL#(COL2, COL3) VALUES (88, 'science');
INSERT INTO TBL#(COL1, COL3) VALUES ('science', 88);	-- ���� : COL2 ���� ����. (NOT NULL ����)
INSERT INTO TBL#(COL1, COL2, COL3) VALUES ('english', 89, 'science');
-- ���� : ���Ἲ ���� ����(UNIQUE)�� ����˴ϴ�. (���� �� �ߺ� �Ұ���)
-- 'SCIENCE'���� COL3�� �ִµ�, 'SCIENCE'���� �� ������ ���� �߻�
INSERT INTO TBL#(COL1, COL2, COL3) VALUES ('english', 89, 'math');
-- ��� �ߵ�.
-- üũ ���� : UNIQUE �÷��� NULL�� ���ȴ�.

-- �������� 3) �⺻Ű(PRIMARY KEY)�� NOT NULL�� UNIQUE ���������̴�.
-- ��, NULL�� ������� �ʰ� ���� �� �ߺ��� ������� �ʴ´�.
CREATE TABLE TBL2# (
	TNO NUMBER(3) PRIMARY KEY,
	TID NUMBER(3) UNIQUE
);

-- Ȯ��
SELECT * FROM TBL2#;

INSERT INTO TBL2# (TNO) VALUES (123);
INSERT INTO TBL2# (TNO) VALUES (123);	-- ���� : TNO�� PRIMARY KEY �� UNIQUE ����
INSERT INTO TBL2# (TID) VALUES (123);	-- ���� : TNO�� PRIMARY KEY �� NOT NULL ����
-- ���Ἲ ���� ����(pk �⺻Ű �÷�, ������ ���̸鼭 NOT NULL�̾�� ��)�� ����˴ϴ�.
-- ������ ������ �� ���̵� ��й�ȣ �ߺ��Ǵ� ��쿡 ���̴°ǰ�?
-- NOT NULL�� ���û����� �� ���̰ڱ�..

-- �������� 4) CHECK : �÷� ���� ������ ����, AGE �÷� ���� 16 ~ 80, NULL�� ���
ALTER TABLE TBL2# ADD AGE NUMBER(3) CHECK (AGE BETWEEN 16 AND 80);
-- BETWEEN ������ �̿�, ���� ���� ����!

-- Ȯ��
SELECT * FROM TBL2#;

INSERT INTO TBL2#(TNO, TID, AGE) VALUES (222, 123, 20);
INSERT INTO TBL2#(TNO, TID, AGE) VALUES (223, 124, 90);
-- ���� : üũ ��������(AGE���� 80 �ʰ�)�� ����Ǿ����ϴ�.

-- GENDER �÷� �߰� (M �Ǵ� F)
ALTER TABLE "TBL2#" ADD GENDER CHAR(1) CHECK (GENDER IN ('M', 'F'));

INSERT INTO "TBL2#" (TNO, GENDER) VALUES (224, 'F');
INSERT INTO "TBL2#" (TNO, GENDER) VALUES (225, 'M');
INSERT INTO "TBL2#" (TNO, GENDER) VALUES (226, 'm');
-- ���� : üũ ��������(�ҹ��� m)�� ����Ǿ����ϴ�.

-- GENDER �÷��� �������� ����
-- ALTER TABLE "TBL2#" MODIFY GENDER CHAR(1) CHECK (GENDER IN ('M', 'F', 'm', 'f'));
-- ���� : ���� GENDER �÷��� �������Ǹ� �����ϴ� ��쿡�� �ٸ� ��ɾ�� �ؾ��Ѵ�.

-- ALTER TABLE ~ DROP CONSTRAINTS�� ������ �������� �����ϰ� ADD �ؾ��Ѵ�.
ALTER TABLE "TBL2#" DROP CONSTRAINTS TBL2__CHK_GENDER;
ALTER TABLE "TBL2#" ADD CONSTRAINTS TBL2__CHK_GENDER2
CHECK (GENDER IN ('M', 'F', 'm', 'f'));

INSERT INTO "TBL2#" (TNO, GENDER) VALUES (226, 'm');
INSERT INTO "TBL2#" (TNO, GENDER) VALUES (227, 'f');
INSERT INTO "TBL2#" (TNO, GENDER) VALUES (228, 'm');
INSERT INTO "TBL2#" (TNO, GENDER) VALUES (229, 'f');
