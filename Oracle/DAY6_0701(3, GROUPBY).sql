-- ���� : �׷�ȭ(���� �׷�ȭ �ϱ�)
-- ������ �Ʒ��� ����.	([]�� ���û���)
-- SELECT �׷��Լ� FROM ���̺��
-- [WHERE] �׷�ȭ�ϱ� ���� ����� ���ǽ�
-- GROUP BY �׷�ȭ�� ����� �÷���
-- [HAVING] �׷�ȭ ����� ���� ���ǽ�
-- [ORDER BY] �׷�ȭ ����� ������ �÷���� ���

SELECT PCODE, COUNT(*) FROM TBL_BUY tb GROUP BY PCODE;

SELECT PCODE, COUNT(*) , SUM(QUANTITY)
	FROM TBL_BUY tb GROUP BY PCODE ORDER BY 2;	-- ��ȸ�� �÷��� ��ġ(�ε���)

SELECT PCODE, COUNT(*) CNT, SUM(QUANTITY) TOTAL
	FROM TBL_BUY tb GROUP BY PCODE ORDER BY CNT;	-- �׷��Լ� ����� ��Ī CNT

-- �׷�ȭ �Ŀ� ���� �հ谡 3 �̻� ��ȸ�ϱ�
SELECT PCODE, COUNT(*) CNT, SUM(QUANTITY) TOTAL
	FROM TBL_BUY tb
	GROUP BY PCODE
--	HAVING TOTAL >= 3		-- HAVING���� �÷� ��Ī�� ����� �� ����. ���̺� �÷����� ����� �� �ִ�.
	HAVING SUM(QUANTITY) >= 3 
	ORDER BY CNT;	-- �׷��Լ� ����� ��Ī CNT	
	
SELECT * FROM TBL_BUY tb2 ;
-- ���� ��¥�� 2022-04-01 ������ �͸� �׷�ȭ�Ͽ� ��ȸ�ϱ�
SELECT PCODE, COUNT(*) CNT, SUM(QUANTITY) TOTAL
	FROM TBL_BUY tb
	WHERE BUY_DATE >= '2022-04-01'
	GROUP BY PCODE
	ORDER BY CNT;


