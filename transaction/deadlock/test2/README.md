# Deadlock

## Test 2
외래키 잠금 전파로 데드락을 발생 시킨다.

- **시나리오**
1. Table 2개 생성 (회원, 회원 아이템)
```sql
CREATE TABLE USER (
    id BIGINT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE USER_ITEM (
    id BIGINT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    name VARCHAR(100),
    price INT,
    CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES USER(id)
);
```

2. USER 테이블에 데이터 저장
```sql
-- USER 테이블에 데이터 삽입
INSERT INTO USER (id, name) VALUES (1, 'User1');
```

3. 첫번째 transaction 생성
```sql
START TRANSACTION;
```
4. 첫번째 transaction에서 USER 테이블 데이터 수정
```sql
UPDATE USER SET name = 'USER-01' WHERE id = 1;
```
5. 두번째 transaction 생성
```sql
START TRANSACTION;
```
6. 두번째 transaction에서 ITEM 테이블 데이터 생성
```sql
INSERT INTO USER_ITEM (id, user_id, name, price) VALUES (1, 1, 'User Item1', 1000);
```
7. 첫번째 transaction에서 USER_ITEM 테이블 데이터 수정
```sql
UPDATE USER_ITEM SET name = 'USER-ITEM-01' WHERE id = 1;
```
8. 두번째 transaction 에서 commit
```sql
COMMIT;
```
9. 첫번째 transaction 에서 commit
```sql
COMMIT;
```

## 결과

- 7번에서 데드락 발생하여 첫번째 트랜잭션이 롤백

## 설명

- 4번에서 첫번째 트랜잭션이 USER 테이블 id = 1 레코드의 X-lock 을 보유하고 있음
- 6번에서 두번째 트랜잭션이 USER_ITEM 테이블 id = 1 레코드의 X-lock 을 보유하고 있음
- 6번에서 두번째 트랜잭션이 외래키 설정으로 인하여 USER 테이블 id = 1 레코드의 S-lock 을 보유해야 하기에 첫번째 트랜잭션이 끝나기를 기다리고 있음
- 7번에서 첫번째 트랜잭션이 USER_ITEM 테이블 id = 1 레코드의 X-lock 을 보유해야 하기에 두번째 트랜잭션이 끝나기를 기다리고 있음
- 데드락 발생
- 첫번째 트랜잭션 롤백
