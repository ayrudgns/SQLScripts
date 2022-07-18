-- ����. CUSTOM_ID 'mina012'�� ������ ���� ��ȸ : PCODE�� ��ȸ������ PNAME�� �� �� ����.
SELECT PCODE FROM TBL_BUY WHERE CUSTOM_ID = 'mina012';

-- 1. �������� (SubQuery, SELECT �ȿ� SELECT�� �����.)
SELECT PNAME FROM TBL_PRODUCT tp	-- �ܺ� ����
	WHERE PCODE =		-- ���ǽ��� = �����̹Ƿ� ���� ������ 1�� ���� ������� �Ѵ�.
	(SELECT PCODE FROM TBL_BUY tb	-- ���� ���� (1)
		WHERE CUSTOM_ID = 'mina012' AND BUY_DATE = '2022-02-06');
-- ���� ������ ���� ����ǰ� �ܺ� ������ ����ȴ�.		
SELECT PNAME FROM TBL_PRODUCT tp
	WHERE PCODE IN		-- ���ǽ��� IN �����̹Ƿ� ���� ������ ������ ���� ����� �����ϴ�.
	(SELECT PCODE FROM TBL_BUY tb WHERE CUSTOM_ID = 'mina012');
	-- ���� ���� (2)

-- ���� ���� �׽�Ʈ (���� ������ ������ ������ �� �ִ�.)
SELECT PCODE FROM TBL_BUY tb	-- ���� ���� (1)
		WHERE CUSTOM_ID = 'mina012' AND BUY_DATE = '2022-02-06'

SELECT PCODE FROM TBL_BUY tb WHERE CUSTOM_ID = 'mina012'	-- ���� ���� (2)

-- ���� ������ ������ :
-- �ܺ� ������ ���ǽ��� ��� �࿡ ���� �˻��� ������ ���� ������ ����ǹǷ�, ó�� �ӵ��� ������ �����.
-- �̷��� �������� �ذ��ϱ� ���ؼ� ���̺��� JOIN ������ ����Ѵ�.

-- 2. SELECT�� ���̺� JOIN : �� �̻��� ���̺�(�ַ� ���� ������ ���̺�)�� �����Ͽ� �����͸� ��ȸ�ϴ� ���
-- ���� ���� : �� �̻��� ���̺��� ����� �÷��� ����, �� �÷����� '����(=)'�� �̿��Ͽ� JOIN�Ѵ�.
-- ���� ���� �� ���� ���̺��� ��� �÷��� ��������. (����� �÷��� �� 9��, ���� �÷��� �̸� ����)
-- �ΰ��� ���� ���� �ุ ��������. (���� ���� �� 6��)

-- ������ ���� ��ǰ �߰��ϱ�
INSERT INTO TBL_PRODUCT VALUES ('GALAXYS22', 'A1', '������S22', 555600);
-- TBL_PRODUCT , TBL_BUY ȭ�� ĸó ������ ���ϱ�!

-- ���� 1 : SELECT ~~ FROM ���̺�1 A, ���̺�2 B (JOIN Ű���� ����)
--					WHERE A.�����÷�1 = B.�����÷�1;
SELECT * FROM TBL_PRODUCT tp , TBL_BUY tb 	-- JOIN�� ���̺� 2�� ����
		WHERE TP.PCODE = TB.PCODE;		-- ���� ����, JOIN �÷����� = ���� ���
		
-- JOIN Ű���带 ���� ��ɹ� ���� 2 (ANSI ǥ��)
SELECT * FROM TBL_PRODUCT tp
		JOIN TBL_BUY tb
		ON TP.PCODE = TB.PCODE;
	
-- ���� �׽�Ʈ : TBL_CUSTOM�� TBL_BUY �����ϱ�
-- TBL_CUSTOM, TBL_BUY ȭ�� ĸó ������ ���ϱ�!
-- ���� 1
SELECT * FROM TBL_CUSTOM tc, TBL_BUY tb
		WHERE TC.CUSTOM_ID = TB.CUSTOM_ID;
-- ���� 2
SELECT * FROM TBL_CUSTOM tc
		JOIN TBL_BUY tb 
		ON TC.CUSTOM_ID = TB.CUSTOM_ID;

-- JOIN�� ������� Ư�� �÷��� ��������
-- CUSTOM_ID �� .�� �� � ���̺��� �÷������� �������ֱ�	
SELECT TC.CUSTOM_ID, NAME, REG_DATE, PCODE, QUANTITY FROM TBL_CUSTOM tc, TBL_BUY tb
		WHERE TC.CUSTOM_ID = TB.CUSTOM_ID;	
	
-- JOIN ���� �ܿ� �ٸ� ������ �߰��غ���	
SELECT TC.CUSTOM_ID, NAME, REG_DATE, PCODE, QUANTITY
		FROM TBL_CUSTOM tc, TBL_BUY tb
		WHERE TC.CUSTOM_ID = TB.CUSTOM_ID AND TC.CUSTOM_ID = 'mina012';			
	
-- mina012�� ������ ��ǰ���� �������� ��ȸ�ϱ�
SELECT TP.PNAME FROM TBL_PRODUCT tp, TBL_BUY tb
		WHERE TP.PCODE = TB.PCODE AND CUSTOM_ID = 'mina012';
	
SELECT TP.PNAME FROM TBL_PRODUCT tp JOIN TBL_BUY tb
			ON TP.PCODE = TB.PCODE AND CUSTOM_ID ='mina012';

SELECT TP.PNAME FROM TBL_PRODUCT tp JOIN TBL_BUY tb
	ON TP.PCODE = TB.PCODE AND CUSTOM_ID ='mina012' AND BUY_DATE = '2022-02-06';
	
-- mina012�� ������ ��ǰ��� ���� ��ȸ�ϱ�
SELECT TP.PNAME, TP.PRICE FROM TBL_PRODUCT tp, TBL_BUY tb
		WHERE TP.PCODE = TB.PCODE AND CUSTOM_ID = 'mina012';
	
-- JOIN ��ɿ��� �̸��� ���� �÷��� ���̺���� �ݵ�� �����ؾ� �Ѵ�.	

-- 3���� ���̺��� ������ �� ������?
SELECT * FROM TBL_PRODUCT tp,
	(SELECT tc.CUSTOM_ID CUSID, NAME, EMAIL, AGE, REG_DATE, PCODE, QUANTITY, BUY_DATE, BUYNO
		FROM TBL_CUSTOM tc, TBL_BUY tb WHERE TC.CUSTOM_ID = TB.CUSTOM_ID) TEMP	-- ù��° ����		
WHERE TP.PCODE = TEMP.PCODE;		-- �ι�° ����

SELECT * FROM TBL_BUY tb, TBL_CUSTOM tc, TBL_PRODUCT tp
	WHERE TB.PCODE = TP.PCODE AND TB.CUSTOM_ID = TC.CUSTOM_ID;

-- Ư�� �÷��� ��ȸ�ϱ�
SELECT TB.CUSTOM_ID, TB.PCODE, NAME, AGE, PNAME, QUANTITY, BUY_DATE
	FROM TBL_BUY tb, TBL_CUSTOM tc, TBL_PRODUCT tp
	WHERE TB.PCODE = TP.PCODE AND TB.CUSTOM_ID = TC.CUSTOM_ID;

-- 3. �ܺ� ���� (OUTER JOIN) : (=) ������ ����ϴ� �����̳� ���ʿ� ���� ��(NULL)�� ���� ����� �����Ѵ�.
-- JOIN Ű���� ���� ���� 1
SELECT * FROM TBL_PRODUCT tp, TBL_BUY tb
	WHERE TP.PCODE = TB.PCODE(+);
-- �ܺ� ���� TBL_BUY ���̺� ��ġ�ϴ� PCODE ���� ��� �����Ѵ�.
-- �������� �� NULL�� �Ǵ� ���̺��� �÷��� (+)��ȣ�� ���δ�.

-- JOIN Ű���带 ���� ��ɹ� ���� 2 (ANSI ǥ��), �ܺ� ������ LEFT JOIN�� �ַ� ����.
-- �θ� ���̺��� ���ʿ� ������ LEFT JOIN�̴�.
-- �����ϴ� ��쿡�� �����ϱ� ������, ���� ���迡 ���� �� �θ� ���̺��� �� ������ �϶�� �ǹ��̴�. 
SELECT * FROM TBL_PRODUCT tp
		LEFT OUTER JOIN TBL_BUY tb
		ON TP.PCODE = TB.PCODE;			-- TBL_PRODUCT�� ���� ���̺��̸� �� ���� ��� �����Ͽ� �����Ѵ�.
		
SELECT * FROM TBL_BUY tb
		RIGHT OUTER JOIN TBL_PRODUCT tp
		ON TB.PCODE = TP.PCODE;
