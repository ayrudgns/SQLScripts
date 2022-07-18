-- SELECT 기본 형식
-- SELECT 컬럼1, 컬럼2, ... FROM 테이블명 WHERE 검색조건식 
--					ORDER BY 기준컬럼 (오름 : ASC, 내림 : DESC);
--					오름차순이 기본이므로 주로 내림(DESC)만 표기를 한다.

SELECT * FROM TBL_BUY tb ;		-- INSERT한 순서대로 결과 출력
SELECT * FROM TBL_CUSTOM tc ;

SELECT * FROM TBL_CUSTOM tc ORDER BY CUSTOM_ID;
SELECT * FROM TBL_BUY tb WHERE CUSTOM_ID = 'mina012';
SELECT * FROM TBL_BUY tb WHERE CUSTOM_ID = 'mina012'
			ORDER BY BUY_DATE DESC;
			-- 날짜를 최근부터 뽑고 싶으면 내림차순
	-- 문법 순서는 WHERE가 반드시 먼저 나오고, 그 다음에 ORDER BY를 써야 한다.
		
-- 조회할 컬럼을 지정할 때, DISTINCT 키워드 : 중복값은 1번만 결과로 출력한다.
SELECT CUSTOM_ID FROM TBL_BUY tb ;		-- 구매 고객 ID 조회하기
SELECT DISTINCT CUSTOM_ID FROM TBL_BUY tb ;		-- 증복값을 1번만 출력한다!
	
