-- ȸ���� �Ϸ翡 1���� å�� �뿩�� �� �ִ�.
-- RETURN_DATE�� NULL�̸� �뿩��, NULL�� �ƴϸ� �ݳ��� ����

-- 1. ���� �߰��ϱ� ��B1102�� , ����Ʈ����ũ �����⡯, ����ö���� ,��KBO�� , ��2020-11-10��
INSERT INTO TBL_BOOK VALUES ('B1102', '��Ʈ����ũ ������', '��ö��', 'KBO', '2020-11-10');

-- 2. �ݳ��� ������ ��ü�ϼ��� ����Ͽ� delay_days �÷��� update�ϱ�
UPDATE TBL_BOOKRENT SET DELAY_DAYS = (RETURN_DATE - EXP_DATE) WHERE RETURN_DATE IS NOT NULL;
SELECT * FROM TBL_BOOKRENT;

-- 3. ���� ���� ������ ��ü �ϼ� ����ؼ� ȸ��IDX, �����ڵ�, ��ü�ϼ� ��ȸ�ϱ�
-- SYSDATE�� ������ ������ �������� �ʾұ� ������ LONG ������ ���ȴ�.
SELECT MEM_IDX, BCODE, TO_DATE(TO_CHAR(SYSDATE, 'YYYY-MM-DD')) - EXP_DATE
FROM TBL_BOOKRENT tb WHERE RETURN_DATE IS NULL;
-- �Ǵ�
SELECT MEM_IDX, BCODE, TRUNC(SYSDATE) - EXP_DATE	-- TRUNC(SYSDATE)�� SYSDATE�� �ð� �κ��� ������. 
FROM TBL_BOOKRENT tb WHERE RETURN_DATE IS NULL;

-- 4. ���� ��ü ���� ȸ���� �̸�, ��ȭ��ȣ �˻��ϱ�. ���� ��¥ SYSDATE�� �������� Ȯ���ϱ�
-- ���� �������� ��ü ���� ���� �ݳ����� < ���糯¥
SELECT NAME, TEL FROM BOOK_MEMBER bm, TBL_BOOKRENT tb
WHERE bm.MEM_IDX = tb.MEM_IDX
AND SYSDATE > EXP_DATE AND RETURN_DATE IS NULL;

-- 5. ���� ���� ���� ������ �����ڵ�� ������ �˻��ϱ�
SELECT tb.BCODE, TITLE FROM TBL_BOOK tb JOIN TBL_BOOKRENT tb2
ON tb.BCODE = tb2.BCODE AND RETURN_DATE IS NULL;

-- 6. ���� ������ �뿩�� ȸ���� ȸ��IDX�� ȸ���̸� �˻��ϱ�
SELECT tb.MEM_IDX, NAME FROM BOOK_MEMBER bm JOIN TBL_BOOKRENT tb
ON bm.MEM_IDX = tb.MEM_IDX AND RETURN_DATE IS NULL;

-- 7. ���� ���� ������ ȸ�� �̸�, ������, �ݳ����� �˻��ϱ�
SELECT NAME, TITLE, EXP_DATE FROM TBL_BOOK tb, TBL_BOOKRENT tb2, BOOK_MEMBER bm
WHERE tb.BCODE = tb2.BCODE AND tb2.MEM_IDX = bm.MEM_IDX
AND RETURN_DATE IS NULL;
-- �Ǵ�
SELECT NAME, TITLE, EXP_DATE FROM TBL_BOOK tb
JOIN TBL_BOOKRENT tb2 ON tb.BCODE = tb2.BCODE
JOIN BOOK_MEMBER bm ON bm.MEM_IDX = tb2.MEM_IDX 
AND RETURN_DATE IS NULL;

-- 8. ���� ��ü ���� ������ ȸ��IDX, �����ڵ�, �ݳ����� �˻��ϱ�
SELECT MEM_IDX, BCODE, EXP_DATE FROM TBL_BOOKRENT tb
WHERE SYSDATE > EXP_DATE;

-- 9. ȸ�� IDX ��10002���� ���� ������ �������� Ȯ���ϴ� ���ν��� �ۼ��ϱ�
DECLARE
	VCNT NUMBER;
BEGIN

	SELECT COUNT(*)
	INTO VCNT		-- SELECT ��ȸ ����� ������ ���� / �������� ,(�޸�)�� ������ �� ����.
	FROM TBL_BOOKRENT tb
	WHERE MEM_IDX = 10002 AND RETURN_DATE IS NULL;		-- vcnt�� 0�� ���� �뿩 ����.	
	IF (VCNT = 0) THEN 			-- IF���� THEN�� END IF;�� �ʿ��ϴ�.
		DBMS_OUTPUT.PUT_LINE('å �뿩 �����մϴ�.');
	ELSE
		DBMS_OUTPUT.PUT_LINE('�뿩 ���� å�� �ݳ��ؾ� �����մϴ�.');
	END IF;
END;

-- �� ������ �ڹ��� �޼ҵ�ó�� �޼ҵ� �̸��� �ٿ��� �����ϱ�
	CREATE OR REPLACE PROCEDURE CHECK_MEMBER(
		ARG_MEM IN BOOK_MEMBER.MEM_IDX %TYPE,		-- ���ν��� ������ �� ���� ���� �Ű�����
		isOK OUT VARCHAR2		-- �ڹ��� ���ϰ��� �ش��ϴ� �κ�
	)
	IS
		VCNT NUMBER;
		VNAME VARCHAR2(100);
	BEGIN
		-- �߰�) �Է� �Ű������� ���� ȸ�������� Ȯ���ϴ� SQL�� EXCEPTION ó��
		-- ARG_MEM���� ȸ�� ���̺��� NAME ��ȸ�ϱ�
		-- ������ EXCEPTION ó���ϱ�
		SELECT NAME INTO VNAME
		FROM BOOK_MEMBER bm WHERE MEM_IDX = ARG_MEM;
		
		-- ���� �ִ� �ڵ�
		SELECT COUNT(*) INTO VCNT
		FROM TBL_BOOKRENT tb
		WHERE MEM_IDX = ARG_MEM AND RETURN_DATE IS NULL;		-- rcnt�� 0�� ���� �뿩 ����.	
		IF (VCNT = 0) THEN 			-- IF���� THEN�� END IF;�� �ʿ��ϴ�.
			DBMS_OUTPUT.PUT_LINE('å �뿩 �����մϴ�.');
			isOK := '����';
		ELSE
			DBMS_OUTPUT.PUT_LINE('�뿩 ���� å�� �ݳ��ؾ� �����մϴ�.');
			isOK := '�Ұ���';
		END IF;
		EXCEPTION
		WHEN NO_DATA_FOUND THEN 
			DBMS_OUTPUT.PUT_LINE('ȸ���� �ƴմϴ�.');
			ISOK := 'NO MATCH';
		
	END;

	-- ���ν��� �����ϱ�
	DECLARE
		VRESULT VARCHAR2(20);
	BEGIN
		CHECK_MEMBER(10001, VRESULT);
		DBMS_OUTPUT.PUT_LINE('��� : ' || VRESULT);
	END;

-- 10. ������ ���佺Ʈ�� ��� ������ ������ �������� Ȯ���ϴ� ���ν��� �ۼ��ϱ� / ���ν��� �̸��� CHECK_BOOK����!
DECLARE
	V_BCODE VARCHAR2(100);
	V_CNT NUMBER;
BEGIN
	SELECT BCODE INTO V_BCODE		-- V_BCODE�� 'A1102'
	FROM TBL_BOOK tb WHERE TITLE = '�佺Ʈ';
	SELECT COUNT(*) INTO V_CNT		-- V_CNT�� ���� 1�̸� V_BCODE å�� ���� ��
	FROM TBL_BOOKRENT tb2
	WHERE BCODE = V_BCODE AND RETURN_DATE IS NULL;
	IF(V_CNT = 1) THEN
		DBMS_OUTPUT.PUT_LINE('�뿩 ���� å�Դϴ�.');
	ELSE
		DBMS_OUTPUT.PUT_LINE('å �뿩 �����մϴ�.');
	END IF;
END;

-- ���ν��� �޼ҵ�ó�� �����
	CREATE OR REPLACE PROCEDURE CHECK_BOOK (
		ARG_BOOK IN TBL_BOOK.TITLE %TYPE,
		ISOK OUT VARCHAR2
	)
	IS
	V_BCODE VARCHAR2(100);
	V_CNT NUMBER;
	BEGIN
		SELECT BCODE INTO V_BCODE		-- V_BCODE�� 'A1102'
		FROM TBL_BOOK tb WHERE TITLE = ARG_BOOK;
		-- ���� å �̸��� �Է��ϸ� ����, BCODE �� �˻��� �ȵȴ�. => EXCEPTION ó��
		SELECT COUNT(*) INTO V_CNT		-- V_CNT�� ���� 1�̸� V_BCODE å�� ���� ��
		FROM TBL_BOOKRENT tb2
		WHERE BCODE = V_BCODE AND RETURN_DATE IS NULL;
		IF(V_CNT = 1) THEN
			DBMS_OUTPUT.PUT_LINE('�뿩 ���� å�Դϴ�.');
			ISOK := 'FALSE';
		ELSE
			DBMS_OUTPUT.PUT_LINE('å �뿩 �����մϴ�.');
			ISOK := 'TRUE';
		END IF;
		EXCEPTION
		WHEN NO_DATA_FOUND THEN 
			DBMS_OUTPUT.PUT_LINE('ã�� �����Ͱ� �����ϴ�.');
			ISOK := 'NO MATCH';
	END;

-- ���ν��� �����ϱ�
	DECLARE
		VRESULT VARCHAR2(100);
	BEGIN
		CHECK_BOOK('�佺Ʈ', VRESULT);
		DBMS_OUTPUT.PUT_LINE('��� : ' || VRESULT);
	END;
	
	

