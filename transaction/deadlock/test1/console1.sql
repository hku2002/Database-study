-- 트랜잭션 시작
START TRANSACTION;

-- PRODUCT 테이블에 값 삽입
UPDATE PRODUCT SET name = 'PRODUCT-01' WHERE id = 1;

-- ITEM 테이블에 값 삽입
UPDATE ITEM SET name = 'ITEM-01' WHERE id = 1;

-- 트랜잭션 커밋
COMMIT;
