-- 데이터 가져오기 (IMPORT)
-- 제공되는 CSV형식의 파일을 테이블로 변환할 수 있는 기능
-- CSV 파일은 데이터 항목을 ,(콤마)로 구분하여 저장한 텍스트 파일이다.
-- (엑셀 또는 메모장에서 열기 가능)
-- 주의사항 : 자동으로 생성되는 테이블 컬럼의 크기가 데이터보다 작지 않게,
-- 또는 적절한 타입으로 설정해야 한다.

-- ANIMAL_INS 테이블 행이 80,187개 정도 되면 SQL 쿼리의 실행 속도 차이를 확인할 수 있다.
-- 예를 들어, 서브쿼리와 조인의 SQL 실행 시간의 비교가 가능하다.

-- 가져온 데이터 테이블 확인 ANIMAL_INS
SELECT * FROM ANIMAL_INS ai WHERE COLOR = 'Black' ORDER BY DATETIME;
-- 가져온 데이터 테이블 확인 ANIMAL_OUTS
SELECT * FROM ANIMAL_OUTS ao WHERE COLOR = 'White' ORDER BY DATETIME;

-- 데이터 내보내기 (EXPORT)
-- 현재 데이터베이스의 테이블 구조와 행(값)들을 파일로 내보낸다.
-- DDL 테이블, 시퀀스 생성 명령문과 INSERT 명령들을 만들어서 .sql 파일을 만든다.





