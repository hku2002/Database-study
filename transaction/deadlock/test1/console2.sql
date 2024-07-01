-- 트랜잭션 시작
START TRANSACTION;

-- ITEM 테이블에 값 삽입
UPDATE ITEM SET price = 1001 WHERE id = 1;

-- PRODUCT 테이블에 값 삽입
UPDATE PRODUCT SET name = 'trx test' WHERE id = 1;

-- 트랜잭션 커밋
COMMIT;
