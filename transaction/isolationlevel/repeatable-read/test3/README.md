# Isolation Level

트랜잭션 격리 레벨

## REPEATABLE READ

변경 전의 레코드를 언두 공간에 백업 하여 언두 레코드 조회
공유락, 배타락으로 조회할 경우 갭 락으로 넥스트 키 락을 걸어 INSERT 가 대기

## Test3
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

5. 첫번째 transaction 에서 id >= 1 레코드 조회
```sql
SELECT * FROM BOOK WHERE id >= 1 FOR UPDATE;
```

6. 두번째 세션에 격리 레벨 Repeatable read 설정
```sql
SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
```

7. 두번째 transaction 생성
```sql
START TRANSACTION;
```

8. 두번째 transaction 에서 새로운 레코드 삽입
```sql
INSERT INTO BOOK (id, name) VALUES (2, 'Book2');
```

9. 첫번째 transaction commit
```sql
COMMIT;
```

9. 두번째 transaction commit
```sql
COMMIT;
```

## 결과

8번 insert 시 대기 발생
9번 commit 시 8번 insert 정상 수행
