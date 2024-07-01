# Deadlock

## Test 1
데드락을 발생 시킨다.

- **시나리오**
1. Table 2개 생성 (상품, 아이탬)
```sql
CREATE TABLE PRODUCT (
    id BIGINT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE ITEM (
    id BIGINT PRIMARY KEY,
    name VARCHAR(100),
    price INT
);
```

2. 각 테이블에 데이터 저장
```sql
-- PRODUCT 테이블에 값 삽입
INSERT INTO PRODUCT (id, name) VALUES (1, 'Product1');

-- ITEM 테이블에 값 삽입
INSERT INTO ITEM (id, name, price) VALUES (1, 'Item1', 1000);
```

3. 첫번째 transaction 생성
```sql
START TRANSACTION;
```
4. 첫번째 transaction에서 PRODUCT 테이블 데이터 수정
```sql
UPDATE PRODUCT SET name = 'PRODUCT-01' WHERE id = 1;
```
5. 두번째 transaction 생성
```sql
START TRANSACTION;
```
6. 두번째 transaction에서 ITEM 테이블 데이터 수정
```sql
UPDATE ITEM SET price = 1001 WHERE id = 1;
```
7. 첫번째 transaction에서 ITEM 테이블 데이터 수정
```sql
UPDATE ITEM SET name = 'ITEM-01' WHERE id = 1;
```
8. 두번째 transaction에서 PRODUCT 테이블 데이터 수정
```sql
UPDATE PRODUCT SET name = 'trx test' WHERE id = 1;
```
9. 첫번째 transaction 에서 commit
```sql
COMMIT;
```
10. 두번째 transaction 에서 commit
```sql
COMMIT;
```

## 결과

- 8번에서 데드락 발생하여 두번째 트랜잭션이 롤백
