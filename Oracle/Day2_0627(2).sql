-- ���ڿ� Ÿ��
-- CHAR(����) : ���� ����, ������ ����Ʈ 
-- VARCHAR(����) : ����Ŭ���� ���������� ������� �ʴ� ���� �ڷ���.
-- VARCHAR2(����) : ������ ����, ������ ����Ʈ, ���̴� �ִ� �����̰� ������ �޸𸮴� ������ ũ�⸸ŭ ����Ѵ�.
--				   �ִ� 2000����Ʈ�̰�, UTF-8 ���ڵ����� �ѱ��� 3����Ʈ, ����/����/��ȣ�� 1����Ʈ�̴�.

CREATE TABLE TBL_STRING (
	acol CHAR(10),			-- 10����Ʈ ���� ����
	bcol VARCHAR2(10),		-- 10����Ʈ ���� ����
	ccol NCHAR(10),			-- ���� ���� 10�� ���� ����
	dcol NVARCHAR2(10));	-- ���� ���� 10�� ���� ����

-- CHAR Ÿ�� 
INSERT INTO TBL_STRING(acol) VALUES ('abcdefghij');
INSERT INTO TBL_STRING(acol) VALUES ('abcdef');		-- acol�� ���� ���� Ÿ�� : ���� 4�� �߰���.
INSERT INTO TBL_STRING(acol) VALUES ('abcdefghijklm');	-- ���� : ���� �ʰ�

-- INSERT Ȯ��
SELECT * FROM TBL_STRING;

-- �ѱ� Ȯ�� : UTF-8 ���ڵ����� �ѱ��� 3����Ʈ
INSERT INTO TBL_STRING(acol) VALUES ('������');		-- ���� ���� Ÿ�� : ���� 1�� �߰���.
INSERT INTO TBL_STRING(acol) VALUES ('�����ٶ�');		-- ���� : ���� ���� ���� �ʹ� ŭ(����: 12, �ִ밪: 10)
INSERT INTO TBL_STRING(acol) VALUES ('����');			-- ���� ���� Ÿ�� : ���� 4�� �߰���.

-- VARCHAR2 Ÿ��  : bcol�� ���� ���� 10����Ʈ
INSERT INTO TBL_STRING(bcol) VALUES ('abcdefghij');
INSERT INTO TBL_STRING(bcol) VALUES ('abcdef');		-- bcol�� ���� ���� Ÿ��, ���� �߰� ����
INSERT INTO TBL_STRING(bcol) VALUES ('abcdefghijklm');	-- ���� : ���� �ʰ�

-- INSERT Ȯ��
SELECT * FROM TBL_STRING;

-- �ѱ� Ȯ�� : UTF-8 ���ڵ����� �ѱ��� 3����Ʈ
INSERT INTO TBL_STRING(bcol) VALUES ('������');		-- ���� �߰� ����
INSERT INTO TBL_STRING(bcol) VALUES ('�����ٶ�');		-- ���� : ���� ���� ���� �ʹ� ŭ(����: 12, �ִ밪: 10)
INSERT INTO TBL_STRING(bcol) VALUES ('����');			-- ���� �߰� ����

-- CHAR�� VARCHAR2�� ����Ʈ �����̴�. NCHAR�� NVARCHAR2�� ���� ���� �����̴�.
-- ���� NCHAR�� NVARCHAR2�� �ٱ��� ���ڰ� ���� ���ԵǴ� �÷��� �����ϴ�.

-- NCHAR Ÿ��
INSERT INTO TBL_STRING(ccol) VALUES ('������');		-- ���� 7�� �߰�
INSERT INTO TBL_STRING(ccol) VALUES ('�����ٶ�');		-- ���� 6�� �߰�
INSERT INTO TBL_STRING(ccol) VALUES ('����');			-- ���� 8�� �߰�
INSERT INTO TBL_STRING(ccol) VALUES ('�����ٶ󸶹ٻ������ī');			-- ���� : ���� �ʰ�

-- INSERT Ȯ��
SELECT * FROM TBL_STRING;

-- NVARCHAR2 Ÿ��
INSERT INTO TBL_STRING(dcol) VALUES ('������');		-- ���� �߰� ����
INSERT INTO TBL_STRING(dcol) VALUES ('�����ٶ�');		-- ���� �߰� ����
INSERT INTO TBL_STRING(dcol) VALUES ('����');			-- ���� �߰� ����
INSERT INTO TBL_STRING(dcol) VALUES ('�����ٶ󸶹ٻ������ī');			-- ���� : ���� �ʰ�

-- INSERT Ȯ��
SELECT * FROM TBL_STRING;


