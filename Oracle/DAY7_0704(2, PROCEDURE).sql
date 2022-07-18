-- PL/SQL
-- : PROCEDURE(����, ����), ������ �ܼ��� SQL�� Ȯ��� ���(SQL�� ����� ���α׷�)
-- : ����, ���(IF, �ݺ���)�� ����Ͽ� ���α׷��� ���� ���� SQL ������ �帧�� ������.
-- !!!! ���ǻ��� : DBEAVER�� PROCEDURE�� DEBUG ����� ����.
--			������� �Ϸ��� SQL DEVELOPER�� ��� �Ѵ�.

DECLARE   -- ���� �����  
--	VNAME VARCHAR2(20);
--	VAGE NUMBER(3,0);
	VNAME TBL_CUSTOM.NAME %TYPE;	-- ������ ���̺��� �÷��� ������ ������ ������ ����ȴ�.
	VAGE TBL_CUSTOM.AGE %TYPE;

BEGIN		-- ���ν��� ����
-- ���ν��� ���ο��� �ַ� DML ��ɹ����� �ۼ�.(�Բ� �����ؾ� �� ���� SQL : Ʈ�����)
	SELECT NAME, AGE 
	INTO VNAME, VAGE	-- ���ν��� ����: �˻������ ������ ����
	FROM "TBL_CUSTOM" tc 
	WHERE CUSTOM_ID ='hongGD';		-- 1�� �ุ ��� ��ȸ�Ǵ� ����
									-- �������� ���� ��ȸ�Ǵ� ������ �ٸ� CURSOR ������ �ʿ��ϴ�.
	
-- �������� �ֿܼ� ���(���ν��� ���)
	DBMS_OUTPUT.PUT_LINE('���̸� : ' || VNAME);		-- ||�� ���ڿ� ���� ����
	DBMS_OUTPUT.PUT_LINE('������ : ' || VAGE);
	EXCEPTION		-- ����(����)ó��
	WHEN NO_DATA_FOUND THEN   -- ���� �̸��� �پ��ϴ�. ����� ���÷� NO_DATA_FOUND
		DBMS_OUTPUT.PUT_LINE('ã�� �����Ͱ� �����ϴ�.');
END;

-- ����Ŭ ��ü ���ν��� ���� : �˻��� ���� �Ű������� �����Ѵ�.
CREATE OR REPLACE PROCEDURE SEARCH_CUSTOM(		-- PROCEDURE �̸� ����
	C_ID IN TBL_CUSTOM.CUSTOM_ID %TYPE		-- �Ű����� IN
												-- ���ϰ��� OUT����!
)
IS 
-- �Ϲ� ���� ����
	VNAME TBL_CUSTOM.NAME %TYPE;
	VAGE TBL_CUSTOM.AGE %TYPE;		

BEGIN 
	SELECT NAME, AGE 
	INTO VNAME, VAGE
	FROM "TBL_CUSTOM" tc 
	WHERE CUSTOM_ID = C_ID;		-- 1�� �ุ ��� ��ȸ�Ǵ� ����
	
	DBMS_OUTPUT.PUT_LINE('���̸� : ' || VNAME);
	DBMS_OUTPUT.PUT_LINE('������ : ' || VAGE);
	EXCEPTION		-- ����(����)ó��
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('ã�� �����Ͱ� �����ϴ�.');
END;

-- ���ν��� ����
BEGIN
	SEARCH_CUSTOM('wonder');
END;

-- ���(���ϰ�)�� �ִ� ���ν��� ���� (��ü ����)
CREATE OR REPLACE PROCEDURE SEARCH_CUSTOM2(		-- PROCEDURE �̸� ����
	C_ID IN TBL_CUSTOM.CUSTOM_ID %TYPE,		-- �Ű����� IN
	C_NAME OUT TBL_CUSTOM.NAME %TYPE		-- ���ϰ� ���ν��� ��� OUT
)
IS 
-- �Ϲ� ���� ����
--	VNAME TBL_CUSTOM.NAME %TYPE;
--	VAGE TBL_CUSTOM.AGE %TYPE;		

BEGIN 
	SELECT NAME 
	INTO C_NAME
	FROM "TBL_CUSTOM" tc 
	WHERE CUSTOM_ID = C_ID;		-- 1�� �ุ ��� ��ȸ�Ǵ� ����
	
	DBMS_OUTPUT.PUT_LINE('���� �˻��Ͽ����ϴ�.' || C_ID);
	EXCEPTION		-- ����(����)ó��
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('ã�� �����Ͱ� �����ϴ�.');
		C_NAME := 'NO MATCH';		-- ���Թ� := ��ȣ ���
END;

-- ���(���ϰ�)�� �ִ� ���ν��� ���� : ��°� ������ ���� ������ �ʿ��ϴ�.
DECLARE
	VNAME TBL_CUSTOM.NAME %TYPE;
BEGIN
	SEARCH_CUSTOM2('momo', VNAME);		-- VNAME�� ���ν��� ������ �� OUT���� ����
--	VNAME := SEATCH_CUSTOM2('mina012');		-- �ùٸ��� ���� ����
	DBMS_OUTPUT.PUT_LINE('*�� �̸� : ' || VNAME);
END;

-- BEGIN ~ END ���� �ϳ��� Ʈ������� �����ϴ� DML(INSERT, UPDATE, DELETE ����) ��ɵ�� ����
-- ������ ����� EXCEPTION���� ROLLBACK; ������ ���� ���� COMMIT;

-- ���ν����� �� �� �ִ� ��� SQL
CREATE TABLE TBL_TEMP
AS
SELECT * FROM TBL_CUSTOM WHERE CUSTOM_ID ='0';

-- SELECT�� ����� INSERT �ϱ�
INSERT INTO TBL_TEMP (SELECT * FROM TBL_CUSTOM WHERE CUSTOM_ID = 'wonder');

SELECT * FROM TBL_TEMP tt;


-- FUNCTION ����Ŭ ��ü�� ��
-- ����Ŭ �Լ� : UPPER, LOWER, DECODE, ROUND, TO_DATE, TO_CHAR, ...
-- FUNCTION�� ����� �Լ��� �����Ѵ�. ���̺��� ������� �ϴ� ���� �ƴ϶�, Ư�� �����͸� �����ϴ� �����̴�.