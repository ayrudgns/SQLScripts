-- SELECT �⺻ ����
-- SELECT �÷�1, �÷�2, ... FROM ���̺�� WHERE �˻����ǽ� 
--					ORDER BY �����÷� (���� : ASC, ���� : DESC);
--					���������� �⺻�̹Ƿ� �ַ� ����(DESC)�� ǥ�⸦ �Ѵ�.

SELECT * FROM TBL_BUY tb ;		-- INSERT�� ������� ��� ���
SELECT * FROM TBL_CUSTOM tc ;

SELECT * FROM TBL_CUSTOM tc ORDER BY CUSTOM_ID;
SELECT * FROM TBL_BUY tb WHERE CUSTOM_ID = 'mina012';
SELECT * FROM TBL_BUY tb WHERE CUSTOM_ID = 'mina012'
			ORDER BY BUY_DATE DESC;
			-- ��¥�� �ֱٺ��� �̰� ������ ��������
	-- ���� ������ WHERE�� �ݵ�� ���� ������, �� ������ ORDER BY�� ��� �Ѵ�.
		
-- ��ȸ�� �÷��� ������ ��, DISTINCT Ű���� : �ߺ����� 1���� ����� ����Ѵ�.
SELECT CUSTOM_ID FROM TBL_BUY tb ;		-- ���� �� ID ��ȸ�ϱ�
SELECT DISTINCT CUSTOM_ID FROM TBL_BUY tb ;		-- �������� 1���� ����Ѵ�!
	
