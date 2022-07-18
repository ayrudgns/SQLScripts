-- �����ͺ��̽� TRIGGER : INSERT, UPDATE, DELETE�� �� �����ϴ� ���ν���
-- Ư�� ���̺� ���� �ִ� ��ü

CREATE OR REPLACE TRIGGER SECURE_CUSTOM
BEFORE UPDATE OR DELETE ON TBL_CUSTOM 				-- ���� � ���̺� ���� TRIGGER�� ���۽�ų�� ����
													-- (Ʈ���Ű� �����ϴ� ���̺�, SQL�� ������ ����)

BEGIN											-- ���ν����̱� ������ BEGIN - END �ʿ�			
	IF TO_CHAR(SYSDATE, 'HH24:MI') BETWEEN '13:00' AND '15:00' THEN
	RAISE_APPLICATION_ERROR(-20000, '���� 1�ú��� ���� 3�ñ����� �۾��� �� �����ϴ�.');
	END IF;
END;
-- Ʈ���� ���� �׽�Ʈ
DELETE FROM TBL_CUSTOM WHERE CUSTOM_ID = 'twice';

-- Ʈ���� ��Ȱ��ȭ
ALTER TRIGGER SECURE_CUSTOM DISABLE;
-- Ʈ���� �ٽ� Ȱ��ȭ
ALTER TRIGGER SECURE_CUSTOM ENABLE;

-- Ʈ���ſ� �ʿ��� ���̺��� ������ �����ϱ�
CREATE TABLE TBL_TEMP
AS
SELECT * FROM TBL_BUY tb WHERE CUSTOM_ID = '0';

-- Ʈ���� ����(����)
CREATE OR REPLACE TRIGGER CANCEL_BUY
AFTER DELETE ON TBL_BUY
FOR EACH ROW		-- ����(����)�ϴ� ���� �������� ��,
					-- :OLD�� UPDATE �Ǵ� DELETE�ϱ� �� ��, :NEW�� INSERT�� ��
BEGIN
	-- ���� ���(TBL_BUY ���̺��� ����)�� �����͸� TBL_TEMP �ӽ� ���̺� INSERT �ϱ�
	-- ���� �࿡ ���� �۾� (ROW TRIGGER)
	INSERT INTO TBL_TEMP
	VALUES (:OLD.CUSTOM_ID, :OLD.PCODE, :OLD.QUANTITY, :OLD.BUY_DATE, :OLD.BUYNO);
END;
-- Ʈ���� ���� �׽�Ʈ
DELETE FROM TBL_BUY tb WHERE CUSTOM_ID = 'wonder';
-- Ʈ���� ���� Ȯ��
SELECT * FROM TBL_TEMP;


-- �߰� VIEW ���� ����
-- GRANT CREATE VIEW TO C##IDEV;		-- �� ������ ������ ���� ������ �߻��ϸ� ������ �ο����־�� �Ѵ�.
CREATE VIEW V_BUY				
AS
SELECT TB.CUSTOM_ID, TB.PCODE, TC.NAME, TC.EMAIL, TB.QUANTITY
FROM TBL_BUY tb, TBL_CUSTOM tc
WHERE TB.CUSTOM_ID = TC.CUSTOM_ID;

