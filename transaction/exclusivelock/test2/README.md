# Exclusive lock

- 다른 트랙잭션에서의 Exclusive Lock 은 허용하지 않는다.

## Test 2
한 세션에서 Exclusive Lock 을 생성 후
다른 세션에서 Exclusive Lock Read 를 진행한다.

- **시나리오**
1. 재고 Table 1개 생성
```sql
CREATE TABLE STOCK (
    id BIGINT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL
);
```

2. 테이블에 데이터 저장
```sql
-- STOCK 테이블에 데이터 삽입
INSERT INTO STOCK (id, name, quantity) VALUES (1, 'Stock1', 100);
```

3. 첫번째 transaction 생성
```sql
START TRANSACTION;
```

4. 첫번째 transaction 에서 Exclusive lock 생성
```sql
SELECT * FROM STOCK WHERE id = 1 FOR UPDATE;
```

5. 두번째 transaction 생성
```sql
START TRANSACTION;
```

6. 두번째 transaction 에서 Shared lock 생성
```sql
SELECT * FROM STOCK WHERE id = 1 FOR UPDATE;
```

7. 첫번째 transaction commit
```sql
COMMIT;
```

8. 두번째 transaction commit
```sql
COMMIT;
```

## 결과
6번 shared lock 조회에서 대기 발생
7번 commit 후 6번 조회 정상 실행
