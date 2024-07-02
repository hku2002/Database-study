# Shared lock (공유잠금 / S Lock)

- Shared lock 은 Read 시 사용하는 lock
- Shared lock 끼리는 동시 접근이 가능

## Test 1
Shared lock 에서 다른 세션간 같은 레코드에 접근한다.

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

4. 첫번째 transaction 에서 Shared lock read 생성
```sql
SELECT * FROM STOCK WHERE id = 1 FOR SHARE;
```

5. 두번째 transaction 생성
```sql
START TRANSACTION;
```

6. 두번째 transaction 에서 Shared lock read 생성
```sql
SELECT * FROM STOCK WHERE id = 1 FOR SHARE;
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

첫번째, 두번째 transaction 에서 모두 올바르게 read 됨
