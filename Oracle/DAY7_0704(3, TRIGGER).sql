-- 데이터베이스 TRIGGER : INSERT, UPDATE, DELETE할 때 동작하는 프로시저
-- 특정 테이블에 속해 있는 객체

CREATE OR REPLACE TRIGGER SECURE_CUSTOM
BEFORE UPDATE OR DELETE ON TBL_CUSTOM 				-- 언제 어떤 테이블에 대해 TRIGGER를 동작시킬지 지정
													-- (트리거가 동작하는 테이블, SQL과 시점을 지정)

BEGIN											-- 프로시저이기 때문에 BEGIN - END 필요			
	IF TO_CHAR(SYSDATE, 'HH24:MI') BETWEEN '13:00' AND '15:00' THEN
	RAISE_APPLICATION_ERROR(-20000, '오후 1시부터 오후 3시까지는 작업할 수 없습니다.');
	END IF;
END;
-- 트리거 동작 테스트
DELETE FROM TBL_CUSTOM WHERE CUSTOM_ID = 'twice';

-- 트리거 비활성화
ALTER TRIGGER SECURE_CUSTOM DISABLE;
-- 트리거 다시 활성화
ALTER TRIGGER SECURE_CUSTOM ENABLE;

-- 트리거에 필요한 테이블을 사전에 생성하기
CREATE TABLE TBL_TEMP
AS
SELECT * FROM TBL_BUY tb WHERE CUSTOM_ID = '0';

-- 트리거 정의(생성)
CREATE OR REPLACE TRIGGER CANCEL_BUY
AFTER DELETE ON TBL_BUY
FOR EACH ROW		-- 만족(적용)하는 행이 여러개일 때,
					-- :OLD는 UPDATE 또는 DELETE하기 전 값, :NEW는 INSERT한 값
BEGIN
	-- 구매 취소(TBL_BUY 테이블에서 삭제)한 데이터를 TBL_TEMP 임시 테이블에 INSERT 하기
	-- 여러 행에 대한 작업 (ROW TRIGGER)
	INSERT INTO TBL_TEMP
	VALUES (:OLD.CUSTOM_ID, :OLD.PCODE, :OLD.QUANTITY, :OLD.BUY_DATE, :OLD.BUYNO);
END;
-- 트리거 동작 테스트
DELETE FROM TBL_BUY tb WHERE CUSTOM_ID = 'wonder';
-- 트리거 동작 확인
SELECT * FROM TBL_TEMP;


-- 추가 VIEW 생성 연습
-- GRANT CREATE VIEW TO C##IDEV;		-- 뷰 생성의 권한이 없는 오류가 발생하면 권한을 부여해주어야 한다.
CREATE VIEW V_BUY				
AS
SELECT TB.CUSTOM_ID, TB.PCODE, TC.NAME, TC.EMAIL, TB.QUANTITY
FROM TBL_BUY tb, TBL_CUSTOM tc
WHERE TB.CUSTOM_ID = TC.CUSTOM_ID;

