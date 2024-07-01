-- 1 첫번째 트랜잭션 시작
START TRANSACTION;

-- 2 USER 데이터 수정
UPDATE USER SET name = 'USER-01' WHERE id = 1;

-- 5 USER_ITEM 데이터 수정
UPDATE USER_ITEM SET name = 'USER-ITEM-01' WHERE id = 1;

-- 7 커밋
COMMIT;