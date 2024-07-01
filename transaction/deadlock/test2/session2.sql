-- 3 두번째 트랜잭션 시작
START TRANSACTION;

-- 4 USER_ITEM 데이터 삽입 FK는 USER 테이블의 id = 1
INSERT INTO USER_ITEM (id, user_id, name, price) VALUES (1, 1, 'User Item1', 1000);

-- 6 커밋
COMMIT;