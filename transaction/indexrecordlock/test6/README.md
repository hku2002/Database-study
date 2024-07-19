# lock 범위 알아보기

- Where 조건에 따른 lock 범위를 알아본다.

## Test 6
Where 조건 2개로 lock 의 범위를 알아본다. 조건 1개에 index 가 존재한다.
index 가 같은 값을 update 한다.

- **시나리오**
1. 버튼 Table 1개 생성
```sql
CREATE TABLE BUTTON (
    id BIGINT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    activated TINYINT(1) NOT NULL DEFAULT 0
);
```

2. 테이블에 데이터 저장
```sql
-- BUTTON 테이블에 데이터 삽입
INSERT INTO BUTTON (id, name, activated) VALUES (1, 'Button1', 0);
INSERT INTO BUTTON (id, name, activated) VALUES (2, 'Button2', 0);
INSERT INTO BUTTON (id, name, activated) VALUES (3, 'Button3', 0);
INSERT INTO BUTTON (id, name, activated) VALUES (4, 'Button4', 1);
INSERT INTO BUTTON (id, name, activated) VALUES (5, 'Button1', 1);
```

3. name 컬럼 인덱스 생성
```sql
ALTER TABLE BUTTON ADD INDEX idx_name (name);
```

4. 첫번째 transaction 생성
```sql
START TRANSACTION;
```

5. 첫번째 transaction 에서 1번 버튼 활성화
```sql
UPDATE BUTTON SET activated = 1 WHERE activated = 0 AND name = 'Button1';
```

6. 두번째 transaction 생성
```sql
START TRANSACTION;
```

7. 두번째 transaction 에서 2번 버튼 활성화
```sql
UPDATE BUTTON SET activated = 0 WHERE activated = 1 AND name = 'Button1';
```

8. 첫번째 transaction commit
```sql
COMMIT;
```

9. 두번째 transaction commit
```sql
COMMIT;
```

## 결과

7번에서 대기가 발생하고 8번 commit 후 대기가 풀린다.
