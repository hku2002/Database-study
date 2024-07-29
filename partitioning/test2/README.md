## 기존 생성되어 있는 테이블에 파티셔닝 추가

기존 테이블에 파티셔닝 추가 방법.
pk 에 파티셔닝 컬럼이 없을 경우 파티셔닝을 할 수 없음

### 시나리오

1. 테이블 생성
```sql
CREATE TABLE LOG_V2 (
  `id` INT NOT NULL AUTO_INCREMENT,
  `contents` VARCHAR(100) NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`)
);
```

2. 데이터 저장
```sql
INSERT INTO LOG_V2
(contents, created_at)
VALUES
('contents 1', '2024-01-01 00:00:00'),
('contents 2', '2024-01-31 23:59:59'),
('contents 3', '2024-02-01 00:00:00'),
('contents 4', '2024-02-28 23:59:59'),
('contents 5', '2024-03-01 00:00:00'),
('contents 6', '2024-03-31 23:59:59'),
('contents 7', NOW());
```

3. 파티셔닝 가능한 동일한 구조의 신규 테이블 생성
```sql
CREATE TABLE LOG_V3 (
  `id` INT NOT NULL AUTO_INCREMENT,
  `contents` VARCHAR(100) NOT NULL,
  `created_at` DATETIME NOT NULL,
  PRIMARY KEY (`id`, `created_at`)
);
```

4. 기존 테이블 데이터를 신규 테이블로 저장
```sql
INSERT INTO LOG_V3
SELECT * FROM LOG_V2;
```

5. 기존 테이블 <-> 신규테이블 스위칭 및 기존 테이블 삭제
```sql
ALTER TABLE LOG_V2 RENAME LOG_V2_BACK;
ALTER TABLE LOG_V3 RENAME LOG_V2;
DROP TABLE LOG_V2_BACK;
```

6. 파티셔닝 추가
```sql
ALTER TABLE LOG_V2 PARTITION BY RANGE (TO_DAYS(created_at)) (
	PARTITION P_202401 VALUES LESS THAN (TO_DAYS('2024-01-01')),
	PARTITION P_202402 VALUES LESS THAN (TO_DAYS('2024-02-01')),
	PARTITION P_202403 VALUES LESS THAN (TO_DAYS('2024-03-01')),
	PARTITION P_maxvalue VALUES LESS THAN MAXVALUE
);
```
