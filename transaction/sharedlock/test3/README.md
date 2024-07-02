# Shared lock (공유잠금 / S Lock)

- Shared lock 이 걸려있을 경우 Write 작업 불가능

## Test 3
한 세션에서 Shared lock 으로 조회 발생 후 
다른 세션에서 write 를 진행한다.

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

4. 첫번째 transaction update 실행
```sql
SELECT * FROM STOCK WHERE id = 1 FOR SHARE;
```

5. 두번째 transaction 생성
```sql
START TRANSACTION;
```

6. 두번째 transaction 에서 Shared lock read 생성
```sql
UPDATE STOCK SET quantity = 101 WHERE id = 1;
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
- 6번 업데이트 쿼리 실행 시 대기 발생
- 7번 commit 후 6번 쿼리 정상 실행

Shared lock 레코드는 write 하지 못한다.
