# Isolation Level

트랜잭션 격리 레벨

## REPEATABLE READ

변경 전의 레코드를 언두 공간에 백업 하여 언두 레코드 조회

## Test1
1. 책 Table 1개 생성
```sql
CREATE TABLE BOOK (
    id BIGINT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
```

2. 테이블에 데이터 저장
```sql
-- BOOK 테이블에 데이터 삽입
INSERT INTO BOOK (id, name) VALUES (1, 'Book1');
```

3. 첫번째 세션에 격리 레벨 Repeatable read 설정
```sql
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

4. 첫번째 transaction 생성
```sql
START TRANSACTION;
```

5. 첫번째 transaction 에서 name 변경
```sql
UPDATE BOOK SET name = 'BOOK-01' WHERE id = 1;
```

6. 두번째 세션에 격리 레벨 Repeatable read 설정
```sql
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

7. 두번째 transaction 생성
```sql
START TRANSACTION;
```

8. 두번째 transaction 에서 id=1 레코드 조회
```sql
SELECT * FROM BOOK WHERE id = 1;
```

9. 첫번째 transaction rollback
```sql
COMMIT;
```

10. 두번째 transaction 에서 id=1 레코드 조회
```sql
SELECT * FROM BOOK WHERE id = 1;
```

11. 두번째 transaction commit
```sql
COMMIT;
```

## 결과

8번 조회 시 name = 'Book1' 조회 됨
10번 조회 시 name = 'Book1' 조회 됨
